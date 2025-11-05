-- Average number of installments per payment type --
SELECT payment_type,
       ROUND(AVG(payment_installments), 2) AS avg_installments,
       COUNT(*) AS payment_count
FROM payments
GROUP BY payment_type
ORDER BY avg_installments DESC;

-- Payment type generating the highest revenue --
SELECT payment_type,
       ROUND(SUM(payment_value), 2) AS total_revenue,
       COUNT(*) AS payment_count
FROM payments
GROUP BY payment_type
ORDER BY total_revenue DESC;

-- Distribution of payment types used --
SELECT payment_type,
       COUNT(*) AS total_payments
FROM payments
GROUP BY payment_type
ORDER BY total_payments DESC;

-- Payment method with the highest transaction value --
SELECT payment_type,
       SUM(payment_value) AS total_transaction
FROM payments
GROUP BY payment_type
ORDER BY total_transaction DESC;

-- Average number of payment installments per order --
SELECT ROUND(SUM(payment_installments) / COUNT(DISTINCT order_id), 2) AS average_installments_per_order
FROM payments;