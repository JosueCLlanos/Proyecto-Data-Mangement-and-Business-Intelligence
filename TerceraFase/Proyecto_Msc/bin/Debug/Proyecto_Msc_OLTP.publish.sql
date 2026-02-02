/*
Script de implementación para Proyecto_Msc_OLTP.sql

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Proyecto_Msc_OLTP.sql"
:setvar DefaultFilePrefix "Proyecto_Msc_OLTP.sql"
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
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Creando la base de datos $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'No se puede modificar la configuración de la base de datos. Debe ser un administrador del sistema para poder aplicar esta configuración.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Creando Tabla [dbo].[Categories]...';


GO
CREATE TABLE [dbo].[Categories] (
    [CategoryID]   INT            IDENTITY (1, 1) NOT NULL,
    [CategoryName] NVARCHAR (15)  NOT NULL,
    [Description]  NVARCHAR (MAX) NULL,
    [Picture]      IMAGE          NULL,
    [rowversion]   TIMESTAMP      NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[CustomerCustomerDemo]...';


GO
CREATE TABLE [dbo].[CustomerCustomerDemo] (
    [CustomerID]     NCHAR (5)  NOT NULL,
    [CustomerTypeID] NCHAR (10) NOT NULL,
    [rowversion]     TIMESTAMP  NULL,
    CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY NONCLUSTERED ([CustomerID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[CustomerDemographics]...';


GO
CREATE TABLE [dbo].[CustomerDemographics] (
    [CustomerTypeID] NCHAR (10)     NOT NULL,
    [CustomerDesc]   NVARCHAR (MAX) NULL,
    [rowversion]     TIMESTAMP      NULL,
    CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY NONCLUSTERED ([CustomerTypeID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Customers]...';


GO
CREATE TABLE [dbo].[Customers] (
    [CustomerID]   NCHAR (5)     NOT NULL,
    [CompanyName]  NVARCHAR (40) NOT NULL,
    [ContactName]  NVARCHAR (30) NULL,
    [ContactTitle] NVARCHAR (30) NULL,
    [Address]      NVARCHAR (60) NULL,
    [City]         NVARCHAR (15) NULL,
    [Region]       NVARCHAR (15) NULL,
    [PostalCode]   NVARCHAR (10) NULL,
    [Country]      NVARCHAR (15) NULL,
    [Phone]        NVARCHAR (24) NULL,
    [Fax]          NVARCHAR (24) NULL,
    [rowversion]   TIMESTAMP     NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Employees]...';


GO
CREATE TABLE [dbo].[Employees] (
    [EmployeeID]      INT            IDENTITY (1, 1) NOT NULL,
    [LastName]        NVARCHAR (20)  NOT NULL,
    [FirstName]       NVARCHAR (10)  NOT NULL,
    [Title]           NVARCHAR (30)  NULL,
    [TitleOfCourtesy] NVARCHAR (25)  NULL,
    [BirthDate]       DATETIME       NULL,
    [HireDate]        DATETIME       NULL,
    [Address]         NVARCHAR (60)  NULL,
    [City]            NVARCHAR (15)  NULL,
    [Region]          NVARCHAR (15)  NULL,
    [PostalCode]      NVARCHAR (10)  NULL,
    [Country]         NVARCHAR (15)  NULL,
    [HomePhone]       NVARCHAR (24)  NULL,
    [Extension]       NVARCHAR (4)   NULL,
    [Photo]           IMAGE          NULL,
    [Notes]           NVARCHAR (MAX) NULL,
    [ReportsTo]       INT            NULL,
    [PhotoPath]       NVARCHAR (255) NULL,
    [rowversion]      TIMESTAMP      NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[EmployeeTerritories]...';


GO
CREATE TABLE [dbo].[EmployeeTerritories] (
    [EmployeeID]  INT           NOT NULL,
    [TerritoryID] NVARCHAR (20) NOT NULL,
    [rowversion]  TIMESTAMP     NULL,
    CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED ([EmployeeID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[OrderDetails]...';


GO
CREATE TABLE [dbo].[OrderDetails] (
    [OrderID]    INT       NOT NULL,
    [ProductID]  INT       NOT NULL,
    [UnitPrice]  MONEY     NOT NULL,
    [Quantity]   SMALLINT  NOT NULL,
    [Discount]   REAL      NOT NULL,
    [rowversion] TIMESTAMP NULL,
    CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Orders]...';


GO
CREATE TABLE [dbo].[Orders] (
    [OrderID]        INT           IDENTITY (1, 1) NOT NULL,
    [CustomerID]     NCHAR (5)     NULL,
    [EmployeeID]     INT           NULL,
    [OrderDate]      DATETIME      NULL,
    [RequiredDate]   DATETIME      NULL,
    [ShippedDate]    DATETIME      NULL,
    [ShipVia]        INT           NULL,
    [Freight]        MONEY         NULL,
    [ShipName]       NVARCHAR (40) NULL,
    [ShipAddress]    NVARCHAR (60) NULL,
    [ShipCity]       NVARCHAR (15) NULL,
    [ShipRegion]     NVARCHAR (15) NULL,
    [ShipPostalCode] NVARCHAR (10) NULL,
    [ShipCountry]    NVARCHAR (15) NULL,
    [rowversion]     TIMESTAMP     NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Products]...';


GO
CREATE TABLE [dbo].[Products] (
    [ProductID]       INT           IDENTITY (1, 1) NOT NULL,
    [ProductName]     NVARCHAR (40) NOT NULL,
    [SupplierID]      INT           NULL,
    [CategoryID]      INT           NULL,
    [QuantityPerUnit] NVARCHAR (20) NULL,
    [UnitPrice]       MONEY         NULL,
    [UnitsInStock]    SMALLINT      NULL,
    [UnitsOnOrder]    SMALLINT      NULL,
    [ReorderLevel]    SMALLINT      NULL,
    [Discontinued]    BIT           NOT NULL,
    [rowversion]      TIMESTAMP     NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Region]...';


GO
CREATE TABLE [dbo].[Region] (
    [RegionID]          INT        NOT NULL,
    [RegionDescription] NCHAR (50) NOT NULL,
    [rowversion]        TIMESTAMP  NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED ([RegionID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Shippers]...';


GO
CREATE TABLE [dbo].[Shippers] (
    [ShipperID]   INT           IDENTITY (1, 1) NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    [rowversion]  TIMESTAMP     NULL,
    CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([ShipperID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Suppliers]...';


GO
CREATE TABLE [dbo].[Suppliers] (
    [SupplierID]   INT            IDENTITY (1, 1) NOT NULL,
    [CompanyName]  NVARCHAR (40)  NOT NULL,
    [ContactName]  NVARCHAR (30)  NULL,
    [ContactTitle] NVARCHAR (30)  NULL,
    [Address]      NVARCHAR (60)  NULL,
    [City]         NVARCHAR (15)  NULL,
    [Region]       NVARCHAR (15)  NULL,
    [PostalCode]   NVARCHAR (10)  NULL,
    [Country]      NVARCHAR (15)  NULL,
    [Phone]        NVARCHAR (24)  NULL,
    [Fax]          NVARCHAR (24)  NULL,
    [HomePage]     NVARCHAR (MAX) NULL,
    [rowversion]   TIMESTAMP      NULL,
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[Territories]...';


GO
CREATE TABLE [dbo].[Territories] (
    [TerritoryID]          NVARCHAR (20) NOT NULL,
    [TerritoryDescription] NCHAR (50)    NOT NULL,
    [RegionID]             INT           NOT NULL,
    [rowversion]           TIMESTAMP     NULL,
    CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED ([TerritoryID] ASC)
);


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_Order_Details_UnitPrice]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT ((0)) FOR [UnitPrice];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_Order_Details_Quantity]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [DF_Order_Details_Quantity] DEFAULT ((1)) FOR [Quantity];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_Order_Details_Discount]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [DF_Order_Details_Discount] DEFAULT ((0)) FOR [Discount];


GO
PRINT N'Creando Restricción DEFAULT [dbo].[DF_Orders_Freight]...';


GO
ALTER TABLE [dbo].[Orders]
    ADD CONSTRAINT [DF_Orders_Freight] DEFAULT ((0)) FOR [Freight];


GO
PRINT N'Creando Clave externa [dbo].[FK_CustomerCustomerDemo]...';


GO
ALTER TABLE [dbo].[CustomerCustomerDemo]
    ADD CONSTRAINT [FK_CustomerCustomerDemo] FOREIGN KEY ([CustomerTypeID]) REFERENCES [dbo].[CustomerDemographics] ([CustomerTypeID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_CustomerCustomerDemo_Customers]...';


GO
ALTER TABLE [dbo].[CustomerCustomerDemo]
    ADD CONSTRAINT [FK_CustomerCustomerDemo_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Employees_Employees]...';


GO
ALTER TABLE [dbo].[Employees]
    ADD CONSTRAINT [FK_Employees_Employees] FOREIGN KEY ([ReportsTo]) REFERENCES [dbo].[Employees] ([EmployeeID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_EmployeeTerritories_Employees]...';


GO
ALTER TABLE [dbo].[EmployeeTerritories]
    ADD CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_EmployeeTerritories_Territories]...';


GO
ALTER TABLE [dbo].[EmployeeTerritories]
    ADD CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY ([TerritoryID]) REFERENCES [dbo].[Territories] ([TerritoryID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Order_Details_Orders]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Order_Details_Products]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Orders_Customers]...';


GO
ALTER TABLE [dbo].[Orders]
    ADD CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[Customers] ([CustomerID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Orders_Employees]...';


GO
ALTER TABLE [dbo].[Orders]
    ADD CONSTRAINT [FK_Orders_Employees] FOREIGN KEY ([EmployeeID]) REFERENCES [dbo].[Employees] ([EmployeeID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Orders_Shippers]...';


GO
ALTER TABLE [dbo].[Orders]
    ADD CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY ([ShipVia]) REFERENCES [dbo].[Shippers] ([ShipperID]);


GO
PRINT N'Creando Clave externa [dbo].[FK_Territories_Region]...';


GO
ALTER TABLE [dbo].[Territories]
    ADD CONSTRAINT [FK_Territories_Region] FOREIGN KEY ([RegionID]) REFERENCES [dbo].[Region] ([RegionID]);


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_Birthdate]...';


GO
ALTER TABLE [dbo].[Employees]
    ADD CONSTRAINT [CK_Birthdate] CHECK (([BirthDate]<getdate()));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_Discount]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [CK_Discount] CHECK (([Discount]>=(0) AND [Discount]<=(1)));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_Quantity]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [CK_Quantity] CHECK (([Quantity]>(0)));


GO
PRINT N'Creando Restricción CHECK [dbo].[CK_UnitPrice]...';


GO
ALTER TABLE [dbo].[OrderDetails]
    ADD CONSTRAINT [CK_UnitPrice] CHECK (([UnitPrice]>=(0)));


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
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Actualización completada.';


GO
