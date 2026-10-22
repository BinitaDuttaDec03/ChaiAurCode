-- VIEW ALL TABLES

SELECT * FROM categories;
SELECT * FROM customers;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM order_items;
SELECT * FROM orders;
SELECT * FROM payments;
SELECT * FROM products;


-- Give me all orders including employee details of the employee who processed that order only include orders punched by employees

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    o.order_id,
    o.status
FROM orders AS o
JOIN employees AS e
ON o.employee_id=e.employee_id;


-- Give me all orders and include employee details of employee who processed that order and if it is directly coming from customer keep employee details empty

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    o.order_id,
    o.status
FROM orders AS o
LEFT JOIN employees AS e
ON o.employee_id=e.employee_id
ORDER BY order_id;


-- Give me all customers who did not place any order

SELECT
    c.first_name,
    o.customer_id,
    o.status
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id=o.customer_id
WHERE o.customer_id IS NULL;


-- Give me orders which have not been paid

SELECT
    o.order_id,
    p.payment_id
FROM orders AS o
LEFT JOIN payments AS p
ON o.order_id=p.order_id
WHERE p.payment_id IS NULL;


-- Give information about all orders that are there in the DB. Include info about order_items, product, customer and category the product belongs to.

SELECT
    o.order_id,
    o.status,
    p.product_id,
    p.product_name,
    c.first_name,
    c.last_name,
    ca.category_id,
    ca.description
FROM orders AS o
JOIN order_items AS oi ON o.order_id=oi.order_id
JOIN products AS p ON oi.product_id=p.product_id
JOIN customers AS c ON o.customer_id=c.customer_id
JOIN categories AS ca ON p.category_id=ca.category_id;


-- Give me info about employees including their manager's info

SELECT
    e.employee_id AS emp_id,
    e.first_name AS emp_name,
    m.employee_id AS manager_id,
    m.first_name AS manager_name
FROM employees AS e
JOIN employees AS m
ON e.manager_id=m.employee_id;


-- Give me total revenue across all orders till now

SELECT
    SUM(quantity*unit_price) AS "Total Revenue"
FROM order_items;


-- Give me total number of products in each category

SELECT
    category_id,
    COUNT(*)
FROM products
GROUP BY category_id;


-- Give me total number of active and inactive products in each category

SELECT
    category_id,
    is_active,
    COUNT(*)
FROM products
GROUP BY category_id, is_active;


-- Give me total number of products in each category include category name in the results

SELECT
    p.category_id, 
    c.category_name,
    COUNT(*)
FROM products AS p
JOIN categories AS c
ON p.category_id=c.category_id
GROUP BY p.category_id, c.category_name;


-- Give me total number of products in each category and give me categories having > 5 products

SELECT
    category_id,
    COUNT(*)
FROM products
GROUP BY category_id
HAVING COUNT(*)>5;


-- Find departments having more than one employee, where their combined salary of whole department exceeds 200000 rupees.

SELECT
    department_id,
    COUNT(*),
    SUM(salary) AS tot_dept_salary
FROM employees
GROUP BY department_id
HAVING COUNT(*)>1 AND SUM(salary)>200000;


-- Find departments having more than one managed employee.

SELECT
    department_id,
    COUNT(*),
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY department_id
HAVING COUNT(*)>1;