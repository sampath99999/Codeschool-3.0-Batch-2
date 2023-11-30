-- Active: 1699516286983@@127.0.0.1@5432@store

CREATE DATABASE Store;

CREATE TABLE
    Customer (
        customer_id INT PRIMARY KEY,
        first_name VARCHAR(30),
        last_name VARCHAR(20),
        phone_number VARCHAR(15)
    );

CREATE TABLE
    Product (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(100) NOT NULL,
        price NUMERIC(5, 2),
        description TEXT
    );

CREATE TABLE
    orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        total_amount DECIMAL(10, 2),
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    );

CREATE TABLE
    order_item (
        order_item_id INT PRIMARY KEY,
        order_id INT,
        product_id INT,
        quantity INT,
        FOREIGN KEY (product_id) REFERENCES Product(product_id),
        FOREIGN KEY (order_id) REFERENCES orders(order_id)
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

------------- Values inserting into table --------------

INSERT INTO
    customer (
        customer_id,
        first_name,
        last_name,
        phone_number
    )
VALUES (1, 'John', 'Lee', '98899-56456'), (2, 'Mad', 'Max', '88988-12345'), (
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
    Product(
        product_id,
        product_name,
        price,
        description
    )
VALUES (
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
        'Perfumes',
        120.216,
        'Grooming'
    ), (
        109,
        'Watches',
        150.219,
        'Gadgets'
    ), (110, 'Bag', 450.616, 'Luggage');

INSERT INTO
    orders(
        order_id,
        customer_id,
        order_date,
        total_amount
    )
VALUES (201, 3, '01-01-23', 1600.218), (202, 6, '03-01-23', 1000.418), (203, 1, '05-01-23', 800.818), (205, 8, '09-01-23', 1100.314), (206, 10, '11-01-23', 1500.218), (207, 9, '13-01-23', 1500.218), (208, 5, '15-01-23', 1600.218), (209, 7, '17-01-23', 900.218);

INSERT INTO
    order_item (
        order_item_id,
        order_id,
        product_id,
        quantity
    )
VALUES
(501, 201, 101, 2), (502, 201, 102, 1), (503, 201, 108, 1), (504, 202, 101, 1), (505, 202, 107, 1), (506, 203, 104, 1), (507, 203, 101, 1), (508, 205, 101, 1), (509, 205, 102, 1), (510, 206, 101, 2), (511, 206, 102, 1), (512, 207, 105, 1), (513, 207, 110, 1), (514, 207, 109, 4), (515, 207, 108, 1), (516, 208, 107, 1), (517, 208, 105, 2), (518, 209, 101, 1), (519, 209, 105, 1), (520, 209, 106, 2);

INSERT INTO
    Shipping(
        shipping_id,
        order_id,
        status,
        shipping_date,
        delivery_date
    )
VALUES (
        301,
        201,
        1,
        '01-05-2023',
        '03-05-2023'
    ), (
        302,
        202,
        2,
        '04-05-2023',
        '07-05-2023'
    ), (
        303,
        203,
        4,
        '08-05-2023',
        '10-05-2023'
    ), (
        304,
        205,
        1,
        '11-05-2023',
        '14-05-2023'
    ), (
        305,
        206,
        3,
        '15-05-2023',
        '18-05-2023'
    ), (
        306,
        207,
        2,
        '19-05-2023',
        '21-05-2023'
    ), (
        307,
        208,
        3,
        '22-05-2023',
        '25-05-2023'
    ), (
        308,
        209,
        4,
        '26-05-2023',
        '28-05-2023'
    );

    ---------------- Queries --------------

SELECT * FROM Customer;

SELECT c.*
FROM Customer c
    JOIN orders o ON c.customer_id = o.customer_id;

SELECT
    c.*,
    MAX(o.total_amount) AS highest_total_amount
FROM Customer c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY
    highest_total_amount DESC
LIMIT 5;

SELECT
    Customer.customer_id,
    Customer.first_name,
    Customer.last_name,
    SUM(orders.total_amount) AS total_total_amount,
    AVG(orders.total_amount) AS average_total_amount
FROM Customer
    JOIN orders ON Customer.customer_id = orders.customer_id
GROUP BY
    Customer.customer_id,
    Customer.first_name,
    Customer.last_name
ORDER BY
    Customer.customer_id;

SELECT
    Customer.customer_id,
    Customer.first_name,
    Customer.last_name
FROM Customer
    LEFT JOIN orders ON Customer.customer_id = orders.customer_id
WHERE
    orders.order_id IS NULL;

SELECT * FROM product;

SELECT Product.product_id ,
       order_item.order_id , 
        Product.product_name 
FROM Product
JOIN order_item ON Product.product_id = order_item.product_id;

SELECT
    DISTINCT Product.product_id,
    Product.product_name
FROM Product
    JOIN order_ITEM ON Product.product_id = order_item.product_id;

SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_sales_amount
FROM Product p
    JOIN order_item od ON p.product_id = od.product_id
    JOIN orders o ON od.order_id = o.order_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_quantity_sold DESC;

SELECT
    p.product_id,
    p.product_name,
    COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
FROM Product p
    LEFT JOIN order_item od ON p.product_id = od.product_id
GROUP BY
    p.product_id,
    p.product_name
ORDER BY
    total_quantity_sold DESC;

SELECT orders.*, Customer.*
FROM orders
    JOIN Customer ON orders.customer_id = Customer.customer_id;

SELECT order_id,status FROM shipping where status<=2;

SELECT orders.*, Shipping.*
FROM orders
    JOIN Shipping ON orders.order_id = Shipping.order_id;

SELECT * FROM order_item;

SELECT
    o.order_id,
    o.order_date,
    s.status
FROM orders o
    JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 1;

SELECT
    o.order_id,
    o.order_date,
    s.status
FROM orders o
    JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 2;

SELECT
    o.order_id,
    o.order_date,
    s.status
FROM orders o
    JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 3;

SELECT
    o.order_id,
    o.order_date,
    s.status
FROM orders o
    JOIN Shipping s ON o.order_id = s.order_id
WHERE s.status = 4;

       