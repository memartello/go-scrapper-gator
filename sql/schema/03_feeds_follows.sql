-- +goose Up
CREATE TABLE IF NOT EXISTS feed_follows (
    id UUID PRIMARY KEY default uuid_generate_v4(),
    feed_id UUID NOT NULL REFERENCES feeds ON DELETE CASCADE, 
    user_id UUID NOT NULL REFERENCES users ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    FOREIGN KEY (feed_id) REFERENCES feeds(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    UNIQUE(feed_id, user_id)
);


-- +goose Down
DROP TABLE IF EXISTS feed_follows;
