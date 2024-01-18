package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api/v5"
)

func contains(slice []string, item string) bool {
	for _, value := range slice {
		if value == item {
			return true
		}
	}
	return false
}

func getCards(deckId string, countCrds string, mode string) ([]string, error) {
	result, err := makeRequest("https://deckofcardsapi.com/api/deck/" + deckId + "/draw/?count=" + countCrds)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	var list = make([]string, 0)
	result_cards := result["cards"] //.(map[string]interface{})["code"]
	for i := range result_cards.([]interface{}) {
		fmt.Println("i:", i)
		playerCard := result_cards.([]interface{})[i].(map[string]interface{})[mode].(string)
		list = append(list, playerCard)
	}
	fmt.Println("list: ", list)
	return list, nil

}

func errorHandler(err error) {
	if err != nil {
		log.Fatal(err)
	}
}

func makeRequest(url string) (map[string]interface{}, error) {
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, fmt.Errorf("Ошибка при создании запроса: %v", err)
	}

	client := &http.Client{}
	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("Ошибка при выполнении запроса: %v", err)
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("Ошибка при чтении ответа: %v", err)
	}

	var result map[string]interface{}
	err = json.Unmarshal([]byte(body), &result)
	if err != nil {
		return nil, fmt.Errorf("Ошибка при распаковке JSON: %v", err)
	}

	return result, nil
}

func downloadFile(url string) (*os.File, error) {
	response, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer response.Body.Close()

	file, err := os.Create("temp.jpg")
	if err != nil {
		return nil, err
	}
	defer file.Close()

	_, err = io.Copy(file, response.Body)
	if err != nil {
		return nil, err
	}

	return file, nil
}

func main() {
	bot, err := tgbotapi.NewBotAPI("6413172953:AAHfd0IANxhHyr0ZegEGBxQTdUrMhXa9Luw")
	errorHandler(err)
	bot.Debug = true
	log.Printf("Authorized on account %s", bot.Self.UserName)
	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	var pullPlayers []string
	var deckId string
	// var tableMessageId int
	typeGroups := []string{"group", "supergroup"}
	quantityPlayers := 0

	updates := bot.GetUpdatesChan(u)
	for update := range updates {
		fmt.Println(&update.Message)
		if update.Message.Text == "/join" && contains(typeGroups, update.Message.Chat.Type) && quantityPlayers < 3 {
			fmt.Println("updateMessageFrom: ", update.Message.From.UserName)
			pullPlayers = append(pullPlayers, update.Message.From.UserName)
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "Hello, "+update.Message.From.FirstName+"!"+" You have joined the game ♠️♥️♣️♦️")
			bot.Send(msg)
			quantityPlayers++
		} else if update.Message.Text == "/join" && contains(typeGroups, update.Message.Chat.Type) && quantityPlayers == 2 {
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "Sorry, the game is full")
			bot.Send(msg)
		} else if update.Message.Text == "/join" && update.Message.Chat.Type == "private" {
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "Sorry, you can't join the game from here, please join from the group")
			bot.Send(msg)
		} else if update.Message.Text == "/startgame" && contains(typeGroups, update.Message.Chat.Type) && quantityPlayers == 1 {
			msg := tgbotapi.NewMessage(update.Message.Chat.ID, "The game has started")
			bot.Send(msg)
			result, err := makeRequest("https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1")
			errorHandler(err)
			deckId = result["deck_id"].(string)
			fmt.Println("deck_id: ", deckId)
			// cardsPlOne, err := getCards(deckId, 2, "code")
			errorHandler(err)
			cardsFlop, err := getCards(deckId, "3", "image")
			errorHandler(err)

			msg = tgbotapi.NewMessage(update.Message.Chat.ID, "		♠️♥️♣️♦️    THE TABLE    ♠️♥️♣️♦️")
			bot.Send(msg)
			mediaList := []interface{}{}
			for i := range cardsFlop {
				photoURL := cardsFlop[i]
				media := tgbotapi.NewInputMediaPhoto(tgbotapi.FileURL(photoURL))
				mediaList = append(mediaList, media)
			}

			// photoURL := cardsFlop[0]
			// photoURL2 := cardsFlop[1]
			// photoURL3 := cardsFlop[2]
			// media := tgbotapi.NewInputMediaPhoto(tgbotapi.FileURL(photoURL))
			// media2 := tgbotapi.NewInputMediaPhoto(tgbotapi.FileURL(photoURL2))
			// media3 := tgbotapi.NewInputMediaPhoto(tgbotapi.FileURL(photoURL3))
			bot.Send(tgbotapi.NewMediaGroup(update.Message.Chat.ID, []interface{}{mediaList[0], mediaList[1], mediaList[2]}))
			msg = tgbotapi.NewMessage(update.Message.Chat.ID, "🪙 COINS - <b>35</b>")
			// coinsMsg, err := bot.Send(msg)
			msg = tgbotapi.NewMessage(update.Message.Chat.ID, "		♠️♥️♣️♦️    THE TABLE    ♠️♥️♣️♦️")
			bot.Send(msg)

		}
	}
}
