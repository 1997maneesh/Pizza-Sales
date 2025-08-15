-- total Generated orders = 48620

SELECT 
COUNT(ORDER_ID)
FROM order_details;

-- Distinct count of orders =  21350

SELECT
COUNT(DISTINCT (order_id))
FROM
order_details;

-- Total revenue generated from pizza's = 817860.05

SELECT 
ROUND(SUM(od.quantity * p.price), 4) AS total_revenue
FROM
order_details AS od
JOIN
pizzas AS p ON od.pizza_id = p.pizza_id;

-- Month of the highest sale. -- July month is the highest selling month with 72557.9

SELECT 
    MONTHNAME(o.date) AS month,
    ROUND(SUM(od.quantity * p.price), 2) AS revenue_from_month
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_id
        JOIN
    pizzas AS p ON p.pizza_id = od.pizza_id
GROUP BY month
ORDER BY revenue_from_month DESC
LIMIT 1;

-- Classic Pizza is the category that contribute the highest revenue earing of rs.220053.1

SELECT 
    pt.category AS category,
    ROUND(SUM(od.quantity * p.price), 3) AS revenue
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY category
ORDER BY revenue DESC
LIMIT 1;

