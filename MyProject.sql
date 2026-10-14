CREATE DATABASE IF NOT EXISTS banking_db;
USE banking_db;

CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    client_id INT,
    report_type VARCHAR(20),
    balance DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
DESCRIBE customers;
INSERT INTO customers (customer_name, city) VALUES
('Janani','Chennai'),
('Arun','Coimbatore'),
('Priya','Madurai'),
('Karthik','Salem');

INSERT INTO accounts (customer_id, account_type, balance) VALUES
(1,'Savings',50000),
(1,'Current',20000),
(2,'Savings',30000),
(3,'Savings',15000),
(4,'Current',40000);

-- 1. Balance greater than 20000
SELECT * FROM accounts WHERE balance > 20000;

-- 2. Customers from Chennai
SELECT * FROM customers WHERE city = 'Chennai';

-- 3. Balance between 20000 and 50000
SELECT * FROM accounts WHERE balance BETWEEN 20000 AND 50000;

-- 4. Names starting with J
SELECT * FROM customers WHERE name LIKE 'J%';

-- 5. Savings or Current accounts
SELECT * FROM accounts
WHERE account_type IN ('Savings','Current');

-- 6. Accounts that are not Savings
SELECT * FROM accounts WHERE account_type <> 'Savings';

-- 7. Names containing a
SELECT * FROM customers WHERE name LIKE '%a%';

-- 8. Balance less than or equal to 30000
SELECT * FROM accounts WHERE balance <= 30000;

-- 9. Customers not from Madurai
SELECT * FROM customers WHERE city <> 'Madurai';

-- 10. Balance not between 10000 and 40000
SELECT * FROM accounts
WHERE balance NOT BETWEEN 10000 AND 40000;

-- 11. Names ending with i
SELECT * FROM customers WHERE name LIKE '%i';

-- 12. Balance equal to 50000
SELECT * FROM accounts WHERE balance = 50000;

-- 13. Customers from Chennai or Salem
SELECT * FROM customers
WHERE city IN ('Chennai','Salem');

-- 14. Balance greater than 10000 and less than 40000
SELECT * FROM accounts
WHERE balance > 10000 AND balance < 40000;

-- 15. Accounts that are not Current
SELECT * FROM accounts
WHERE account_type NOT IN ('Current');

-- 16. Sort balances descending
SELECT * FROM accounts ORDER BY balance DESC;

-- 17. Sort customers by name
SELECT * FROM customers ORDER BY name ASC;

-- 18. Sort by account type and balance
SELECT * FROM accounts
ORDER BY account_type ASC, balance DESC;

-- 19. Total balance
SELECT SUM(balance) AS total_balance FROM accounts;

-- 20. Average balance
SELECT AVG(balance) AS average_balance FROM accounts;

-- 21. Maximum balance
SELECT MAX(balance) AS maximum_balance FROM accounts;

-- 22. Minimum balance
SELECT MIN(balance) AS minimum_balance FROM accounts;

-- 23. Number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- 24. Total balance by account type
SELECT account_type, SUM(balance) AS total_balance
FROM accounts
GROUP BY account_type;

-- 25. Average balance by account type
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type;

-- 26. Account types with average balance above 20000
SELECT account_type, AVG(balance) AS average_balance
FROM accounts
GROUP BY account_type
HAVING AVG(balance) > 20000;

-- 27. Number of accounts per customer
SELECT c.customer_id, c.name, COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;

-- 28. Customers with more than one account
SELECT c.customer_id, c.name, COUNT(a.account_id) AS account_count
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING COUNT(a.account_id) > 1;

-- 29. Customer names and account balances
SELECT c.name, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id;

-- 30. All customers and their accounts
SELECT c.*, a.account_id, a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id;

-- 31. Accounts with customer details
SELECT a.*, c.name, c.city
FROM accounts a
LEFT JOIN customers c ON a.customer_id = c.customer_id;

-- 32. Customer names and accounts with balance above 20000
SELECT c.name, a.account_type, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
WHERE a.balance > 20000;

-- 33. Total balance per customer
SELECT c.customer_id, c.name,
       COALESCE(SUM(a.balance),0) AS total_balance
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;

-- 34. Customer balances in ascending order
SELECT c.name, a.balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
ORDER BY a.balance ASC;

-- 35. Number of accounts per city
SELECT c.city, COUNT(a.account_id) AS account_count
FROM customers c
LEFT JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.city;

-- 36. Accounts with balance above average
SELECT * FROM accounts
WHERE balance > (SELECT AVG(balance) FROM accounts);

-- 37. Customers who have accounts
SELECT * FROM customers
WHERE customer_id IN (SELECT customer_id FROM accounts);

-- 38. Customers without accounts
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT customer_id FROM accounts);

-- 39. Account with the highest balance
SELECT * FROM accounts
WHERE balance = (SELECT MAX(balance) FROM accounts);

