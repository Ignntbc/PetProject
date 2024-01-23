-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS test (
 id SERIAL PRIMARY KEY
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS test;
-- +goose StatementEnd