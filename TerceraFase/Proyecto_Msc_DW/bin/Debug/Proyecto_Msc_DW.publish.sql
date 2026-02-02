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
USE [$(DatabaseName)];


GO
PRINT N'Creando Tabla [dbo].[DimCustomers]...';


GO
CREATE TABLE [dbo].[DimCustomers] (
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
    [CustomerDesc] NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerIDSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimDate]...';


GO
CREATE TABLE [dbo].[DimDate] (
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
    [CalendarSemester]  TINYINT       NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([DateKey] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimEmployees]...';


GO
CREATE TABLE [dbo].[DimEmployees] (
    [EmployeeIDSK]         INT            IDENTITY (1, 1) NOT NULL,
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
    [TerritoryDescription] NCHAR (50)     NOT NULL,
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeIDSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimProducts]...';


GO
CREATE TABLE [dbo].[DimProducts] (
    [ProductIDSK]     INT            IDENTITY (1, 1) NOT NULL,
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
    [HomePage]        NVARCHAR (MAX) NULL,
    CONSTRAINT [PK_ProductIDSK] PRIMARY KEY CLUSTERED ([ProductIDSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimShippers]...';


GO
CREATE TABLE [dbo].[DimShippers] (
    [ShipperIDSK] INT           IDENTITY (1, 1) NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([ShipperIDSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactOrders]...';


GO
CREATE TABLE [dbo].[FactOrders] (
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
    [Discount]        REAL          NOT NULL,
    CONSTRAINT [PK_Fact_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ItemID] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [PackageID]      INT          IDENTITY (1, 1) NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL,
    CONSTRAINT [PackageID] PRIMARY KEY CLUSTERED ([PackageID] ASC)
);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_DimCustomers]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_DimCustomers] FOREIGN KEY ([CustomerIDSK]) REFERENCES [dbo].[DimCustomers] ([CustomerIDSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_DimEmployees]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_DimEmployees] FOREIGN KEY ([EmployeeIDSK]) REFERENCES [dbo].[DimEmployees] ([EmployeeIDSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_DimProducts]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_DimProducts] FOREIGN KEY ([ProductIDSK]) REFERENCES [dbo].[DimProducts] ([ProductIDSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_DimShippers]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_FactOrders_DimShippers] FOREIGN KEY ([ShipViaIDSK]) REFERENCES [dbo].[DimShippers] ([ShipperIDSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_OrderDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_RequiredDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_RequiredDate] FOREIGN KEY ([RequiredDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_ShippedDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_ShippedDate] FOREIGN KEY ([ShippedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Procedimiento [dbo].[GetLastPackageRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetLastPackageRowVersion]
  (
	@tableName VARCHAR(50)
  )
  AS
  BEGIN
	SELECT LastRowVersion
	FROM [dbo].[PackageConfig]
	WHERE TableName = @tableName;
  END
GO
PRINT N'Creando Procedimiento [dbo].[UpdateLastPackageRowVersion]...';


GO
CREATE PROCEDURE [dbo].[UpdateLastPackageRowVersion]
  (
	@tableName VARCHAR(50)
	,@lastRowVersion BIGINT
  )
  AS
  BEGIN
	UPDATE [dbo].[PackageConfig]
	SET LastRowVersion = @lastRowVersion
	WHERE TableName = @tableName;
  END
GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_DimCustomers];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_DimEmployees];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_DimProducts];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_FactOrders_DimShippers];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_OrderDate];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_RequiredDate];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_ShippedDate];


GO
PRINT N'Actualización completada.';


GO
