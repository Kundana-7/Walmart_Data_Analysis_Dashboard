-- Average review score across all orders --
SELECT ROUND(AVG(review_score), 2) AS avg_review_score
FROM order_reviews;

-- Count of 5-star & 1-star reviews --
SELECT review_score,
       COUNT(*) AS review_count
FROM order_reviews
WHERE review_score IN (1, 5)
GROUP BY review_score;

-- Number of reviews per day --
SELECT review_creation_date,
       COUNT(*) AS total_reviews,
       ROUND(AVG(review_score), 2) AS avg_review_score
FROM order_reviews
GROUP BY review_creation_date
ORDER BY review_creation_date;

-- Most common review scores --
SELECT review_score,
       COUNT(*) AS total_reviews
FROM order_reviews
GROUP BY review_score
ORDER BY total_reviews DESC;

-- Average review score by month --
SELECT DATE_FORMAT(STR_TO_DATE(review_answer_timestamp, '%d-%m-%Y %H:%i'), '%m') AS review_month,
       ROUND(AVG(review_score), 2) AS avg_review_score,
       COUNT(review_id) AS total_reviews
FROM order_reviews
WHERE review_answer_timestamp IS NOT NULL 
AND review_answer_timestamp <> ''
GROUP BY review_month
ORDER BY review_month;