-- Active: 1699519056535@@127.0.0.1@5432@dbtask@public

create DATABASE dbtask;

CREATE TABLE
    Theaters (
        TheaterID INT PRIMARY KEY,
        TheaterName VARCHAR(255),
        Location VARCHAR(255),
        Capacity INT
    );

INSERT INTO
    Theaters (
        TheaterID,
        TheaterName,
        Location,
        Capacity
    )
VALUES (
        1,
        'PVR CINEMAS',
        'Vijayawada',
        400
    ), (2, 'IMAX', 'Hyderabad', 800), (
        3,
        'Sarada Theater',
        'Visakhapatnam',
        600
    ), (
        4,
        'PVP Cinemas',
        'Kakinada',
        550
    ), (
        5,
        'Venkata Ramana Theatre',
        'Rajahmundry',
        500
    ), (
        6,
        'Sai Ram Theatre',
        'Tirupati',
        750
    ), (7, 'Cinepolis', 'Mumbai', 450), (
        8,
        'Sridevi Multiplex',
        'Kurnool',
        700
    ), (
        9,
        'Sri Rama Cinema',
        'Nellore',
        600
    ), (
        10,
        'Murali Krishna Theater',
        'Ongole',
        550
    );

select * from theaters;

CREATE TABLE
    TheaterBranches (
        BranchID INT PRIMARY KEY,
        TheaterID INT,
        BranchName VARCHAR(255),
        Location VARCHAR(255),
        FOREIGN KEY (TheaterID) REFERENCES Theaters(TheaterID)
    );

SELECT * from TheaterBranches;

CREATE TABLE
    Movies (
        MovieID INT PRIMARY KEY,
        Title VARCHAR(255),
        Genre VARCHAR(255),
        ReleaseDate DATE
    );

INSERT INTO
    Movies (
        MovieID,
        Title,
        Genre,
        ReleaseDate
    )
VALUES (
        201,
        'Interstellar',
        'Sci-Fi',
        '2014-11-07'
    ), (
        202,
        'Vikram',
        'Action',
        '2022-05-12'
    ), (
        203,
        'Inception',
        'Sci-Fi',
        '2010-07-08'
    ), (
        204,
        'Zathura',
        'Adventure',
        '2005-11-11'
    ), (
        205,
        'Darling',
        'Romance',
        '2010-04-23'
    ), (
        206,
        'Simha',
        'Action',
        '2010-04-30'
    ), (
        207,
        'Gabbar Singh',
        'Action',
        '2012-05-11'
    ), (
        208,
        'Yamadonga',
        'Action',
        '2007-08-15'
    ), (
        209,
        'RRR',
        'Action',
        '2022-03-24'
    ), (
        210,
        'The Pursuit of Happyness',
        'Biography',
        '2006-12-15'
    );

INSERT INTO
    TheaterBranches (
        BranchID,
        TheaterID,
        BranchName,
        Location
    )
VALUES (
        101,
        1,
        'PVP Vijayawada',
        'Vijayawada'
    ), (
        102,
        1,
        'TRENDSET Vijayawada',
        'Hyderabad'
    ), (
        103,
        2,
        'Bhaskara Vizag Central',
        'Central Vizag'
    ), (
        104,
        3,
        'Sarada Theater East',
        'Visakhapatnam'
    ), (
        105,
        4,
        'PVP Cinemas Central',
        'Kakinada'
    ), (
        106,
        5,
        'Venkata Ramana Theatre WEST',
        'Rajahmundry'
    );

SELECT * from Movies;

CREATE TABLE
    Shows (
        ShowID INT PRIMARY KEY,
        BranchID INT,
        MovieID INT,
        ShowDateTime TIMESTAMP,
        FOREIGN KEY (BranchID) REFERENCES TheaterBranches(BranchID),
        FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
    );

INSERT INTO
    Shows (
        ShowID,
        BranchID,
        MovieID,
        ShowDateTime
    )
VALUES (
        301,
        101,
        201,
        '2023-01-15 18:00:00'
    ), (
        302,
        102,
        202,
        '2023-02-28 20:00:00'
    ), (
        303,
        103,
        203,
        '2023-03-20 15:30:00'
    ), (
        304,
        104,
        204,
        '2023-04-10 18:30:00'
    ), (
        305,
        105,
        205,
        '2023-05-15 19:45:00'
    ), (
        306,
        106,
        206,
        '2023-06-20 16:15:00'
    );

SELECT * from Shows;

CREATE TABLE
    SlotSeats (
        SeatID INT PRIMARY KEY,
        ShowID INT,
        SeatNumber INT,
        IsBooked BOOLEAN,
        FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
    );

INSERT INTO
    SlotSeats (
        SeatID,
        ShowID,
        SeatNumber,
        IsBooked
    )
VALUES (401, 301, 1, FALSE), (402, 301, 2, FALSE), (403, 302, 1, TRUE), (404, 302, 2, FALSE), (405, 303, 1, FALSE), (406, 303, 2, TRUE);

SELECT * from SlotSeats;

