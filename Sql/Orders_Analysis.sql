-- Find states and cities with the highest number of delayed deliveries --
SELECT c.customer_state,
       c.customer_city,
       COUNT(*) AS delayed_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date > o.order_estimated_delivery_date
GROUP BY c.customer_state, c.customer_city
ORDER BY delayed_orders DESC;

-- Identify top sellers by total orders and calculate their average review score --
SELECT s.seller_id,
       t.total_orders,
       ROUND(r.avg_review_score, 2) AS avg_review_score
FROM sellers s
JOIN (
        SELECT oi.seller_id, COUNT(DISTINCT o.order_id) AS total_orders
        FROM orders o
        JOIN order_items oi ON o.order_id = oi.order_id
        WHERE o.order_status = 'delivered'
        GROUP BY oi.seller_id
     ) t ON s.seller_id = t.seller_id
LEFT JOIN (
        SELECT oi.seller_id, AVG(r.review_score) AS avg_review_score
        FROM order_items oi
        JOIN order_reviews r ON oi.order_id = r.order_id
        GROUP BY oi.seller_id
     ) r ON s.seller_id = r.seller_id
ORDER BY t.total_orders DESC;

-- Identify months and years with the highest number of purchases --
SELECT YEAR(order_purchase_timestamp) AS year,
       MONTH(order_purchase_timestamp) AS month,
       COUNT(order_id) AS purchases
FROM orders
GROUP BY year, month
ORDER BY purchases DESC;

-- Find the most frequent order status by customer state --
SELECT c.customer_state,
       o.order_status,
       COUNT(*) AS status_count
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state, o.order_status
ORDER BY status_count DESC;

-- Count how many orders were placed in each month and year --
SELECT MONTH(order_purchase_timestamp) AS month,
       YEAR(order_purchase_timestamp) AS year,
       COUNT(DISTINCT order_id) AS orders
FROM orders
GROUP BY month, year 
ORDER BY year, month;

-- Track yearly trend of orders delivered late compared to estimated delivery date --
SELECT YEAR(order_purchase_timestamp) AS year,
       COUNT(*) AS delayed_orders
FROM orders
WHERE order_status = 'delivered'
  AND order_delivered_customer_date > order_estimated_delivery_date
GROUP BY year
ORDER BY delayed_orders;

-- Analyze which weekdays have the highest order volumes --
SELECT DAYNAME(order_purchase_timestamp) AS weekday,
       COUNT(order_id) AS order_count
FROM orders
WHERE order_status = 'delivered'
GROUP BY weekday
ORDER BY order_count DESC;
