/*
Script de implementación para Proyecto_Msc_DW.sql

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "Proyecto_Msc_DW.sql"
:setvar DefaultFilePrefix "Proyecto_Msc_DW.sql"
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
PRINT N'Creando Tabla [staging].[Customers]...';


GO
CREATE TABLE [staging].[Customers] (
    [CustomerIDSK] NCHAR (5)      NOT NULL,
    [CustomerID]   NCHAR (5)      NOT NULL,
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
    [CustomerDesc] NVARCHAR (MAX) NULL
);


GO
PRINT N'Creando Tabla [staging].[Date]...';


GO
CREATE TABLE [staging].[Date] (
    [DateKey]           INT           NOT NULL,
    [FullDate]          DATE          NOT NULL,
    [DayNumberOfWeek]   TINYINT       NOT NULL,
    [DayNameOfWeek]     NVARCHAR (10) NOT NULL,
    [DayNumberOfMonth]  TINYINT       NOT NULL,
    [DayNumberOfYear]   SMALLINT      NOT NULL,
    [WeekNumberOfYear]  TINYINT       NOT NULL,
    [MonthName]         NVARCHAR (10) NOT NULL,
    [MonthNumberOfYear] TINYINT       NOT NULL,
    [CalendarQuarter]   TINYINT       NOT NULL,
    [CalendarYear]      SMALLINT      NOT NULL,
    [CalendarSemester]  TINYINT       NOT NULL
);


GO
PRINT N'Creando Tabla [staging].[Employees]...';


GO
CREATE TABLE [staging].[Employees] (
    [EmployeeIDSK]         INT            NOT NULL,
    [EmployeeID]           INT            NOT NULL,
    [LastName]             NVARCHAR (20)  NOT NULL,
    [FirstName]            NVARCHAR (10)  NOT NULL,
    [Title]                NVARCHAR (30)  NULL,
    [TitleOfCourtesy]      NVARCHAR (25)  NULL,
    [BirthDate]            DATETIME       NULL,
    [HireDate]             DATETIME       NULL,
    [Address]              NVARCHAR (60)  NULL,
    [City]                 NVARCHAR (15)  NULL,
    [Region]               NVARCHAR (15)  NULL,
    [PostalCode]           NVARCHAR (10)  NULL,
    [Country]              NVARCHAR (15)  NULL,
    [HomePhone]            NVARCHAR (24)  NULL,
    [Extension]            NVARCHAR (4)   NULL,
    [Photo]                IMAGE          NULL,
    [Notes]                NVARCHAR (MAX) NULL,
    [ReportsTo]            INT            NULL,
    [PhotoPath]            NVARCHAR (255) NULL,
    [RegionDescription]    NCHAR (50)     NOT NULL,
    [TerritoryDescription] NCHAR (50)     NOT NULL
);


GO
PRINT N'Creando Tabla [Staging].[FactOrders]...';


GO
CREATE TABLE [Staging].[FactOrders] (
    [OrderID]         INT           NOT NULL,
    [ItemID]          INT           NOT NULL,
    [CustomerIDSK]    NCHAR (5)     NOT NULL,
    [EmployeeIDSK]    INT           NOT NULL,
    [OrderDateKey]    INT           NOT NULL,
    [RequiredDateKey] INT           NOT NULL,
    [ShippedDateKey]  INT           NOT NULL,
    [ShipViaIDSK]     INT           NOT NULL,
    [Freight]         MONEY         NULL,
    [ShipName]        NVARCHAR (40) NULL,
    [ShipAddress]     NVARCHAR (60) NULL,
    [ShipCity]        NVARCHAR (15) NULL,
    [ShipRegion]      NVARCHAR (15) NULL,
    [ShipPostalCode]  NVARCHAR (10) NULL,
    [ShipCountry]     NVARCHAR (15) NULL,
    [ProductIDSK]     INT           NOT NULL,
    [UnitPrice]       MONEY         NOT NULL,
    [Quantity]        SMALLINT      NOT NULL,
    [Discount]        REAL          NOT NULL
);


GO
PRINT N'Creando Tabla [staging].[PackageConfig]...';


GO
CREATE TABLE [staging].[PackageConfig] (
    [PackageID]      INT          NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL
);


GO
PRINT N'Creando Tabla [staging].[Products]...';


GO
CREATE TABLE [staging].[Products] (
    [ProductIDSK]     INT            NOT NULL,
    [ProductID]       INT            NOT NULL,
    [ProductName]     NVARCHAR (40)  NOT NULL,
    [QuantityPerUnit] NVARCHAR (20)  NULL,
    [UnitPrice]       MONEY          NULL,
    [UnitsInStock]    SMALLINT       NULL,
    [UnitsOnOrder]    SMALLINT       NULL,
    [ReorderLevel]    SMALLINT       NULL,
    [Discontinued]    BIT            NOT NULL,
    [CategoryName]    NVARCHAR (15)  NOT NULL,
    [Description]     NVARCHAR (MAX) NULL,
    [Picture]         IMAGE          NULL,
    [CompanyName]     NVARCHAR (40)  NOT NULL,
    [ContactName]     NVARCHAR (30)  NULL,
    [ContactTitle]    NVARCHAR (30)  NULL,
    [Address]         NVARCHAR (60)  NULL,
    [City]            NVARCHAR (15)  NULL,
    [Region]          NVARCHAR (15)  NULL,
    [PostalCode]      NVARCHAR (10)  NULL,
    [Country]         NVARCHAR (15)  NULL,
    [Phone]           NVARCHAR (24)  NULL,
    [Fax]             NVARCHAR (24)  NULL,
    [HomePage]        NVARCHAR (MAX) NULL
);


GO
PRINT N'Creando Tabla [staging].[Shippers]...';


GO
CREATE TABLE [staging].[Shippers] (
    [ShipperIDSK] INT           NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL
);


GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimCustomers]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimCustomers]
AS
BEGIN
    UPDATE dc
    SET [CompanyName] = sc.[CompanyName],
        [ContactName] = sc.[ContactName],
        [ContactTitle] = sc.[ContactTitle],
        [Address] = sc.[Address],
        [City] = sc.[City],
        [Region] = sc.[Region],
        [PostalCode] = sc.[PostalCode],
        [Country] = sc.[Country],
        [Phone] = sc.[Phone],
        [Fax] = sc.[Fax],
        [CustomerDesc] = sc.[CustomerDesc]
    FROM [dbo].[DimCustomers] dc
    INNER JOIN [staging].[customers] sc ON dc.[CustomerID] = sc.[CustomerID];
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimEmployees]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimEmployees]
AS
BEGIN
    UPDATE de
    SET [LastName] = se.[LastName],
        [FirstName] = se.[FirstName],
        [Title] = se.[Title],
        [TitleOfCourtesy] = se.[TitleOfCourtesy],
        [BirthDate] = se.[BirthDate],
        [HireDate] = se.[HireDate],
        [Address] = se.[Address],
        [City] = se.[City],
        [Region] = se.[Region],
        [PostalCode] = se.[PostalCode],
        [Country] = se.[Country],
        [HomePhone] = se.[HomePhone],
        [Extension] = se.[Extension],
        [Photo] = se.[Photo],
        [Notes] = se.[Notes],
        [ReportsTo] = se.[ReportsTo],
        [PhotoPath] = se.[PhotoPath],
        [RegionDescription] = se.[RegionDescription],
        [TerritoryDescription] = se.[TerritoryDescription]
    FROM [dbo].[DimEmployees] de
    INNER JOIN [staging].[employees] se ON de.[EmployeeID] = se.[EmployeeID];
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimProducts]...';


GO




CREATE PROCEDURE [dbo].[DW_MergeDimProducts]
AS
BEGIN
    UPDATE dp
    SET [ProductName] = sp.[ProductName],
        [QuantityPerUnit] = sp.[QuantityPerUnit],
        [UnitPrice] = sp.[UnitPrice],
        [UnitsInStock] = sp.[UnitsInStock],
        [UnitsOnOrder] = sp.[UnitsOnOrder],
        [ReorderLevel] = sp.[ReorderLevel],
        [Discontinued] = sp.[Discontinued],
        [CategoryName] = sp.[CategoryName],
        [Description] = sp.[Description],
        [Picture] = sp.[Picture],
        [CompanyName] = sp.[CompanyName],
        [ContactName] = sp.[ContactName],
        [ContactTitle] = sp.[ContactTitle],
        [Address] = sp.[Address],
        [City] = sp.[City],
        [Region] = sp.[Region],
        [PostalCode] = sp.[PostalCode],
        [Country] = sp.[Country],
        [Phone] = sp.[Phone],
        [Fax] = sp.[Fax],
        [HomePage] = sp.[HomePage]
    FROM [dbo].[DimProducts] dp
    INNER JOIN [staging].[products] sp ON dp.[ProductID] = sp.[ProductID];
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimShippers]...';


GO

CREATE PROCEDURE [dbo].[DW_MergeDimShippers]
AS
BEGIN
    UPDATE ds
    SET [CompanyName] = ss.[CompanyName],
        [Phone] = ss.[Phone]
    FROM [dbo].[DimShippers] ds
    INNER JOIN [staging].[shippers] ss ON ds.[ShipperID] = ss.[ShipperID];
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeFactOrders]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeFactOrders]
AS
BEGIN
    UPDATE fo
    SET [CustomerIDSK] = so.[CustomerIDSK],
        [EmployeeIDSK] = so.[EmployeeIDSK],
        [OrderDateKey] = so.[OrderDateKey],
        [RequiredDateKey] = so.[RequiredDateKey],
        [ShippedDateKey] = so.[ShippedDateKey],
        [ShipViaIDSK] = so.[ShipViaIDSK],
        [Freight] = so.[Freight],
        [ShipName] = so.[ShipName],
        [ShipAddress] = so.[ShipAddress],
        [ShipCity] = so.[ShipCity],
        [ShipRegion] = so.[ShipRegion],
        [ShipPostalCode] = so.[ShipPostalCode],
        [ShipCountry] = so.[ShipCountry],
        [ProductIDSK] = so.[ProductIDSK],
        [UnitPrice] = so.[UnitPrice],
        [Quantity] = so.[Quantity],
        [Discount] = so.[Discount]
    FROM [dbo].[FactOrders] fo
    INNER JOIN [staging].[orders] so 
        ON fo.[OrderID] = so.[OrderID] 
        AND fo.[ItemID] = so.[ItemID];
END
GO
PRINT N'Actualización completada.';


GO
