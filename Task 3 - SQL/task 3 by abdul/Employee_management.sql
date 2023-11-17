-- Active: 1700135985174@@127.0.0.1@5432@Bill_Management
-- Employee table created
CREATE TABLE
    Employee_Details (
        Employee_Code SERIAL PRIMARY KEY,
        First_Name VARCHAR(255) NOT NULL,
        Last_Name VARCHAR(255),
        DOJ DATE,
        DOB DATE,
        Gender VARCHAR(255),
        Phone BIGINT,
        WORKING_Status VARCHAR(255),
        Designation VARCHAR(255),
        LOCATION VARCHAR(255)
    );

-- Set the starting value for the SERIAL column

SELECT setval('employee_details_employee_code_seq', 20000);

Create table Earn_Detection_List(
    id BIGINT Primary key,
    name VARCHAR(255),
    type int
);

create table Employee_Earn_deduction(
    id BIGINT,
    Employee_id  INT REFERENCES Employee_Details(Employee_Code),
    Earn_Detection_Code INT REFERENCES Earn_Detection_List(id),
    ammount BIGINT);

create table Transction(
    id BIGINT primary key,
    month VARCHAR(255),
    year INT,
    gross BIGINT,
    Deduction BIGINT,
    net BIGINT,
    status VARCHAR(255)
);
create table bill(
    id int primary key,
    transctionid INT REFERENCES Transction(id),
    Employee_id  INT REFERENCES Employee_Details(Employee_Code),
    gross BIGINT,
    deduction BIGINT,net BIGINT);

    create table Employee_BillEarnDedn(
id int primary key,
transctionid INT REFERENCES Transction(id),
bp_id INT REFERENCES bill(id),
Earn_Detection_List_id INT REFERENCES Earn_Detection_List(id),
ammount BIGINT
    );



-- Insert data into Employee_Details table
INSERT INTO Employee_Details (First_Name, Last_Name, DOJ, DOB, Gender, Phone, WORKING_Status, Designation, LOCATION)
VALUES 
('Amit', 'Sharma', '2023-01-01', '1990-05-15', 'Male', 1234567890, 'Active', 'Manager', 'Delhi'),
('Priya', 'Patel', '2023-02-01', '1988-08-20', 'Female', 9876543210, 'Inactive', 'Developer', 'Mumbai'),
('Rahul', 'Gupta', '2023-03-01', '1995-11-10', 'Male', 5555555555, 'Active', 'Analyst', 'Bangalore'),
('Kavita', 'Singh', '2023-04-01', '1987-07-05', 'Female', 9998887777, 'Active', 'Engineer', 'Chennai'),
('Vivek', 'Verma', '2023-05-01', '1980-12-15', 'Male', 3332221111, 'Inactive', 'Supervisor', 'Mumbai'),
('Ananya', 'Reddy', '2023-06-01', '1993-09-25', 'Female', 4443332222, 'Active', 'Coordinator', 'Hyderabad'),
('Nikhil', 'Kumar', '2023-07-01', '1982-03-08', 'Male', 6667778888, 'Active', 'Manager', 'Pune'),
('Swati', 'Joshi', '2023-08-01', '1989-06-18', 'Female', 1110009999, 'Inactive', 'Developer', 'Mumbai'),
('Rajesh', 'Yadav', '2023-09-01', '1975-10-30', 'Male', 8889990000, 'Active', 'Analyst', 'Mumbai'),
('Aishwarya', 'Rao', '2023-10-01', '1984-04-12', 'Female', 7778889999, 'Active', 'Engineer', 'Jaipur');


-- Insert data into Earn_Detection_List table
INSERT INTO Earn_Detection_List (id, name, type)
VALUES 
(1, 'Basic Pay', 1),
(2, 'House Rent Allowance', 1),
(3, 'City Compensatory Allowance', 1),
(4, 'Professional Tax', 2),
(5, 'Income Tax', 2);

-- Insert data into Employee_Earn_deduction table with Employee_id starting from 20001
INSERT INTO Employee_Earn_deduction (id, Employee_id, Earn_Detection_Code, ammount)
VALUES 
(1, 20001, 1, 5000),
(2, 20002, 2, 2000),
(3, 20003, 1, 6000),
(4, 20004, 3, 1000),
(5, 20005, 1, 5500),
(6, 20006, 4, 1500),
(7, 20007, 2, 2500),
(8, 20008, 1, 7000),
(9, 20009, 3, 1200),
(10, 20010, 5, 1800);


