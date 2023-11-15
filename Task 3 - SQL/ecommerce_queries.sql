-- Active: 1699515905486@@127.0.0.1@5432@ecommerce@public

-- Active: 1699515905486@@127.0.0.1@5432

CREATE DATABASE Ecommerce ;

CREATE TABLE
    Products (
        product_id SERIAL NOT NULL,
        name VARCHAR(255) NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        category_id INT NOT NULL,
        PRIMARY KEY (product_id),
        FOREIGN KEY (category_id) REFERENCES Categories (category_id)
    );

CREATE TABLE
    Categories (
        category_id SERIAL NOT NULL,
        name VARCHAR(255) NOT NULL,
        PRIMARY KEY (category_id)
    );

CREATE TABLE
    Customers (
        customer_id SERIAL NOT NULL,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        email VARCHAR(255) NOT NULL,
        address TEXT NOT NULL,
        PRIMARY KEY (customer_id)
    );

CREATE TABLE
    Orders (
        order_id SERIAL NOT NULL,
        customer_id INT NOT NULL,
        order_date DATE NOT NULL,
        status VARCHAR(255) NOT NULL,
        PRIMARY KEY (order_id),
        FOREIGN KEY (customer_id) REFERENCES Customers (customer_id)
    );

CREATE TABLE
    OrderItems (
        order_item_id SERIAL NOT NULL,
        order_id INT NOT NULL,
        product_id INT NOT NULL,
        quantity INT NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        PRIMARY KEY (order_item_id),
        FOREIGN KEY (order_id) REFERENCES Orders (order_id),
        FOREIGN KEY (product_id) REFERENCES Products (product_id)
    );

-- inserting into categories table

INSERT INTO Categories (name)
VALUES ('Electronics'), ('Clothing'), ('Home and Garden'), ('Books'), ('Sports');

-- inserting into products table

INSERT INTO
    Products (name, price, category_id)
VALUES ('Laptop', 999.99, 1), ('T-shirt', 19.99, 2), ('Garden Tools Set', 49.99, 3), ('Programming Book', 29.99, 4), ('Running Shoes', 79.99, 5), ('Smartphone', 699.99, 1), ('Jeans', 39.99, 2), ('Outdoor Furniture', 149.99, 3), ('Mystery Novel', 14.99, 4), ('Basketball', 24.99, 5);

-- price = price of  each product

--inserting  into customer table

INSERT INTO
    Customers (
        first_name,
        last_name,
        email,
        address
    )
VALUES (
        'John',
        'Doe',
        'john.doe@email.com',
        '123 Main St, City'
    ), (
        'Jane',
        'Smith',
        'jane.smith@email.com',
        '456 Oak St, Town'
    ), (
        'Bob',
        'Johnson',
        'bob.johnson@email.com',
        '789 Pine St, Village'
    ), (
        'Alice',
        'Williams',
        'alice.williams@email.com',
        '101 Elm St, Hamlet'
    ), (
        'Charlie',
        'Brown',
        'charlie.brown@email.com',
        '202 Maple St, Borough'
    ), (
        'Eva',
        'Davis',
        'eva.davis@email.com',
        '303 Cedar St, District'
    ), (
        'Frank',
        'Moore',
        'frank.moore@email.com',
        '404 Birch St, Suburb'
    ), (
        'Grace',
        'Taylor',
        'grace.taylor@email.com',
        '505 Walnut St, Neighborhood'
    ), (
        'Henry',
        'Clark',
        'henry.clark@email.com',
        '606 Pine St, Community'
    ), (
        'Ivy',
        'Martin',
        'ivy.martin@email.com',
        '707 Oak St, Township'
    );

-- Insert into orders

INSERT INTO
    Orders (
        customer_id,
        order_date,
        status
    )
VALUES (1, '2023-01-01', 'Shipped'), (2, '2023-01-02', 'Processing'), (3, '2023-03-03', 'Delivered'), (4, '2023-03-04', 'Shipped'), (5, '2023-03-05', 'Processing'), (6, '2023-04-06', 'Shipped'), (7, '2023-05-07', 'Delivered'), (8, '2023-06-08', 'Processing'), (9, '2023-06-09', 'Shipped'), (10, '2023-07-10', 'Delivered');

INSERT INTO
    Orders (
        customer_id,
        order_date,
        status
    )
VALUES (4, '2023-08-16', 'shipped');

INSERT INTO
    Orders (
        customer_id,
        order_date,
        status
    )
VALUES (6, '2023-08-16', 'shipped');

-- Insert into  order items

INSERT INTO
    OrderItems (
        order_id,
        product_id,
        quantity,
        price
    )
VALUES (1, 1, 1, 999.99), (2, 2, 2, 39.98), (3, 3, 1, 49.99), (4, 4, 3, 89.97), (5, 5, 1, 79.99), (6, 6, 1, 699.99), (7, 7, 2, 79.98), (8, 8, 1, 149.99), (9, 9, 3, 44.97), (10, 10, 2, 49.98);

