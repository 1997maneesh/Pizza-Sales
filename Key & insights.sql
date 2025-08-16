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

-- The top 4 pizzas by total revenue are The Thai Chicken Pizza 43434.25, The Barbecue Chicken Pizza	42768
-- The California Chicken Pizza 41409.5, The Classic Deluxe Pizza	38180.5

SELECT 
    pt.name AS names,
    SUM(od.quantity * p.price) AS total_revenue
FROM
    pizzas AS p
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
        JOIN
    pizza_types AS pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY names
ORDER BY total_revenue DESC
LIMIT 4;

-- The most frequently ordered pizza size is Large, with the highest total quantity 18956 sold compared to other sizes

SELECT 
    p.size AS size, SUM(od.quantity) AS total_quantity
FROM
    pizzas AS p
        JOIN
    order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY size
ORDER BY total_quantity DESC
LIMIT 1;

The top 3 most sold pizza types are The Classic Deluxe Pizza 2453, The Barbecue Chicken Pizza 2432,
The Hawaiian Pizza 2422 


SELECT 
    pt.name AS Pizza_Name,
    SUM(od.quantity) AS Total_quantity_sold
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON p.pizza_type_id = pt.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY Pizza_name
ORDER BY Total_quantity_sold DESC
LIMIT 3;

-- The highest value pizza order is Order ID #15674, with a total order value of $83 and quantity sold 4 to the The California Chicken Pizza

SELECT 
    od.order_id,
    pt.name AS pizza_name, od.quantity as quantity,
    SUM(od.quantity * p.price) AS order_value
FROM order_details od
JOIN pizzas p 
    ON od.pizza_id = p.pizza_id
JOIN pizza_types pt 
    ON pt.pizza_type_id = p.pizza_type_id
GROUP BY od.order_id, pt.name, quantity
ORDER BY order_value DESC
LIMIT 1;

-- On average, each order contains around 2.32 pizzas

SELECT 
    ROUND(SUM(quantity) / COUNT(DISTINCT order_id),
            2) AS avg_pizza_per_order
FROM
    order_details;

-- Total Quantity by Category
-- Classic	14888
-- Supreme	11987
-- Veggie	11649
-- Chicken	11050

SELECT 
    pt.category AS category, SUM(od.quantity) AS total_quantity
FROM
    pizza_types AS pt
        JOIN
    pizzas AS p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details AS od ON od.pizza_id = p.pizza_id
GROUP BY category
ORDER BY total_quantity DESC;

-- The highest number of pizzas were ordered 12 to 13 PM
-- 12	11832149
-- 13	11694198
-- 18	11338388
-- 17	10683107
-- 19	9505830
-- 16	9029757

SELECT 
    HOUR(o.time) AS hours, SUM(od.order_details_id) AS orders
FROM
    orders AS o
        JOIN
    order_details AS od ON o.order_id = od.order_details_id
GROUP BY hours
ORDER BY orders DESC;