-- 40. Customers whose total balance exceeds 40000
SELECT c.customer_id, c.name, SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name
HAVING SUM(a.balance) > 40000;
-- PART 2: RAILWAY RESERVATION SYSTEM

CREATE DATABASE IF NOT EXISTS railway_db;
USE railway_db;

-- Create Trains Table
CREATE TABLE trains (
    train_id INT PRIMARY KEY,
    train_name VARCHAR(50),
    source VARCHAR(50),
    destination VARCHAR(50),
    fare DECIMAL(10,2)
);

-- Create Bookings Table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_name VARCHAR(50),
    train_id INT,
    seats INT,
    booking_date DATE,
    FOREIGN KEY (train_id) REFERENCES trains(train_id)
);

-- Insert Train Records
INSERT INTO trains VALUES
(101, 'Express One', 'Hyderabad', 'Chennai', 500),
(102, 'Super Fast', 'Bangalore', 'Hyderabad', 700),
(103, 'Coastal Express', 'Chennai', 'Vizag', 600),
(104, 'Night Express', 'Hyderabad', 'Bangalore', 450),
(105, 'City Express', 'Chennai', 'Bangalore', 550);

-- Insert Booking Records
INSERT INTO bookings
(passenger_name, train_id, seats, booking_date)
VALUES
('Gayathri', 101, 2, '2026-10-01'),
('Rahul', 102, 1, '2026-10-02'),
('Priya', 103, 3, '2026-10-03'),
('Kiran', 101, 1, '2026-10-04'),
('Anil', 104, 2, '2026-10-05');

-- 41. Display all trains
SELECT * FROM trains;

-- 42. Display all bookings
SELECT * FROM bookings;

-- 43. Find trains departing from Hyderabad
SELECT * FROM trains
WHERE source = 'Hyderabad';

-- 44. Find trains arriving at Chennai
SELECT * FROM trains
WHERE destination = 'Chennai';

-- 45. Find trains with fare greater than 500
SELECT * FROM trains
WHERE fare > 500;

-- 46. Display passenger names and train names
SELECT b.passenger_name, t.train_name
FROM bookings b
JOIN trains t ON b.train_id = t.train_id;

-- 47. Display bookings with more than one seat
SELECT * FROM bookings
WHERE seats > 1;

-- 48. Count bookings for each train
SELECT t.train_name, COUNT(b.booking_id) AS total_bookings
FROM trains t
LEFT JOIN bookings b ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- 49. Calculate total seats booked for each train
SELECT t.train_name, COALESCE(SUM(b.seats), 0) AS total_seats
FROM trains t
LEFT JOIN bookings b ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;

-- 50. Calculate total booking fare for each train
SELECT t.train_name,
       COALESCE(SUM(t.fare * b.seats), 0) AS total_booking_fare
FROM trains t
LEFT JOIN bookings b ON t.train_id = b.train_id
GROUP BY t.train_id, t.train_name;
-- PART 3: EMPLOYEE MANAGEMENT

CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

-- Create Employee Table
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2),
    city VARCHAR(50),
    age INT
);

-- Insert Sample Records
INSERT INTO employees
(emp_id, emp_name, department, salary, city, age)
VALUES
(1, 'Gayathri', 'IT', 45000, 'Kadapa', 24),
(2, 'Rahul', 'HR', 35000, 'Hyderabad', 26),
(3, 'Priya', 'IT', 50000, 'Chennai', 25),
(4, 'Kiran', 'Finance', 40000, 'Bangalore', 28),
(5, 'Anil', 'HR', 30000, 'Kadapa', 23);

-- 1. Display all employees
SELECT * FROM employees;

-- 2. Display employees earning more than 40000
SELECT * FROM employees WHERE salary > 40000;

-- 3. Display employees from the IT department
SELECT * FROM employees WHERE department = 'IT';

-- 4. Display employees in descending salary order
SELECT * FROM employees ORDER BY salary DESC;

-- 5. Find the highest salary
SELECT MAX(salary) AS highest_salary FROM employees;

-- 6. Find the lowest salary
SELECT MIN(salary) AS lowest_salary FROM employees;

-- 7. Find the average salary
SELECT AVG(salary) AS average_salary FROM employees;

-- 8. Count the total employees
SELECT COUNT(*) AS total_employees FROM employees;

-- 9. Calculate total salary
SELECT SUM(salary) AS total_salary FROM employees;

-- 10. Calculate average salary by department
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department;

-- 11. Find departments with average salary above 35000
SELECT department, AVG(salary) AS average_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 35000;

-- 12. Find employees whose names start with G
SELECT * FROM employees WHERE emp_name LIKE 'G%';

-- 13. Find employees whose salary is between 30000 and 45000
SELECT * FROM employees
WHERE salary BETWEEN 30000 AND 45000;

-- 14. Find employees from Kadapa
SELECT * FROM employees WHERE city = 'Kadapa';

-- 15. Display employees older than 24
SELECT * FROM employees WHERE age > 24;
-- PART 4: CUSTOMERS AND ORDERS

