-- ================================================
-- RetailMart Profit Analysis
-- Dataset: E-Commerce Sales
-- ================================================

-- Q1(a): Categories & Sub-categories by Profit
SELECT
    category,
    `sub-category`,
    SUM(profit) AS total_profit
FROM ecommerce_sales
GROUP BY category, `sub-category`
ORDER BY total_profit DESC;

-- Q1(b): Where Discounts Are Hurting Margins
SELECT
    region,
    category,
    `sub-category`,
    AVG(discount) AS avg_discount,
    AVG(profit) AS avg_profit
FROM ecommerce_sales
GROUP BY region, category, `sub-category`
ORDER BY avg_discount DESC, avg_profit ASC;

-- Q1(c) / Q2: Top Products to Stock in North Region
SELECT
    region,
    product_name,
    SUM(quantity) AS total_qty,
    SUM(profit) AS total_profit
FROM ecommerce_sales
WHERE region = 'North'
GROUP BY region, product_name
ORDER BY total_qty DESC, total_profit DESC;
