-- name: CreateFeed :one
INSERT INTO feeds (id, created_at, updated_at, user_id, url, title) VALUES (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6
)
RETURNING *;

-- name: GetFeed :one
SELECT * FROM feeds WHERE url = $1 LIMIT 1;

-- name: GetFeeds :many
SELECT f.*, u.name as username FROM feeds as f JOIN users as u on u.id = f.user_id;

-- name: CreateFeedFollow :one
WITH inserted_feed_follow as (
    INSERT INTO feed_follows (id, feed_id, user_id, created_at, updated_at) VALUES (
        $1,
        $2,
        $3,
        $4,
        $5
    )
    RETURNING *
)
SELECT feeds.title, users.name as username 
FROM inserted_feed_follow 
INNER JOIN users ON users.id = inserted_feed_follow.user_id
INNER JOIN feeds ON feeds.id = inserted_feed_follow.feed_id
LIMIT 1;

-- name: GetMyFeeds :many
SELECT feeds.title, users.name FROM feed_follows 
INNER JOIN feeds ON feeds.id = feed_follows.feed_id
INNER JOIN users ON users.id = feed_follows.user_id
WHERE feed_follows.user_id = $1;

-- name: Unfollow :exec
DELETE FROM feed_follows WHERE feed_follows.user_id = $1 AND feed_follows.feed_id = (
    SELECT feeds.id FROM feeds WHERE feeds.url = $2 LIMIT 1
);

-- name: MarkFeedFetched :exec
UPDATE feeds SET last_fetched_at = $1 WHERE url = $2;

-- name: GetNextFeedToFetch :one
SELECT * FROM feeds WHERE last_fetched_at IS NULL OR last_fetched_at < $1
ORDER BY last_fetched_at ASC LIMIT 1;