-- Insert data into Transction table with status 'Approved'
INSERT INTO Transction (id, month, year, gross, Deduction, net, status)
VALUES 
(1, 'January', 2023, 10000, 2000, 8000, 'Approved'),
(2, 'February', 2023, 12000, 2500, 9500, 'Approved'),
(3, 'March', 2023, 11000, 1800, 9200, 'Approved'),
(4, 'April', 2023, 13000, 3000, 10000, 'Approved'),
(5, 'May', 2023, 10500, 2200, 8300, 'Approved'),
(6, 'June', 2023, 12500, 2700, 9800, 'Approved'),
(7, 'July', 2023, 11500, 2400, 9100, 'Approved'),
(8, 'August', 2023, 13500, 3200, 10300, 'Approved'),
(9, 'September', 2023, 10700, 2000, 8700, 'Approved'),
(10, 'October', 2023, 14000, 3500, 10500, 'Approved');


-- Insert data into bill table
INSERT INTO bill (id, transctionid, Employee_id, gross, deduction, net)
VALUES 
(1, 1, 20001, 10000, 2000, 8000),
(2, 2, 20002, 12000, 2500, 9500),
(3, 3, 20003, 11000, 1800, 9200),
(4, 4, 20004, 13000, 3000, 10000),
(5, 5, 20005, 10500, 2200, 8300),
(6, 6, 20006, 12500, 2700, 9800),
(7, 7, 20007, 11500, 2400, 9100),
(8, 8, 20008, 13500, 3200, 10300),
(9, 9, 20009, 10700, 2000, 8700),
(10, 10, 20010, 14000, 3500, 10500);


-- Insert data into Employee_BillEarnDedn table
INSERT INTO Employee_BillEarnDedn (id, transctionid, bp_id, Earn_Detection_List_id, ammount)
VALUES 
(1, 1, 1, 1, 5000),
(2, 2, 2, 2, 2000),
(3, 3, 3, 3, 6000),
(4, 4, 4, 4, 1000),
(5, 5, 5, 5, 5500),
(6, 6, 6, 1, 1500),
(7, 7, 7, 2, 2500),
(8, 8, 8, 3, 7000),
(9, 9, 9, 4, 1200),
(10, 10, 10, 5, 1800);



-- save employees basic details such as "empcode, firstname, lastname, doj, dob, gender, phone, working_status, designation, location

-- Select employee basic details
SELECT 
    Employee_Code,
    First_Name,
    Last_Name,
    DOJ,
    DOB,
    Gender,
    Phone,
    WORKING_Status,
    Designation,
    LOCATION
FROM Employee_Details;


-- Count of employees location-wise
SELECT 
    LOCATION,
    COUNT(*) AS Employee_Count
FROM Employee_Details
GROUP BY LOCATION;


-- Count of employees designation-wise
SELECT 
    Designation,
    COUNT(*) AS Employee_Count
FROM Employee_Details
GROUP BY Designation;


-- Count of employees working status-wise
SELECT 
    WORKING_Status,
    COUNT(*) AS Employee_Count
FROM Employee_Details
GROUP BY WORKING_Status;


-- Calculate and show employees' retirement dates
SELECT
    Employee_Code,
    CONCAT(First_Name, ' ', Last_Name) AS Employee_Name,
    DOB,
    DOJ,
    DOB + INTERVAL '60 years' AS Retirement_Date
FROM
    Employee_Details;


-- show salary break up(each salary compoment) of each employee wise. (employee code, name, basic pay, hra, cca, pt, it)
-- Show salary breakup for each employee
SELECT
    ed.Employee_Code,
    CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name,
    COALESCE(SUM(CASE WHEN edl.name = 'Basic Pay' THEN eed.ammount END), 0) AS Basic_Pay,
    COALESCE(SUM(CASE WHEN edl.name = 'House Rent Allowance' THEN eed.ammount END), 0) AS HRA,
    COALESCE(SUM(CASE WHEN edl.name = 'City Compensatory Allowance' THEN eed.ammount END), 0) AS CCA,
    COALESCE(SUM(CASE WHEN edl.name = 'Professional Tax' THEN eed.ammount END), 0) AS PT,
    COALESCE(SUM(CASE WHEN edl.name = 'Income Tax' THEN eed.ammount END), 0) AS IT
FROM
    Employee_Details ed
