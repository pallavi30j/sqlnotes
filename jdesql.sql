DROP DATABASE IF EXISTS jde;
CREATE DATABASE jde;
USE jde;
-- DEPARTMENT TABLE
CREATE TABLE departments(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(20)
);

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance'),
(4, 'Marketing'),
(5, 'Sales'),
(6, 'Operations'),
(7, 'Legal'),
(8, 'Research'),
(9, 'Support'),
(10, 'Admin');


-- EMPLOYEES TABLE
CREATE TABLE employees(
    employees_id INT PRIMARY KEY,
    employee_name VARCHAR(20),
    department_id INT,
    salary INT,
    joining_date DATE,
    city VARCHAR(20),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees VALUES
(1, 'Pallavi', 1, 55000, '2023-01-15', 'Bangalore'),
(2, 'Rahul', 2, 62000, '2022-06-20', 'Mumbai'),
(3, 'Sneha', 1, 48000, '2024-02-10', 'Bangalore'),
(4, 'Arjun', 3, 75000, '2021-11-05', 'Chennai'),
(5, 'Priya', 2, 68000, '2023-08-12', 'Hyderabad'),
(6, 'Kiran', 1, 55000, '2022-03-18', 'Bangalore'),
(7, 'Ananya', 3, 82000, '2020-09-25', 'Mumbai'),
(8, 'Vikram', 2, 62000, '2024-01-08', 'Delhi'),
(9, 'Meera', 3, 75000, '2021-05-30', 'Chennai'),
(10, 'Rohit', 1, 48000, '2023-12-01', 'Delhi');

SELECT * FROM departments;
SELECT * FROM employees;

-- PROJECTS TABLE
create table projects(
project_id int primary key,
project_name varchar(30),
employees_id int,
project_cost int,
start_date date,
foreign key (employees_id) references employees(employees_id)
);

insert into projects values
(101, 'Cloud Migration', 1, 500000, '2024-01-10'),
(102, 'Banking App', 2, 750000, '2023-06-15'),
(103, 'E-Commerce', 3, 450000, '2024-02-20'),
(104, 'AI Platform', 4, 900000, '2022-11-01'),
(105, 'Mobile App', 5, 600000, '2023-08-25'),
(106, 'Data Analytics', 6, 550000, '2024-03-10'),
(107, 'Security System', 7, 850000, '2022-09-05'),
(108, 'Payment Gateway', 8, 700000, '2024-01-20'),
(109, 'IoT Platform', 9, 800000, '2023-05-12'),
(110, 'DevOps Project', 10, 400000, '2023-12-15');

select * from projects;


-- CUSTOMERS TABLE
create table customers(
customer_id int primary key,
customer_name varchar(20),
city varchar(20)
);

insert into customers values
(1, 'Aarav', 'Bangalore'),
(2, 'Diya', 'Mumbai'),
(3, 'Rohan', 'Chennai'),
(4, 'Ananya', 'Delhi'),
(5, 'Karthik', 'Hyderabad'),
(6, 'Sneha', 'Bangalore'),
(7, 'Arjun', 'Pune'),
(8, 'Meera', 'Mumbai'),
(9, 'Vikram', 'Chennai'),
(10, 'Pooja', 'Delhi');

select * from customers;

-- TRANSACTIONS TABLE
create table transactions(
transaction_id int primary key,
customer_id int,
transaction_date date,
transaction_type varchar(20),
amount int,
foreign key (customer_id) references customers(customer_id)
);

insert into transactions values
(1, 1, '2026-01-05', 'Credit', 50000),
(2, 2, '2026-01-08', 'Debit', 15000),
(3, 3, '2026-01-12', 'Credit', 30000),
(4, 1, '2026-01-15', 'Debit', 10000),
(5, 4, '2026-01-18', 'Credit', 45000),
(6, 5, '2026-01-22', 'Debit', 20000),
(7, 2, '2026-01-25', 'Credit', 35000),
(8, 6, '2026-02-01', 'Debit', 12000),
(9, 3, '2026-02-05', 'Credit', 25000),
(10, 7, '2026-02-10', 'Debit', 18000);

select * from transactions;

-- EMPLOYEE_HISTORY TABLE
create table employee_history(
employee_id int,
salary int,
effective_date date
);

insert into employee_history values
(1, 45000, '2022-01-10'),
(1, 50000, '2023-01-15'),
(1, 55000, '2024-02-20'),
(2, 50000, '2022-06-10'),
(2, 58000, '2023-07-15'),
(2, 62000, '2024-08-20'),
(3, 40000, '2023-01-05'),
(3, 45000, '2024-03-10'),
(4, 65000, '2022-05-12'),
(4, 75000, '2024-06-18');

select * from employee_history;

-- 1. Department Salary Analysis 
-- Which query correctly returns the employee count and average salary for each department? 
 SELECT department_id, COUNT(*) AS employee_count, AVG(salary) AS average_salary FROM employees GROUP BY department_id; 

-- 2. High Average Salary Departments 
-- Which query returns departments whose average salary is greater than 70000? 
select department_id , avg(salary) as average_salary from employees
group by department_id having avg(salary) > 70000; 

-- 3. Employee Department Report
-- Which query correctly displays employee name, department name, and salary? 
select e.employee_name, d.department_name,e.salary
from employees e 
join departments d
on e.department_id = d.department_id;

-- 4. Employees Without Department 
-- Which query finds employees whose department does not exist in the departments table? 
select e.department_id, d.department_id,e.salary
from employees e
left join departments d
on e.department_id = d.department_id
where d.department_id is null;

-- 5. Employees With Multiple Projects
-- Which query finds employees assigned to more than 2 projects? 
select employees_id from projects group by employees_id
having count(*) > 2;

-- 6. Total Project Cost 
-- Which query calculates total project cost for each employee? 
SELECT employees_id, SUM(project_cost) AS total_cost
FROM projects
GROUP BY employees_id;

-- 7. Top 5 Salaries
-- Which query returns the 5 highest salaries? 
SELECT * FROM employees
ORDER BY salary DESC
LIMIT 5;

-- 8. Second-Highest Distinct Salary
-- Which query correctly returns the second-highest distinct salary? 
SELECT MAX(salary) FROM employees
WHERE salary < (
    SELECT MAX(salary)
    FROM employees
);

-- 9. Employees Above Overall Average
-- Which query finds employees whose salary is greater than the overall average salary? 
SELECT * FROM employees
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
);

