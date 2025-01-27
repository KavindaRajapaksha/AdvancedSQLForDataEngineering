USE SalesDB;

SELECT 
OrderId,
OrderDate,
ShipDate,
CreationTime,
GETDATE() today,
YEAR(CreationTime) asyear,
MONTH(CreationTime) asmonth,
DAY(CreationTime) asdate,
DATEPART(week,CreationTime) asweek,
DATEPART(QUARTER,CreationTime) asquater,
DATEPART(HOUR,CreationTime) asHour,
DATENAME(WEEKDAY,CreationTime) asDate,
DATENAME(MONTH,CreationTime) asMon,
DATETRUNC(HOUR,CreationTime) asTrunc,
EOMONTH(CreationTime) asEndmonth
FROM Sales.Orders;



--How many Order were Placed Each month

SELECT * FROM Sales.Orders;

SELECT
DATENAME(month,OrderDate) AS mnth,
SUM(Sales) AS monthlySales
FROM Sales.Orders
GROUP BY DATENAME(month,OrderDate) ORDER BY DATENAME(month,OrderDate) ;