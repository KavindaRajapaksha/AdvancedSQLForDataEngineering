USE SalesDB;
--analyze ythe month over month perfoming by finmdinng the percentage change
--in sales between current and previous month

SELECT
MONTH(OrderDate) OrderMonth,
SUM(Sales) MonthSales,
LAG(SUM(Sales),1,0) OVER(ORDER BY MONTH(OrderDate)) PreviousSales,
LEAD(SUM(Sales),1,0) OVER(ORDER BY MONTH(OrderDate)) NextSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate);

SELECT *,
MonthSales-PreviousSales AS MoM_change
FROM(
SELECT
MONTH(OrderDate) OrderMonth,
SUM(Sales) MonthSales,
LAG(SUM(Sales),1,0) OVER(ORDER BY MONTH(OrderDate)) PreviousSales,
LEAD(SUM(Sales),1,0) OVER(ORDER BY MONTH(OrderDate)) NextSales
FROM Sales.Orders
GROUP BY MONTH(OrderDate))t;


--In order to analyze customer loyalty rank customer s based on the average days between their orders

SELECT
*
FROM Sales.Orders;

SELECT *,
RANK() OVER(ORDER BY OrderDate-PrevDate DESC) place FROM(
SELECT
OrderId,
CustomerId,
OrderDate,
LAG(OrderDate)OVER(PARTITION BY CustomerID ORDER BY OrderDate) PrevDate
FROM Sales.Orders
)t GROUP BY CustomerID;



SELECT
OrderId,
CustomerId,
OrderDate,
LAG(OrderDate)OVER(PARTITION BY CustomerID ORDER BY OrderDate) PrevDate,
DATEDIFF(day,LAG(OrderDate)OVER(PARTITION BY CustomerID ORDER BY OrderDate),OrderDate) DifDates
FROM Sales.Orders;


SELECT CustomerID,
RANK()OVER(ORDER BY AVG(DifDates) DESC) rankCus FROM(
SELECT
OrderId,
CustomerId,
OrderDate,
LAG(OrderDate)OVER(PARTITION BY CustomerID ORDER BY OrderDate) PrevDate,
DATEDIFF(day,LAG(OrderDate)OVER(PARTITION BY CustomerID ORDER BY OrderDate),OrderDate) DifDates
FROM Sales.Orders)AS Subquery GROUP BY CustomerId ;

SELECT ProductID,
FIRST_VALUE(TotalSale) OVER(ORDER BY TotalSale DESC) FROM(
SELECT
OrderID,
ProductId,
Sales,
SUM(Sales) OVER(PARTITION BY ProductId) TotalSale
FROM Sales.Orders)t GROUP BY ProductID ;

SELECT
OrderID,
ProductId,
Sales,
FIRST_VALUE(Sales) OVER(PARTITION BY ProductId ORDER BY Sales )  lowest ,
LAST_VALUE(Sales) OVER(PARTITION BY ProductId ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING)  HigestVal 
FROM Sales.Orders;


