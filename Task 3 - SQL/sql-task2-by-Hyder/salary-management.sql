-- Active: 1699519738665@@127.0.0.1@5432@postgres
CREATE DATABASE salary_management;
--location table
CREATE TABLE location(
    id INTEGER  PRIMARY KEY,
    city_name varchar(20)
);

INSERT INTO location (
    id,
    city_name)
    VALUES
    (1,'hyderabad'),
    (2,'bengaluru'),
    (3,'ahemedabad');


--working_status
CREATE TABLE working_status(
    id INTEGER PRIMARY KEY,
    status VARCHAR(20)
);

INSERT INTO working_status(id,status)
    VALUES(1,'working'),
        (2,'retired');

--designation
CREATE TABLE designation(
    id INTEGER PRIMARY KEY,
    designation VARCHAR(30)
);
INSERT INTO designation(id,designation)
    VALUES(1,'human resources'),
        (2,'software developer'),
        (3,'marketing'),
        (4,'project management');

CREATE TABLE employee_details (
    employee_code VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_join DATE NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(10),
    phone VARCHAR(15),
    working_status INT REFERENCES working_status(id),
    designation INT REFERENCES designation(id),
    location INT REFERENCES location(id),
    CONSTRAINT employee_code_format CHECK (
        employee_code ~ '^20001\d{5}$' -- Employee_code should be 5 digits starting with "20001"
    )
);

INSERT INTO employee_details(
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
    ('2000100001', 'Kane', 'Williamson', '2022-01-15', '1980-05-20', 'Male', '1234567890', 1, 4, 1),
    ('2000100002', 'Jane', 'Smith', '2022-02-20', '1955-08-10', 'Female', '9876543210', 2, 2, 2),
    ('2000100003', 'Alice', 'Johnson', '2022-03-10', '1990-03-25', 'Female', '5551234567', 1, 3, 3),
    ('2000100004', 'David', 'Warner', '2022-04-05', '1958-11-15', 'Male', '7778889999', 2, 3, 1),
    ('2000100005', 'Eva', 'Davis', '2022-05-12', '1995-09-08', 'Female', '3334445555', 1, 1, 2),
    ('2000100006','Mike','Tyson','2021-09-20','1990-08-12','Male','0943649122',1,2,3),
    ('2000100007','Adam','Gilchrist','2022-09-28','1965-07-23','Male','8977707655',2,1, 2);
--earn and deduction list

CREATE Table earn_deduction_list(
    id INT PRIMARY KEY,
    name VARCHAR (20),
    type INT
);
INSERT INTO earn_deduction_list(id,name,type)
    VALUES
   (1, 'bp' ,1),--basic pay
    (2,'da' ,1),--dearness_allowance
   (3,'hra' ,1),--house_rent_allowance
    (4,'cca',1),--city_compensatory_allowance
    --deductions
    (5,'insurance' ,2),
    (6,'pt',2),
    (7,'Pf',2 );--Provident Fund);

--Employee_Earn_Dedn
CREATE Table Employee_Earn_Deduction(
    id INT PRIMARY KEY,
    employee_code VARCHAR REFERENCES employee_details(employee_code),
    earn_deduction_id INT REFERENCES earn_deduction_list(id),
    amount BIGINT,
    with_effect_date DATE
);

