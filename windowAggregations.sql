USE SalesDB;

SELECT
OrderId,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) num
FROM Sales.Orders;

SELECT
OrderId,
Sales,
RANK() OVER(ORDER BY Sales DESC) num
FROM Sales.Orders;

SELECT
OrderId,
Sales,
DENSE_RANK() OVER(ORDER BY Sales DESC) num
FROM Sales.Orders;

SELECT
OrderId,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) rownum,
RANK() OVER(ORDER BY Sales DESC) ranknum,
DENSE_RANK() OVER(ORDER BY Sales DESC) densenum
FROM Sales.Orders;

--FIND the top highest sales for each product
SELECT * FROM(
SELECT
OrderId,
Sales,
ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) num
FROM Sales.Orders) AS Subquery WHERE num IN (1,2) ;

--FIND the lowest 2 customers based on their sales

SELECT *
FROM
(
SELECT
CustomerID,
SUM(Sales)  totalsales,
ROW_NUMBER() Over(ORDER BY SUM(Sales)) rankcus
FROM Sales.Orders
GROUP BY CustomerID
)As Subquery WHERE rankcus in (1,2);

--generate unique id for a table
SELECT
ROW_NUMBER() OVER (ORDER BY OrderId,OrderDate) UniqueID,
* 
FROM Sales.OrdersArchive;

--remove duplicates in order archive table

SELECT *
FROM(
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY OrderId Order BY CreationTime Desc) rownum
FROM Sales.OrdersArchive)AS Subquery WHERE rownum=1;

--duplicates
SELECT *
FROM(
SELECT
*,
ROW_NUMBER() OVER(PARTITION BY OrderId Order BY CreationTime Desc) rownum
FROM Sales.OrdersArchive)AS Subquery WHERE rownum!=1;

--Ntiles

SELECT
OrderId,
Sales,
Ntile(1) Over(Order by sales) oneBucket
FROM Sales.Orders;

SELECT
OrderId,
Sales,
Ntile(2) Over(Order by sales) twoBucket
FROM Sales.Orders;
--rule sql- larger groups comes first
SELECT
OrderId,
Sales,
Ntile(1) Over(Order by sales) oneBucket,
Ntile(2) Over(Order by sales) twoBucket,
Ntile(3) Over(Order by sales) threeBucket,
Ntile(4) Over(Order by sales) fourBucket
FROM Sales.Orders;

-- SEgment data into three categories based on sales high medium and low

SELECT 
*,
CASE WHEN category=1 Then 'High'
     WHEN category=2 Then 'Medium'
	 WHEN category =3 THEN 'Low'
END SalesSegmentation
FROM(
SELECT
OrderId,
Sales,
Ntile(3) Over(Order by sales DESC) category
FROM Sales.Orders) AS Subquery;

-- In order to export data ,divide the orders into 2 groups
SELECT *
FROM Sales.Orders;

SELECT
NTILE(2) OVER (ORDER BY OrderId) Buckets,
*
FROM Sales.Orders;

--FIND the products that fall within the highest 40% of prices
SELECT * FROM(
SELECT
Product,
Price,
PERCENT_RANK() OVER(Order by Price DESC) percentagePrice
FROM Sales.Products) as Subquery WHERE percentagePrice<0.4;

SELECT * FROM Sales.Products;