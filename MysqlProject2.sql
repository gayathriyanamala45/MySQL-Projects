CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    account_type VARCHAR(20) NOT NULL,
    balance DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

INSERT INTO customers (customer_name, city) VALUES
('Janani', 'Chennai'),
('Rahul', 'Hyderabad'),
('Priya', 'Bengaluru'),
('Kiran', 'Chennai'),
('Anil', 'Vijayawada'),
('Sneha', 'Hyderabad'),
('Arjun', 'Nellore'),
('Meena', 'Bengaluru');

INSERT INTO accounts (customer_id, account_type, balance)
SELECT c.customer_id, v.account_type, v.balance
FROM (
    SELECT 1 AS customer_id, 'Savings' AS account_type, 25000.00 AS balance
    UNION ALL
    SELECT 1, 'Fixed Deposit', 50000.00
    UNION ALL
    SELECT 2, 'Current', 72000.00
    UNION ALL
    SELECT 3, 'Savings', 18000.00
    UNION ALL
    SELECT 4, 'Savings', 35000.00
    UNION ALL
    SELECT 5, 'Current', 12000.00
    UNION ALL
    SELECT 6, 'Savings', 90000.00
    UNION ALL
    SELECT 7, 'Savings', 15000.00
    UNION ALL
    SELECT 8, 'Fixed Deposit', 110000.00
) AS v
INNER JOIN customers c
    ON c.customer_id = v.customer_id;

SELECT * FROM customers;

SELECT * FROM accounts;

SELECT  customer_name, city  FROM customers;

SELECT * FROM customers WHERE city = 'Chennai';

SELECT * FROM accounts WHERE balance > 30000;

SELECT * FROM accounts
WHERE balance BETWEEN 15000 AND 75000;

SELECT * FROM customers
WHERE city IN ('Chennai', 'Hyderabad');

SELECT * FROM customers
WHERE city <> 'Chennai';

SELECT * FROM customers
WHERE customer_name LIKE 'A%';

SELECT * FROM customers
WHERE customer_name LIKE '%a%';

SELECT * FROM customers
ORDER BY customer_name ASC;

SELECT * FROM accounts
ORDER BY balance DESC;

SELECT * FROM accounts
ORDER BY balance DESC
LIMIT 3;

SELECT COUNT(*) AS total_customers
FROM customers;

SELECT COUNT(*) AS total_accounts
FROM accounts;

SELECT SUM(balance) AS total_balance
FROM accounts;

SELECT AVG(balance) AS average_balance
FROM accounts;

SELECT MAX(balance) AS highest_balance
FROM accounts;

SELECT MIN(balance) AS lowest_balance
FROM accounts;

SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city;

SELECT account_type, SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type;

SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type
HAVING AVG(balance) > 30000;

SELECT c.customer_name, c.city, a.account_type, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

SELECT c.customer_id, c.customer_name, c.city,
       a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id;

SELECT c.customer_name, c.city, a.account_type, a.balance
FROM accounts a
RIGHT JOIN customers c
ON c.customer_id = a.customer_id;

SELECT c.customer_id, c.customer_name,
       COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM accounts
);

SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM accounts
);

SELECT *
FROM accounts
WHERE balance > (
    SELECT AVG(balance) FROM accounts
);

SELECT *
FROM accounts
WHERE balance = (
    SELECT MAX(balance) FROM accounts
);

SELECT DISTINCT c.*
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.account_type = 'Savings';

SELECT c.customer_id, c.customer_name,
       COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(a.account_id) > 1;

SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(a.balance), 0) AS total_balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.customer_name;

SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
HAVING COUNT(*) > 1;

SELECT c.city, COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city;

SELECT *
FROM accounts
WHERE balance > (
    SELECT AVG(balance) FROM accounts
);

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM accounts
);

SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM accounts
);

SELECT *
FROM accounts
ORDER BY balance DESC
LIMIT 1;

SELECT c.customer_name, c.city, a.account_type, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY c.customer_name ASC;

CREATE DATABASE IF NOT EXISTS railway_db;
USE railway_db;

CREATE TABLE IF NOT EXISTS passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_name VARCHAR(60) NOT NULL,
    age INT NOT NULL,
    gender VARCHAR(10) NOT NULL
);



CREATE TABLE IF NOT EXISTS trains (
    train_id INT PRIMARY KEY AUTO_INCREMENT,
    train_name VARCHAR(80) NOT NULL,
    source_station VARCHAR(50) NOT NULL,
    destination_station VARCHAR(50) NOT NULL
);


