USE AdventureWorksLT2022;

--SQL functions

SELECT FirstName,LastName,
CONCAT(FirstName,' ',LastName) AS fullName,
UPPER(FirstName)AS upperCase,
LOWER(FirstName)AS lowerCase,
TRIM(CONCAT(FirstName,' ',LastName))AS removespace
FROM
SalesLT.Customer;

SELECT CustomerID,REPLACE(SalesPerson,'-','/////')AS updatedPerson,
LEFT(SalesPerson,9) as adventure
FROM
SalesLT.Customer;

