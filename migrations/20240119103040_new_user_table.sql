-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS rooms (
 id SERIAL PRIMARY KEY,
 player_name VARCHAR(255) NOT NULL,
 player_id bigint NOT NULL,
 is_creator boolean NOT NULL);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
-- +goose StatementEnd
