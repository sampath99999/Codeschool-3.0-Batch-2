-- Active: 1699516286983@@127.0.0.1@5432@postgres

CREATE DATABASE shopping;

CREATE TABLE
    customer (
        customer_id INT PRIMARY KEY,
        first_name VARCHAR(30),
        last_name VARCHAR(20),
        phone_number VARCHAR(15)
    );

CREATE TABLE
    product (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(100) NOT NULL,
        price NUMERIC(5, 2),
        description TEXT
    );

CREATE TABLE
    orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        product_id INT,
        order_date DATE,
        quantity INT,
        total_amount DECIMAL(10, 2),
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
        FOREIGN KEY (product_id) REFERENCES Product(product_id)
    );

CREATE TABLE
    Shipping (
        shipping_id INT PRIMARY KEY,
        order_id INT,
        status INT,
        shipping_date DATE,
        delivery_date DATE,
        FOREIGN KEY (order_id) REFERENCES orders(order_id),
        CHECK (status IN (1, 2, 3, 4))
    );

ALTER TABLE customer DROP COLUMN phone_number;

ALTER TABLE customer ADD phone_number INT;

ALTER TABLE customer DROP COLUMN phone_number;

ALTER TABLE customer ADD phone_number VARCHAR(15);

SELECT * FROM customer;

INSERT INTO
    customer (
        customer_id,
        first_name,
        last_name,
        phone_number
    )
VALUES (
        1,
        'Bharat',
        'Bunny',
        '98899-56456'
    ), (2, 'Mad', 'Max', '88988-12345'), (
        3,
        'Beast',
        'Arya',
        '77899-56456'
    ), (
        4,
        'Turbo',
        'Gana',
        '98877-77456'
    ), (
        5,
        'Sharath',
        'Kumar',
        '98899-55555'
    ), (
        6,
        'Sunil',
        'Reddy',
        '98440-56456'
    ), (
        7,
        'Prasad',
        'Reddy',
        '93981-56456'
    ), (
        8,
        'Narasimha',
        'Reddy',
        '77801-56456'
    ), (
        9,
        'Nishanth',
        'Reddy',
        '9381-61066'
    ), (
        10,
        'Sai',
        'Kumar',
        '63742-55789'
    );

ALTER TABLE product DROP COLUMN price;

ALTER TABLE product ADD price DECIMAL(10 , 2);

INSERT INTO
    product(
        product_id,
        product_name,
        price,
        description
    )
VALUES
(
        101,
        'Shirts',
        500.215,
        'Top_wear'
    ), (
        102,
        'Jeans',
        600.214,
        'Bottom_wear'
    ), (
        103,
        'Sweaters',
        400.616,
        'Winter_wear'
    ), (
        104,
        'Casual_shoes',
        300.414,
        'Foot_wear'
    ), (
        105,
        'Formal_shoes',
        200.414,
        'Foot_wear'
    ), (
        106,
        'Tracks',
        100.213,
        'Active_wear'
    ), (
        107,
        'Kurtas',
        700.514,
        'Ethnic_wear'
    ), (
        108,
        'Perfumes', 120.216,
        'Grooming'
    ), (
        109,
        'Watches' ,150.219,
        'Gadgets'
    ), (110, 'Bag', 450.616, 'Luggage');

    INSERT INTO 
      orders(order_id , customer_id , product_id , order_date , quantity , total_amount)
VALUES(201 ,  1 , 101 , '01-01-2023' , 4 , 1200.414), (202 ,  2 , 102 , '02-01-2023' , 2 , 400.214),(203 , 3 , 103 , '03-01-2023' , 3 , 800.515),(204 ,  4 , 104 , '04-01-2023' , 0 , 000.00),(205 , 5 , 105 , '05-01-2023' , 4 , 1000.414),(206 , 6 , 106 , '06-01-2023' , 3 , 750.315),(207 , 7 , 107 , '07-01-2023' , 5 , 1250.335),(208 , 8 , 108 , '08-01-2023' , 5 ,1200.414),(209 , 9 , 109 , '09-01-2023' , 2 , 700.914),(210 , 10 , 110 , '10-01-2023' , 0 , 000.000);




INSERT INTO 
      Shipping(shipping_id , order_id ,status , shipping_date , delivery_date )
VALUES(301 , 201 , 1 , '01-05-2023' , '03-05-2023'),(302 , 202 , 2 , '04-05-2023' , '07-05-2023'),(303 , 203 , 4 , '08-05-2023' , '10-05-2023'),(304 , 204 , 1 , '11-05-2023' , '14-05-2023'),(305 , 205 , 3 , '15-05-2023' , '18-05-2023'),(306 , 206 , 2 , '19-05-2023' , '21-05-2023'),(307 , 207 , 3 , '22-05-2023' , '25-05-2023'),(308 , 208 , 4 , '26-05-2023' , '28-05-2023'),(309 , 209 , 3 , '29-05-2023' , '31-05-2023'),(310 , 210 , 1 , '02-06-2023' , '05-06-2023');

SELECT * FROM customer;

SELECT c.*
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id;

SELECT c.*, MAX(o.total_amount) AS highest_total_amount
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY highest_total_amount DESC;

SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(oi.quantity * p.price) AS total_total_amount,
    AVG(oi.quantity * p.price) AS average_total_amount
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

    SELECT * FROM product;

SELECT DISTINCT p.*
FROM product p
JOIN orders oi ON p.product_id = oi.product_id;

 SELECT
    p.product_id,
    p.product_name,
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
    SUM(oi.quantity) AS total_quantity_sold
FROM
    product p
JOIN
    orders oi ON p.product_id = oi.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_quantity_sold DESC
LIMIT 6;

    SELECT * FROM orders;

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
    s.status = 1;

    SELECT * FROM Shipping;

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