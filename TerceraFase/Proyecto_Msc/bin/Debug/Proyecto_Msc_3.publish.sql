/*
Script de implementación para Proyecto_Msc

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Proyecto_Msc"
:setvar DefaultFilePrefix "Proyecto_Msc"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Creando Procedimiento [dbo].[CustOrderHist]...';


GO
CREATE PROCEDURE [dbo].[CustOrderHist] @CustomerID nchar(5)
AS
SELECT ProductName, Total=SUM(Quantity)
FROM Products P, [Order Details] OD, Orders O, Customers C
WHERE C.CustomerID = @CustomerID
AND C.CustomerID = O.CustomerID AND O.OrderID = OD.OrderID AND OD.ProductID = P.ProductID
GROUP BY ProductName
GO
PRINT N'Creando Procedimiento [dbo].[CustOrdersDetail]...';


GO
CREATE PROCEDURE [dbo].[CustOrdersDetail]  @OrderID int
AS
SELECT ProductName,
    UnitPrice=ROUND(Od.UnitPrice, 2),
    Quantity,
    Discount=CONVERT(int, Discount * 100), 
    ExtendedPrice=ROUND(CONVERT(money, Quantity * (1 - Discount) * Od.UnitPrice), 2)
FROM Products P, [Order Details] Od
WHERE Od.ProductID = P.ProductID and Od.OrderID = @OrderID
GO
PRINT N'Creando Procedimiento [dbo].[CustOrdersOrders]...';


GO
CREATE PROCEDURE [dbo].[CustOrdersOrders] @CustomerID nchar(5)
AS
SELECT OrderID, 
	OrderDate,
	RequiredDate,
	ShippedDate
FROM Orders
WHERE CustomerID = @CustomerID
ORDER BY OrderID
GO
PRINT N'Creando Procedimiento [dbo].[Employee Sales by Country]...';


GO
CREATE PROCEDURE [dbo].[Employee Sales by Country]
@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Employees.Country, Employees.LastName, Employees.FirstName, Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal AS SaleAmount
FROM Employees INNER JOIN 
	(Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID) 
	ON Employees.EmployeeID = Orders.EmployeeID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date
GO
PRINT N'Creando Procedimiento [dbo].[GetCustomerChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetCustomerChangesByRowVersion]
(
    @startRow BIGINT 
    ,@endRow  BIGINT 
)
AS
BEGIN
  SELECT c.[CustomerID]
    ,c.[CompanyName]
    ,c.[ContactName]
    ,c.[ContactTitle]
    ,c.[Address]
    ,c.[City]
    ,c.[Region]
    ,c.[PostalCode]
    ,c.[Country]
    ,c.[Phone]
    ,c.[Fax]
    ,c.[rowversion]
    ,g.[CustomerDesc]
  FROM 
    [dbo].[Customers] c
    LEFT JOIN [dbo].[CustomerCustomerDemo] d ON c.CustomerID=d.CustomerID
    LEFT JOIN [dbo].[CustomerDemographics] g ON g.CustomerTypeID=g.CustomerTypeID
  WHERE 
    (c.[rowversion] > CONVERT(ROWVERSION,@startRow) AND c.[rowversion] <= CONVERT(ROWVERSION,@endRow))
    OR (d.[rowversion] > CONVERT(ROWVERSION,@startRow) AND d.[rowversion] <= CONVERT(ROWVERSION,@endRow))
    OR (g.[rowversion] > CONVERT(ROWVERSION,@startRow) AND g.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END
GO
PRINT N'Creando Procedimiento [dbo].[GetDatabaseRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetDatabaseRowVersion]
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT DBTS = (CONVERT(BIGINT,MIN_ACTIVE_ROWVERSION())-1);
END
GO
PRINT N'Creando Procedimiento [dbo].[GetEmployeeChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetEmployeeChangesByRowVersion]
AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON

	SELECT DBTS = (CONVERT(BIGINT,MIN_ACTIVE_ROWVERSION())-1);
END
GO
PRINT N'Creando Procedimiento [dbo].[GetProductChangesByRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetProductChangesByRowVersion]
(
   @startRow BIGINT 
   ,@endRow  BIGINT 
)
AS
BEGIN

  SELECT e.[EmployeeID]
      ,e.[LastName]
      ,e.[FirstName]
      ,e.[Title]
      ,e.[TitleOfCourtesy]
      ,e.[BirthDate]
      ,e.[HireDate]
      ,e.[Address]
      ,e.[City]
      ,e.[Region]
      ,e.[PostalCode]
      ,e.[Country]
      ,e.[HomePhone]
      ,e.[Extension]
      ,e.[Photo]
      ,e.[Notes]
      ,e.[ReportsTo]
      ,e.[PhotoPath]
    ,t.[TerritoryDescription]
    ,r.[RegionDescription]
  FROM 
  [dbo].[Employees] e
  INNER JOIN [dbo].[EmployeeTerritories] et ON e.EmployeeID=et.EmployeeID
  INNER JOIN [dbo].[Territories] t ON et.TerritoryID=t.TerritoryID
  INNER JOIN [dbo].[Region] r ON t.RegionID=r.RegionID
  WHERE 
  (e.[rowversion] > CONVERT(ROWVERSION,@startRow) AND e.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (et.[rowversion] > CONVERT(ROWVERSION,@startRow) AND et.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (t.[rowversion] > CONVERT(ROWVERSION,@startRow) AND t.[rowversion] <= CONVERT(ROWVERSION,@endRow))
  OR (r.[rowversion] > CONVERT(ROWVERSION,@startRow) AND r.[rowversion] <= CONVERT(ROWVERSION,@endRow))
END
GO
PRINT N'Creando Procedimiento [dbo].[Sales by Year]...';


GO
CREATE PROCEDURE [dbo].[Sales by Year]
	@Beginning_Date DateTime, @Ending_Date DateTime AS
SELECT Orders.ShippedDate, Orders.OrderID, "Order Subtotals".Subtotal, DATENAME(yy,ShippedDate) AS Year
FROM Orders INNER JOIN "Order Subtotals" ON Orders.OrderID = "Order Subtotals".OrderID
WHERE Orders.ShippedDate Between @Beginning_Date And @Ending_Date
GO
PRINT N'Creando Procedimiento [dbo].[SalesByCategory]...';


GO
CREATE PROCEDURE [dbo].[SalesByCategory]
    @CategoryName nvarchar(15), @OrdYear nvarchar(4) = '1998'
AS
IF @OrdYear != '1996' AND @OrdYear != '1997' AND @OrdYear != '1998' 
BEGIN
	SELECT @OrdYear = '1998'
END

SELECT ProductName,
	TotalPurchase=ROUND(SUM(CONVERT(decimal(14,2), OD.Quantity * (1-OD.Discount) * OD.UnitPrice)), 0)
FROM [Order Details] OD, Orders O, Products P, Categories C
WHERE OD.OrderID = O.OrderID 
	AND OD.ProductID = P.ProductID 
	AND P.CategoryID = C.CategoryID
	AND C.CategoryName = @CategoryName
	AND SUBSTRING(CONVERT(nvarchar(22), O.OrderDate, 111), 1, 4) = @OrdYear
GROUP BY ProductName
ORDER BY ProductName
GO
PRINT N'Creando Procedimiento [dbo].[Ten Most Expensive Products]...';


GO
CREATE PROCEDURE [dbo].[Ten Most Expensive Products]
as
SET ROWCOUNT 10
SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC
GO
PRINT N'Actualización completada.';


GO
