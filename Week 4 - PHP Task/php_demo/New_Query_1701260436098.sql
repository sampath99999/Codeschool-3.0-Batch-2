-- Active: 1699519056535@@127.0.0.1@5432@movies@public

create table
    users(
        id SERIAL PRIMARY KEY NOT NULL,
        name VARCHAR(255),
        email VARCHAR(255),
        password varchar(255),
        token VARCHAR(255) UNIQUE
    );

select * from users;

CREATE TABLE
    theaters (
        theater_id SERIAL PRIMARY KEY,
        theater_name VARCHAR(255) NOT NULL,
        location VARCHAR(255) NOT NULL
    );

SELECT * FROM theaters;

SELECT * from shows;

CREATE TABLE
    shows (
        show_id SERIAL PRIMARY KEY,
        theater_id INT,
        movie_name VARCHAR(255) NOT NULL,
        show_running VARCHAR(20) NOT NULL CHECK (
            show_running IN (
                'running',
                'completed',
                'other'
            )
        ),
        FOREIGN KEY (theater_id) REFERENCES theaters(theater_id)
    );

alter table shows drop COLUMN show_time;

INSERT INTO
    shows (
        show_id,
        theater_id,
        movie_name,
        show_running
    )
VALUES (1, 2, 'Movie A', 'running'), (2, 3, 'Movie B', 'completed'), (3, 2, 'Movie C', 'other');

CREATE TABLE
    bookings (
        booking_id SERIAL PRIMARY KEY,
        show_id INT,
        user_id INT,
        booked_seats INT NOT NULL,
        FOREIGN KEY (show_id) REFERENCES shows(show_id)
    );
INSERT INTO bookings (show_id, user_id, booked_seats)
VALUES (1, 1, 2);
SELECT * from bookings;
DROP TABLE theaters;

drop table bookings;

drop table shows;