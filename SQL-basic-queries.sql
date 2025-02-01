-- Active: 1738446948923@@127.0.0.1@1433@AdventureWorks2022
USE AdventureWorks2022

--1 
SELECT * FROM HumanResources.Department

--2
SELECT GroupName FROM HumanResources.Department
Group by GroupName;

SELECT GroupName FROM HumanResources.Department

--3 
SELECT * FROM HumanResources.Department
ORDER BY  DepartmentID desc

--4
SELECT * FROM HumanResources.Department
ORDER BY  DepartmentID asc

--5
SELECT * FROM HumanResources.Employee

--6
SELECT * FROM HumanResources.Employee
WHERE Gender = 'M'

--7 
SELECT * FROM HumanResources.Employee
WHERE OrganizationLevel > 3

--8
SELECT * FROM HumanResources.Employee
WHERE Gender = 'F' and OrganizationLevel >= 2 

--9
SELECT JobTitle, BusinessEntityID, NationalIDNumber
FROM HumanResources.Employee
WHERE JobTitle in ('Design Engineer' , 'Marketing Assistant')

SELECT JobTitle, BusinessEntityID, NationalIDNumber
FROM HumanResources.Employee
WHERE JobTitle = 'Design Engineer' or JobTitle = 'Marketing Assistant'

--10
SELECT * FROM HumanResources.Employee
WHERE BirthDate  between '1969-01-01' and '1972-12-31'

--11
SELECT SUM(vacationHours)'Horas trabajo en vacaci�n' ,SUM(VacationHours)*8 'total $ a pagar' 
FROM HumanResources.Employee

SELECT BusinessEntityID, VacationHours, VacationHours * 8.00 AS TotalPagar
FROM HumanResources.Employee;

--12
SELECT psc.Name AS Categoria, COUNT(pssc.ProductSubcategoryID) AS NumeroDeCategorias
FROM Production.ProductSubcategory pssc
INNER JOIN Production.ProductCategory psc ON pssc.ProductCategoryID = psc.ProductCategoryID
GROUP BY psc.Name;

--13
SELECT t.Name AS Territorio, COUNT(c.CustomerID) AS NumeroDeClientes
FROM Sales.Customer c
INNER JOIN Sales.SalesTerritory t ON c.TerritoryID = t.TerritoryID
GROUP BY t.Name;


--14
SELECT CustomerID, SUM(SubTotal) AS CompraTotal
FROM Sales.SalesOrderHeader
WHERE CustomerID = 29672
GROUP BY CustomerID;

--15
SELECT CardType, COUNT(*) AS NumeroDeTargetas
FROM Sales.CreditCard
GROUP BY CardType;

--16

SELECT SalesOrderID,
    LineTotal AS TotalOriginal,
    CASE
        WHEN LineTotal > 2000.00 THEN LineTotal * 0.82
        WHEN LineTotal > 1500.00 THEN LineTotal * 0.86
        WHEN LineTotal > 1000.00 THEN LineTotal * 0.90
        ELSE LineTotal
    END AS TotalDescontado
FROM Sales.SalesOrderDetail;




