-- price = total quantity of a  particular item * quantity of that particular item

-- adding more items to existing orders

insert into
    orderitems(
        order_id,
        product_id,
        quantity,
        price
    )
VALUES(1, 3, 1, 49.99);

insert into
    orderitems(
        order_id,
        product_id,
        quantity,
        price
    )
VALUES(2, 4, 2, 29.99 * 2);

-- adding item to new order

insert into
    orderitems(
        order_id,
        product_id,
        quantity,
        price
    )
VALUES(11, 6, 1, 699.9)

-- adding item to new order

insert into
    orderitems(
        order_id,
        product_id,
        quantity,
        price
    )
VALUES(12, 6, 1, 699.9)

-- Retrieve data from tables

SELECT * FROM customers;

SELECT * FROM categories;

SELECT * FROM products;

SELECT * FROM orders;

SELECT * FROM orderitems;

-- Drop tables

DROP TABLE customers;

DROP TABLE categories;

DROP TABLE products;

DROP TABLE orders;

DROP TABLE orderitems;

-- Retrieve each order price

SELECT
    orderitems.order_id,
    sum(orderitems.price) AS each_order_price
FROM orderitems
    INNER JOIN products on orderitems.product_id = products.product_id
GROUP BY orderitems.order_id
ORDER BY orderitems.order_id;

-- 1.What is the total revenue for each category?

SELECT
    products.category_id,
    categories.name AS category_name,
    sum(orderitems.price) AS total_revenue
FROM orderitems
    INNER join products ON orderitems.product_id = products.product_id
    INNER join categories on products.category_id = categories.category_id
group by
    products.category_id,
    categories.name
order by total_revenue;

-- 2. Which customer has the most orders?

-- 1st solution

SELECT
    orders.customer_id,
    count(orders.customer_id) AS no_of_orders,
    customers.first_name,
    customers.last_name
FROM orders
    INNER join customers on orders.customer_id = customers.customer_id
GROUP BY
    orders.customer_id,
    customers.first_name,
    customers.last_name
ORDER BY no_of_orders DESC
limit 1;

-- 2nd solution

WITH total_orders_customer AS(
        SELECT
            count(orders.customer_id) AS no_of_orders,
            customers.first_name AS first_name,
            customers.last_name AS last_name
        from orders
            INNER join customers on orders.customer_id = customers.customer_id
        group by
            orders.customer_id,
            customers.first_name,
            customers.last_name
    )
select
    first_name,
    last_name,
    no_of_orders
from total_orders_customer
where no_of_orders = (
        select
            max(no_of_orders)
        from
            total_orders_customer
    )

-- 3. What is the average order value for each customer?

WITH
    -- finding total amount spent by customers on all of their orders
    expenditure_on_all_orders_per_customer AS(
        SELECT
            orders.customer_id AS customer_id,
            sum(price) AS total_expenditure
        FROM orderitems
            INNER join orders ON orderitems.order_id = orders.order_id
        GROUP BY
            orders.customer_id
        order by
            orders.customer_id
    ),
    -- finding total number of orders given by each customer
    total_orders_per_customer AS (
        SELECT
            orders.customer_id AS customer_id,
            customers.first_name AS first_name,
            customers.last_name AS last_name,
            count(orders.customer_id) AS no_of_orders
        FROM orders
            INNER join customers on orders.customer_id = customers.customer_id
        GROUP BY
            orders.customer_id,
            customers.first_name,
            customers.last_name
        ORDER BY customer_id
    )
SELECT
    expenditure_on_all_orders_per_customer.customer_id,
    total_orders_per_customer.first_name,
    total_orders_per_customer.last_name,
    ROUND(
        expenditure_on_all_orders_per_customer.total_expenditure / total_orders_per_customer.no_of_orders,
        2
    ) AS average_order_value
FROM
    expenditure_on_all_orders_per_customer
    INNER JOIN total_orders_per_customer ON expenditure_on_all_orders_per_customer.customer_id = total_orders_per_customer.customer_id;

-- 4. What is the total revenue for each month?

select
    to_char(order_date, 'month') AS month_name,
    sum(price) AS total_revenue
from orders
    INNER join orderitems on orders.order_id = orderitems.order_id
GROUP BY
    month_name,
    EXTRACT(
        MONTH
        FROM order_date
    )
ORDER BY EXTRACT(
        MONTH
        FROM order_date
    );

-- 5. Which products have been ordered the most and how many times?

-- 1st solution

SELECT
    orderitems.product_id,
    products.name,
    sum(quantity) AS total_ordered
FROM orderitems
    INNER join products on orderitems.product_id = products.product_id
GROUP BY
    orderitems.product_id,
    products.name
ORDER BY total_ordered DESC
limit 1;

-- 2nd solution

