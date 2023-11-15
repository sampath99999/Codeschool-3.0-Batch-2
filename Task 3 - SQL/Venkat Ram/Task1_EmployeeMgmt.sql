CREATE DATABASE employee;

\c employee;

CREATE TABLE location (
  id SERIAL PRIMARY KEY,
  description VARCHAR,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE working_status (
  id SERIAL PRIMARY KEY,
  description VARCHAR,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE designation (
  id SERIAL PRIMARY KEY,
  designation VARCHAR,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE salary_type (
  id SERIAL PRIMARY KEY,
  types VARCHAR,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE salary_components_types (
  id SERIAL PRIMARY KEY,
  salary_type_id INTEGER REFERENCES salary_type(id),
  components_name VARCHAR,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE SEQUENCE empcode_seq START WITH 20001;

CREATE TABLE employees (
  id SERIAL PRIMARY KEY,
  empcode INTEGER DEFAULT nextval('empcode_seq'),
  f_name VARCHAR,
  l_name VARCHAR,
  surname VARCHAR,
  dob DATE,
  doj DATE,
  gender VARCHAR,
  phone BIGINT,
  working_status_id INTEGER REFERENCES working_status(id),
  designation_id INTEGER REFERENCES designation(id),
  location_id INTEGER REFERENCES location(id),
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE employee_salary_breakup (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id),
  salary_type_id INTEGER REFERENCES salary_type(id),
  salary_components_type_id INTEGER REFERENCES salary_components_types(id),
  amount INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE salary_details (
  id SERIAL PRIMARY KEY,
  employee_id INTEGER REFERENCES employees(id),
  month INTEGER,
  year INTEGER,
  paid_on DATE,
  gross INTEGER,
  deduction INTEGER,
  net INTEGER,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO location (description) VALUES
  ('Hyderabad'),
  ('Chennai');

INSERT INTO working_status (description) VALUES
  ('Full-Time'),
  ('Part-Time');

INSERT INTO designation (designation) VALUES
  ('Software Engineer'),
  ('Senior Software Engineer'),
  ('Project Manager'),
  ('System Analyst'),
  ('Database Administrator');

INSERT INTO salary_type (types) VALUES
  ('Basic Pay'),
  ('House Rent Allowance'),
  ('Professional Tax'),
  ('City Compensatory Allowance'),
  ('Income Tax');

INSERT INTO salary_components_types (salary_type_id, components_name) VALUES
  (1, 'Basic Salary'),
  (2, 'House Rent Allowance'),
  (3, 'Professional Tax'),
  (4, 'City Compensatory Allowance'),
  (5, 'Income Tax');

INSERT INTO employees (f_name, l_name, surname, dob, doj, gender, phone, working_status_id, designation_id, location_id) VALUES
  ('John', 'Doe', 'Jr.', '1990-01-15', '2020-03-01', 'Male', 1234567890, 1, 1, 1),
  ('Jane', 'Smith', 'Sr.', '1985-08-20', '2018-11-15', 'Female', 9876543210, 2, 2, 2),
  ('Michael', 'Johnson', 'Sr.', '1988-05-10', '2019-02-15', 'Male', 5551237890, 1, 3, 1),
  ('Emily', 'Williams', 'Jr.', '1992-11-22', '2021-07-05', 'Female', 3339876543, 2, 4, 2),
  ('Robert', 'Anderson', 'Sr.', '1980-03-18', '2015-09-10', 'Male', 7778765432, 1, 5, 1),
  ('Sophia', 'Brown', 'Jr.', '1995-07-30', '2022-04-12', 'Female', 4442345678, 2, 1, 2),
  ('William', 'Davis', 'Sr.', '1987-09-05', '2017-12-20', 'Male', 6667890123, 2, 2, 1),
  ('Ava', 'Martinez', 'Jr.', '1994-01-08', '2020-10-25', 'Female', 5553456789, 1, 3, 2),
  ('John', 'Taylor', 'Sr.', '1983-12-01', '2016-05-15', 'Male', 4448901234, 1, 4, 1),
  ('Olivia', 'Clark', 'Jr.', '1991-06-14', '2019-09-18', 'Female', 7770123456, 2, 5, 2),
  ('James', 'Garcia', 'Sr.', '1986-04-25', '2018-01-30', 'Male', 8887654321, 1, 1, 1),
  ('Emma', 'Lopez', 'Jr.', '1993-02-28', '2021-03-08', 'Female', 9992345678, 1, 2, 2),
  ('Daniel', 'Hill', 'Sr.', '1984-08-12', '2017-06-22', 'Male', 1118765432, 2, 3, 1),
  ('Mia', 'Adams', 'Jr.', '1996-10-17', '2022-08-14', 'Female', 2229876543, 2, 4, 2),
  ('Alexander', 'Baker', 'Sr.', '1989-07-03', '2019-11-28', 'Male', 3337654321, 1, 5, 1);

INSERT INTO employee_salary_breakup (employee_id, salary_type_id, salary_components_type_id, amount) VALUES
  (1, 1, 1, 70000),
  (1, 2, 2, 2000),
  (1, 3, 3, 3000),
  (1, 4, 4, 2000),
  (1, 5, 5, 3000),
  (2, 1, 1, 75000),
  (2, 2, 2, 2000),
  (2, 3, 3, 3000),
  (2, 4, 4, 2000),
  (2, 5, 5, 4000),
  (3, 1, 1, 85000),
  (3, 2, 2, 2000),
  (3, 3, 3, 3000),
  (3, 4, 4, 3000),
  (3, 5, 5, 4000),
  (4, 1, 1, 90000),
  (4, 2, 2, 2000),
  (4, 3, 3, 3000),
  (4, 4, 4, 3000),
  (4, 5, 5, 5000),
  (5, 1, 1, 95000),
  (5, 2, 2, 2000),
  (5, 3, 3, 3000),
  (5, 4, 4, 3000),
  (5, 5, 5, 6000),
  (6, 1, 1, 80000),
  (6, 2, 2, 2000),
  (6, 3, 3, 3000),
  (6, 4, 4, 2000),
  (6, 5, 5, 2000),
  (7, 1, 1, 83000),
  (7, 2, 2, 2000),
  (7, 3, 3, 3000),
  (7, 4, 4, 2000),
  (7, 5, 5, 2500),
  (8, 1, 1, 87000),
  (8, 2, 2, 2000),
  (8, 3, 3, 3000),
  (8, 4, 4, 2000),
  (8, 5, 5, 3000),
  (9, 1, 1, 93000),
  (9, 2, 2, 2000),
  (9, 3, 3, 3000),
  (9, 4, 4, 2000),
  (9, 5, 5, 3500),
  (10, 1, 1, 100000),
  (10, 2, 2, 2000),
  (10, 3, 3, 3000),
  (10, 4, 4, 3000),
  (10, 5, 5, 3000),
  (11, 1, 1, 105000),
  (11, 2, 2, 2000),
  (11, 3, 3, 3000),
  (11, 4, 4, 3000),
  (11, 5, 5, 3500),
  (12, 1, 1, 110000),
  (12, 2, 2, 2000),
  (12, 3, 3, 3000),
  (12, 4, 4, 3000),
  (12, 5, 5, 4000),
  (13, 1, 1, 115000),
  (13, 2, 2, 2000),
  (13, 3, 3, 3000),
  (13, 4, 4, 4000),
  (13, 5, 5, 3500),
  (14, 1, 1, 120000),
  (14, 2, 2, 2000),
  (14, 3, 3, 3000),
  (14, 4, 4, 4000),
  (14, 5, 5, 4000),
  (15, 1, 1, 125000),
  (15, 2, 2, 2000),
  (15, 3, 3, 3000),
  (15, 4, 4, 4000),
  (15, 5, 5, 4500);

INSERT INTO salary_details (employee_id, month, year, paid_on, gross, deduction, net) VALUES
  (1, 10, 2023, '2023-10-28', 75000, 5000, 70000),
  (2, 11, 2023, '2023-11-28', 80000, 6000, 74000),
  (3, 10, 2023, '2023-10-28', 90000, 7000, 83000),
  (4, 2, 2023, '2023-02-28', 95000, 8000, 87000),
  (5, 10, 2023, '2023-10-28', 100000, 9000, 91000),
  (6, 2, 2023, '2023-02-28', 85000, 4000, 81000),
  (7, 10, 2023, '2023-10-28', 88000, 4500, 83500),
  (8, 2, 2023, '2023-02-28', 92000, 5000, 87000),
  (9, 10, 2023, '2023-10-28', 98000, 5500, 92500),
  (10, 2, 2023, '2023-02-28', 105000, 6000, 99000),
  (11, 10, 2023, '2023-10-28', 110000, 6500, 103500),
  (12, 2, 2023, '2023-02-28', 115000, 7000, 108000),
  (13, 10, 2023, '2023-10-28', 120000, 7500, 112500),
  (14, 2, 2023, '2023-02-28', 125000, 8000, 116000),
  (15, 10, 2023, '2023-10-28', 130000, 8500, 121500);


--Queries

--1) List of employees (name, doj, dob, gender, phone, working_status, designation, location)

SELECT
    f_name || ' ' || l_name || ' ' || surname "Employee Name",
    doj "Date of Joining",
    dob "Date of Birth",
    gender "Gender",
    phone "Phone Number",
    ws.description "Working Status",
    d.designation "Designation",
    l.description "Location"
FROM employees emp
    JOIN working_status ws ON emp.working_status_id = ws.id
    JOIN designation d ON emp.designation_id = d.id
    JOIN location l ON emp.location_id = l.id;

--2) Count of employees location wise(location,employee count)

SELECT
  COUNT(emp.id) "Employee Count",
  l.description "Location"
FROM
  employees emp
  JOIN location l ON emp.location_id = l.id
GROUP BY
  l.description;

--3) Count of employees designation wise (designation,employee count)

SELECT
  d.designation "Designation",
  COUNT(emp.id) "Employee Count"
FROM
  employees emp
  JOIN designation d ON emp.designation_id = d.id
GROUP BY
  d.designation;

--4) Count of employees working status (working status,employee count)

SELECT
  ws.description "Working Status",
  COUNT(emp.id) "Employee Count"
FROM
  employees emp
  JOIN working_status ws ON emp.working_status_id = ws.id
GROUP BY
  ws.description;

--5) Calculate and show all employees retirement date (empoyee code, employee_name, dob, doj, retirement_date) (if retirement will be at age of 60)

SELECT
  empcode "Employee Code",
  f_name || ' ' || l_name || ' ' || surname "Employee Name",
  doj "Date of Joining",
  dob "Date of Birth",
  DATE(dob + INTERVAL '60 years') AS "Retirement Date"
FROM
  employees;

--6) Show salary break up(each salary compoment) of each employee wise. (employee code, name, basic pay, hra, cca, pt, it)

SELECT
  emp.empcode "Employee Code",
  emp.f_name || ' ' || emp.l_name || ' ' || emp.surname "Employee Name",
  esb.amount AS "Base Salary",
  esb_h.amount AS "House Rent Allowance",
  esb_c.amount AS "City Compensatory Allowance",
  esb_pt.amount AS "Professional Tax",
  esb_it.amount AS "Income Tax"
FROM
  employees emp
  LEFT JOIN employee_salary_breakup esb ON emp.id = esb.employee_id AND esb.salary_type_id = 1
  LEFT JOIN employee_salary_breakup esb_h ON emp.id = esb_h.employee_id AND esb_h.salary_type_id = 2
  LEFT JOIN employee_salary_breakup esb_c ON emp.id = esb_c.employee_id AND esb_c.salary_type_id = 4
  LEFT JOIN employee_salary_breakup esb_pt ON emp.id = esb_pt.employee_id AND esb_pt.salary_type_id = 3
  LEFT JOIN employee_salary_breakup esb_it ON emp.id = esb_it.employee_id AND esb_it.salary_type_id = 5

--7) Show gross, deductions, net salary of each employee (employee code, name, gross, deduction, net)

