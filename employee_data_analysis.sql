
CREATE DATABASE IF NOT EXISTS Employee_Analysis;
USE Employee_Analysis;

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department_id INT,
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE,
    city VARCHAR(50),
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Sales');

INSERT INTO employees VALUES
(101, 'Arun', 1, 'Data Analyst', 45000, '2024-01-15', 'Bengaluru'),
(102, 'Priya', 2, 'HR Executive', 35000, '2023-06-10', 'Chennai'),
(103, 'Rahul', 1, 'Developer', 55000, '2022-03-20', 'Bengaluru'),
(104, 'Sneha', 3, 'Accountant', 40000, '2023-09-12', 'Hyderabad'),
(105, 'Kiran', 4, 'Sales Executive', 30000, '2024-04-05', 'Chennai'),
(106, 'Divya', 1, 'Data Analyst', 50000, '2021-11-18', 'Hyderabad'),
(107, 'Manoj', 3, 'Financial Analyst', 48000, '2022-08-22', 'Bengaluru'),
(108, 'Keerthi', 4, 'Sales Manager', 60000, '2020-02-14', 'Chennai'),
(109, 'Ravi', 2, 'HR Manager', 52000, '2021-07-30', 'Hyderabad'),
(110, 'Pooja', 1, 'Tester', 42000, '2024-07-01', 'Bengaluru');

-- 1. Total employees
SELECT COUNT(*) AS total_employees
FROM employees;

-- 2. Salary summary
SELECT
    ROUND(AVG(salary), 2) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;

-- 3. Department-wise employee count
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 4. Highest-paid employee
SELECT employee_name, job_title, salary
FROM employees
WHERE salary = (SELECT MAX(salary) FROM employees);

-- 5. Salary category
SELECT
    employee_name,
    salary,
    CASE
        WHEN salary >= 50000 THEN 'High Salary'
        WHEN salary >= 40000 THEN 'Medium Salary'
        ELSE 'Low Salary'
    END AS salary_category
FROM employees;

-- 6. Department salary report
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS average_salary,
    SUM(e.salary) AS total_salary
FROM departments d
JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY average_salary DESC;

-- 7. City-wise employee count
SELECT city, COUNT(*) AS employee_count
FROM employees
GROUP BY city
ORDER BY employee_count DESC;

-- 8. Employees earning at least 45000
SELECT employee_name, job_title, salary
FROM employees
WHERE salary >= 45000
ORDER BY salary DESC;

-- 9. Employee and department report
SELECT
    e.employee_name,
    e.job_title,
    d.department_name,
    e.salary,
    e.city
FROM employees e
JOIN departments d
    ON e.department_id = d.department_id
ORDER BY e.salary DESC;

-- 10. Employees earning above company average
SELECT employee_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;
