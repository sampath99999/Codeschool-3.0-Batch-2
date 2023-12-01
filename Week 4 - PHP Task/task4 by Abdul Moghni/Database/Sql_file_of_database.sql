-- Active: 1700995460540@@127.0.0.1@5432@Management

CREATE TABLE
    users (
        user_id SERIAL PRIMARY KEY,
        username VARCHAR(255) NOT NULL UNIQUE,
        ddocode VARCHAR CHECK (LENGTH(ddocode) = 11) not null unique,
        password VARCHAR(255) NOT NULL,
        token VARCHAR(255)
    );

CREATE TABLE
    employee_details (
        employee_code SERIAL PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255),
        doj DATE,
        dob DATE,
        gender VARCHAR(255),
        phone BIGINT,
        working_status VARCHAR(255),
        designation VARCHAR(255),
        location VARCHAR(255),
        ddocode VARCHAR REFERENCES users(ddocode)
    );

SELECT setval( 'employee_details_employee_code_seq', 20000 );

-- Earnings Table

CREATE TABLE
    earnings (
        earning_id SERIAL PRIMARY KEY,
        employee_code INTEGER REFERENCES employee_details(employee_code),
        earning_type VARCHAR(255)  NOT NULL,
        amount DECIMAL(10, 2) NOT NULL,
        earning_date DATE
    );

-- Deductions Table

CREATE TABLE
    deductions (
        deduction_id SERIAL PRIMARY KEY,
        employee_code INTEGER REFERENCES employee_details(employee_code),
        deduction_type VARCHAR(255)  NOT NULL,
        amount DECIMAL(10, 2) NOT NULL,
        deduction_date DATE
    );

INSERT INTO
    users (
        username,
        ddocode,
        password,
        token
    )
VALUES (
        'AaravKumar',
        12345678901,
        'password123',
        NULL
    ), (
        'AnanyaPatel',
        23456789012,
        'securepass',
        NULL
    ), (
        'RohanSharma',
        34567890123,
        'mypassword',
        NULL
    );

SELECT *
FROM users
WHERE (
        username = 'AaravKumar'
        OR ddocode = ''
    )
    AND password = 'password123';

select * from employee_details;

select * from earnings;