-- 10. Departments With At Least 5 Employees
--  Which query returns departments having at least 5 employees? 
SELECT department_id FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 5;

-- 11. Duplicate Employee Names 
-- Which query identifies employee names appearing more than once?
 SELECT employee_name FROM employees
GROUP BY employee_name
HAVING COUNT(*) > 1;

-- 12. City-wise Employee Analysis 
-- Which query returns cities having more than 10 employees? 
SELECT city FROM employees
GROUP BY city
HAVING COUNT(*) > 10;

-- 13. High Project Cost Employees Which query finds employees whose total project cost exceeds 1,000,000? 
SELECT employee_id
FROM projects
GROUP BY employee_id
HAVING SUM(project_cost) > 1000000;

-- 14. Employee Project Report Which query correctly returns each employee's total project cost?
SELECT e.employee_id, e.employee_name,
       SUM(p.project_cost) AS total_cost
FROM employees e
JOIN projects p
ON e.employee_id = p.employee_id
GROUP BY e.employee_id, e.employee_name;

-- 15. High-Value Customers Which query finds customers whose total transaction amount exceeds 200000? 
SELECT customer_id FROM transactions
GROUP BY customer_id
HAVING SUM(amount) > 200000;

-- 16. Monthly Transaction Analysis Which query correctly calculates total transaction amount by year and month? 
SELECT YEAR(transaction_date),
       MONTH(transaction_date),
       SUM(amount)
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date);

