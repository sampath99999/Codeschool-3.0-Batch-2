-- Active: 1699612031259@@127.0.0.1@5432@postgres
create database ecomerce;
create table customer (
    id serial primary key,
    first_name varchar (50) not null,
    last_name varchar(50),
    mail varchar(50) ,
    address varchar(100)
   );
create table category(
    id serial primary key,
    category_type varchar(50)
);
create table product(
    id serial primary key,
    name_product varchar(50) not null,
    price decimal(8,2),
    category_id int references category(id)
);

create table orders(
    id serial primary key,
    order_year date,
    order_status varchar(50),
    customer_id int references customer(id)
);
create table order_items(
    id serial primary key,
    order_item_revenue int,
    quantity int,
    product_id int references product(id),
    orders_id int references orders(id)
);
insert into  customer (first_name, last_name, mail, address) values
    ('varsha', 'raju', 'xxx@example.com', 'hyderabd'),
        ('uma', 'raju', 'yyy@example.com', 'chennai'),
        ('usha', 'rani', 'zzz@example.com', 'hyderabd'),
        ('hari', 'raju', 'aaa@example.com', 'hyderabd'),
        ('harsha','reddy','bbb@example.com','banglore');
select * from customer;
insert into  category (category_type) values
    ('shopping'),
    ('working'),
    ('gardening'),
    ('cleaning'),
    ('typing');

 insert into product (name_product, price, category_id) values
    ('computer', 400.00, 1),
    ('shirt', 100.1, 2),
     ('mobiles', 200.1, 3),
      ('refridgerator', 300.1, 4),
       ('medicines', 500.1, 5);
 insert into orders (order_year, order_status, customer_id) values
    ('2023-01-15', 'unShipped', 1), 
      ('2023-02-15', 'Shipped', 2), 
        ('2023-03-15', 'pending', 3), 
  ('2023-04-15', 'Shipped', 4), 
  ('2023-05-15', 'pending', 5);
insert into order_items (order_item_revenue, quantity, product_id, orders_id) values
    (1999, 20, 1, 1),
     (2999, 30, 2, 2),
      (3999, 40, 3, 3),
       (4999, 70, 4, 4),
        (5999, 60, 5, 5);
select
    c.category_type,
    sum(oi.order_item_revenue) as total_revenue
from
    category c, product p, order_items oi
where
    c.id = p.category_id
    and p.id = oi.product_id
group by
    c.category_type; 

select c.first_name, c.last_name, COUNT(o.id) as order_count
from customer c
join orders o on c.id = o.customer_id
group by c.id
order by order_count; 

select c.first_name, c.last_name, AVG(oi.order_item_revenue) as average_order_value
from customer c
join orders o on c.id = o.customer_id
join order_items oi on o.id = oi.orders_id
group by c.id
order by average_order_value DESC;
 
 select
    c.id AS customer_id,
    c.first_name,
    c.last_name,
    (SELECT COUNT(*) from orders o where o.customer_id = c.id) as orders_count
from
    customer c
order by
    orders_count DESC;

select
    extract(month from o.order_year) as month,
   sum(oi.order_item_revenue) AS total_revenue
from
    orders o,
    order_items oi
where
    o.id = oi.orders_id
group by
    month
order by
    month;

select c.first_name, c.last_name, COUNT(oi.id) AS order_count
from customer c
join orders o ON c.id = o.customer_id
join order_items oi ON o.id = oi.orders_id
where oi.product_id = product_id
group by c.id
order by order_count DESC;

SELECT 
  EXTRACT(MONTH FROM o.order_year) AS month,
  AVG(oi.order_item_revenue) AS average_order_value
FROM orders o
JOIN order_items oi ON o.id = oi.orders_id
GROUP BY month
ORDER BY month;

SELECT
    p.id AS product_id,
    p.name_product,
    AVG(oi.quantity) AS average_quantity_ordered
FROM
    product p
JOIN
    order_items oi ON p.id = oi.product_id
GROUP BY
    p.id, p.name_product
ORDER BY
    average_quantity_ordered DESC;

select
    c.category_type,
    AVG(oi.order_item_revenue) AS average_revenue_per_customer
from
    category c
join
    product p ON c.id = p.category_id
join
    order_items oi ON p.id = oi.product_id
join
    orders o ON oi.orders_id = o.id
join
    customer cus ON o.customer_id = cus.id
group by
    c.category_type
order by
    average_revenue_per_customer DESC;


select
    EXTRACT(MONTH FROM o.order_year) AS month,
    o.order_status,
    SUM(oi.order_item_revenue) AS total_revenue
from
    orders o
join
    order_items oi ON o.id = oi.orders_id
group by
    month, o.order_status
order by
    month, o.order_status;