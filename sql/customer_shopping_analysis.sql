-- ============================================================
-- Consumer Shopping Behavior & Sales Intelligence
-- PostgreSQL SQL Analysis
-- ============================================================

-- ============================================================
-- 1. Category Performance
-- ============================================================

SELECT
    category,
    COUNT(*) AS customer_count,
    SUM(purchase_amount_usd) AS total_purchase_amount,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY category
ORDER BY total_purchase_amount DESC;


-- ============================================================
-- 2. Seasonal Purchase Analysis
-- ============================================================

SELECT
    season,
    COUNT(*) AS customer_count,
    SUM(purchase_amount_usd) AS total_purchase_amount,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY season
ORDER BY total_purchase_amount DESC;


-- ============================================================
-- 3. Subscription Analysis
-- ============================================================

SELECT
    subscription_status,
    COUNT(*) AS customer_count,
    SUM(purchase_amount_usd) AS total_purchase_amount,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_shopping_behavior
GROUP BY subscription_status
ORDER BY customer_count DESC;


-- ============================================================
-- 4. Discount Analysis
-- ============================================================

SELECT
    discount_applied,
    COUNT(*) AS customer_count,
    SUM(purchase_amount_usd) AS total_purchase_amount,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_shopping_behavior
GROUP BY discount_applied
ORDER BY customer_count DESC;


-- ============================================================
-- 5. Payment Method Analysis
-- ============================================================

SELECT
    payment_method,
    COUNT(*) AS customer_count,
    SUM(purchase_amount_usd) AS total_purchase_amount,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY payment_method
ORDER BY total_purchase_amount DESC;


-- ============================================================
-- 6. Purchase Frequency Analysis
-- ============================================================

SELECT
    frequency_of_purchases,
    COUNT(*) AS customer_count,
    SUM(purchase_amount_usd) AS total_purchase_amount,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases
FROM customer_shopping_behavior
GROUP BY frequency_of_purchases
ORDER BY total_purchase_amount DESC;


-- ============================================================
-- 7. Customer Behavioral Segmentation
-- ============================================================

SELECT
    CASE
        WHEN previous_purchases >= 35 THEN 'High'
        WHEN previous_purchases >= 20 THEN 'Medium'
        ELSE 'Low'
    END AS customer_segment,
    COUNT(*) AS customer_count,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY
    CASE
        WHEN previous_purchases >= 35 THEN 'High'
        WHEN previous_purchases >= 20 THEN 'Medium'
        ELSE 'Low'
    END
ORDER BY avg_previous_purchases DESC;


-- ============================================================
-- 8. Customer Segment and Category Analysis
-- ============================================================

SELECT
    CASE
        WHEN previous_purchases >= 35 THEN 'High'
        WHEN previous_purchases >= 20 THEN 'Medium'
        ELSE 'Low'
    END AS customer_segment,
    category,
    COUNT(*) AS customer_count,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY
    CASE
        WHEN previous_purchases >= 35 THEN 'High'
        WHEN previous_purchases >= 20 THEN 'Medium'
        ELSE 'Low'
    END,
    category
ORDER BY customer_segment, avg_purchase_amount DESC;


-- ============================================================
-- 9. Geographic Purchase Analysis
-- ============================================================

SELECT
    location,
    COUNT(*) AS customer_count,
    SUM(purchase_amount_usd) AS total_purchase_amount,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY location
ORDER BY total_purchase_amount DESC
LIMIT 10;


-- ============================================================
-- 10. Subscription and Discount Combination
-- ============================================================

SELECT
    subscription_status,
    discount_applied,
    COUNT(*) AS customer_count,
    ROUND(AVG(previous_purchases), 2) AS avg_previous_purchases,
    ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
FROM customer_shopping_behavior
GROUP BY
    subscription_status,
    discount_applied
ORDER BY customer_count DESC;


-- ============================================================
-- 11. Advanced Analysis:
-- Category Ranking Within Customer Segments
-- ============================================================

WITH segment_category AS (
    SELECT
        CASE
            WHEN previous_purchases >= 35 THEN 'High'
            WHEN previous_purchases >= 20 THEN 'Medium'
            ELSE 'Low'
        END AS customer_segment,
        category,
        ROUND(AVG(purchase_amount_usd), 2) AS avg_purchase_amount
    FROM customer_shopping_behavior
    GROUP BY
        CASE
            WHEN previous_purchases >= 35 THEN 'High'
            WHEN previous_purchases >= 20 THEN 'Medium'
            ELSE 'Low'
        END,
        category
)

SELECT
    customer_segment,
    category,
    avg_purchase_amount,
    RANK() OVER (
        PARTITION BY customer_segment
        ORDER BY avg_purchase_amount DESC
    ) AS category_rank
FROM segment_category
ORDER BY customer_segment, category_rank;