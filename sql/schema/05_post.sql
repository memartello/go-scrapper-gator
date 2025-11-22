-- +goose Up
CREATE TABLE IF NOT EXISTS posts (
    id UUID PRIMARY KEY default uuid_generate_v4(),
    title VARCHAR(250),
    url VARCHAR(250),
    description varchar(250),
    published_at TIMESTAMP NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    feed_id UUID NOT NULL REFERENCES feeds ON DELETE CASCADE, 
    FOREIGN KEY (feed_id) REFERENCES feeds(id),
    UNIQUE(url)
);

-- +goose Down
DROP TABLE IF EXISTS posts;