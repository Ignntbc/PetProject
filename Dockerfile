FROM golang:alpine
WORKDIR /poker_bot
COPY go.mod go.sum ./
RUN go mod download
COPY * ./
RUN go build -o poker_bot main.go
CMD ["./poker_bot"]