SELECT
  emp.empcode "Employee Code",
  emp.f_name || ' ' || emp.l_name || ' ' || emp.surname "Employee Name",
  esb_b.amount + esb_h.amount + esb_c.amount "Gross Amount",
  esb_pt.amount + esb_it.amount "Deduction Amount",
  esb_b.amount + esb_h.amount + esb_c.amount - (esb_pt.amount + esb_it.amount) "Net Amount"
FROM
  employees emp
  LEFT JOIN employee_salary_breakup esb_b ON emp.id = esb_b.employee_id AND esb_b.salary_type_id = 1 
  LEFT JOIN employee_salary_breakup esb_h ON emp.id = esb_h.employee_id AND esb_h.salary_type_id = 2
  LEFT JOIN employee_salary_breakup esb_c ON emp.id = esb_c.employee_id AND esb_c.salary_type_id = 4  LEFT JOIN employee_salary_breakup esb_pt ON emp.id = esb_pt.employee_id AND esb_pt.salary_type_id = 3
  LEFT JOIN employee_salary_breakup esb_it ON emp.id = esb_it.employee_id AND esb_it.salary_type_id = 5

--8) Salary received by each employee for last month (employee_id, name, salary_year, salary_month, gross, deduction, net)

SELECT
  emp.id "Employee ID",
  emp.f_name || ' ' || emp.l_name || ' ' || emp.surname AS "Employee Name",
  sd.year AS "Salary Year",
  sd.month AS "Salary Month",
  sd.gross "Gross Amount",
  sd.deduction "Deduction Amount",
  sd.net "Net Amount"
FROM
  employees emp
  JOIN salary_details sd ON emp.id = sd.employee_id
WHERE
  sd.paid_on >= DATE_TRUNC('MONTH', CURRENT_DATE) - INTERVAL '1 month' AND sd.paid_on < DATE_TRUNC('MONTH', CURRENT_DATE);

--9) List of employees who have not received salary for last month (employee code, name)

SELECT
  emp.empcode "Employee Code",
  emp.f_name || ' ' || emp.l_name || ' ' || emp.surname "Employee Name"
FROM
  employees emp
WHERE
  NOT EXISTS (
    SELECT 1
    FROM salary_details sd
    WHERE sd.employee_id = emp.id
    AND DATE_TRUNC('MONTH', sd.paid_on) = DATE_TRUNC('MONTH', CURRENT_DATE - INTERVAL '1 month')
  );