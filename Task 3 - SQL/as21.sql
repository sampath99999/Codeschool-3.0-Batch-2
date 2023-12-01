
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
3,'2021-08-01','2021-09-01'),(4,4,4,'2021-09-01','2021-10-01');

SELECT * FROM customer;
SELECT * from orders;
SELECT  * from shipping;
SELECT * from product;
SELECT c.*
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

create database dtu;


CREATE TABLE
    Customer (
        customer_id INT PRIMARY KEY,
        first_name VARCHAR(30),
        last_name VARCHAR(20),
        phone_number VARCHAR(15),
        address VARCHAR(29)
    );

    CREATE TABLE
    Product (
        product_id INT PRIMARY KEY,
        product_name VARCHAR(100) NOT NULL,
        price DECIMAL(10 , 2),
        description TEXT
    );

    CREATE TABLE
    orders (
        order_id INT PRIMARY KEY,
        customer_id INT,
        order_date DATE,
        total_amount DECIMAL(10, 2),
        order_amount DECIMAL(10, 2),
        FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
    );

    CREATE TABLE order_item (
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

    INSERT INTO
    customer (
        customer_id,
        first_name,
        last_name,
        phone_number
    )
VALUES (
        1,
        'Jimmy',
        'choe',
        '98899-56456'
    ),
     (2,
       'Lad',
       'left',
       '88988-12345'), 
    (
        3,
        'Brook',
        'lesnar',
        '77899-56456'
    ), (
        4,
        'lefft',
        'Gana',
        '98877-77456'
    ), (
        5,
        'raju',
        'Kumar',
        '98899-55555'
    ), (
        6,
        'vakanta',
        'vamsi',
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
    orders(order_id , customer_id , order_date , total_amount ,order_amount)
VALUES (201 , 3 , '01-01-23' , 1600.218,240.98),(202 , 6 , '03-01-23' , 1000.418,440.98),(203 , 1 , '05-01-23' , 800.818,560.87),(205 , 8 , '09-01-23' , 1100.314,459.90) ,(206 , 10 , '11-01-23' , 1500.218,560.90),(207 , 9 , '13-01-23' , 1500.218,786.90) , (208 ,  5 , '15-01-23' , 1600.218,780.98) , (209 , 7 , '17-01-23' , 900.218,980.09);    

INSERT INTO 
     order_item (order_item_id , order_id , product_id , quantity)
VALUES(501 , 201 , 101 , 2),(502 , 201 , 102 , 1),(503 , 201 , 108 , 1),(504 , 202 , 101 , 1),(505 , 202 , 107 , 1),(506, 203 , 104 , 1),(507 , 203 , 101 , 1),(508 , 205 , 101 , 1),(509 , 205 , 102 , 1),(510, 206 , 101 , 2),(511 , 206 , 102 , 1),(512 , 207 , 105 , 1),(513 , 207 , 110 , 1),(514 , 207 , 109 , 4),(515 , 207 , 108 , 1),(516 , 208 , 107 , 1),(517 , 208 , 105 , 2),(518 , 209 , 101 , 1),(519 , 209 , 105 , 1),(520 , 209 , 106 , 2);

INSERT INTO
    Shipping(
        shipping_id,
        order_id,
        status,
        shipping_date,
        delivery_date
    )
VALUES
(
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
--List all customers with complete details--
    SELECT * FROM customer;
    --List all products with complete details--
    SELECT * FROM product;
    SELECT * FROM order_item;
   SELECT product.product_id ,order_item.order_id, product.product_name
FROM product
   JOIN order_item ON product.product_id = order_item.product_id;
   ----List all orders with complete details--
    SELECT * FROM orders;
  ---3--
  ---List customers who made orders----
  SELECT c.*
FROM Customer c
    JOIN orders o ON c.customer_id = o.customer_id;
----List customers who made highest orders----
SELECT
    c.*,
    MAX(o.total_amount) AS highest_total_amount
FROM Customer c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
ORDER BY
    highest_total_amount DESC
LIMIT 6;

    SELECT
    customer_id,
    SUM(order_amount) AS total_order_amount
FROM
    orders
GROUP BY
    customer_id
ORDER BY
    total_order_amount DESC
LIMIT 1;
--4--
SELECT
    c.customer_id
FROM
    customer c
LEFT JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    o.customer_id IS NULL;
---5--

SELECT DISTINCT
    customer_id
FROM
    orders;
----Customer wise order amounts with average amount---

    SELECT
    customer_id,
    SUM(order_amount) AS total_order_amount,
    AVG(order_amount) AS average_order_amount
FROM
    orders
GROUP BY
    customer_id;
    ---List customers who did not make any order---
    SELECT
    c.customer_id,
   c.first_name,
   c.last_name
FROM customer c
LEFT JOIN
    orders o ON c.customer_id = o.customer_id
WHERE
    o.customer_id IS NULL;

    ----------------------List only those products which are ordered by customers------
    SELECT DISTINCT
    p.product_id,
    p.product_name
FROM
    product p
JOIN
    order_item od ON p.product_id = od.product_id;

---6---
SELECT DISTINCT
    p.product_id,
    p.product_name
FROM
    product p
JOIN
    order_item od ON p.product_id = od.product_id
JOIN
    orders o ON od.order_id = o.order_id;
  --7--

    SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_sales_amount
FROM
    product p
JOIN
     order_item od ON p.product_id = od.product_id
GROUP BY
    p.product_id, p.product_name;
    --8--
    SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM
    product p
JOIN
    order_item od ON p.product_id = od.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_quantity_sold DESC;
--9--
----product wise sale summery----
    SELECT
    o.order_id,
    o.order_date,
    c.customer_id,
    p.product_id,
    p.product_name,
    od.quantity,
    p.price
FROM
    orders o
JOIN
    customer c ON o.customer_id = c.customer_id
JOIN
    order_item od ON o.order_id = od.order_id
JOIN
    product p ON od.product_id = p.product_id;
--10--
---List products which are highest sold------------
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold,
    SUM(od.quantity * p.price) AS total_sales_amount
FROM
    product p
JOIN
    order_item od ON p.product_id = od.product_id
JOIN
    orders o ON od.order_id = o.order_id
GROUP BY
    p.product_id, p.product_name;
SELECT
    p.product_id,
    p.product_name,
    COALESCE(SUM(od.quantity), 0) AS total_quantity_sold
FROM
    product p
LEFT JOIN
    order_item od ON p.product_id = od.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_quantity_sold DESC;
--10--

    SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM
    product p
JOIN
    order_item od ON p.product_id = od.product_id
GROUP BY
    p.product_id, p.product_name
ORDER BY
    total_quantity_sold DESC
LIMIT 10; -- Adjust the limit according to your needs, e.g., top 10 products

--11--
SELECT  order_id,status
FROM shipping
where status<=2;
--12--
SELECT orders.*, Shipping.*
FROM orders
JOIN Shipping ON orders.order_id = Shipping.order_id;

SELECT  order_id,status
FROM shipping;
//13//
SELECT  order_id,status
FROM shipping
where status=4;
--13--
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

