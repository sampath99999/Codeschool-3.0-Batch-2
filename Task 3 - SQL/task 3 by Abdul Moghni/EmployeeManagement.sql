-- Active: 1699939186465@@127.0.0.1@5432@EmployeesManagement

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

select * from employee_details;

CREATE TABLE
    EarningAndDeduction (
        Employee_Code INT REFERENCES Employee_Details(Employee_Code),
        Basic_Pay NUMERIC,
        Basic_Pay_Date DATE,
        Deaeness_Allowness NUMERIC,
        Deaeness_Allowness_Date DATE,
        House_Rent_Allowness NUMERIC,
        House_Rent_Allowness_Date DATE,
        City_Compensatory_Allowance NUMERIC,
        City_Compensatory_Allowance_Date DATE,
        Telangana_Increment NUMERIC,
        Telangana_Increment_Date DATE,
        AG_GPF_Subscription NUMERIC,
        AG_GPF_Subscription_Recovered_INST NUMERIC,
        AG_GPF_Subscription_INITIAL_INST NUMERIC,
        AG_GPF_Subscription_MAX_INST NUMERIC,
        AG_GPF_Subscription_Policy_No VARCHAR(255),
        AG_GPF_Subscription_Last_Date DATE,
        AG_GPF_Subscription_Action VARCHAR(255),
        GIS_Ins_Fund NUMERIC,
        GIS_Ins_Fund_Recovered_Inst NUMERIC,
        GIS_Ins_Fund_INITIAL_INST NUMERIC,
        GIS_Ins_Fund_MAX_INST NUMERIC,
        GIS_Ins_Fund_Policy_No VARCHAR(255),
        GIS_Ins_Fund_Last_Date DATE,
        GIS_Ins_Fund_Action VARCHAR(255),
        Professional_Tax NUMERIC,
        Professional_Tax_Recovered_INST NUMERIC,
        Professional_Tax_INITIAL_INST NUMERIC,
        Professional_Tax_MAX_INST NUMERIC,
        Professional_Tax_Policy_No VARCHAR(255),
        Professional_Tax_Last_Date DATE,
        Professional_Tax_Action VARCHAR(255),
        TSGLI_Subscription NUMERIC,
        TSGLI_Recovered_INST NUMERIC,
        TSGLI_INITIAL_INST NUMERIC,
        TSGLI_MAX_INST NUMERIC,
        TSGLI_Policy_No VARCHAR(255),
        TSGLI_Last_Date DATE,
        TSGLI_Action VARCHAR(255),
        NG_NON_GOVT_Others NUMERIC,
        NG_NON_GOVT_Others_Recovered_INST NUMERIC,
        NG_NON_GOVT_Others_INITIAL_INST NUMERIC,
        NG_NON_GOVT_Others_MAX_INST NUMERIC,
        NG_NON_GOVT_Others_Policy_No VARCHAR(255),
        NG_NON_GOVT_Others_Last_Date DATE,
        NG_NON_GOVT_Others_Action VARCHAR(255)
    );

-- Assuming Employee_Details table already exists

-- Create Transaction Table

-- Assuming Employee_Details table already exists

-- Create Transaction Table with Total Earning as the sum of the months

CREATE TABLE
    Transaction (
        Employee_Code INT REFERENCES Employee_Details(Employee_Code),
        JANUARY NUMERIC,
        FEBRUARY NUMERIC,
        MARCH NUMERIC,
        APRIL NUMERIC,
        MAY NUMERIC,
        JUNE NUMERIC,
        JULY NUMERIC,
        AUGUST NUMERIC,
        SEPTEMBER NUMERIC,
        OCTOBER NUMERIC,
        NOVEMBER NUMERIC,
        DECEMBER NUMERIC,
        Total_Earning NUMERIC GENERATED ALWAYS AS (
            JANUARY + FEBRUARY + MARCH + APRIL + MAY + JUNE + JULY + AUGUST + SEPTEMBER + OCTOBER + NOVEMBER + DECEMBER
        ) STORED
    );

