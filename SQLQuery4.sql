--Find the total number of orders

USE SalesDB;

SELECT* FROM Sales.Orders;

SELECT
COUNT(*) As CountOrders
FROM Sales.Orders;

SELECT
OrderID,
COUNT(*) OVER() As CountOrders
FROM Sales.Orders;

--Total number orders each customer
SELECT
CustomerID,
COUNT(*) OVER(Partition BY CustomerID) As CountOrders
FROM Sales.Orders ;

SELECT
*,
COUNT(*)  OVER() TotalCus
FROM Sales.Orders ;