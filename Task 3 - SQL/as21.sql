
create database  student;
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(8,2),
    quantity INTEGER,
    description TEXT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    order_amount INT,
    quantity INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE Shipping (
    shipping_id INT PRIMARY KEY,
    order_id INT,
    status INT,
    shipping_date DATE,
    delivery_date DATE,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CHECK (status IN (1, 2, 3, 4))
);
insert into customer(
    customer_id,first_name, last_name,
    email,phone_number
) VALUES
(1,'John','Doe', 'john.doe@gmail.com', '+91-876543
'),
(2,'Jane','Smith', 'janesmith@yahoo.com', '+91-765432
'),
(3,'Mary','Brown', 'marybrown@hotmail.com', '+91-654321
'),
(4,'Robert','Williams', 'robertwilliams@aol.com', '+91-54321
');
INSERT INTO product(product_id,product_name,
price,description)VALUES(
    1,'Product A',100.00,'This is a great product'
),
(2,'Product B',200.00,'Another good product'),
(3,'Product C',300.00,'The best one yet!'),
(4,'Product D',400.00,'Awesome product');
insert into orders(
    order_id,customer_id,product_id,
    order_date,
    quantity,order_amount,total_amount)values(
    1,1,1,'2021-01-01',2,200.00,400
),
(2,1,2,'2021-02-01',3,300.00,900),
(3,2,3,'2021-03-01',4,400.00,160
),
(
    4,3,4,'2021-04-01',5,500.00,250
);
insert into shipping(shipping_id,order_id,status,shipping_date,delivery_date) values(1,
1,1,'2021-06-01','2021-07-01'),(2,2
,2,'2021-07-01','2021-08-01'),(3,3,
3,'2021-08-01','2021-09-01'),(4,4,4
,'2021-09-01','2021-10-01');
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