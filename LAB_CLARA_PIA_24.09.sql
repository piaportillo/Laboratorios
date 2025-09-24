-- EJERCICIO 1
-- 1
SELECT officeCode, phone
FROM offices
ORDER BY officeCode;

-- 2
SELECT employeeNumber, firstName, lastName, email
FROM employees
WHERE email LIKE '%.es';

-- 3
SELECT customerNumber, customerName, city, country, state
FROM customers
WHERE state IS NULL;

-- 4
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE amount > 20000;

-- 5
SELECT customerNumber, checkNumber, paymentDate, amount
FROM payments
WHERE amount > 20000
  AND YEAR(paymentDate) = 2005;
  
  -- 6
  SELECT DISTINCT productCode
FROM orderdetails
ORDER BY productCode;

-- 7
CREATE TABLE purchases_by_country AS
SELECT c.country,
COUNT(DISTINCT o.orderNumber) AS purchases
FROM customers c
JOIN orders o ON o.customerNumber = c.customerNumber
GROUP BY c.country;


-- EJERECICIO 2
-- 1
SELECT productLine, CHAR_LENGTH(textDescription) AS descLen
FROM productlines
ORDER BY descLen DESC
LIMIT 1;

-- 2
SELECT o.officeCode,
       COUNT(DISTINCT c.customerNumber) AS customersCount
FROM offices o
LEFT JOIN employees e ON e.officeCode = o.officeCode
LEFT JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
GROUP BY o.officeCode;

-- 3
SELECT DAYNAME(o.orderDate) AS weekday,
       SUM(od.quantityOrdered) AS unitsSold
FROM orders o
JOIN orderdetails od ON od.orderNumber = o.orderNumber
GROUP BY DAYOFWEEK(o.orderDate), DAYNAME(o.orderDate)
LIMIT 1;

-- 4
UPDATE offices
SET territory = CASE
                  WHEN territory IS NULL OR territory = '' THEN 'USA'
                  ELSE territory
                END;

-- 5
WITH per_order AS (
  SELECT o.orderNumber,
         YEAR(o.orderDate) AS yr,
         MONTH(o.orderDate) AS mo,
         SUM(od.quantityOrdered * od.priceEach) AS orderAmount,
         SUM(od.quantityOrdered) AS items
  FROM orders o
  JOIN orderdetails od ON od.orderNumber = o.orderNumber
  JOIN customers c ON c.customerNumber = o.customerNumber
  JOIN employees e ON e.employeeNumber = c.salesRepEmployeeNumber
  WHERE e.lastName = 'Patterson'
    AND YEAR(o.orderDate) IN (2004, 2005)
  GROUP BY o.orderNumber, YEAR(o.orderDate), MONTH(o.orderDate)
)
SELECT yr, mo,
       ROUND(AVG(orderAmount),2) AS avg_cart_amount,
       ROUND(AVG(items),2)       AS avg_items_per_order,
       SUM(items)                AS total_items_in_month
FROM per_order
GROUP BY yr, mo
ORDER BY yr, mo;

-- EJERECICIO 3
-- 1
SELECT yr, mo,
       ROUND(AVG(orderAmount),2) AS avg_cart_amount,
       ROUND(AVG(totalItems),2)  AS avg_items_per_order,
       COUNT(*)                  AS orders_count
FROM (
    SELECT YEAR(o.orderDate) AS yr,
           MONTH(o.orderDate) AS mo,
           (SELECT SUM(od.quantityOrdered * od.priceEach)
            FROM orderdetails od
            WHERE od.orderNumber = o.orderNumber) AS orderAmount,
           (SELECT SUM(od.quantityOrdered)
            FROM orderdetails od
            WHERE od.orderNumber = o.orderNumber) AS totalItems
    FROM orders o
    WHERE YEAR(o.orderDate) IN (2004, 2005)
      AND o.customerNumber IN (
          SELECT c.customerNumber
          FROM customers c
          WHERE c.salesRepEmployeeNumber IN (
              SELECT e.employeeNumber
              FROM employees e
              WHERE e.lastName = 'Patterson'
          )
      )
) t
GROUP BY yr, mo
ORDER BY yr, mo;

-- 2
SELECT DISTINCT o.officeCode, o.city, o.country, o.phone
FROM offices o
WHERE EXISTS (
  SELECT 1
  FROM employees e
  JOIN customers c ON c.salesRepEmployeeNumber = e.employeeNumber
  WHERE e.officeCode = o.officeCode
    AND c.state IS NULL
)
ORDER BY o.officeCode;
