-- Active: 1699519056535@@127.0.0.1@5432@test@public

create table
    users(
        id SERIAL PRIMARY KEY NOT NULL,
        name VARCHAR(255),
        email VARCHAR(255),
        password varchar(255),
        token VARCHAR(255) UNIQUE
    );

select * from users;

create table
    employee(
        id SERIAL PRIMARY KEY NOT NULL,
        firstname VARCHAR(255),
        lastname VARCHAR,
        job varchar(255),
        email VARCHAR(255),
        phone BIGINT,
        mobilefax VARCHAR(255),
        fax VARCHAR(255)
    )

INSERT INTO
    employee (
        firstname,
        lastname,
        job,
        email,
        phone,
        mobilefax,
        fax,
        status
    )
VALUES (
        'John',
        'Doe',
        'Designer',
        'john.doe@example.com',
        '1234567890',
        '9876543210',
        'Fax123',
        'inactive'
    ), (
        'Jane',
        'Smith',
        'Developer',
        'jane.smith@example.com',
        '9876543210',
        '1234567890',
        'Fax456',
        'inactive'
    ), (
        'Alice',
        'Johnson',
        'Manager',
        'alice.johnson@example.com',
        '5555555555',
        '6666666666',
        'Fax789',
        'inactive'
    ), (
        'Bob',
        'Johnson',
        'Coordinator',
        'bob.johnson@example.com',
        '1111111111',
        '2222222222',
        'Fax999',
        'inactive'
    );

ALTER TABLE employee ADD COLUMN status VARCHAR(10) DEFAULT 'active';

select * from employee;

drop Table employee;