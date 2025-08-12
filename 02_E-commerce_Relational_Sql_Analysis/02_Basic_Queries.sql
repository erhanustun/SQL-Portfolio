### Total Orders and Revenue Analysis
This SQL query joins the `orders` and `order_items` tables to calculate the total number of orders and the total revenue generated.

SELECT 
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price + oi.freight_value), 2) AS total_revenue
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id;
