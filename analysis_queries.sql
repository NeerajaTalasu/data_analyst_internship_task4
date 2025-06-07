use classicmodels;
SHOW TABLES;
# Select all products with price > 50, ordered by price descending

SELECT productCode, productName, buyPrice
FROM products
WHERE buyPrice > 50
ORDER BY buyPrice DESC;

#Count number of customers per country

SELECT country, COUNT(*) AS customer_count
FROM customers
GROUP BY country
ORDER BY customer_count DESC;

#JOINS
# List all orders with customer name (INNER JOIN)

SELECT o.orderNumber, o.orderDate, c.customerName
FROM orders o
INNER JOIN customers c ON o.customerNumber = c.customerNumber
ORDER BY o.orderDate DESC;

# List all employees with their office city (LEFT JOIN — show employees even if office missing)

SELECT e.employeeNumber, e.firstName, e.lastName, o.city
FROM employees e
LEFT JOIN offices o ON e.officeCode = o.officeCode;

# List customers and their sales representatives (RIGHT JOIN — show all sales reps even if no customers)

SELECT e.employeeNumber, e.firstName, e.lastName, c.customerName
FROM employees e
LEFT JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber;

# Subqueries
# Find customers who have made payments greater than average payment amount

SELECT customerNumber, amount
FROM payments
WHERE amount > (
    SELECT AVG(amount) FROM payments
);

# Find products that have never been ordered

SELECT productCode, productName
FROM products
WHERE productCode NOT IN (
    SELECT DISTINCT productCode FROM orderdetails
);

# Aggregate Functions (SUM, AVG)
# Total quantity ordered per product

SELECT productCode, SUM(quantityOrdered) AS total_quantity
FROM orderdetails
GROUP BY productCode
ORDER BY total_quantity DESC;

# Average buy price of products per product line

SELECT productLine, AVG(buyPrice) AS avg_buy_price
FROM products
GROUP BY productLine;

# Views for analysis
# Create a view for total payments by customer

CREATE OR REPLACE VIEW customer_payments AS
SELECT c.customerNumber, c.customerName, SUM(p.amount) AS totalPayments
FROM customers c
LEFT JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName;
SELECT * FROM customer_payments ORDER BY totalPayments DESC;

# Optimize queries with indexes
# Check indexes on a table

SHOW INDEX FROM orders;