with most_order_items AS (
        SELECT
            orderitems.product_id AS product_id,
            products.name AS product_name,
            sum(quantity) AS total_ordered
        FROM orderitems
            INNER join products on orderitems.product_id = products.product_id
        GROUP BY
            orderitems.product_id,
            products.name
    )
select
    product_id,
    product_name,
    total_ordered
from most_order_items
where total_ordered = (
        select
            max(total_ordered)
        from
            most_order_items
    );

-- 6. Which customers have ordered a particular product and how many times?

-- SELECT

--     orders.customer_id,

--     orderitems.product_id,

--     customers.first_name,

--     customers.last_name,

--     products.name,

--     orderitems.quantity

-- FROM orderitems

--     INNER JOIN orders ON orderitems.order_id = orders.order_id

--     INNER JOIN products ON orderitems.product_id = products.product_id

--     INNER JOIN customers on orders.customer_id = customers.customer_id

-- ORDER BY orders.customer_id;

SELECT
    orders.customer_id,
    orderitems.product_id,
    count(orderitems.product_id) as order_count,
    products.name
from orderitems
    INNER JOIN orders ON orderitems.order_id = orders.order_id
    INNER JOIN products ON orderitems.product_id = products.product_id
GROUP BY
    orders.customer_id,
    orderitems.product_id,
    products.name
ORDER BY
    order_count DESC,
    orders.customer_id ASC;

-- 7. What is the average order value for each month?

-- for each month sum of all orders,number of orders  is calculated

WITH
    total_order_value_count AS (
        SELECT extract(
                MONTH
                FROM
                    orders.order_date
            ) AS month_no,
            Sum(orderitems.price) AS total_price,
            count(
                extract(
                    MONTH
                    FROM
                        orders.order_date
                )
            ) AS no_of_orders
        FROM orderitems
            INNER JOIN orders ON orderitems.order_id = orders.order_id
        GROUP BY month_no
        ORDER by month_no
    )
SELECT
    month_no,
    total_price,
    no_of_orders,
    ROUND(total_price / no_of_orders, 2) AS Average_order_value
FROM total_order_value_count;

-- 8. What is the average quantity ordered for each product?

WITH
    total_quantity_product AS(
        -- total quantities of each product
        SELECT
            orderitems.product_id as product_id,
            sum(orderitems.quantity) as total_quantity
        FROM orderitems
            INNER JOIN orders ON orderitems.order_id = orders.order_id
        GROUP BY
            orderitems.product_id
        ORDER BY
            orderitems.product_id ASC
    ),
    product_count_different_orders AS(
        -- number of times a product has been in different orders
        SELECT
            orderitems.product_id as product_id,
            count(orderitems.product_id) as no_of_different_orders
        FROM orderitems
            INNER JOIN orders ON orderitems.order_id = orders.order_id
        GROUP BY
            orderitems.product_id
        ORDER BY
            orderitems.product_id
    )
SELECT
    total_quantity_product.product_id,
    total_quantity_product.total_quantity,
    product_count_different_orders.no_of_different_orders,
    ROUND( (
            CAST(
                total_quantity_product.total_quantity as DECIMAL(10, 2)
            ) / product_count_different_orders.no_of_different_orders
        ),
        1
    ) AS average_quantity_ordered
FROM total_quantity_product
    INNER JOIN product_count_different_orders ON total_quantity_product.product_id = product_count_different_orders.product_id

-- 9. Which category has the highest revenue per customer on average?

-- SELECT *

-- FROM orderitems

--     inner join products on orderitems.product_id = products.product_id

-- ORDER BY products.category_id;

-- data on products price and their category

-- SELECT

--     products.name,

--     orderitems.price,

--     products.category_id

-- FROM orderitems

-- inner join products on orderitems.product_id = products.product_id

-- ORDER BY products.category_id

-- max total revenue per category per customer generated

SELECT
    products.category_id,
    categories.name,
    SUM(orderitems.price) AS total_revenue_per_category,
    COUNT(products.category_id) AS order_count,
    ROUND(
        SUM(orderitems.price) / COUNT(products.category_id),
        3
    ) AS average_revenue_per_category
FROM orderitems
    INNER JOIN products ON orderitems.product_id = products.product_id
    INNER JOIN categories ON products.category_id = categories.category_id
GROUP BY
    products.category_id,
    categories.name
ORDER BY
    average_revenue_per_category DESC
LIMIT 1;

-- 10. What is the total revenue for each status and month combination?

-- data on orders,order date,status

-- SELECT *

-- FROM orderitems

--     INNER JOIN orders ON orderitems.order_id = orders.order_id

-- ORDER BY orders.order_date;

SELECT Extract(
        MONTH
        from
            orders.order_date
    ) as month_number,
    to_char(orders.order_date, 'month'),
    orders.status,
    count(orders.status),
    sum(price) as total_revenue
FROM orderitems
    INNER JOIN orders ON orderitems.order_id = orders.order_id
GROUP BY
    orders.status,
    orders.order_date
ORDER BY orders.order_date;