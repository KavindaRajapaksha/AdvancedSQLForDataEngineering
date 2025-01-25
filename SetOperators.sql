USE SalesDB;

--SET Op
SELECT
FirstName,
LastName AS ln
FROM Sales.Customers

UNION

SELECT
FirstName AS fn,
LastName
FROM Sales.Employees
ORDER BY FirstName DESC;


SELECT
CustomerID AS CompanyID,
FirstName,
LastName
FROM Sales.Customers
UNION
SELECT 
EmployeeID,
FirstName,
LastName
FROM Sales.Employees;



SELECT
FirstName,
LastName AS ln
FROM Sales.Customers

UNION ALL

SELECT
FirstName AS fn,
LastName
FROM Sales.Employees
ORDER BY FirstName DESC;

SELECT
FirstName,
LastName AS ln
FROM Sales.Customers

EXCEPT

SELECT
FirstName AS fn,
LastName
FROM Sales.Employees
ORDER BY FirstName DESC;

SELECT
FirstName,
LastName AS ln
FROM Sales.Customers

INTERSECT

SELECT
FirstName AS fn,
LastName
FROM Sales.Employees
ORDER BY FirstName DESC;

--Order data are stored in separate table (Orders and order archive )combine all orders dat in to one report wthout duplicates-combine information

SELECT
'Orders' AS SourceTable,
 [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.Orders
UNION 
SELECT 
'OrdersArchive' AS SourceTable,
 [OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM Sales.OrdersArchive;

