
USE SalesDB;

--generate report showing the totsl dslrd for each category: HIGH,MEDIUM AND LOW and sort

SELECT
OrderId,
ProductId,
Sales,
CASE
  WHEN Sales>50 THEN 'High'
  WHEN Sales>20 AND Sales<=50 THEN 'Medium'
  WHEN Sales<=20 THEN 'LOW'
END AS Category
FROM Sales.Orders ORDER BY Sales ;



SELECT
Category,
SUM(Sales) TotalSales
FROM(
SELECT
OrderId,
ProductId,
Sales,
CASE
  WHEN Sales>50 THEN 'High'
  WHEN Sales>20 AND Sales<=50 THEN 'Medium'
  WHEN Sales<=20 THEN 'LOW'
END AS Category
FROM Sales.Orders )t GROUP BY Category ORDER BY  TotalSales DESC;

--Gender displays as full text

SELECT
EmployeeId,
FirstName,
LastName,
CASE
   WHEN Gender='M' THEN 'Male'
   WHEN Gender='F' THEN 'Female'
END AS FullGender
FROM Sales.Employees;

SELECT
EmployeeId,
FirstName,
LastName,
CASE Gender
   WHEN 'M' THEN 'Male'
   WHEN 'F' THEN 'Female'
END AS FullGender
FROM Sales.Employees;

--Find the average scores of customers and treat NUll as 0

SELECT * FROM Sales.Customers;

SELECT
CustomerId,
LastName,
Score,
AVG (CASE
   WHEN Score IS NULL THEN 0
   ELSE Score
END ) OVER() AS CleanAVG
FROM Sales.Customers;

--count how many times each customer has made an order with sales greater than 30
SELECT
CustomerId,
SUM(CASE
WHEN Sales>30 THEN 1
ELSE 0
END )AS TotalOrdersHighSales,
COUNT(*) TotalOrders
FROM Sales.Orders GROUP BY CustomerID;

