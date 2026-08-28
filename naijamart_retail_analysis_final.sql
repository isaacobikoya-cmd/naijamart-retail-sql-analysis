-- ============================================================
-- NAIJAMART RETAIL SALES ANALYSIS
-- SQL Portfolio Project
-- ============================================================
--
-- Objective:
-- Analyze retail sales performance across products,
-- categories, customers, sales channels, geography and time.
--
-- Database: SQLite
-- Analysis Period: January 1, 2025 - December 31, 2025
--
-- Business Rule:
-- Financial and sales-performance analysis uses COMPLETED
-- orders only, excluding Cancelled and Pending orders.
-- ============================================================


-- ============================================================
-- 01. DATA QUALITY CHECKS
-- ============================================================

-- Check the structure of the Products table
PRAGMA table_info(Products);

-- Check the structure of the Customers table
PRAGMA table_info(Customers);

-- Check the structure of the Orders table
PRAGMA table_info(Orders);

-- Check the structure of the Order_items table
PRAGMA table_info(Order_items);


-- Check for duplicate product names
SELECT
    product_name,
    COUNT(*) AS product_count
FROM Products
GROUP BY product_name
HAVING COUNT(*) > 1
ORDER BY product_count DESC;
-- ============================================================
-- 02. OVERALL BUSINESS KPIs
-- ============================================================

-- Business Question:
-- What are NaijaMart's overall financial performance metrics?

SELECT
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * p.unit_cost) AS total_cost,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit,
    ROUND(
        SUM(oi.quantity * (p.unit_price - p.unit_cost)) * 100.0
        / SUM(oi.quantity * p.unit_price),
        2
    ) AS profit_margin
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed';


-- Business Question:
-- How many completed orders, order items and units were sold?

SELECT
    COUNT(DISTINCT o.order_id) AS completed_orders,
    COUNT(DISTINCT oi.order_item_id) AS total_order_items,
    SUM(oi.quantity) AS total_units_sold
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed';


-- Business Question:
-- What are the Average Order Value and Average Units per Order?