INSERT INTO employee_earn_deduction(id,employee_code,earn_deduction_id,amount,with_effect_date)
    VALUES(1,'2000100001',1,40000,'2023-11-03'),
        (2,'2000100001',2,8000,'2023-11-03'),
        (3,'2000100001',3,6000,'2023-11-03'),
        (4,'2000100001',4,1500,'2023-11-03'),
        (5,'2000100001',5,1200,'2023-11-03'),
        (6,'2000100001',6,900,'2023-11-03'),
        (7,'2000100001',7,4000,'2023-11-03'),
        (8,'2000100002',1,22000,'2023-11-03'),
        (9,'2000100002',2,3000,'2023-11-03'),
        (10,'2000100002',4,2000,'2023-11-03'),
        (11,'2000100002',5,1500,'2023-11-03'),
        (12,'2000100002',7,3000,'2023-11-03'),
        (13,'2000100003',1,38000,'2023-11-03'),
        (14,'2000100003',2,9000,'2023-11-03'),
        (15,'2000100003',3,5500,'2023-11-03'),
        (16,'2000100003',4,1600,'2023-11-03'),
        (17,'2000100003',6,2200,'2023-11-03'),
        (18,'2000100003',7,3500,'2023-11-03'),
        (19,'2000100004',1,25000,'2023-11-03'),
        (20,'2000100004',2,1200,'2023-11-03'),
        (21,'2000100004',3,800,'2023-11-03'),
        (22,'2000100004',7,2500,'2023-11-03'),
        (23,'2000100005',1,48000,'2023-11-03'),
        (24,'2000100005',2,12000,'2023-11-03'),
        (244,'2000100005',3,8000,'2023-11-03'),
        (25,'2000100005',4,2000,'2023-11-03'),
        (26,'2000100005',5,1800,'2023-11-03'),
        (27,'2000100005',6,1500,'2023-11-03'),
        (28,'2000100005',7,5000,'2023-11-03'),
        (29,'2000100006',1,36000,'2023-11-03'),
        (30,'2000100006',2,8500,'2023-11-03'),
        (31,'2000100006',3,5500,'2023-11-03'),
        (32,'2000100006',4,2000,'2023-11-03'),
        (33,'2000100006',5,2000,'2023-11-03'),
        (34,'2000100006',6,2000,'2023-11-03'),
        (35,'2000100006',7,3500,'2023-11-03'),
        (36,'2000100007',1,50000,'2023-11-03'),
        (37,'2000100007',2,13000,'2023-11-03'),
        (38,'2000100007',3,9000,'2023-11-03'),
        (39,'2000100007',4,2200,'2023-11-03'),
        (40,'2000100007',5,2000,'2023-11-03'),
        (41,'2000100007',6,3000,'2023-11-03'),
        (42,'2000100007',7,3500,'2023-11-03'),
    --last MONTH
        (43,'2000100001',1,38000,'2023-10-03'),
        (44,'2000100001',2,7500,'2023-10-03'),
        (45,'2000100001',3,6000,'2023-10-03'),
        (46,'2000100001',4,1300,'2023-10-03'),
        (47,'2000100001',5,1200,'2023-10-03'),
        (48,'2000100001',6,900,'2023-10-03'),
        (49,'2000100001',7,4000,'2023-10-03'),
        (50,'2000100002',1,22000,'2023-10-03'),
        (51,'2000100002',2,3000,'2023-10-03'),
        (52,'2000100002',4,2000,'2023-10-03'),
        (53,'2000100002',5,1500,'2023-10-03'),
        (54,'2000100002',7,3000,'2023-10-03'),
        (55,'2000100004',1,25000,'2023-10-03'),
        (56,'2000100004',2,1200,'2023-10-03'),
        (57,'2000100004',3,800,'2023-10-03'),
        (58,'2000100004',7,2500,'2023-10-03'),
        (59,'2000100005',1,45000,'2023-10-03'),
        (60,'2000100005',2,12000,'2023-10-03'),
        (61,'2000100005',3,8500,'2023-10-03'),
        (62,'2000100005',4,2000,'2023-10-03'),
        (63,'2000100005',5,1700,'2023-10-03'),
        (64,'2000100005',6,1500,'2023-10-03'),
        (65,'2000100005',7,5000,'2023-10-03'),
        (66,'2000100006',1,36000,'2023-10-03'),
        (67,'2000100006',2,8500,'2023-10-03'),
        (68,'2000100006',3,5500,'2023-10-03'),
        (69,'2000100006',4,2000,'2023-10-03'),
        (70,'2000100006',5,2000,'2023-10-03'),
        (71,'2000100006',6,2000,'2023-10-03'),
        (72,'2000100006',7,3500,'2023-10-03');

        

--transaction
CREATE Table transaction(
    id INT PRIMARY KEY,
    employee_code VARCHAR(10) REFERENCES employee_details(employee_code),
    month VARCHAR(100),
    year VARCHAR(100),
    gross BIGINT,
    deduction BIGINT,
    net BIGINT,
    status VARCHAR(100)
);
 SELECT * FROM transaction;
