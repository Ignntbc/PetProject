-- +goose Up
-- +goose StatementBegin
CREATE TABLE IF NOT EXISTS test (
 id SERIAL PRIMARY KEY,
 test_name VARCHAR(255) NOT NULL
);
-- +goose StatementEnd

-- +goose Down
-- +goose StatementBegin
DROP TABLE IF EXISTS test;
-- +goose StatementEnd