-- 17. Credit Transaction Analysis Which query calculates total CREDIT amount for each customer? 
SELECT customer_id, SUM(amount) FROM transactions
WHERE transaction_type = 'CREDIT'
GROUP BY customer_id;

-- 18. Customers With More Than 5 Transactions Which query returns customers having more than 5 transactions? 
SELECT customer_id FROM transactions
GROUP BY customer_id
HAVING COUNT(*) > 5;

-- 19. Customer Transaction Report Which query correctly displays customer name and transaction amount? 
SELECT c.customer_name, t.amount FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id;

-- 20. Customers Without Transactions Which query finds customers who have no transactions? 
SELECT c.customer_id FROM customers c
LEFT JOIN transactions t
ON c.customer_id = t.customer_id
WHERE t.customer_id IS NULL;

-- 21. Highest Average Salary Department Which query returns the department with the highest average salary? 
SELECT department_id, AVG(salary) AS avg_salary FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 1;

-- 22. Minimum Salary by Department Which query returns departments where the minimum salary is greater than 40000? 
SELECT department_id, MIN(salary) FROM employees
GROUP BY department_id
HAVING MIN(salary) > 40000;

-- 23. Employees Joined During 2026 Which query correctly finds employees who joined during calendar year 2026? 
SELECT * FROM employees
WHERE YEAR(joining_date) = 2026;

-- 24. Most Recently Joined Employee Which query returns the most recently joined employee? 
SELECT * FROM employees
ORDER BY joining_date DESC
LIMIT 1;

-- 25. Employees Working on Multiple Projects Which query finds employees assigned to at least 3 distinct projects? 
SELECT employee_id FROM projects
GROUP BY employee_id
HAVING COUNT(DISTINCT project_id) >= 3;

-- 26. Employees With No Projects Which query finds employees who are not assigned to any project? 
SELECT e.employee_id FROM employees e
LEFT JOIN projects p
ON e.employee_id = p.employee_id
WHERE p.project_id IS NULL;

-- 27. Highest-Cost Project Which query returns the project with the highest project cost? 
SELECT * FROM projects
ORDER BY project_cost DESC
LIMIT 1;

-- 28. Departments Including Zero Employees Which query includes departments even when they have zero employees? 
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e
ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name;

-- 29. Salary Range by Department Which query calculates the salary range (maximum minus minimum) for each department? 
SELECT department_id, MAX(salary) - MIN(salary) AS salary_range
FROM employees
GROUP BY department_id;

-- 30. Multiple Group Conditions Which query returns departments having at least 5 employees and an average salary above 60000? 
SELECT department_id FROM employees
GROUP BY department_id
HAVING COUNT(*) >= 5
AND AVG(salary) > 60000;

-- 31. Salary Ranking Within Department Which window function correctly ranks employees by salary within each department? 
SELECT employee_id, employee_name, department_id, salary,
RANK() OVER ( PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 32. Top 3 Salary Ranks Per Department Which query returns employees whose salary is within the top 3 distinct salary ranks of their department? 
SELECT * FROM (
    SELECT e.*,DENSE_RANK() OVER ( PARTITION BY department_id
               ORDER BY salary DESC) AS salary_rank
    FROM employees e
) x
WHERE salary_rank <= 3;

-- 33. Running Salary Total Which query calculates a running total of salary ordered by employee_id? 
SELECT employee_id, salary,
SUM(salary) OVER (ORDER BY employee_id) AS running_total
FROM employees;

-- 34. Department Average Alongside Employee Salary Which query displays each employee's salary together with the average salary of that employee's department? 
SELECT employee_id, salary, AVG(salary) OVER (PARTITION BY department_id) AS department_avg
FROM employees;

-- 35. Salary Above Department Average Which query finds employees earning more than their own department's average salary?  
SELECT * FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);

-- 36. Latest Employee History Record employee_history(employee_id, salary, effective_date) stores salary history. Which query returns the latest history record for each employee? 
SELECT * FROM (
    SELECT h.*,
	ROW_NUMBER() OVER (
    PARTITION BY employee_id
    ORDER BY effective_date DESC) AS rn
    FROM employee_history h) x
