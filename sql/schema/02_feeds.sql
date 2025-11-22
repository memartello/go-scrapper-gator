-- +goose Up

CREATE TABLE IF NOT EXISTS feeds(
    id UUID PRIMARY KEY default uuid_generate_v4(),
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    title varchar(250),
    url varchar(250),
    user_id UUID NOT NULL REFERENCES users ON DELETE CASCADE,
    UNIQUE(url),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- +goose Down
DROP TABLE IF EXISTS feeds;