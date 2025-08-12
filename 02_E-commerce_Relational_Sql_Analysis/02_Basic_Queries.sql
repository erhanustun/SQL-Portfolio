### Total Orders and Revenue Analysis
SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id;