CREATE TABLE
    Bookings (
        BookingID INT PRIMARY KEY,
        ShowID INT,
        UserID INT,
        PaymentMethod VARCHAR(255),
        BookingTime TIMESTAMP,
        TotalAmount DECIMAL(10, 2),
        FOREIGN KEY (ShowID) REFERENCES Shows(ShowID)
    );

INSERT INTO
    Bookings (
        BookingID,
        ShowID,
        UserID,
        PaymentMethod,
        BookingTime,
        TotalAmount
    )
VALUES (
        501,
        301,
        1001,
        'Credit Card',
        '2023-01-10 12:30:00',
        250.00
    ), (
        502,
        302,
        1002,
        'Debit Card',
        '2023-02-25 15:45:00',
        300.00
    ), (
        503,
        303,
        1003,
        'UPI',
        '2023-03-18 10:00:00',
        200.00
    ), (
        504,
        304,
        1004,
        'Credit Card',
        '2023-04-05 17:30:00',
        270.00
    ), (
        505,
        305,
        1005,
        'Cash',
        '2023-05-10 14:15:00',
        320.00
    );

SELECT * from bookings;

CREATE TABLE
    BookingSlots (
        BookingID INT,
        SeatID INT,
        PRIMARY KEY (BookingID, SeatID),
        FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID),
        FOREIGN KEY (SeatID) REFERENCES SlotSeats(SeatID)
    );

SELECT * from bookingslots;

INSERT INTO
    BookingSlots (BookingID, SeatID)
VALUES (501, 401), (502, 403), (503, 405), (504, 402), (505, 404);

INSERT INTO
    Movies (
        MovieID,
        Title,
        Genre,
        ReleaseDate
    )
VALUES (
        211,
        'Interstellar',
        'Sci-Fi',
        '2014-11-07'
    ), (
        212,
        'Vikram',
        'Action',
        '2022-05-12'
    ), (
        213,
        'Inception',
        'Sci-Fi',
        '2010-07-08'
    );

INSERT INTO
    Shows (
        ShowID,
        BranchID,
        MovieID,
        ShowDateTime
    )
VALUES (
        307,
        101,
        211,
        '2023-01-15 18:00:00'
    ), (
        308,
        102,
        212,
        '2023-02-28 20:00:00'
    ), (
        309,
        103,
        213,
        '2023-03-20 15:30:00'
    );

INSERT INTO
    SlotSeats (
        SeatID,
        ShowID,
        SeatNumber,
        IsBooked
    )
VALUES (407, 307, 1, FALSE), (408, 307, 2, FALSE), (409, 308, 1, TRUE), (410, 308, 2, FALSE), (411, 309, 1, FALSE), (412, 309, 2, TRUE);

INSERT INTO
    Bookings (
        BookingID,
        ShowID,
        UserID,
        PaymentMethod,
        BookingTime,
        TotalAmount
    )
VALUES (
        506,
        307,
        1006,
        'Credit Card',
        '2023-01-10 12:30:00',
        250.00
    ), (
        507,
        308,
        1007,
        'Debit Card',
        '2023-02-25 15:45:00',
        300.00
    ), (
        508,
        309,
        1008,
        'UPI',
        '2023-03-18 10:00:00',
        200.00
    );

SELECT * from bookings;

INSERT INTO
    BookingSlots (BookingID, SeatID)
VALUES (506, 407), (507, 409), (508, 411);



INSERT INTO
    Bookings (
        BookingID,
        ShowID,
        UserID,
        PaymentMethod,
        BookingTime,
        TotalAmount
    )
VALUES (
        509,
        303,
        1009,
        'Credit Card',
        '2023-03-20 16:00:00',
        220.00
    ), (
        510,
        306,
        1010,
        'Cash',
        '2023-06-20 17:30:00',
        310.00
    );
SELECT *
FROM Movies
WHERE MovieID NOT IN (
        SELECT
            DISTINCT MovieID
        FROM Shows
    );

SELECT * from bookings;
SELECT * from movies;
select * from shows;
INSERT INTO Bookings (BookingID, ShowID, UserID, PaymentMethod, BookingTime, TotalAmount)
VALUES
    (511, 306, 1006, 'Credit Card', '2023-06-25 14:00:00', 280.00),
    (512, 306, 1007, 'Debit Card', '2023-06-25 15:30:00', 320.00),
    (513, 306, 1008, 'UPI', '2023-06-25 16:45:00', 300.00);
-- QUERIES ---
SELECT *
FROM Movies
WHERE MovieID NOT IN (
        SELECT
            DISTINCT MovieID
        FROM Shows
    );

SELECT
M.Title AS MovieTitle,
COUNT(B.BookingID) AS BookingCount
FROM
    Movies M
JOIN
    Shows S ON M.MovieID = S.MovieID
JOIN
    Bookings B ON S.ShowID = B.ShowID
GROUP BY
    M.MovieID
ORDER BY
    BookingCount DESC
LIMIT 2;
SELECT tb.*, m.Title AS CurrentMovie
FROM TheaterBranches tb
JOIN Shows s ON tb.BranchID = s.BranchID
JOIN Movies m ON s.MovieID = m.MovieID
WHERE s.ShowDateTime <= CURRENT_TIMESTAMP
ORDER BY tb.BranchID;