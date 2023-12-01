create database Employee_Management;
create table working_status(
  id SERIAL PRIMARY KEY,
  status_name varchar(50),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
create table location(
  id SERIAL PRIMARY KEY,
  location_name varchar(50),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
create table designation(
  id SERIAL PRIMARY KEY,
  designation_name varchar(50),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
create table employees(
  id int,
  empcode varchar(5) PRIMARY KEY UNIQUE CHECK (empcode >= '20001' AND empcode <= '29999'),
  first_name VARCHAR(50),
  last_name varchar(50),
  doj date,
  dob DATE,
  gender varchar(10),
  phone varchar(15),
  status_id int REFERENCES working_status(id),
  location_id int REFERENCES location(id),
  designation_id int REFERENCES designation(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
create table salary_details(
  id SERIAL PRIMARY KEY,
  empcode varchar(5) REFERENCES employees(empcode),
  month int,
  year int,
  paid_on DATE,
  gross int,
  deduction int,
  net int,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
create table salary_type(
  id int PRIMARY KEY,
  types varchar(30),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
create table salary_components(
  id int PRIMARY KEY,
  component_name varchar(30),
  salary_type_id int REFERENCES salary_type(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
create table employee_salary(
  id int PRIMARY KEY,
  salary_type_id int,
  salary_components_type_id int REFERENCES salary_components(id),
  amount decimal(12,2),
  empcode varchar(5) REFERENCES employees(empcode),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);
INSERT INTO working_status (status_name, created_at, updated_at) VALUES
  ('Active', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Inactive', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Intern', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Part-time', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Full-time', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO location (location_name, created_at, updated_at) VALUES
  ('New york', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Hyderabad', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Chennai', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('US', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Hyderabad', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO designation (designation_name, created_at, updated_at) VALUES
  ('Manager', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Developer', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('HR', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('CEO', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('Devops', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO employees (id,empcode, first_name, last_name, doj, dob, gender, phone, status_id, location_id, designation_id, created_at, updated_at) VALUES
  (1,'20001', 'John', 'Doe', '2023-01-01', '1990-05-15', 'Male', '1234567890', 1, 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2,'20002', 'Jane', 'Smith', '2023-02-01', '1988-09-20', 'Female', '9876543210', 1, 2, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3,'20003', 'Bob', 'Johnson', '2023-03-01', '1995-12-10', 'Male', '5556667777', 2, 3, 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4,'20004', 'Prashanth', 'Uppula', '2023-05-01', '1999-09-20', 'Male', '9876983210', 4, 5, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (5,'20005', 'Venkat', 'Venky', '2023-04-01', '2001-12-10', 'Male', '5559877777', 5, 4, 5, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO salary_details (empcode, month, year, paid_on, gross, deduction, net, created_at, updated_at) VALUES
  ('20001', 1, 2023, '2023-01-25', 5000, 500, 4500, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('20002', 3, 2023, '2023-03-25', 6000, 600, 5400, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('20003', 2, 2023, '2023-02-25', 7000, 700, 6300, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('20004', 3, 2023, '2023-03-25', 6000, 600, 5500, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  ('20005', 2, 2023, '2023-02-25', 7000, 700, 6600, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO salary_type (id, types, created_at, updated_at) VALUES
  (1, 'basic salary', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'earnings', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 'deduction', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO salary_components (id, component_name, salary_type_id, created_at, updated_at) VALUES
  (1, 'basic_pay', 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 'h_r_a', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 'c_c_a', 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4, 'pt', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (5, 'it', 3, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
INSERT INTO employee_salary (id, salary_type_id, salary_components_type_id, amount, empcode, created_at, updated_at) VALUES
  (1, 1, 1, 3000, '20001', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (2, 2, 2, 1000, '20002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (3, 3, 3, 500, '20003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (4, 2, 4, 1000, '20002', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
  (5, 3, 5, 5000, '20003', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
--1. list of employees (name, doj, dob, gender, phone, working_status, designation, location)
SELECT
  first_name || ' ' || last_name AS employee_name,
  doj,
  dob,
  gender,
  phone,
  working_status.status_name AS working_status,
  designation.designation_name AS designation,
  location.location_name AS location
FROM employees
JOIN working_status ON employees.status_id = working_status.id
JOIN designation ON employees.designation_id = designation.id
JOIN location ON employees.location_id = location.id;

--2. count of employees location wise(location,employee count).
SELECT
  location.location_name AS location,
  COUNT(*) AS employee_count
FROM employees
JOIN location ON employees.location_id = location.id
GROUP BY location.location_name;

--3. count of employees designation wise (designation,employee count),
SELECT
  designation.designation_name AS designation,
  COUNT(*) AS employee_count
FROM employees
JOIN designation ON employees.designation_id = designation.id
GROUP BY designation.designation_name;

--7. show gross, deductions, net salary of each employee (employee code, name, gross, deduction, net)
SELECT
  e.empcode AS employee_code,
  e.first_name || ' ' || e.last_name AS employee_name,
  sd.gross,
  sd.deduction,
  sd.net
FROM employees e
JOIN salary_details sd ON e.empcode = sd.empcode;

--8. salary received by each employee for last month (employee_id, name, salary_year, salary_month, gross, deduction, net).
SELECT
  e.id AS employee_id,
  e.first_name || ' ' || e.last_name AS employee_name,
  EXTRACT(YEAR FROM sd.paid_on) AS salary_year,
  EXTRACT(MONTH FROM sd.paid_on) AS salary_month,
  sd.gross,
  sd.deduction,
  sd.net
FROM employees e
JOIN salary_details sd ON e.empcode = sd.empcode
WHERE sd.paid_on >= DATE_TRUNC('MONTH', CURRENT_DATE - INTERVAL '1 month')
  AND sd.paid_on < DATE_TRUNC('MONTH', CURRENT_DATE);

--9. list of employees who have not received salary for last month (employee code, name)
SELECT
  e.empcode AS employee_code,
  e.first_name || ' ' || e.last_name AS employee_name
FROM employees e
LEFT JOIN salary_details sd ON e.empcode = sd.empcode
WHERE sd.empcode IS NULL
   OR (sd.paid_on < DATE_TRUNC('MONTH', CURRENT_DATE - INTERVAL '1 month')
       AND sd.paid_on >= DATE_TRUNC('MONTH', CURRENT_DATE - INTERVAL '2 months'));

--10. list of employees whos actual salary net amount not matched with net amount of salary received in last month. (employee code, name, actual net, last month net salary).
SELECT
  e.empcode AS employee_code,
  e.first_name || ' ' || e.last_name AS employee_name,
  es_actual.amount AS actual_net,
  sd.net AS last_month_net
FROM employees e
JOIN employee_salary es_actual ON e.empcode = es_actual.empcode AND es_actual.salary_type_id = 3 -- Assuming salary_type_id 3 corresponds to net salary
LEFT JOIN salary_details sd ON e.empcode = sd.empcode
WHERE sd.paid_on >= DATE_TRUNC('MONTH', CURRENT_DATE - INTERVAL '1 month')
  AND sd.paid_on < DATE_TRUNC('MONTH', CURRENT_DATE)
  AND (es_actual.amount IS NULL OR es_actual.amount != sd.net);
  

-- count of employees working status (working status,employee count)
SELECT
  ws.status_name AS working_status,
  COUNT(e.id) AS employee_count
FROM
  working_status ws
LEFT JOIN
  employees e ON ws.id = e.status_id
GROUP BY
  ws.status_name;

-- calculate and show all employees retirement date (empoyee code, employee_name, dob, doj, retirement_date) (if retirement ll be at age of 60)
SELECT
  emp.empcode AS employee_code,
  CONCAT(emp.first_name, ' ', emp.last_name) AS employee_name,
  emp.dob AS date_of_birth,
  emp.doj AS date_of_joining,
  (emp.dob + INTERVAL '60 years') AS retirement_date
FROM
  employees emp;


--show salary break up(each salary compoment) of each employee wise. (employee code, name, basic pay, hra, cca, pt, it)
SELECT
  e.empcode AS employee_code,
  CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
  es.amount AS basic_pay,
  es_hra.amount AS hra,
  es_cca.amount AS cca,
  es_pt.amount AS pt,
  es_it.amount AS it
FROM
  employees e
JOIN
  employee_salary es ON e.empcode = es.empcode
LEFT JOIN
  employee_salary es_hra ON e.empcode = es_hra.empcode AND es_hra.salary_components_type_id = (SELECT id FROM salary_components WHERE component_name = 'h_r_a')
LEFT JOIN
  employee_salary es_cca ON e.empcode = es_cca.empcode AND es_cca.salary_components_type_id = (SELECT id FROM salary_components WHERE component_name = 'c_c_a')
LEFT JOIN
  employee_salary es_pt ON e.empcode = es_pt.empcode AND es_pt.salary_components_type_id = (SELECT id FROM salary_components WHERE component_name = 'pt')
LEFT JOIN
  employee_salary es_it ON e.empcode = es_it.empcode AND es_it.salary_components_type_id = (SELECT id FROM salary_components WHERE component_name = 'it');
  