SELECT
    ROUND(
        SUM(oi.quantity * p.unit_price) * 1.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_order_value,
    ROUND(
        SUM(oi.quantity) * 1.0
        / COUNT(DISTINCT o.order_id),
        2
    ) AS average_units_per_order
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed';
-- ============================================================
-- 03. ORDER STATUS ANALYSIS
-- ============================================================

-- Business Question:
-- How are orders distributed across their different statuses?

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM Orders
GROUP BY order_status
ORDER BY total_orders DESC;


-- Business Question:
-- What percentage of all orders were cancelled?

SELECT
    ROUND(
        SUM(
            CASE
                WHEN order_status = 'Cancelled' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS cancellation_rate
FROM Orders;
-- ============================================================
-- 04. PRODUCT PERFORMANCE
-- ============================================================

-- Business Question:
-- Which products generate the most revenue and profit?
--
-- Products are grouped by product_name and category to
-- combine records where the same product appears more than once.

SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_name,
    p.category
ORDER BY total_revenue DESC
LIMIT 15;


-- Business Question:
-- Which products have the highest profit margins?

SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    ROUND(
        SUM(oi.quantity * (p.unit_price - p.unit_cost)) * 100.0
        / SUM(oi.quantity * p.unit_price),
        2
    ) AS profit_margin
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY
    p.product_name,
    p.category
ORDER BY profit_margin DESC
LIMIT 10;
-- ============================================================
-- 05. CATEGORY PERFORMANCE
-- ============================================================

-- Business Question:
-- Which product category generates the most revenue and profit?

SELECT
    p.category,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * p.unit_cost) AS total_cost,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit,
    ROUND(
        SUM(oi.quantity * (p.unit_price - p.unit_cost)) * 100.0
        / SUM(oi.quantity * p.unit_price),
        2
    ) AS profit_margin
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY p.category
ORDER BY total_profit DESC;

-- ============================================================
-- 06. SALES CHANNEL PERFORMANCE
-- ============================================================

-- Business Question:
-- How do Online and Store sales channels compare in terms
-- of revenue, profit and profitability?

SELECT
    o.sales_channel,
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit,
    ROUND(
        SUM(oi.quantity * (p.unit_price - p.unit_cost)) * 100.0
        / SUM(oi.quantity * p.unit_price),
        2
    ) AS profit_margin
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY o.sales_channel
ORDER BY total_revenue DESC;

-- ============================================================
-- 07. MONTHLY PERFORMANCE
-- ============================================================

-- Business Question:
-- How does revenue change throughout the year?

SELECT
    strftime('%Y-%m', o.order_date) AS sales_month,
    SUM(oi.quantity * p.unit_price) AS total_revenue
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY sales_month;


-- Business Question:
-- How does profit change throughout the year?

SELECT
    strftime('%Y-%m', o.order_date) AS sales_month,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit
FROM Orders o
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY strftime('%Y-%m', o.order_date)
ORDER BY sales_month;

-- ============================================================
-- 08. CUSTOMER SEGMENT ANALYSIS
-- ============================================================

-- Business Question:
-- Which customer segments generate the most revenue and profit?

SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_segment
ORDER BY total_revenue DESC;


-- Business Question:
-- Which customer segment generates the most revenue and profit
-- per customer?

SELECT
    c.customer_segment,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    ROUND(
        SUM(oi.quantity * p.unit_price) * 1.0
        / COUNT(DISTINCT c.customer_id),
        2
    ) AS revenue_per_customer,
    ROUND(
        SUM(oi.quantity * (p.unit_price - p.unit_cost)) * 1.0
        / COUNT(DISTINCT c.customer_id),
        2
    ) AS profit_per_customer
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_segment
ORDER BY revenue_per_customer DESC;

-- ============================================================
-- 09. CUSTOMER GENDER ANALYSIS
-- ============================================================

-- Business Question:
-- How does purchasing performance differ by gender?

SELECT
    c.gender,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.gender
ORDER BY total_revenue DESC;

-- ============================================================
-- 10. GEOGRAPHIC ANALYSIS
-- ============================================================

-- Business Question:
-- Which states generate the most revenue and profit?

SELECT
    c.state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY c.state
ORDER BY total_revenue DESC;


-- Business Question:
-- Which cities generate the most revenue and profit?

SELECT
    c.city,
    c.state,
    COUNT(DISTINCT c.customer_id) AS total_customers,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * p.unit_price) AS total_revenue,
    SUM(oi.quantity * (p.unit_price - p.unit_cost)) AS total_profit
FROM Customers c
JOIN Orders o
    ON c.customer_id = o.customer_id
JOIN Order_items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.city,
    c.state
ORDER BY total_revenue DESC
LIMIT 10;

-- ============================================================
-- 11. CUSTOMER RETENTION
-- ============================================================

-- Business Question:
-- What percentage of customers are one-time versus repeat buyers?

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time Customer'
        ELSE 'Repeat Customer'
    END AS customer_type,
    COUNT(*) AS total_customers,
    ROUND(
        COUNT(*) * 100.0 / (
            SELECT COUNT(DISTINCT customer_id)
            FROM Orders
            WHERE order_status = 'Completed'
        ),
        2
    ) AS percentage_of_customers
FROM (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM Orders
    WHERE order_status = 'Completed'
    GROUP BY customer_id
) AS customer_orders
GROUP BY customer_type
ORDER BY total_customers DESC;

-- ============================================================
-- 12. PRODUCT BASKET ANALYSIS
-- ============================================================

-- Business Question:
-- Which products are most frequently purchased together
-- in completed orders?

SELECT
    p1.product_name AS product_1,
    p2.product_name AS product_2,
    COUNT(DISTINCT oi1.order_id) AS orders_together
FROM Order_items oi1
JOIN Order_items oi2
    ON oi1.order_id = oi2.order_id
    AND oi1.product_id < oi2.product_id
JOIN Orders o
    ON oi1.order_id = o.order_id
JOIN Products p1
    ON oi1.product_id = p1.product_id
JOIN Products p2
    ON oi2.product_id = p2.product_id
WHERE o.order_status = 'Completed'
GROUP BY
    oi1.product_id,
    oi2.product_id,
    p1.product_name,
    p2.product_name
ORDER BY orders_together DESC
LIMIT 10;


-- ============================================================
-- END OF NAIJAMART RETAIL SALES ANALYSIS
-- ============================================================