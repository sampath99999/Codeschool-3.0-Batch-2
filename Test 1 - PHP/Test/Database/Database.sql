CREATE table
    users (
        id serial primary key,
        username varchar(255) UNIQUE not null,
        password VARCHAR (255) not null,
        name varchar(255) not null,
        email varchar(255) unique not null,
        number VARCHAR (255) unique not null,
        token varchar(255)
    );

CREATE table
    products(
        product_id serial primary key,
        product_name varchar(255) UNIQUE not null,
        product_description varchar(255) not null,
        product_image varchar(255) not null,
        product_price varchar(255) not null,
        product_rating varchar(255) not null,
        users_id varchar(255) REFERENCES users(username)
    );

select * from users ;
select * from products;