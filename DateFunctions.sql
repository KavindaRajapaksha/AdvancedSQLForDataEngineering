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


--Date formatting

SELECT
OrderID,
CreationTime,
FORMAT(CreationTime,'dd') dd,
FORMAT(CreationTime,'dd/MM/yy') formatedDate1,
FORMAT(CreationTime,'MM/dd/yy') formatedDate2,
FORMAT(CreationTime,'dddd') dateNames,
FORMAT(CreationTime,'MMMM') Mon1,
FORMAT(CreationTime,'MMM') Mon2,
FORMAT(CreationTime,'HH:mm:ss tt')
FROM Sales.Orders;



SELECT
    OrderID,
    CreationTime,
    'Day ' + FORMAT(CreationTime, 'ddd') + ' ' + 
    FORMAT(CreationTime, 'MMM') + 
    ' Q1 ' + FORMAT(CreationTime, 'yyyy') + ' ' + 
    FORMAT(CreationTime, 'hh:mm:ss tt') AS formattedTime
FROM Sales.Orders;


SELECT
CONVERT(INT,'123') AS [String to Int],
CONVERT(DATE,'2025-08-20')AS [SREING To DATE];

SELECT
CreationTime,
CONVERT(VARCHAR,CreationTime,32)AS usaTimestd,
CONVERT(VARCHAR,CreationTime,34)AS euroTimestd
FROM Sales.Orders;


--date add
SELECT
OrderId,
OrderDate,
DATEADD(year,2,OrderDate) As comeyear,
DATEADD(month,-2,OrderDate) As latemon,
DATEADD(day,2,OrderDate) As comeday
FROM Sales.Orders;

--calculate the age of employees

SELECT
EmployeeId,
FirstName,
DATEDIFF(year,BirthDate,GETDATE()) As age
FROM Sales.Employees;

--Find the average shipping during days for each month
SELECT 
    createmonth, 
    AVG(shippingDur) AS AvgShippingDuration
FROM (
    SELECT
        DATENAME(month, CreationTime) AS createmonth,
        DATEDIFF(day, OrderDate, ShipDate) AS shippingDur
    FROM Sales.Orders
) AS Subquery
GROUP BY createmonth;

---Time Gap analysis
--Find the number of days between each order and the previous orders

SELECT
OrderId,
OrderDate CurrentOrderDate,
LAG(OrderDate) Over(Order By OrderDate) PreviousDate,
DATEDIFF(day,LAG(OrderDate) Over(Order By OrderDate),OrderDate)NofSdats
FROM  Sales.Orders;
