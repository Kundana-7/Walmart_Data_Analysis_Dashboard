-- Which product categories are the most popular (by order count) --
SELECT p.`product category` AS category,
       COUNT(DISTINCT oi.order_id) AS order_count
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY order_count DESC;

-- Which categories generate the highest total revenue --
SELECT p.`product category` AS category,
       ROUND(SUM(py.payment_value), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
JOIN payments py ON oi.order_id = py.order_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 5;

-- What is the average price and freight value per category --
SELECT p.`product category` AS category,
       ROUND(AVG(oi.price), 2) AS avg_price,
       ROUND(AVG(oi.freight_value), 2) AS avg_freight_value
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY category
ORDER BY avg_price DESC, avg_freight_value DESC;

-- How many unique products are there --
SELECT COUNT(DISTINCT product_id) AS unique_products 
FROM products;

-- What are the Top 10 best-selling products --
SELECT COUNT(DISTINCT oi.order_id) AS order_count,
       p.product_id,
       p.`product category` AS category
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_id, category
ORDER BY order_count DESC
LIMIT 10;

-- Which product categories are most popular in each state --
SELECT COUNT(DISTINCT oi.order_id) AS order_count,
       c.customer_state,
       p.`product category` AS category
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY c.customer_state, category
ORDER BY order_count DESC;

-- Which products have the widest price range (max – min) --
SELECT p.product_id,
       p.`product category` AS category,
	   (MAX(oi.price) - MIN(oi.price)) AS price_range
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_id, category
ORDER BY price_range DESC
LIMIT 20;