CREATE TABLE IF NOT EXISTS reservations (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    train_id INT NOT NULL,
    journey_date DATE NOT NULL,
    seat_no VARCHAR(10) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',
    fare DECIMAL(8,2) NOT NULL,

    FOREIGN KEY (passenger_id)
        REFERENCES passengers(passenger_id),

    FOREIGN KEY (train_id)
        REFERENCES trains(train_id)
);


INSERT INTO passengers
(passenger_name, age, gender)
VALUES
('Asha', 24, 'Female'),
('Ravi', 31, 'Male'),
('Divya', 19, 'Female'),
('Mohan', 42, 'Male'),
('Keerthi', 28, 'Female');


INSERT INTO trains
(train_name, source, destination,fare)
VALUES
('Coastal Express', 'Chennai', 'Nellore',450.00),
('Deccan Express', 'Hyderabad', 'Vijayawada',350.00),
('South Mail', 'Bengaluru', 'Chennai',500.00);


INSERT INTO reservations
(passenger_id, train_id, journey_date, seat_no, status, fare)
VALUES
(1, 1, '2026-11-01', 'S1-01', 'Confirmed', 450.00),
(2, 2, '2026-11-02', 'S2-14', 'Confirmed', 620.00),
(3, 1, '2026-11-01', 'S1-02', 'Waiting', 450.00),
(4, 3, '2026-11-03', 'B1-05', 'Confirmed', 850.00),
(5, 2, '2026-11-02', 'S2-15', 'Cancelled', 620.00);

SELECT * FROM passengers;

SELECT * FROM trains;

SELECT * FROM reservations;


SELECT *
FROM passengers
WHERE age > 25;


SELECT *
FROM reservations
WHERE status = 'Confirmed';


SELECT
    r.reservation_id,
    p.passenger_name,
    t.train_name,
    t.source,
    t.destination,
    r.journey_date,
    r.seat_no,
    r.status,
    r.fare
FROM reservations r
JOIN passengers p
    ON r.passenger_id = p.passenger_id
JOIN trains t
    ON r.train_id = t.train_id;


SELECT
    t.train_name,
    COUNT(r.reservation_id) AS reservation_count
FROM trains t
LEFT JOIN reservations r
    ON t.train_id = r.train_id
GROUP BY t.train_id, t.train_name;


SELECT
    SUM(fare) AS confirmed_fare_total
FROM reservations
WHERE status = 'Confirmed';


SELECT *
FROM passengers
WHERE passenger_id IN (
    SELECT passenger_id
    FROM reservations
);
 
SELECT *
FROM reservations
WHERE journey_date >= '2026-11-02'
ORDER BY journey_date ASC;

CREATE DATABASE IF NOT EXISTS employee_db;

USE employee_db;


CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(60) NOT NULL,
    department VARCHAR(40) NOT NULL,
    job_title VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    hire_date DATE NOT NULL,
    city VARCHAR(50) NOT NULL
);


INSERT INTO employees
(emp_name, department, salary, age, city)
VALUES
('Gayathri', 'IT', 45000.00, 25, 'Nellore'),
('Rahul', 'HR', 38000.00, 28, 'Hyderabad'),
('Priya', 'IT', 42000.00, 24, 'Chennai'),
('Kiran', 'Finance', 50000.00, 30, 'Vijayawada'),
('Anil', 'IT', 78000.00, 27, 'Hyderabad'),
('Sneha', 'HR', 36000.00, 26, 'Bengaluru'),
('Arjun', 'Finance', 52000.00, 29, 'Chennai'),
('Meena', 'IT', 47000.00, 23, 'Nellore');

SELECT * FROM employees;

SELECT emp_name, salary
FROM employees;


SELECT *
FROM employees
WHERE department = 'IT';


SELECT *
FROM employees
WHERE salary > 45000;


SELECT *
FROM employees
WHERE salary BETWEEN 35000 AND 55000;

SELECT *
FROM employees
ORDER BY salary DESC;

SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1;

SELECT AVG(salary) AS average_salary
FROM employees;
SELECT SUM(salary) AS total_salary_expense
FROM employees;

SELECT
    department,
    COUNT(*) AS employee_count
FROM employees
GROUP BY department;


SELECT
    department,
    AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 45000;

