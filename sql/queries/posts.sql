-- name: CreatePost :one
INSERT INTO posts (title, url, description, published_at, created_at, updated_at, feed_id) VALUES (
    $1,
    $2,
    $3,
    $4,
    $5,
    $6,
    $7
)
RETURNING *;

-- name: GetPostsForUser :many
SELECT p.*, users.name as username FROM posts p 
INNER JOIN feed_follows ON feed_follows.feed_id = p.feed_id 
INNER JOIN users ON users.id = feed_follows.user_id 
WHERE users.id = $1
ORDER BY p.published_at DESC LIMIT $2;