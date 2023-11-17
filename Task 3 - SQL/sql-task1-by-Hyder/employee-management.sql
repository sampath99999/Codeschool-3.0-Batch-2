-- Active: 1699519738665@@127.0.0.1@5432@postgres
CREATE DATABASE employees_management;
-- Table for basic employee details
CREATE Table employee_basic_details(
    employee_code VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name varchar(50),
    date_of_join DATE NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    phone VARCHAR(15),
    working_status VARCHAR(20),
    designation varchar(30),
    location VARCHAR(30),
    CONSTRAINT employee_code_format CHECK (
        employee_code ~ '^20001\d{5}$' -- Employee_code should be 5 digits starting with ""
    )
);

--salaries details 
 CREATE TABLE salary_details(
    employee_code VARCHAR(10) REFERENCES employee_basic_details(employee_code),
    transaction_id VARCHAR(5) PRIMARY KEY,
    --earnings
    bp FLOAT,--basic pay
    da FLOAT,--dearness_allowance
    hra FLOAT,--house_rent_allowance
    cca FLOAT,--city_compensatory_allowance
    --deductions
    insurance FLOAT,
    pt FLOAT,--professional tax
    Pf FLOAT --Provident Fund
 );


--salaries details of  month wise
CREATE TABLE transaction_details(
    transaction_id VARCHAR(5) REFERENCES salary_details(transaction_id),
    month VARCHAR(10),
    salary_received_status VARCHAR(5),--yes or no
    --earnings
    bp FLOAT,--basic pay
    da FLOAT,--dearness_allowance
    hra FLOAT,--house_rent_allowance
    cca FLOAT,--city_compensatory_allowance
    ot FLOAT,--over_time
    --deductions
    insurance FLOAT,
    pt FLOAT,--professional tax
    Pf FLOAT --Provident Fund
 );





--inserting employee_basic _details

 INSERT INTO employee_basic_details (
    employee_code,
    first_name,
    last_name,
    date_of_join,
    date_of_birth,
    gender,
    phone,
    working_status,
    designation,
    location
) VALUES
    ('2000100001', 'John', 'Doe', '2022-01-15', '1980-05-20', 'Male', '1234567890', 'Working', 'Manager', 'New York'),
    ('2000100002', 'Jane', 'Smith', '2022-02-20', '1955-08-10', 'Female', '9876543210', 'Retired', 'Developer', 'San Francisco'),
    ('2000100003', 'Alice', 'Johnson', '2022-03-10', '1990-03-25', 'Female', '5551234567', 'Working', 'Analyst', 'seattle'),
    ('2000100004', 'Bob', 'Williams', '2022-04-05', '1958-11-15', 'Male', '7778889999', 'Retired', 'Designer', 'Los Angeles'),
    ('2000100005', 'Eva', 'Davis', '2022-05-12', '1995-09-08', 'Female', '3334445555', 'Working', 'Engineer', 'Seattle'),
    ('2000100006','Mike','Tyson','2021-09-20','1990-08-12','Male','0943649122','Working','Developer','New York'),
    ('2000100007','Adam','Gilchrist','2022-09-28','1965-07-23','Male','8977707655','Retired','Analyst', 'San Francisco');



--inserting in to salary_details
INSERT INTO salary_details (
    employee_code,
    transaction_id,
    bp,
    da,
    hra,
    cca,
    insurance,
    pt,
    pf
) VALUES
    ('2000100001','00001', 40000.00, 8000.00, 6000.00, 1500.00, 1200.00, 200.00, 4000.00),
    ('2000100002','00002', 22000.00, 3000.00, 2000.00, 1800.00, 1500.00, 0.00, 3500.00),
    ('2000100003','00003', 38000.00, 9000.00, 5500.00, 1600.00, 1300.00, 220.00, 4500.00),
    ('2000100004','00004', 25000.00, 1500.00, 1000.00, 1200.00, 1000.00, 0.00, 3000.00),
    ('2000100005','00005', 48000.00, 12000.00, 8000.00, 2000.00, 1800.00, 350.00, 6000.00),
    ('2000100006','00006', 36000.00, 8500.00, 5800.00, 1700.00, 1400.00, 220.00, 4200.00),
    ('2000100007','00007', 50000.00, 13000.00, 9000.00, 2200.00, 2000.00, 400.00, 7000.00);