-- transaction
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
(SELECT
    1 AS id,
    '2000100001' AS employee_code,
    '11' AS month,
    '2023' AS year,
    COALESCE(SUM(eed.amount),0) as gross,
    COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount  END),0) as deduction,
    COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
    CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
FROM
    employee_earn_deduction eed
JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
WHERE
    eed.employee_code = '2000100001'
    AND eed.with_effect_date = '2023-11-03');

INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
SELECT
    2 AS id,
    '2000100002' AS employee_code,
    '11' AS month,
    '2023' AS year,
    COALESCE(SUM(eed.amount),0) as gross,
    COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount  END),0) as deduction,
    COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
    CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
FROM
    employee_earn_deduction eed
JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
WHERE
    eed.employee_code = '2000100002'
    AND eed.with_effect_date = '2023-11-03';
    
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
SELECT 
    3 as id,
    '2000100003' AS employee_code,
    '11' AS month,
    '2023' AS year,
    COALESCE(SUM(eed.amount),0) as gross,
    COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
    COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
    CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
FROM
    employee_earn_deduction eed
JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
WHERE
    eed.employee_code = '2000100003'
    AND eed.with_effect_date = '2023-11-03';

INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        4 as id,
        '2000100004' AS employee_code,
        '11' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount  END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100004'
        AND eed.with_effect_date = '2023-11-03';
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        5 as id,
        '2000100005' AS employee_code,
        '11' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100005'
        AND eed.with_effect_date = '2023-11-03';
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        6 as id,
        '2000100006' AS employee_code,
        '11' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100006'
        AND eed.with_effect_date = '2023-11-03';
    INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        7 as id,
        '2000100007' AS employee_code,
        '11' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100007'
        AND eed.with_effect_date = '2023-11-03';
---last month transactions
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    (SELECT
        8 AS id,
        '2000100001' AS employee_code,
        '10' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '20000100001'
        AND eed.with_effect_date = '2023-10-03');

INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT
        9 AS id,
        '2000100002' AS employee_code,
        '10' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100002'
        AND eed.with_effect_date = '2023-10-03';
        
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        10 as id,
        '2000100003' AS employee_code,
        '10' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100003'
        AND eed.with_effect_date = '2023-10-03';

INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        11 as id,
        '2000100004' AS employee_code,
        '10' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100004'
        AND eed.with_effect_date = '2023-10-03';
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        12 as id,
        '2000100005' AS employee_code,
        '10' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100005'
        AND eed.with_effect_date = '2023-10-03';
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        13 as id,
        '2000100006' AS employee_code,
        '10' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100006'
        AND eed.with_effect_date = '2023-10-03';
INSERT INTO transaction (id, employee_code, month, year, gross, deduction, net, status)
    SELECT 
        14 as id,
        '2000100007' AS employee_code,
        '10' AS month,
        '2023' AS year,
        COALESCE(SUM(eed.amount),0) as gross,
        COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as deduction,
        COALESCE(SUM(eed.amount),0) - COALESCE(SUM(CASE WHEN edl.type = 2 THEN eed.amount END),0) as net,
        CASE WHEN COALESCE(SUM(eed.amount),0) > 0 THEN 'yes' ELSE 'no' END as status
    FROM
        employee_earn_deduction eed
    JOIN earn_deduction_list edl ON eed.earn_deduction_id = edl.id
    WHERE
        eed.employee_code = '2000100007'
        AND eed.with_effect_date = '2023-10-03';




--1. list of employees (name, doj, dob, gender, phone, working_status, designation, location)
SELECT CONCAT(e.first_name, ' ', e.last_name) AS name,e.date_of_join,e.date_of_birth,e.gender,
    e.phone,w.status,d.designation,l.city_name
FROM employee_details e
JOIN working_status w on e.working_status = w.id 
JOIN designation d on e.designation = d.id
JOIN location l on e.location = l.id;

--2. count of employees location wise(location,employee count).
SELECT l.city_name,COUNT(e.employee_code) AS employee_count
FROM employee_details e
JOIN location l on e.location=l.id
GROUP BY l.city_name;