-- Data-Entry into Employee_Details table

INSERT INTO
    Employee_Details (
        First_Name,
        Last_Name,
        DOJ,
        DOB,
        Gender,
        Phone,
        WORKING_Status,
        Designation,
        LOCATION
    )
VALUES (
        'Abdul',
        'Moghni',
        '2023-01-01',
        '2002-08-27',
        'Male',
        1234567890,
        'Active',
        'Manager',
        'Banglore'
    ), (
        'Rocky',
        'Jerry',
        '2023-02-15',
        '2002-08-27',
        'Male',
        9876543210,
        'Active',
        'Engineer',
        'Hyderabad'
    ), (
        'Farhan',
        'Ahmad',
        '2023-03-10',
        '2000-11-04',
        'Male',
        5555555555,
        'Inactive',
        'Analyst',
        'Delhi'
    ), (
        'Sana',
        'Parveen',
        '2023-01-01',
        '2001-07-23',
        'Female',
        1234567890,
        'Active',
        'Manager',
        'Mohali'
    ), (
        'Iram',
        'Nabi',
        '2023-02-15',
        '2000-09-27',
        'Female',
        9876543210,
        'Active',
        'Engineer',
        'Chandigarh'
    ), (
        'Sagufta',
        'Parveen',
        '2023-03-10',
        '1990-08-25',
        'Female',
        5555555555,
        'Inactive',
        'Analyst',
        'Hyderabad'
    ), (
        'Danish',
        'Anwar',
        '2023-07-23',
        '1997-07-23',
        'Male',
        1234567890,
        'Active',
        'Manager',
        'Delhi'
    ), (
        'Farhia',
        'Khanam',
        '2023-02-15',
        '1985-05-20',
        'Female',
        9876543210,
        'Active',
        'Engineer',
        'Delhi'
    ), (
        'Alice',
        'Johnson',
        '2023-03-10',
        '1990-08-25',
        'Female',
        5555555555,
        'Inactive',
        'Analyst',
        'Chandigarh'
    );

-- Data-Entry into earning and Deduction table

INSERT INTO
    EarningAndDeduction (
        Employee_Code,
        Basic_Pay,
        Basic_Pay_Date,
        Deaeness_Allowness,
        Deaeness_Allowness_Date,
        House_Rent_Allowness,
        House_Rent_Allowness_Date,
        City_Compensatory_Allowance,
        City_Compensatory_Allowance_Date,
        Telangana_Increment,
        Telangana_Increment_Date,
        AG_GPF_Subscription,
        AG_GPF_Subscription_Recovered_INST,
        AG_GPF_Subscription_INITIAL_INST,
        AG_GPF_Subscription_MAX_INST,
        AG_GPF_Subscription_Policy_No,
        AG_GPF_Subscription_Last_Date,
        AG_GPF_Subscription_Action,
        GIS_Ins_Fund,
        GIS_Ins_Fund_Recovered_Inst,
        GIS_Ins_Fund_INITIAL_INST,
        GIS_Ins_Fund_MAX_INST,
        GIS_Ins_Fund_Policy_No,
        GIS_Ins_Fund_Last_Date,
        GIS_Ins_Fund_Action,
        Professional_Tax,
        Professional_Tax_Recovered_INST,
        Professional_Tax_INITIAL_INST,
        Professional_Tax_MAX_INST,
        Professional_Tax_Policy_No,
        Professional_Tax_Last_Date,
        Professional_Tax_Action,
        TSGLI_Subscription,
        TSGLI_Recovered_INST,
        TSGLI_INITIAL_INST,
        TSGLI_MAX_INST,
        TSGLI_Policy_No,
        TSGLI_Last_Date,
        TSGLI_Action,
        NG_NON_GOVT_Others,
        NG_NON_GOVT_Others_Recovered_INST,
        NG_NON_GOVT_Others_INITIAL_INST,
        NG_NON_GOVT_Others_MAX_INST,
        NG_NON_GOVT_Others_Policy_No,
        NG_NON_GOVT_Others_Last_Date,
        NG_NON_GOVT_Others_Action
    )