--inserting in to transaction_details
INSERT INTO transaction_details (
    transaction_id,
    month,
    salary_received_status,
    bp,
    da,
    hra,
    cca,
    insurance,
    pt,
    pf
) VALUES
    ('00001', '2023-11', 'yes', 40000.00, 8000.00, 6000.00, 1500.00, 1200.00, 200.00, 4000.00),
    ('00002', '2023-11', 'yes', 21000.00, 2000.00, 1500.00, 1800.00, 1500.00, 0.00, 3500.00),
    ('00003', '2023-11', 'yes', 38000.00, 8000.00, 5500.00, 1600.00, 1300.00, 220.00, 5000.00),
    ('00004', '2023-11', 'yes', 20000.00, 1500.00, 1000.00, 1200.00, 1000.00, 0.00, 3000.00),
    ('00005', '2023-11', 'yes', 48000.00, 12000.00, 8000.00, 2000.00, 1800.00, 350.00, 6000.00),
    ('00006', '2023-11', 'yes', 36000.00, 8500.00, 5800.00, 1700.00, 1400.00, 220.00, 4200.00),
    ('00007', '2023-11', 'yes', 50000.00, 13000.00, 9000.00, 2200.00, 2000.00, 400.00, 8000.00),
    ('00001', '2023-10', 'no', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
    ('00002', '2023-10', 'yes', 19000.00, 3000.00, 2000.00, 1800.00, 1500.00, 0.00, 5000.00),
    ('00003', '2023-10', 'yes', 38000.00, 8000.00, 5000.00, 1600.00, 1300.00, 220.00, 5000.00),
    ('00004', '2023-10', 'yes', 21000.00, 1500.00, 2000.00, 1200.00, 1500.00, 0.00, 2000.00),
    ('00005', '2023-10', 'yes', 38000.00, 12000.00, 8000.00, 2000.00, 1800.00, 350.00, 6000.00),
    ('00006', '2023-10', 'no', 0.00, 0.00, 0.00, 0.00, 0.00, 0.00, 0.00),
    ('00007', '2023-10', 'yes', 50000.00, 13000.00, 9000.00, 2200.00, 2000.00, 400.00, 8000.00);

    

--1. list of employees (name, doj, dob, gender, phone, working_status, designation, location)
SELECT CONCAT(first_name, ' ', last_name) AS name,date_of_join,date_of_birth,gender,
    phone,working_status,designation,location
FROM employee_basic_details;

--2. count of employees location wise(location,employee count).
SELECT location,COUNT(employee_code) AS employee_count
FROM employee_basic_details
GROUP BY location;

--3. count of employees designation wise (designation,employee count).
SELECT designation,COUNT(employee_code) AS employee_count
FROM employee_basic_details
GROUP BY designation;

--4. count of employees working status (working status,employee count).
SELECT working_status,COUNT(employee_code) AS employee_count
FROM employee_basic_details
WHERE working_status='Working'
GROUP BY working_status;

--5. calculate and show all employees retirement date (employee code, employee_name, dob, doj, retirement_date) (if retirement ll be at age of 60)
SELECT employee_code,concat(first_name,' ',last_name) AS employee_name,date_of_birth,date_of_join,
    date_of_birth + INTERVAL'60 YEAR' AS retirement_date
FROM employee_basic_details;

--6. show salary break up(each salary component) of each employee wise. (employee code, name, basic pay, hra, cca, pt, pf)
SELECT e.employee_code,CONCAT(e.first_name,' ',e.last_name) AS employee_name,
    s.bp,s.hra,s.cca,s.pt,s.pf
FROM employee_basic_details e 
JOIN salary_details s ON e.employee_code = s.employee_code;
    

--7. show gross, deductions, net salary of each employee (employee code, name, gross, deduction, net)
SELECT e.employee_code,
    CONCAT(e.first_name,' ',e.last_name) AS employee_name,
    s.bp + s.da + s.hra + s.cca AS gross,
    s.insurance + s.pt + s.pf AS deductions,
    (s.bp + s.da + s.hra + s.cca)-(s.insurance + s.pt + s.pf) AS net
FROM employee_basic_details e
JOIN salary_details s on e.employee_code=s.employee_code;

--8. salary received by each employee for last month (employee_id, name, salary_year, salary_month, gross, deduction, net).
SELECT e.employee_code,
    CONCAT(e.first_name,' ',e.last_name) AS employee_name,
    EXTRACT(YEAR FROM TO_DATE(t.month, 'YYYY-MM')) AS salary_year,
    EXTRACT(MONTH FROM TO_DATE(t.month, 'YYYY-MM')) AS salary_month,
    t.bp + t.da + t.hra + t.cca AS gross,
    t.insurance + t.pt + t.pf AS deductions,
    (t.bp + t.da + t.hra + t.cca)-(t.insurance + t.pt + t.pf) AS net
FROM employee_basic_details e
JOIN salary_details s on e.employee_code=s.employee_code
JOIN transaction_details t on s.transaction_id = t.transaction_id
WHERE month='2023-10';

--9. list of employees who have not received salary for last month (employee code, name)
SELECT e.employee_code,
    CONCAT(e.first_name,' ',e.last_name) AS name 
FROM employee_basic_details e
    JOIN salary_details s ON e.employee_code = s.employee_code
    JOIN transaction_details t ON s.transaction_id = t.transaction_id
    WHERE t.bp + t.da + t.hra + t.cca=0
    OR salary_received_status='no';

--10. list of employees who's actual salary net amount not matched with net amount of salary received in last month. 
--(employee code, name, actual net, last month net salary).
SELECT e.employee_code,CONCAT(e.first_name,'',e.last_name),
    (s.bp + s.hra + s.cca + s.da) - (s.insurance + s.pt + s.pf) AS actual_net_salary,
    (t.bp + t.hra + t.cca + t.da) - (t.insurance + t.pt + t.pf) AS last_month_net_salary
FROM employee_basic_details e
JOIN salary_details s ON e.employee_code = s.employee_code
JOIN transaction_details t ON s.transaction_id = t.transaction_id   
WHERE month = '2023-10';


