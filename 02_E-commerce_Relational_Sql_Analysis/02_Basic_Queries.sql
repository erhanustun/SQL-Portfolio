-- 1. Total Orders and Total Revenue
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id;

-- 2. Top Customers by Number of Orders
SELECT 
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;

-- 3. Total Sales by Product Category
SELECT 
    pct.product_category_name_english AS category,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p 
    ON oi.product_id = p.product_id
JOIN product_category_name_translation pct
    ON p.product_category_name = pct.product_category_name
GROUP BY category
ORDER BY total_sales DESC;

-- 4. Orders Distribution by City
SELECT 
    c.customer_city,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;

-- 5. Average Delivery Time (in Days)
SELECT 
    ROUND(AVG(
        JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp)
    ), 2) AS avg_delivery_days
FROM orders
WHERE order_delivered_customer_date IS NOT NULL;

-- 6. Most Used Payment Method
SELECT 
    payment_type,
    COUNT(*) AS usage_count
FROM order_payments
GROUP BY payment_type
ORDER BY usage_count DESC;

-- 7. Monthly Sales Trend
SELECT 
    strftime('%Y-%m', order_purchase_timestamp) AS year_month,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
GROUP BY year_month
ORDER BY year_month;