-- 
UPDATE employees
SET salary = ROUND(salary * 1.05, 2)
WHERE department = 'IT';

SELECT emp_name, department, salary
FROM employees
WHERE department = 'IT';



SELECT *
FROM employees
WHERE emp_name LIKE 'S%';

SELECT
    emp_name,
    department,
    salary
FROM employees
ORDER BY department, emp_name;


CREATE DATABASE IF NOT EXISTS shop_db;

USE shop_db;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(60) NOT NULL,
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(20) NOT NULL DEFAULT 'Placed',

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

USE shop_db;

INSERT INTO customers (customer_name, email, city)
VALUES
('Nisha', 'nisha@example.com', 'Chennai'),
('Vikram', 'vikram@example.com', 'Hyderabad'),
('Pooja', 'pooja@example.com', 'Bengaluru'),
('Suresh', 'suresh@example.com', 'Nellore'),
('Latha', 'latha@example.com', 'Chennai'),
('Imran', 'imran@example.com', 'Vijayawada')
ON DUPLICATE KEY UPDATE
    customer_name = VALUES(customer_name),
    city = VALUES(city);

INSERT INTO orders
(customer_id, order_date, amount)
VALUES
(1, '2026-09-01', 1500.00),
(2, '2026-09-03', 2400.00),
(1, '2026-09-10', 750.00),
(3, '2026-09-12', 3200.00),
(4, '2026-09-15', 500.00),
(5, '2026-09-20', 1800.00),
(2, '2026-09-25', 1250.00);


SELECT * FROM customers;


SELECT * FROM orders;

SELECT *
FROM customers
WHERE city = 'Chennai';


SELECT *
FROM orders
WHERE amount > 1000;

SELECT *
FROM orders
ORDER BY amount DESC;


SELECT
    
    c.customer_name,
    o.order_date,
    o.amount
    
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id;


SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    
    o.amount

FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id;

SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS order_count
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;



SELECT
    SUM(amount) AS total_order_amount
FROM orders;

SELECT
    AVG(amount) AS average_order_amount
FROM orders;


SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 2000;

SELECT *
FROM orders
WHERE order_date;

SELECT *
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);



SELECT *
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

SELECT *
FROM orders
WHERE amount = (
    SELECT MAX(amount)
    FROM orders
);


CREATE DATABASE IF NOT EXISTS students_db;

USE students_db;

CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(60) NOT NULL,
    age INT NOT NULL,
    course VARCHAR(50) NOT NULL,
    marks DECIMAL(5,2) NOT NULL,
    city VARCHAR(50) NOT NULL
);


USE students_db;

INSERT INTO students
(student_name, age, department, marks, city)
VALUES
('Akhila', 21, 'MCA', 88.50, 'Nellore'),
('Bharat', 22, 'MCA', 76.00, 'Chennai'),
('Charan', 20, 'BCA', 69.50, 'Hyderabad'),
('Deepa', 23, 'MCA', 92.00, 'Bengaluru'),
('Eswar', 21, 'BSc', 58.00, 'Vijayawada'),
('Farah', 22, 'BCA', 81.00, 'Chennai'),
('Gopal', 20, 'BSc', 73.50, 'Nellore'),
('Harini', 21, 'MCA', 95.00, 'Hyderabad');


SELECT * FROM students;

SELECT student_name, department
FROM students;


SELECT *
FROM students
WHERE department = 'MCA';


SELECT *
FROM students
WHERE marks >= 80;


 SELECT * FROM students
WHERE marks BETWEEN 70 AND 90;

 
SELECT *
FROM students
ORDER BY marks DESC;

SELECT *
FROM students
ORDER BY marks DESC
LIMIT 1;


SELECT
    AVG(marks) AS average_marks
FROM students;


SELECT
    MIN(marks) AS lowest_marks
FROM students;


SELECT
    department,
    AVG(marks) AS average_marks
FROM students
GROUP BY department
HAVING AVG(marks) > 75;

SELECT
    city,
    COUNT(*) AS student_count
FROM students
GROUP BY city;

SELECT *
FROM students
WHERE student_name LIKE 'H%';


UPDATE students
SET marks = 72.00
WHERE student_id = 3;

UPDATE students
SET marks = 72.00
WHERE student_id = 3;

SELECT *
FROM students
WHERE student_id = 3;

SELECT *
FROM students
WHERE marks > (
    SELECT AVG(marks)
    FROM students
);