JOIN
    Employee_Earn_deduction eed ON ed.Employee_Code = eed.Employee_id
JOIN
    Earn_Detection_List edl ON eed.Earn_Detection_Code = edl.id
GROUP BY
    ed.Employee_Code, ed.First_Name, ed.Last_Name;


    -- Show gross, deductions, and net salary for each employee
SELECT
    ed.Employee_Code,
    CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name,
    COALESCE(SUM(tb.gross), 0) AS Gross,
    COALESCE(SUM(tb.deduction), 0) AS Deduction,
    COALESCE(SUM(tb.net), 0) AS Net
FROM
    Employee_Details ed
JOIN
    bill tb ON ed.Employee_Code = tb.Employee_id
JOIN
    Transction t ON tb.transctionid = t.id
LEFT JOIN
    Employee_BillEarnDedn ebd ON tb.id = ebd.bp_id
GROUP BY
    ed.Employee_Code, ed.First_Name, ed.Last_Name;


-- Salary received by each employee for the last month
WITH LastMonth AS (
    SELECT
        ed.Employee_Code,
        CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name,
        EXTRACT(YEAR FROM t.month) AS Salary_Year,
        EXTRACT(MONTH FROM t.month) AS Salary_Month,
        COALESCE(SUM(b.gross), 0) AS Gross,
        COALESCE(SUM(b.deduction), 0) AS Deduction,
        COALESCE(SUM(b.net), 0) AS Net
    FROM
        Employee_Details ed
    JOIN
        bill b ON ed.Employee_Code = b.Employee_id
    JOIN
        Transction t ON b.transctionid = t.id
    GROUP BY
        ed.Employee_Code, ed.First_Name, ed.Last_Name, Salary_Year, Salary_Month
)
-- Salary received by each employee for the last month
WITH LastMonth AS (
    SELECT
        ed.Employee_Code,
        CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name,
        EXTRACT(YEAR FROM t.month) AS Salary_Year,
        EXTRACT(MONTH FROM t.month) AS Salary_Month,
        COALESCE(SUM(b.gross), 0) AS Gross,
        COALESCE(SUM(b.deduction), 0) AS Deduction,
        COALESCE(SUM(b.net), 0) AS Net
    FROM
        Employee_Details ed
    JOIN
        bill b ON ed.Employee_Code = b.Employee_id
    JOIN
        Transction t ON b.transctionid = t.id
    GROUP BY
        ed.Employee_Code, ed.First_Name, ed.Last_Name, Salary_Year, Salary_Month
)


-- Salary received by each employee for the last month
WITH LastMonth AS (
    SELECT
        ed.Employee_Code,
        CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name,
        EXTRACT(YEAR FROM t.month) AS Salary_Year,
        EXTRACT(MONTH FROM t.month) AS Salary_Month,
        COALESCE(SUM(b.gross), 0) AS Gross,
        COALESCE(SUM(b.deduction), 0) AS Deduction,
        COALESCE(SUM(b.net), 0) AS Net
    FROM
        Employee_Details ed
    JOIN
        bill b ON ed.Employee_Code = b.Employee_id
    JOIN
        Transction t ON b.transctionid = t.id
    GROUP BY
        ed.Employee_Code, ed.First_Name, ed.Last_Name, Salary_Year, Salary_Month
)



-- Calculate the salary of the employee last month
SELECT
    ed.Employee_Code,
    CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name,
    COALESCE(SUM(b.net), 0) AS Net_Value
FROM
    Employee_Details ed
JOIN
    bill b ON ed.Employee_Code = b.Employee_id
JOIN
    Transction t ON b.transctionid = t.id
GROUP BY
    ed.Employee_Code, ed.First_Name, ed.Last_Name;



-- Employee who have not recieve salary of last month

-- Names and employee codes of employees with transaction ID not equal to 10
SELECT
    ed.Employee_Code,
    CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name
FROM
    Employee_Details ed
JOIN
    bill b ON ed.Employee_Code = b.Employee_id
WHERE
    b.transctionid != 10;

-- list of employees whos actual salary net amount not matched with net amount of salary received in last month. (employee code, name, actual net, last month net salary).
SELECT
    ed.Employee_Code,
    CONCAT(ed.First_Name, ' ', ed.Last_Name) AS Employee_Name
FROM
    Employee_Details ed
JOIN
    bill b ON ed.Employee_Code = b.Employee_id
WHERE
    b.transctionid != 10;