VALUES (
        20001,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20002,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20003,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20004,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20005,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20006,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20007,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20008,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    ), (
        20009,
        5000,
        '2023-01-01',
        1000,
        '2023-01-05',
        800,
        '2023-01-10',
        1200,
        '2023-01-15',
        500,
        '2023-01-20',
        1000,
        200,
        150,
        100,
        'Policy1',
        '2023-01-25',
        'Action1',
        700,
        300,
        200,
        150,
        'Policy2',
        '2023-01-30',
        'Action2',
        50,
        20,
        10,
        5,
        'Policy3',
        '2023-01-05',
        'Action3',
        100,
        50,
        30,
        20,
        'Policy4',
        '2023-01-10',
        'Action4',
        150,
        70,
        40,
        25,
        'Policy5',
        '2023-01-15',
        'Action5'
    );

-- Data-Entry into Transction table

INSERT INTO
    Transaction (
        Employee_Code,
        JANUARY,
        FEBRUARY,
        MARCH,
        APRIL,
        MAY,
        JUNE,
        JULY,
        AUGUST,
        SEPTEMBER,
        OCTOBER,
        NOVEMBER,
        DECEMBER
    )
VALUES (
        20001,
        10000,
        12000,
        15000,
        13000,
        14000,
        16000,
        18000,
        20000,
        18000,
        16000,
        15000,
        17000
    ), (
        20002,
        8000,
        10000,
        12000,
        11000,
        13000,
        14000,
        15000,
        16000,
        17000,
        16000,
        15000,
        18000
    ), (
        20003,
        10000,
        12000,
        15000,
        13000,
        14000,
        16000,
        18000,
        20000,
        18000,
        16000,
        15000,
        17000
    ), (
        20004,
        8000,
        10000,
        12000,
        11000,
        13000,
        14000,
        15000,
        16000,
        17000,
        16000,
        15000,
        18000
    ), (
        20005,
        10000,
        12000,
        15000,
        13000,
        14000,
        16000,
        18000,
        20000,
        18000,
        16000,
        15000,
        17000
    ), (
        20006,
        8000,
        10000,
        12000,
        11000,
        13000,
        14000,
        15000,
        16000,
        17000,
        16000,
        15000,
        18000
    ), (
        20007,
        10000,
        12000,
        15000,
        13000,
        14000,
        16000,
        18000,
        20000,
        18000,
        16000,
        15000,
        17000
    ), (
        20008,
        8000,
        10000,
        12000,
        11000,
        13000,
        14000,
        15000,
        16000,
        17000,
        16000,
        15000,
        18000
    ), (
        20009,
        10000,
        12000,
        15000,
        13000,
        14000,
        16000,
        18000,
        20000,
        18000,
        16000,
        15000,
        17000
    );

-- Q1..list of employees (name, doj, dob, gender, phone, working_status, designation, location)

Select * from Employee_Details;

-- Q2.count of employees location wise(location,employee count).

SELECT
    LOCATION,
    COUNT(*) AS Employee_Count
FROM Employee_Details
GROUP BY LOCATION;

-- Q3.count of employees designation wise (designation,employee count)

SELECT
    Designation,
    COUNT(*) AS Employee_Count
FROM Employee_Details
GROUP BY Designation;

-- Q4.count of employees working status (working status,employee count)

SELECT
    WORKING_Status,
    COUNT(*) AS Employee_Count
FROM Employee_Details
GROUP BY WORKING_Status;

-- Q5.calculate and show all employees retirement date (empoyee code, employee_name, dob, doj, retirement_date) (if retirement ll be at age of 60)

SELECT
    Employee_Code,
    CONCAT(First_Name, ' ', Last_Name) AS Employee_Name,
    DOB,
    DOJ,
    DOB + INTERVAL '60 years' AS Retirement_Date
