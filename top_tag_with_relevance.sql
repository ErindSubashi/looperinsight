WITH TagFrequency AS (
    SELECT 
        t.movieId, 
        gt.tagId, 
        COUNT(t.tag) AS tag_frequency
    FROM tag t
    JOIN genome_tags gt ON t.tag = gt.tag
    GROUP BY t.movieId, gt.tagId
),
Top5Tags AS (
    SELECT 
        movieId, 
        tagId, 
        tag_frequency,
        ROW_NUMBER() OVER (PARTITION BY movieId ORDER BY tag_frequency DESC) AS tag_rank
    FROM TagFrequency
)
SELECT 
    tf.movieId,
    tf.tagId,
    gt.tag,
    tf.tag_frequency,
    gs.relevance
FROM Top5Tags tf
JOIN genome_tags gt ON tf.tagId = gt.tagId
JOIN genome_scores gs ON tf.movieId = gs.movieId AND tf.tagId = gs.tagId
WHERE tf.tag_rank <= 5
ORDER BY tf.movieId, tf.tag_frequency DESC;
