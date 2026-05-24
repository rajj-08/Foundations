-- ================================================
-- TheLook E-Commerce Marketing Analysis
-- Dataset: thelook_ecommerce (Google BigQuery)
-- ================================================

-- Q1(A): Product Category Performance
SELECT
    p.category,
    COUNT(oi.id) AS items_sold,
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price - p.cost) AS profit
FROM order_items oi
JOIN products p ON oi.product_id = p.id
GROUP BY p.category
ORDER BY profit DESC;

-- Q1(B-a): Gender-wise Performance
SELECT
    u.gender,
    COUNT(oi.id) AS items_sold,
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price - COALESCE(p.cost, 0)) AS profit
FROM order_items oi
JOIN users u ON oi.user_id = u.id
LEFT JOIN products p ON oi.product_id = p.id
GROUP BY u.gender
ORDER BY profit DESC;

-- Q1(B-b): Age Group-wise Performance
SELECT
    CASE
        WHEN u.age < 25 THEN 'Under 25'
        WHEN u.age BETWEEN 25 AND 40 THEN '25-40'
        ELSE '40+'
    END AS age_group,
    COUNT(oi.id) AS items_sold,
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price - p.cost) AS profit
FROM order_items oi
JOIN products p ON oi.product_id = p.id
JOIN users u ON oi.user_id = u.id
GROUP BY age_group
ORDER BY profit DESC;

-- Q1(B-c): City-wise Performance
SELECT
    u.city,
    COUNT(oi.id) AS items_sold,
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price - p.cost) AS profit
FROM order_items oi
JOIN products p ON oi.product_id = p.id
JOIN users u ON oi.user_id = u.id
GROUP BY u.city
ORDER BY profit DESC;

-- Q1(C): Marketing Channel Performance
SELECT
    u.traffic_source,
    COUNT(DISTINCT oi.user_id) AS total_customers,
    COUNT(*) AS items_sold,
    SUM(oi.sale_price) AS revenue,
    SUM(oi.sale_price - p.cost) AS profit,
    SUM(oi.sale_price - p.cost) / COUNT(DISTINCT oi.user_id) AS profit_per_customer
FROM order_items oi
JOIN products p ON oi.product_id = p.id
JOIN users u ON oi.user_id = u.id
WHERE u.traffic_source IS NOT NULL
GROUP BY u.traffic_source
ORDER BY profit_per_customer DESC;