FROM Employee_Details;

-- Q6.show salary break up(each salary compoment) of each employee wise. (employee code, name, basic pay, hra, cca, pt, it)

SELECT
    ed.Employee_Code,
    ed.First_Name,
    ed.Last_Name,
    ea.Basic_Pay,
    ea.Deaeness_Allowness,
    ea.House_Rent_Allowness,
    ea.City_Compensatory_Allowance,
    ea.Telangana_Increment
FROM Employee_Details ed
    JOIN EarningAndDeduction ea ON ed.Employee_Code = ea.Employee_Code;

-- Q7.show gross, deductions, net salary of each employee (employee code, name, gross, deduction, net)

SELECT
    ed.Employee_Code,
    CONCAT(
        ed.First_Name,
        ' ',
        ed.Last_Name
    ) AS Employee_Name, (
        ea.Basic_Pay + ea.Deaeness_Allowness + ea.House_Rent_Allowness + ea.City_Compensatory_Allowance + ea.Telangana_Increment
    ) AS Gross, (
        ea.AG_GPF_Subscription + ea.GIS_Ins_Fund + ea.Professional_Tax + ea.TSGLI_Subscription + ea.NG_NON_GOVT_Others
    ) AS Deductions, ( (
            ea.Basic_Pay + ea.Deaeness_Allowness + ea.House_Rent_Allowness + ea.City_Compensatory_Allowance + ea.Telangana_Increment
        ) - (
            ea.AG_GPF_Subscription + ea.GIS_Ins_Fund + ea.Professional_Tax + ea.TSGLI_Subscription + ea.NG_NON_GOVT_Others
        )
    ) AS Net_Salary
FROM Employee_Details ed
    JOIN EarningAndDeduction ea ON ed.Employee_Code = ea.Employee_Code;

--  Q8.   salary received by each employee for last month (employee_id, name, salary_year, salary_month,).

SELECT
    ed.Employee_Code,
    CONCAT(
        ed.First_Name,
        ' ',
        ed.Last_Name
    ) AS Employee_Name,
    tr.OCTOBER AS Salary_October
FROM Employee_Details ed
    JOIN Transaction tr ON ed.Employee_Code = tr.Employee_Code;

-- Q9. list of employees who have not received salary for last month (employee code, name)

SELECT
    ed.Employee_Code,
    CONCAT(
        ed.First_Name,
        ' ',
        ed.Last_Name
    ) AS Employee_Name
FROM Employee_Details ed
    LEFT JOIN Transaction tr ON ed.Employee_Code = tr.Employee_Code
WHERE tr.OCTOBER IS NULL;

--Q.10 list of employees whos actual salary net amount not matched with net amount of salary received in last month. (employee code, name, actual net, last month net salary).

SELECT
    ed.Employee_Code,
    CONCAT(
        ed.First_Name,
        ' ',
        ed.Last_Name
    ) AS Employee_Name, ( (
            ea.Basic_Pay + ea.Deaeness_Allowness + ea.House_Rent_Allowness + ea.City_Compensatory_Allowance + ea.Telangana_Increment
        ) - (
            ea.AG_GPF_Subscription + ea.GIS_Ins_Fund + ea.Professional_Tax + ea.TSGLI_Subscription + ea.NG_NON_GOVT_Others
        )
    ) AS Net_Salary,
    tr.october
FROM Employee_Details ed
    JOIN EarningAndDeduction ea ON ed.Employee_Code = ea.Employee_Code
    LEFT JOIN Transaction tr ON ed.Employee_Code = tr.Employee_Code
WHERE ( (
            ea.Basic_Pay + ea.Deaeness_Allowness + ea.House_Rent_Allowness + ea.City_Compensatory_Allowance + ea.Telangana_Increment
        ) - (
            ea.AG_GPF_Subscription + ea.GIS_Ins_Fund + ea.Professional_Tax + ea.TSGLI_Subscription + ea.NG_NON_GOVT_Others
        )
    ) != tr.Total_Earning;