WHERE rn = 1;

-- 37. CTE-Based High Salary Analysis Which query correctly uses a CTE to return employees earning above 80000? 
SELECT employee_id, employee_name, department_id, salary,
RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 38. Highest Average Salary Department Which query returns the department having the highest average salary? 
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
ORDER BY avg_salary DESC
LIMIT 1;

-- 39. Duplicate Employee Records Which query identifies duplicate combinations of employee_id and joining_date? 
SELECT employee_id, joining_date FROM employees
GROUP BY employee_id, joining_date
HAVING COUNT(*) > 1;

-- 40. Unique Row Number for Duplicate Records Which expression assigns a sequential row number within each employee_id based on joining_date? 
SELECT employee_id, employee_name, joining_date,
ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY joining_date) AS row_num
FROM employees;

-- 41. Highest Transaction Per Customer Which query returns the highest transaction amount for each customer? 
SELECT customer_id, MAX(amount) AS highest_transaction
FROM transactions
GROUP BY customer_id;

-- 42. Complete Highest Transaction Record Which query returns the complete highest-value transaction record for every customer? 
SELECT * FROM (
    SELECT t.*, ROW_NUMBER() OVER ( PARTITION BY customer_id ORDER BY amount DESC) AS rn
    FROM transactions t
) x
WHERE rn = 1;

-- 43. Monthly Transaction Revenue Which query calculates total transaction amount for each year and month? 
SELECT YEAR(transaction_date) AS yr,
       MONTH(transaction_date) AS mon,
       SUM(amount) AS total_amount
FROM transactions
GROUP BY YEAR(transaction_date), MONTH(transaction_date);

-- 44. Monthly Customer Ranking Which window expression ranks customers by their monthly transaction total within each year/month? 
SELECT
    customer_id,
    YEAR(transaction_date) AS year,
    MONTH(transaction_date) AS month,
    SUM(amount) AS monthly_total,
    RANK() OVER (
        PARTITION BY YEAR(transaction_date), MONTH(transaction_date)
        ORDER BY SUM(amount) DESC
    ) AS monthly_rank
FROM transactions
GROUP BY customer_id,
YEAR(transaction_date),
MONTH(transaction_date);

-- 45. Running Transaction Total Per Customer Which query calculates a running transaction total separately for each customer? 
SELECT customer_id, transaction_date, amount,
       SUM(amount) OVER (PARTITION BY customer_id
           ORDER BY transaction_date ) AS running_total
FROM transactions;

-- 46. Cumulative Project Cost Which query calculates cumulative project cost ordered by project start date? 
SELECT project_id, start_date, project_cost,SUM(project_cost) OVER ( ORDER BY start_date) AS cumulative_cost
FROM projects;

-- 47. Previous Transaction Amount Which query gets the previous transaction amount for each customer? 
SELECT customer_id, transaction_date, amount, LAG(amount) OVER (
           PARTITION BY customer_id
           ORDER BY transaction_date
       ) AS previous_amount
FROM transactions;

-- 48. Next Transaction Amount Which query gets the next transaction amount for each customer? 
SELECT customer_id, transaction_date, amount,LEAD(amount) OVER ( PARTITION BY customer_id ORDER BY transaction_date) AS next_amount
FROM transactions;

-- 49. Transaction Data Quality Check Which condition identifies transactions with a missing customer, missing amount, or negative amount? 
SELECT * FROM transactions
WHERE amount IS NULL OR customer_id IS NULL OR amount < 0;

-- 50. Top 2 Salary Ranks Per Department Including Ties Which query returns employees in the top 2 salary ranks of each department, including ties? 
SELECT * FROM ( SELECT e.*, DENSE_RANK() OVER (
PARTITION BY department_id
ORDER BY salary DESC
) AS rnk
FROM employees e
) x
WHERE rnk <= 2;