CREATE DATABASE IF NOT EXISTS shop_db;
USE shop_db;

-- Create Customers Table
CREATE TABLE IF NOT EXISTS customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50),
    email VARCHAR(100)
);

-- Create Orders Table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Insert Customer Records
INSERT INTO customers VALUES
(1, 'Gayathri', 'Kadapa', 'gayathri@example.com'),
(2, 'Rahul', 'Hyderabad', 'rahul@example.com'),
(3, 'Priya', 'Chennai', 'priya@example.com'),
(4, 'Kiran', 'Bangalore', 'kiran@example.com'),
(5, 'Anil', 'Kadapa', 'anil@example.com');

-- Insert Order Records
INSERT INTO orders VALUES
(101, 1, '2026-10-01', 2500),
(102, 2, '2026-10-02', 4000),
(103, 1, '2026-10-03', 1500),
(104, 3, '2026-10-04', 3000),
(105, 4, '2026-10-05', 5000);

-- 1. Display all customers
SELECT * FROM customers;

-- 2. Display all orders
SELECT * FROM orders;

-- 3. Find customers from Kadapa
SELECT * FROM customers WHERE city = 'Kadapa';

-- 4. Find orders above 3000
SELECT * FROM orders WHERE amount > 3000;

-- 5. Display orders in descending amount order
SELECT * FROM orders ORDER BY amount DESC;

-- 6. Display customer names and their order amounts
SELECT c.customer_name, o.amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;

-- 7. Find the total order amount
SELECT SUM(amount) AS total_order_amount
FROM orders;

-- 8. Find the average order amount
SELECT AVG(amount) AS average_order_amount
FROM orders;

-- 9. Find the highest order amount
SELECT MAX(amount) AS highest_order
FROM orders;

-- 10. Count the total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 11. Calculate total order amount for each customer
SELECT c.customer_id, c.customer_name,
       COALESCE(SUM(o.amount), 0) AS total_amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 12. Find customers whose total orders exceed 3000
SELECT c.customer_name, SUM(o.amount) AS total_amount
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 3000;

-- 13. Find customers who have not placed orders
SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 14. Find orders placed after October 2, 2026
SELECT * FROM orders
WHERE order_date > '2026-10-02';

-- 15. Display customers and their orders, including customers without orders
SELECT c.customer_name, o.order_id, o.order_date, o.amount
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;
-- ==========================================
-- PART 5: STUDENTS
-- ==========================================

CREATE DATABASE IF NOT EXISTS students_db;
USE students_db;

-- Create Students table
CREATE TABLE IF NOT EXISTS Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    department VARCHAR(30),
    marks INT
);

-- Insert sample student records
INSERT INTO Students
(student_id, student_name, department, marks)
VALUES
(1, 'Anu', 'CSE', 85),
(2, 'Rahul', 'CSE', 78),
(3, 'Priya', 'ECE', 92),
(4, 'Kiran', 'ECE', 70),
(5, 'Sneha', 'CSE', 95),
(6, 'Arjun', 'IT', 88),
(7, 'Divya', 'IT', 76),
(8, 'Ravi', 'ECE', 65),
(9, 'Meena', 'IT', 90),
(10, 'Vijay', 'CSE', 60);

-- Display all students
SELECT * FROM Students;

-- 31. Average marks in each department
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department;

-- 32. Departments whose average marks are above 75
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 75;

-- 33. Highest mark in each department
SELECT department, MAX(marks) AS highest_mark
FROM Students
GROUP BY department;

-- 34. Total number of students in each department
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department;

-- 35. Lowest mark in each department
SELECT department, MIN(marks) AS lowest_mark
FROM Students
GROUP BY department;

-- 36. Total marks in each department
SELECT department, SUM(marks) AS total_marks
FROM Students
GROUP BY department;

-- 37. Students sorted by marks in descending order
SELECT *
FROM Students
ORDER BY marks DESC;

-- 38. Students who scored more than 80 marks
SELECT *
FROM Students
WHERE marks > 80;

-- 39. Students who scored between 70 and 90
SELECT *
FROM Students
WHERE marks BETWEEN 70 AND 90;

-- 40. Departments having more than two students
SELECT department, COUNT(*) AS student_count
FROM Students
GROUP BY department
HAVING COUNT(*) > 2;

-- 41. Number of students scoring above 75 in each department
SELECT department, COUNT(*) AS student_count
FROM Students
WHERE marks > 75
GROUP BY department;

-- 42. Difference between highest and lowest marks
-- in each department
SELECT department,
       MAX(marks) - MIN(marks) AS marks_difference
FROM Students
GROUP BY department;

-- 43. Top three students based on marks
SELECT *
FROM Students
ORDER BY marks DESC
LIMIT 3;

-- 44. Students whose marks are greater than the
-- overall average marks
SELECT *
FROM Students
WHERE marks > (SELECT AVG(marks) FROM Students);

-- 45. Department-wise average marks in descending order
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC;