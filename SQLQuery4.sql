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
FROM Sales.Customers ;

SELECT
*,
COUNT(Score)  OVER() Scores,
COUNT(*)  OVER() TotalCus
FROM Sales.Customers ;


--Find duplicates in order table
SELECT 
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) checkPK
FROM Sales.Orders;

SELECT 
OrderID,
COUNT(*) OVER(PARTITION BY OrderID) checkPK
FROM Sales.OrdersArchive;

--Find total sales across all andd each prod

SELECT 
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(Partition BY ProductID) totalSalesByProd
FROM Sales.Orders;
--cast use for change data type
SELECT 
OrderID,
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
ROUND(CAST (Sales As FLOAT)/SUM(Sales)OVER()*100,2) As percentageOfSales
FROM Sales.Orders;

--Find AVG sales

SELECT
	AVG(sales) AS avgSales
FROM Sales.Orders;

SELECT 
OrderID,
ProductID,
Sales,
AVG (Sales) OVER() TotalAvg,
AVG (Sales) OVER(PARTITION BY ProductID) TotalAvgByProd
FROM Sales.Orders;

SELECT AVG(Score) OVER() FROM Sales.Customers ;

SELECT
  CustomerID,
  LastName,
  Score,
  COALESCE(Score,0) CustomerScore,
  AVG(Score) OVER() AS AvgScore,
  AVG( COALESCE(Score,0)) OVER() AvgWithoutNull
FROM Sales.Customers ;

--Find all orders are higher than the avg sales

SELECT *
FROM (
  SELECT
    CustomerID,
    LastName,
    Score,
    COALESCE(Score, 0) AS CustomerScore,
    AVG(Score) OVER() AS AvgWithout
  FROM Sales.Customers
) AS Subquery
WHERE CustomerScore > AvgWithout;

--Find Highest and Lowest values Sales for each product with order Id
SELECT
OrderID,
OrderDate,
MAX(COALESCE(Sales,0)) Over() As MaxVal,
MIN(COALESCE(Sales,0)) Over() As MinVal
FROM Sales.Orders;

SELECT * FROM(
SELECT * ,MAX(Salary)Over() HighSal FROM Sales.Employees)AS Subquery WHERE Salary= HighSal ;

SELECT
OrderID,
OrderDate,
MAX(COALESCE(Sales,0)) Over() As MaxVal,
MIN(COALESCE(Sales,0)) Over() As MinVal,
Sales-MIN(COALESCE(Sales,0))  Over() As deviation
FROM Sales.Orders;

--moving average
SELECT
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER() AS simpleAvg,
	AVG(Sales) Over(Partition By ProductId Order By OrderDate)Movingavg
FROM Sales.Orders;

--calculate the moving avg including next order

SELECT
	OrderID,
	ProductID,
	Sales,
	AVG(Sales) OVER() AS simpleAvg,
	AVG(Sales) OVER(Partition By ProductId) AS simpleAvgByProd,
	AVG(Sales) Over(Partition By ProductId Order By OrderDate)Movingavg,
	AVG(Sales) Over(Partition By ProductId Order By OrderDate ROWS Between Current Row AND 1 Following )MovingavgTonextDoor
FROM Sales.Orders;