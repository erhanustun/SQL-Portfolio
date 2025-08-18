-- 1. Customer Lifetime Value Analysis
SELECT
    c.customer_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.price + oi.freight_value) AS total_spent,
    MIN(o.order_purchase_timestamp) AS first_order_date,
    MAX(o.order_purchase_timestamp) AS last_order_date,
    DATE_PART('day', MAX(o.order_purchase_timestamp) - MIN(o.order_purchase_timestamp)) AS relationship_days
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

-- 2. Repeat Purchase Rate
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT
    COUNT(CASE WHEN order_count > 1 THEN 1 END)::decimal / COUNT(*) * 100 AS repeat_purchase_percentage
FROM customer_orders;

-- 3. Average Revenue Per User (ARPU)
SELECT
    SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.customer_id) AS arpu
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id;

-- 4. Category-wise Monthly Revenue Growth
SELECT
    p.product_category_name,
    strftime('%Y-%m', o.order_purchase_timestamp) AS month,
    SUM(oi.price) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name, month
ORDER BY p.product_category_name, month;

-- 5. Delivery Performance Analysis
SELECT
    JULIANDAY(o.order_delivered_customer_date) - JULIANDAY(o.order_estimated_delivery_date) AS delay_days,
    COUNT(*) AS number_of_orders
FROM orders o
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY delay_days
ORDER BY delay_days DESC;

-- 6. Top 10 Cities by Revenue per Order
SELECT
    c.customer_city,
    SUM(oi.price + oi.freight_value) / COUNT(DISTINCT o.order_id) AS avg_revenue_per_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_city
ORDER BY avg_revenue_per_order DESC
LIMIT 10;
