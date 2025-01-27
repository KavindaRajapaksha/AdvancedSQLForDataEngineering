--find the avg scores of the customer
USE SalesDB;

SELECT
AVG(ISNULL(Score,0)) AS avgScore
FROM Sales.Customers;

SELECT
AVG(Score) AS avgScore
FROM Sales.Customers;

SELECT
AVG(COALESCE(Score,0)) AS avgScore
FROM Sales.Customers;

--Display full name by merging first and last names and Add 10 poin to customer scores

SELECT
CustomerID,
FirstName,
LastName,
(ISNULL(FirstName,'')+' '+ISNULL(LastName,''))AS fullname,
Score,
ISNULL(Score,0)+10 AS custScore
FROM Sales.Customers;

--Sort the customers lowest to highest scores with Null apearing last

SELECT
CustomerId,
Score,
COALESCE(Score,9999999)AS updatedScore
FROM Sales.Customers 
ORDER BY updatedScore;

--find the sales price or each order by dividing sales by quantity



SELECT
OrderId,
Sales,
Quantity,
Sales/NULLIF(Quantity,0) AS Price
FROM Sales.Orders;

--List all details from customers who have not placed any orders

SELECT
c.*,
o.OrderId
FROM Sales.Customers c
LEFT  JOIN Sales.Orders o
ON c.CustomerID=o.CustomerId WHERE o.CustomerID IS NULL;
