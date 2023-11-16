
create database  student;
SELECT * FROM customer;
SELECT * from orders;
SELECT  * from shipping;
SELECT * from product;SELECT c.*
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.*, MAX(o.order_amount) AS highest_order_amount
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY highest_order_amount DESC;
List customers who made highest orders

SELECT c.*, MAX(o.order_amount) AS highest_order_amount
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY highest_order_amount DESC
LIMIT 1;

Customer wise order amounts with average amount

SELECT c.*, SUM(o.quantity*p.price)/COUNT(*) as avg_order_amount
FROM customer c
JOIN orders o ON c.customer_id=o.customer_id
JOIN product p on o.product_id=p.product_id
GROUP BY c.customer_id
HAVING COUNT(*)>1
ORDER BY avg_order_amount DESC;
SELECT
    c.customer_id,
    c.first_name,
    c.last_name
FROM
    Customer c
LEFT JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    o.quantity > 0;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * p.price) AS total_order_amount
FROM
    customer c
JOIN
    orders o ON c.customer_id = o.customer_id
JOIN
    orders oi ON o.order_id = oi.order_id
JOIN
    product p ON oi.product_id = p.product_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    total_order_amount DESC
LIMIT 1;
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * p.price) AS total_order_amount,
    AVG(oi.quantity * p.price) AS average_order_amount
FROM
    customer c
JOIN
    orders o ON c.customer_id = o.customer_id
JOIN
    orders oi ON o.order_id = oi.order_id
JOIN
    product p ON oi.product_id = p.product_id
GROUP BY
    c.customer_id, c.first_name, c.last_name
ORDER BY
    c.customer_id;
  
    SELECT c.*
FROM customer c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
SELECT *
FROM product;

SELECT DISTINCT p.*
FROM product p
JOIN orders oi ON p.product_id = oi.product_id;//7//

SELECT DISTINCT p.*
FROM product p
JOIN orders oi ON p.product_id = oi.product_id;

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_sales_amount
FROM
    product p
JOIN
    orders oi ON p.product_id = oi.product_id
JOIN
    orders o ON oi.order_id = o.order_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_sales_amount DESC;
    ///8//

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_sales_amount
FROM
    product p
JOIN
    orders oi ON p.product_id = oi.product_id
JOIN
    orders o ON oi.order_id = o.order_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_sales_amount DESC;

    SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.quantity * p.price) AS total_sales_amount
FROM
    product p
JOIN
     orders oi ON p.product_id = oi.product_id
JOIN
    orders o ON oi.order_id = o.order_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_quantity_sold DESC
LIMIT 1;


//9//

SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.first_name,
    c.last_name,
    s.shipping_id,
    s.status AS shipping_status,
    s.shipment_date,
    s.delivery_date
FROM
    orders o
JOIN
    customer c ON o.customer_id = c.customer_id
LEFT JOIN
    shipping s ON o.order_id = s.order_id;

SELECT 
    o.order_id,
    o.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name,
    p.product_id,
    p.product_name,
    o.order_date,
    o.quantity,
    o.total_amount,
    s.status AS shipping_status,
    s.shipping_date,
    s.delivery_date
FROM 
    orders o
JOIN 
    customer c ON o.customer_id = c.customer_id
JOIN 
    product p ON o.product_id = p.product_id
JOIN 
    shipping s ON o.order_id = s.order_id;
    SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold
FROM
    product p
JOIN
    orders oi ON p.product_id = oi.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_quantity_sold DESC
LIMIT 3;

    SELECT *from orders;
    SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    c.first_name AS customer_first_name,
    c.last_name AS customer_last_name
FROM
    orders o
JOIN
    customer c ON o.customer_id = c.customer_id
LEFT JOIN
    shipping s ON o.order_id = s.order_id
WHERE
    s.order_id IS NULL;

    SELECT *from shipping;

SELECT o.order_id, o.order_date, s.status
FROM orders o
JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 1;

 SELECT o.order_id, o.order_date, s.status
FROM orders o
JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 2;
SELECT o.order_id, o.order_date, s.status
FROM orders o
JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 3;
SELECT o.order_id, o.order_date, s.status
FROM orders o
JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 4;