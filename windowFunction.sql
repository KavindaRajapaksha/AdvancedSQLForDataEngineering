--Find all total sales aross all orders
USE SalesDB;

SELECT SUM(Sales) AS total_sales FROM Sales.Orders; 

--Total sales for each products

SELECT ProductID,SUM(Sales) AS total_sales FROM Sales.Orders GROUP BY ProductID;

--total sales for each product with order id and order date


SELECT ProductID,SUM(Sales) AS total_sales,OrderID,OrderDate FROM Sales.Orders GROUP BY OrderID,OrderDate,ProductID;

--using window function

SELECT
ProductId,OrderId,OrderDate,
SUM(Sales) OVER(PARTITION BY ProductId) TotalSalesByProducts 
FROM Sales.Orders;
--find the totl sales across all orders with order id and order date
SELECT
OrderId,
OrderDate,
SUM(Sales) Over() Total_sal
FROM Sales.Orders;

--for each product
SELECT
OrderId,
OrderDate,
SUM(Sales) Over(PARTITION BY ProductId) Total_sal
FROM Sales.Orders;

--above two in one
SELECT
OrderId,
OrderDate,
SUM(Sales) Over() Total_sal,
SUM(Sales) Over(PARTITION BY ProductId) Total_sal_by_prod
FROM Sales.Orders;

--each sales by prod and order status
SELECT
OrderId,
OrderDate,
OrderStatus,
SUM(Sales) Over(PARTITION BY ProductId,OrderStatus) Total_sal
FROM Sales.Orders;

-- all of above
SELECT
OrderId,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) Over() Total_sal,
SUM(Sales) Over(PARTITION BY ProductId) Total_sal_by_prod,
SUM(Sales) Over(PARTITION BY ProductId,OrderStatus) Total_sal_by_prod_and_status
FROM Sales.Orders;

SELECT
OrderId,
OrderDate,
OrderStatus,
SUM(Sales) Over(PARTITION BY ProductId) Total_sal_by_prod,
Rank() Over(PARTITION BY ProductId Order By OrderDate) rank_of_order
FROM Sales.Orders;

--Rank each order based on their sales Asc 
SELECT 
OrderId,
OrderDate,
Sales,
Rank() Over(Order By Sales DESC) rank_over_sales
From Sales.Orders;

--frames

SELECT
OrderId,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) Over(PARTITION BY OrderStatus Order By OrderDate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING ) Total_sal
FROM Sales.Orders;

SELECT
OrderId,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) Over(PARTITION BY OrderStatus Order By OrderDate ROWS 2 PRECEDING ) Total_sal
FROM Sales.Orders;

SELECT
OrderId,
OrderDate,
OrderStatus,
Sales,
SUM(Sales) Over(PARTITION BY OrderStatus) Total_sal
FROM Sales.Orders
ORDER BY SUM(Sales) Over(PARTITION BY OrderStatus) DESC  ;

SELECT
OrderId,
OrderDate,
OrderStatus,
Sales,
ProductID,
SUM(Sales) Over(PARTITION BY OrderStatus) Total_sal
FROM Sales.Orders
WHERE ProductId IN (102,101);

--Rank customers on their total sales

SELECT
CustomerID,
SUM(Sales) TotalSales,
RANK() OVER(ORDER BY SUM(Sales) DESC) cutsRank
FROM
Sales.Orders GROUP BY CustomerID;