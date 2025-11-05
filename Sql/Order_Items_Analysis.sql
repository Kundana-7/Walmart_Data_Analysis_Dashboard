-- What are the unique products in the dataset --
SELECT DISTINCT p.`product category` AS product_name,
       oi.product_id
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
ORDER BY product_name;

-- Find the most popular product --
SELECT p.`product category` AS product_name,
       oi.product_id,
       COUNT(oi.order_id) AS order_count
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.`product category`
ORDER BY order_count DESC
LIMIT 1;

-- Find the product with the highest average review score --
SELECT ROUND(AVG(r.review_score), 2) AS avg_review_score,
       oi.product_id,
       p.`product category` AS product_name
FROM order_reviews r
JOIN order_items oi ON r.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY oi.product_id, p.`product category`
ORDER BY avg_review_score DESC;

-- Find most frequently ordered products per state --
SELECT c.customer_state,
       oi.product_id,
       COUNT(o.order_id) AS order_count
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state, oi.product_id
ORDER BY order_count DESC;

-- Find trend of items sold per month/year --
SELECT YEAR(o.order_purchase_timestamp) AS year,
       MONTH(o.order_purchase_timestamp) AS month,
       COUNT(oi.order_item_id) AS items_sold
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
GROUP BY year, month
ORDER BY year, month;

-- Analyze product dimensions and weight --
SELECT p.`product category`,
       ROUND(AVG(p.product_weight_g), 2) AS avg_weight_g,
       ROUND(AVG(p.product_length_cm), 2) AS avg_length_cm,
       ROUND(AVG(p.product_height_cm), 2) AS avg_height_cm,
       ROUND(AVG(p.product_width_cm), 2) AS avg_width_cm
FROM products p
GROUP BY p.`product category`
ORDER BY avg_weight_g DESC;