--3. count of employees designation wise (designation,employee count).
SELECT d.designation,COUNT(e.employee_code) AS employee_count
FROM employee_details e 
JOIN designation d on e.designation = d.id
GROUP BY d.designation;

--4. count of employees working status (working status,employee count).
SELECT w.status as working_status, COUNT(e.employee_code) AS employee_count
FROM employee_details e
JOIN working_status w ON e.working_status = w.id
WHERE w.status = 'working'
GROUP BY w.status;


--5. calculate and show all employees retirement date (employee code, employee_name, dob, doj, retirement_date) (if retirement ll be at age of 60)
SELECT employee_code,concat(first_name,' ',last_name) AS employee_name,date_of_birth,date_of_join,
    date_of_birth + INTERVAL'60 YEAR' AS retirement_date
FROM employee_details;

--6. show salary break up(each salary component) of each employee wise. (employee code, name, basic pay, hra, cca, pt, pf)
-- Show salary break up (each salary component) for each employee
SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    SUM(CASE WHEN edl.name = 'bp' THEN eed.amount ELSE 0 END) AS basic_pay,
    SUM(CASE WHEN edl.name = 'hra' THEN eed.amount ELSE 0 END) AS hra,
    SUM(CASE WHEN edl.name = 'cca' THEN eed.amount ELSE 0 END) AS cca,
    SUM(CASE WHEN edl.name = 'pt' THEN eed.amount ELSE 0 END) AS pt,
    SUM(CASE WHEN edl.name = 'Pf' THEN eed.amount ELSE 0 END) AS pf
FROM 
    employee_details e
JOIN 
    employee_earn_deduction eed ON e.employee_code = eed.employee_code
JOIN 
    earn_deduction_list edl ON eed.earn_deduction_id = edl.id
WHERE 
    edl.name IN ('bp', 'hra', 'cca', 'pt', 'Pf') and 
    eed.with_effect_date = '2023-11-03'
GROUP BY 
    e.employee_code, CONCAT(e.first_name, ' ', e.last_name);
 

--7. show gross, deductions, net salary of each employee (employee code, name, gross, deduction, net)
SELECT e.employee_code,
    CONCAT(e.first_name,' ',e.last_name) AS employee_name,
    t.gross as gross,
    t.deduction as deductions,
    t.net as net
FROM employee_details e
JOIN transaction t on e.employee_code = t.employee_code
JOIN employee_earn_deduction e2 on e.employee_code = e2.employee_code
JOIN earn_deduction_list e3 on e2.earn_deduction_id = e3.id
WHERE t.month = '11'
GROUP BY e.employee_code, t.gross,t.deduction,t.net;

--8. salary received by each employee for last month (employee_id, name, salary_year, salary_month, gross, deduction, net).
SELECT e.employee_code,
    CONCAT(e.first_name,' ',e.last_name) AS employee_name,
    t.year as salary_year,
    t.month as salary_month,
    t.gross as gross,
    t.deduction as deductions,
    t.net as net
FROM employee_details e
JOIN transaction t on e.employee_code = t.employee_code
JOIN employee_earn_deduction e2 on e.employee_code = e2.employee_code
JOIN earn_deduction_list e3 on e2.earn_deduction_id = e3.id
WHERE t.month = '10'
GROUP BY e.employee_code, t.gross,t.deduction,t.net,t.year,t.month;

--9. list of employees who have not received salary for last month (employee code, name)
SELECT e.employee_code,concat(e.first_name,'',e.last_name)
FROM employee_details e
JOIN transaction t on e.employee_code = t.employee_code
WHERE (t.gross = 0 OR t.gross IS NULL) AND month = '10';


--10. list of employees who's actual salary net amount not matched with net amount of salary received in last month. 
--(employee code, name, actual net, last month net salary).

SELECT 
    e.employee_code,
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    (SELECT t.gross FROM transaction t WHERE t.employee_code = e.employee_code AND t.month = '11') AS actual_net,
    (SELECT t.gross FROM transaction t WHERE t.employee_code = e.employee_code AND t.month = '10') AS last_month_net
FROM 
    employee_details e
JOIN 
    transaction t ON e.employee_code = t.employee_code
GROUP BY e.employee_code
ORDER BY e.employee_code;
