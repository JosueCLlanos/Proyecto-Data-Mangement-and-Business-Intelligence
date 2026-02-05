/*
Script de implementación para NorthWindDW

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "NorthWindDW"
:setvar DefaultFilePrefix "NorthWindDW"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER2022\MSSQL\DATA\"

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
PRINT N'Creando Esquema [staging]...';


GO
CREATE SCHEMA [staging]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Tabla [staging].[Shippers]...';


GO
CREATE TABLE [staging].[Shippers] (
    [ShipperIDSK] INT           NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL
) ON [PRIMARY];


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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[FactOrders]...';


GO
CREATE TABLE [staging].[FactOrders] (
    [OrderID]         INT       NOT NULL,
    [ItemID]          INT       NOT NULL,
    [CustomerIDSK]    NCHAR (5) NOT NULL,
    [EmployeeIDSK]    INT       NOT NULL,
    [ShipperIDSK]     INT       NOT NULL,
    [ProductIDSK]     INT       NOT NULL,
    [OrderDateKey]    INT       NOT NULL,
    [RequiredDateKey] INT       NOT NULL,
    [ShippedDateKey]  INT       NOT NULL,
    [UnitPrice]       MONEY     NOT NULL,
    [Quantity]        SMALLINT  NOT NULL,
    [Discount]        REAL      NOT NULL
) ON [PRIMARY];


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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


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
) ON [PRIMARY];


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
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimCustomers]...';


GO
CREATE TABLE [dbo].[DimCustomers] (
    [CustomerIDSK] INT            IDENTITY (1, 1) NOT NULL,
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
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerIDSK] ASC) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


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
    CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED ([DateKey] ASC) ON [PRIMARY]
) ON [PRIMARY];


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
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeIDSK] ASC) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimOrdersDetail]...';


GO
CREATE TABLE [dbo].[DimOrdersDetail] (
    [OrderIDSK]  INT       IDENTITY (1, 1) NOT NULL,
    [OrderID]    INT       NOT NULL,
    [ProductID]  INT       NOT NULL,
    [UnitPrice]  MONEY     NOT NULL,
    [Quantity]   SMALLINT  NOT NULL,
    [Discount]   REAL      NOT NULL,
    [rowversion] TIMESTAMP NULL,
    CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderIDSK] ASC)
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
    CONSTRAINT [PK_ProductIDSK] PRIMARY KEY CLUSTERED ([ProductIDSK] ASC) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[DimShippers]...';


GO
CREATE TABLE [dbo].[DimShippers] (
    [ShipperIDSK] INT           IDENTITY (1, 1) NOT NULL,
    [ShipperID]   INT           NOT NULL,
    [CompanyName] NVARCHAR (40) NOT NULL,
    [Phone]       NVARCHAR (24) NULL,
    CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([ShipperIDSK] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[FactOrders]...';


GO
CREATE TABLE [dbo].[FactOrders] (
    [OrderID]         INT      NOT NULL,
    [ItemID]          INT      NOT NULL,
    [CustomerIDSK]    INT      NOT NULL,
    [EmployeeIDSK]    INT      NOT NULL,
    [OrderDateKey]    INT      NOT NULL,
    [RequiredDateKey] INT      NOT NULL,
    [ShippedDateKey]  INT      NOT NULL,
    [ProductIDSK]     INT      NOT NULL,
    [UnitPrice]       MONEY    NOT NULL,
    [Quantity]        SMALLINT NOT NULL,
    [Discount]        REAL     NOT NULL,
    CONSTRAINT [PK_Fact_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC, [ItemID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [PackageID]      INT          IDENTITY (1, 1) NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL,
    CONSTRAINT [PackageID] PRIMARY KEY CLUSTERED ([PackageID] ASC) ON [PRIMARY]
) ON [PRIMARY];


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_OrderDate]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_RequiredDate]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_DimDate_RequiredDate] FOREIGN KEY ([RequiredDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_ShippedDate]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_DimDate_ShippedDate] FOREIGN KEY ([ShippedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_DimCustomers]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_DimCustomers] FOREIGN KEY ([CustomerIDSK]) REFERENCES [dbo].[DimCustomers] ([CustomerIDSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_DimEmployees]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_DimEmployees] FOREIGN KEY ([EmployeeIDSK]) REFERENCES [dbo].[DimEmployees] ([EmployeeIDSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_FactOrders_DimProducts]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD CONSTRAINT [FK_FactOrders_DimProducts] FOREIGN KEY ([ProductIDSK]) REFERENCES [dbo].[DimProducts] ([ProductIDSK]);


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
CREATE PROCEDURE  [dbo].[DW_MergeFactOrders]
AS
BEGIN
    UPDATE fo
    SET [CustomerIDSK] = so.[CustomerIDSK],
        [EmployeeIDSK] = so.[EmployeeIDSK],
        [OrderDateKey] = so.[OrderDateKey],
        [RequiredDateKey] = so.[RequiredDateKey],
        [ShippedDateKey] = so.[ShippedDateKey],
        [ProductIDSK] = so.[ProductIDSK],
        [UnitPrice] = so.[UnitPrice],
        [Quantity] = so.[Quantity],
        [Discount] = so.[Discount]
    FROM [dbo].[FactOrders] fo
    INNER JOIN [staging].[factOrders] so 
        ON fo.[OrderID] = so.[OrderID] 
        AND fo.[ItemID] = so.[ItemID];
END
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
/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.			
 Ejemplo:      :r .\miArchivo.sql								
 Use la sintaxis de SQLCMD para hacer referencia a una variable en el script posterior a la implementación.		
 Ejemplo:      :setvar TableName miTabla							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------

INSERT INTO NorthWindDW.dbo.DimDate
SELECT Distinct 
	CONVERT(VARCHAR(8), OrderDate, 112) dataKey, 
	OrderDate Fulldate,
	datePart(dw,OrderDate) DayNumberOfWeek,
	dateName(dw,OrderDate) [DayNameOfWeek],
	datePart(dd,OrderDate) DayNumberOfMonth,
	datePart(dy,OrderDate) DayNumberOfYear,
	datePart(wk,OrderDate) WeekNumberOfYear,
	dateName(MONTH,OrderDate) [MonthName],
	FORMAT(OrderDate, 'MM') MonthNumberOfYear,
	datePart(QUARTER,OrderDate) CalendarQuarter,
	Year(OrderDate) CalendarYear,
	CASE WHEN MONTH(OrderDate) < 7 THEN 1 -- Months 1 through 6
        ELSE 2                     -- Months 7 through 12
    END AS CalendarSemester
FROM dbo.Orders
*/

SET IDENTITY_INSERT [dbo].[PackageConfig] ON 
INSERT [dbo].[PackageConfig] ([PackageID], [TableName], [LastRowVersion]) VALUES (1, N'Customer', 0)
INSERT [dbo].[PackageConfig] ([PackageID], [TableName], [LastRowVersion]) VALUES (2, N'Employees', 0)
INSERT [dbo].[PackageConfig] ([PackageID], [TableName], [LastRowVersion]) VALUES (3, N'Products', 0)
INSERT [dbo].[PackageConfig] ([PackageID], [TableName], [LastRowVersion]) VALUES (4, N'Shippers', 0)
INSERT [dbo].[PackageConfig] ([PackageID], [TableName], [LastRowVersion]) VALUES (5, N'Orders', 0)
SET IDENTITY_INSERT [dbo].[PackageConfig] OFF

INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960704, CAST(N'1996-07-04' AS Date), 4, N'Jueves', 4, 186, 27, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960705, CAST(N'1996-07-05' AS Date), 5, N'Viernes', 5, 187, 27, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960708, CAST(N'1996-07-08' AS Date), 1, N'Lunes', 8, 190, 28, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960709, CAST(N'1996-07-09' AS Date), 2, N'Martes', 9, 191, 28, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960710, CAST(N'1996-07-10' AS Date), 3, N'Miércoles', 10, 192, 28, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960711, CAST(N'1996-07-11' AS Date), 4, N'Jueves', 11, 193, 28, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960712, CAST(N'1996-07-12' AS Date), 5, N'Viernes', 12, 194, 28, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960715, CAST(N'1996-07-15' AS Date), 1, N'Lunes', 15, 197, 29, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960716, CAST(N'1996-07-16' AS Date), 2, N'Martes', 16, 198, 29, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960718, CAST(N'1996-07-18' AS Date), 4, N'Jueves', 18, 200, 29, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960719, CAST(N'1996-07-19' AS Date), 5, N'Viernes', 19, 201, 29, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960722, CAST(N'1996-07-22' AS Date), 1, N'Lunes', 22, 204, 30, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960723, CAST(N'1996-07-23' AS Date), 2, N'Martes', 23, 205, 30, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960724, CAST(N'1996-07-24' AS Date), 3, N'Miércoles', 24, 206, 30, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960725, CAST(N'1996-07-25' AS Date), 4, N'Jueves', 25, 207, 30, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960726, CAST(N'1996-07-26' AS Date), 5, N'Viernes', 26, 208, 30, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960729, CAST(N'1996-07-29' AS Date), 1, N'Lunes', 29, 211, 31, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960730, CAST(N'1996-07-30' AS Date), 2, N'Martes', 30, 212, 31, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960731, CAST(N'1996-07-31' AS Date), 3, N'Miércoles', 31, 213, 31, N'Julio', 7, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960801, CAST(N'1996-08-01' AS Date), 4, N'Jueves', 1, 214, 31, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960802, CAST(N'1996-08-02' AS Date), 5, N'Viernes', 2, 215, 31, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960805, CAST(N'1996-08-05' AS Date), 1, N'Lunes', 5, 218, 32, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960806, CAST(N'1996-08-06' AS Date), 2, N'Martes', 6, 219, 32, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960808, CAST(N'1996-08-08' AS Date), 4, N'Jueves', 8, 221, 32, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960809, CAST(N'1996-08-09' AS Date), 5, N'Viernes', 9, 222, 32, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960812, CAST(N'1996-08-12' AS Date), 1, N'Lunes', 12, 225, 33, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960813, CAST(N'1996-08-13' AS Date), 2, N'Martes', 13, 226, 33, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960814, CAST(N'1996-08-14' AS Date), 3, N'Miércoles', 14, 227, 33, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960815, CAST(N'1996-08-15' AS Date), 4, N'Jueves', 15, 228, 33, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960816, CAST(N'1996-08-16' AS Date), 5, N'Viernes', 16, 229, 33, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960819, CAST(N'1996-08-19' AS Date), 1, N'Lunes', 19, 232, 34, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960821, CAST(N'1996-08-21' AS Date), 3, N'Miércoles', 21, 234, 34, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960822, CAST(N'1996-08-22' AS Date), 4, N'Jueves', 22, 235, 34, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960823, CAST(N'1996-08-23' AS Date), 5, N'Viernes', 23, 236, 34, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960826, CAST(N'1996-08-26' AS Date), 1, N'Lunes', 26, 239, 35, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960827, CAST(N'1996-08-27' AS Date), 2, N'Martes', 27, 240, 35, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960830, CAST(N'1996-08-30' AS Date), 5, N'Viernes', 30, 243, 35, N'Agosto', 8, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960902, CAST(N'1996-09-02' AS Date), 1, N'Lunes', 2, 246, 36, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960903, CAST(N'1996-09-03' AS Date), 2, N'Martes', 3, 247, 36, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960904, CAST(N'1996-09-04' AS Date), 3, N'Miércoles', 4, 248, 36, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960905, CAST(N'1996-09-05' AS Date), 4, N'Jueves', 5, 249, 36, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960906, CAST(N'1996-09-06' AS Date), 5, N'Viernes', 6, 250, 36, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960909, CAST(N'1996-09-09' AS Date), 1, N'Lunes', 9, 253, 37, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960910, CAST(N'1996-09-10' AS Date), 2, N'Martes', 10, 254, 37, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960911, CAST(N'1996-09-11' AS Date), 3, N'Miércoles', 11, 255, 37, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960913, CAST(N'1996-09-13' AS Date), 5, N'Viernes', 13, 257, 37, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960917, CAST(N'1996-09-17' AS Date), 2, N'Martes', 17, 261, 38, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960918, CAST(N'1996-09-18' AS Date), 3, N'Miércoles', 18, 262, 38, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960919, CAST(N'1996-09-19' AS Date), 4, N'Jueves', 19, 263, 38, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960920, CAST(N'1996-09-20' AS Date), 5, N'Viernes', 20, 264, 38, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960923, CAST(N'1996-09-23' AS Date), 1, N'Lunes', 23, 267, 39, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960924, CAST(N'1996-09-24' AS Date), 2, N'Martes', 24, 268, 39, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960926, CAST(N'1996-09-26' AS Date), 4, N'Jueves', 26, 270, 39, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19960930, CAST(N'1996-09-30' AS Date), 1, N'Lunes', 30, 274, 40, N'Septiembre', 9, 3, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961001, CAST(N'1996-10-01' AS Date), 2, N'Martes', 1, 275, 40, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961002, CAST(N'1996-10-02' AS Date), 3, N'Miércoles', 2, 276, 40, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961003, CAST(N'1996-10-03' AS Date), 4, N'Jueves', 3, 277, 40, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961004, CAST(N'1996-10-04' AS Date), 5, N'Viernes', 4, 278, 40, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961007, CAST(N'1996-10-07' AS Date), 1, N'Lunes', 7, 281, 41, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961008, CAST(N'1996-10-08' AS Date), 2, N'Martes', 8, 282, 41, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961010, CAST(N'1996-10-10' AS Date), 4, N'Jueves', 10, 284, 41, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961011, CAST(N'1996-10-11' AS Date), 5, N'Viernes', 11, 285, 41, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961014, CAST(N'1996-10-14' AS Date), 1, N'Lunes', 14, 288, 42, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961015, CAST(N'1996-10-15' AS Date), 2, N'Martes', 15, 289, 42, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961016, CAST(N'1996-10-16' AS Date), 3, N'Miércoles', 16, 290, 42, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961017, CAST(N'1996-10-17' AS Date), 4, N'Jueves', 17, 291, 42, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961018, CAST(N'1996-10-18' AS Date), 5, N'Viernes', 18, 292, 42, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961021, CAST(N'1996-10-21' AS Date), 1, N'Lunes', 21, 295, 43, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961022, CAST(N'1996-10-22' AS Date), 2, N'Martes', 22, 296, 43, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961023, CAST(N'1996-10-23' AS Date), 3, N'Miércoles', 23, 297, 43, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961024, CAST(N'1996-10-24' AS Date), 4, N'Jueves', 24, 298, 43, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961025, CAST(N'1996-10-25' AS Date), 5, N'Viernes', 25, 299, 43, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961028, CAST(N'1996-10-28' AS Date), 1, N'Lunes', 28, 302, 44, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961029, CAST(N'1996-10-29' AS Date), 2, N'Martes', 29, 303, 44, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961030, CAST(N'1996-10-30' AS Date), 3, N'Miércoles', 30, 304, 44, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961031, CAST(N'1996-10-31' AS Date), 4, N'Jueves', 31, 305, 44, N'Octubre', 10, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961101, CAST(N'1996-11-01' AS Date), 5, N'Viernes', 1, 306, 44, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961104, CAST(N'1996-11-04' AS Date), 1, N'Lunes', 4, 309, 45, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961105, CAST(N'1996-11-05' AS Date), 2, N'Martes', 5, 310, 45, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961106, CAST(N'1996-11-06' AS Date), 3, N'Miércoles', 6, 311, 45, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961107, CAST(N'1996-11-07' AS Date), 4, N'Jueves', 7, 312, 45, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961108, CAST(N'1996-11-08' AS Date), 5, N'Viernes', 8, 313, 45, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961111, CAST(N'1996-11-11' AS Date), 1, N'Lunes', 11, 316, 46, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961112, CAST(N'1996-11-12' AS Date), 2, N'Martes', 12, 317, 46, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961113, CAST(N'1996-11-13' AS Date), 3, N'Miércoles', 13, 318, 46, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961114, CAST(N'1996-11-14' AS Date), 4, N'Jueves', 14, 319, 46, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961115, CAST(N'1996-11-15' AS Date), 5, N'Viernes', 15, 320, 46, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961118, CAST(N'1996-11-18' AS Date), 1, N'Lunes', 18, 323, 47, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961120, CAST(N'1996-11-20' AS Date), 3, N'Miércoles', 20, 325, 47, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961121, CAST(N'1996-11-21' AS Date), 4, N'Jueves', 21, 326, 47, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961122, CAST(N'1996-11-22' AS Date), 5, N'Viernes', 22, 327, 47, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961125, CAST(N'1996-11-25' AS Date), 1, N'Lunes', 25, 330, 48, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961126, CAST(N'1996-11-26' AS Date), 2, N'Martes', 26, 331, 48, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961127, CAST(N'1996-11-27' AS Date), 3, N'Miércoles', 27, 332, 48, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961128, CAST(N'1996-11-28' AS Date), 4, N'Jueves', 28, 333, 48, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961129, CAST(N'1996-11-29' AS Date), 5, N'Viernes', 29, 334, 48, N'Noviembre', 11, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961202, CAST(N'1996-12-02' AS Date), 1, N'Lunes', 2, 337, 49, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961203, CAST(N'1996-12-03' AS Date), 2, N'Martes', 3, 338, 49, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961204, CAST(N'1996-12-04' AS Date), 3, N'Miércoles', 4, 339, 49, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961205, CAST(N'1996-12-05' AS Date), 4, N'Jueves', 5, 340, 49, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961206, CAST(N'1996-12-06' AS Date), 5, N'Viernes', 6, 341, 49, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961210, CAST(N'1996-12-10' AS Date), 2, N'Martes', 10, 345, 50, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961211, CAST(N'1996-12-11' AS Date), 3, N'Miércoles', 11, 346, 50, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961212, CAST(N'1996-12-12' AS Date), 4, N'Jueves', 12, 347, 50, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961213, CAST(N'1996-12-13' AS Date), 5, N'Viernes', 13, 348, 50, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961216, CAST(N'1996-12-16' AS Date), 1, N'Lunes', 16, 351, 51, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961218, CAST(N'1996-12-18' AS Date), 3, N'Miércoles', 18, 353, 51, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961219, CAST(N'1996-12-19' AS Date), 4, N'Jueves', 19, 354, 51, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961220, CAST(N'1996-12-20' AS Date), 5, N'Viernes', 20, 355, 51, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961223, CAST(N'1996-12-23' AS Date), 1, N'Lunes', 23, 358, 52, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961224, CAST(N'1996-12-24' AS Date), 2, N'Martes', 24, 359, 52, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961226, CAST(N'1996-12-26' AS Date), 4, N'Jueves', 26, 361, 52, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961227, CAST(N'1996-12-27' AS Date), 5, N'Viernes', 27, 362, 52, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961230, CAST(N'1996-12-30' AS Date), 1, N'Lunes', 30, 365, 53, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19961231, CAST(N'1996-12-31' AS Date), 2, N'Martes', 31, 366, 53, N'Diciembre', 12, 4, 1996, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970102, CAST(N'1997-01-02' AS Date), 4, N'Jueves', 2, 2, 1, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970103, CAST(N'1997-01-03' AS Date), 5, N'Viernes', 3, 3, 1, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970107, CAST(N'1997-01-07' AS Date), 2, N'Martes', 7, 7, 2, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970108, CAST(N'1997-01-08' AS Date), 3, N'Miércoles', 8, 8, 2, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970109, CAST(N'1997-01-09' AS Date), 4, N'Jueves', 9, 9, 2, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970110, CAST(N'1997-01-10' AS Date), 5, N'Viernes', 10, 10, 2, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970113, CAST(N'1997-01-13' AS Date), 1, N'Lunes', 13, 13, 3, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970114, CAST(N'1997-01-14' AS Date), 2, N'Martes', 14, 14, 3, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970115, CAST(N'1997-01-15' AS Date), 3, N'Miércoles', 15, 15, 3, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970116, CAST(N'1997-01-16' AS Date), 4, N'Jueves', 16, 16, 3, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970117, CAST(N'1997-01-17' AS Date), 5, N'Viernes', 17, 17, 3, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970120, CAST(N'1997-01-20' AS Date), 1, N'Lunes', 20, 20, 4, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970121, CAST(N'1997-01-21' AS Date), 2, N'Martes', 21, 21, 4, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970122, CAST(N'1997-01-22' AS Date), 3, N'Miércoles', 22, 22, 4, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970123, CAST(N'1997-01-23' AS Date), 4, N'Jueves', 23, 23, 4, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970124, CAST(N'1997-01-24' AS Date), 5, N'Viernes', 24, 24, 4, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970127, CAST(N'1997-01-27' AS Date), 1, N'Lunes', 27, 27, 5, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970128, CAST(N'1997-01-28' AS Date), 2, N'Martes', 28, 28, 5, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970129, CAST(N'1997-01-29' AS Date), 3, N'Miércoles', 29, 29, 5, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970130, CAST(N'1997-01-30' AS Date), 4, N'Jueves', 30, 30, 5, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970131, CAST(N'1997-01-31' AS Date), 5, N'Viernes', 31, 31, 5, N'Enero', 1, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970203, CAST(N'1997-02-03' AS Date), 1, N'Lunes', 3, 34, 6, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970204, CAST(N'1997-02-04' AS Date), 2, N'Martes', 4, 35, 6, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970205, CAST(N'1997-02-05' AS Date), 3, N'Miércoles', 5, 36, 6, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970206, CAST(N'1997-02-06' AS Date), 4, N'Jueves', 6, 37, 6, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970207, CAST(N'1997-02-07' AS Date), 5, N'Viernes', 7, 38, 6, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970210, CAST(N'1997-02-10' AS Date), 1, N'Lunes', 10, 41, 7, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970211, CAST(N'1997-02-11' AS Date), 2, N'Martes', 11, 42, 7, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970212, CAST(N'1997-02-12' AS Date), 3, N'Miércoles', 12, 43, 7, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970213, CAST(N'1997-02-13' AS Date), 4, N'Jueves', 13, 44, 7, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970214, CAST(N'1997-02-14' AS Date), 5, N'Viernes', 14, 45, 7, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970217, CAST(N'1997-02-17' AS Date), 1, N'Lunes', 17, 48, 8, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970218, CAST(N'1997-02-18' AS Date), 2, N'Martes', 18, 49, 8, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970219, CAST(N'1997-02-19' AS Date), 3, N'Miércoles', 19, 50, 8, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970220, CAST(N'1997-02-20' AS Date), 4, N'Jueves', 20, 51, 8, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970221, CAST(N'1997-02-21' AS Date), 5, N'Viernes', 21, 52, 8, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970224, CAST(N'1997-02-24' AS Date), 1, N'Lunes', 24, 55, 9, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970225, CAST(N'1997-02-25' AS Date), 2, N'Martes', 25, 56, 9, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970226, CAST(N'1997-02-26' AS Date), 3, N'Miércoles', 26, 57, 9, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970227, CAST(N'1997-02-27' AS Date), 4, N'Jueves', 27, 58, 9, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970228, CAST(N'1997-02-28' AS Date), 5, N'Viernes', 28, 59, 9, N'Febrero', 2, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970303, CAST(N'1997-03-03' AS Date), 1, N'Lunes', 3, 62, 10, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970304, CAST(N'1997-03-04' AS Date), 2, N'Martes', 4, 63, 10, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970306, CAST(N'1997-03-06' AS Date), 4, N'Jueves', 6, 65, 10, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970307, CAST(N'1997-03-07' AS Date), 5, N'Viernes', 7, 66, 10, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970311, CAST(N'1997-03-11' AS Date), 2, N'Martes', 11, 70, 11, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970312, CAST(N'1997-03-12' AS Date), 3, N'Miércoles', 12, 71, 11, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970313, CAST(N'1997-03-13' AS Date), 4, N'Jueves', 13, 72, 11, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970314, CAST(N'1997-03-14' AS Date), 5, N'Viernes', 14, 73, 11, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970317, CAST(N'1997-03-17' AS Date), 1, N'Lunes', 17, 76, 12, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970318, CAST(N'1997-03-18' AS Date), 2, N'Martes', 18, 77, 12, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970319, CAST(N'1997-03-19' AS Date), 3, N'Miércoles', 19, 78, 12, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970320, CAST(N'1997-03-20' AS Date), 4, N'Jueves', 20, 79, 12, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970324, CAST(N'1997-03-24' AS Date), 1, N'Lunes', 24, 83, 13, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970325, CAST(N'1997-03-25' AS Date), 2, N'Martes', 25, 84, 13, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970326, CAST(N'1997-03-26' AS Date), 3, N'Miércoles', 26, 85, 13, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970327, CAST(N'1997-03-27' AS Date), 4, N'Jueves', 27, 86, 13, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970328, CAST(N'1997-03-28' AS Date), 5, N'Viernes', 28, 87, 13, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970331, CAST(N'1997-03-31' AS Date), 1, N'Lunes', 31, 90, 14, N'Marzo', 3, 1, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970401, CAST(N'1997-04-01' AS Date), 2, N'Martes', 1, 91, 14, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970402, CAST(N'1997-04-02' AS Date), 3, N'Miércoles', 2, 92, 14, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970403, CAST(N'1997-04-03' AS Date), 4, N'Jueves', 3, 93, 14, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970404, CAST(N'1997-04-04' AS Date), 5, N'Viernes', 4, 94, 14, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970407, CAST(N'1997-04-07' AS Date), 1, N'Lunes', 7, 97, 15, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970408, CAST(N'1997-04-08' AS Date), 2, N'Martes', 8, 98, 15, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970409, CAST(N'1997-04-09' AS Date), 3, N'Miércoles', 9, 99, 15, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970410, CAST(N'1997-04-10' AS Date), 4, N'Jueves', 10, 100, 15, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970411, CAST(N'1997-04-11' AS Date), 5, N'Viernes', 11, 101, 15, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970414, CAST(N'1997-04-14' AS Date), 1, N'Lunes', 14, 104, 16, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970415, CAST(N'1997-04-15' AS Date), 2, N'Martes', 15, 105, 16, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970417, CAST(N'1997-04-17' AS Date), 4, N'Jueves', 17, 107, 16, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970418, CAST(N'1997-04-18' AS Date), 5, N'Viernes', 18, 108, 16, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970421, CAST(N'1997-04-21' AS Date), 1, N'Lunes', 21, 111, 17, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970422, CAST(N'1997-04-22' AS Date), 2, N'Martes', 22, 112, 17, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970423, CAST(N'1997-04-23' AS Date), 3, N'Miércoles', 23, 113, 17, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970424, CAST(N'1997-04-24' AS Date), 4, N'Jueves', 24, 114, 17, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970425, CAST(N'1997-04-25' AS Date), 5, N'Viernes', 25, 115, 17, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970428, CAST(N'1997-04-28' AS Date), 1, N'Lunes', 28, 118, 18, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970429, CAST(N'1997-04-29' AS Date), 2, N'Martes', 29, 119, 18, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970430, CAST(N'1997-04-30' AS Date), 3, N'Miércoles', 30, 120, 18, N'Abril', 4, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970501, CAST(N'1997-05-01' AS Date), 4, N'Jueves', 1, 121, 18, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970505, CAST(N'1997-05-05' AS Date), 1, N'Lunes', 5, 125, 19, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970506, CAST(N'1997-05-06' AS Date), 2, N'Martes', 6, 126, 19, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970507, CAST(N'1997-05-07' AS Date), 3, N'Miércoles', 7, 127, 19, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970508, CAST(N'1997-05-08' AS Date), 4, N'Jueves', 8, 128, 19, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970509, CAST(N'1997-05-09' AS Date), 5, N'Viernes', 9, 129, 19, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970512, CAST(N'1997-05-12' AS Date), 1, N'Lunes', 12, 132, 20, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970513, CAST(N'1997-05-13' AS Date), 2, N'Martes', 13, 133, 20, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970514, CAST(N'1997-05-14' AS Date), 3, N'Miércoles', 14, 134, 20, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970515, CAST(N'1997-05-15' AS Date), 4, N'Jueves', 15, 135, 20, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970516, CAST(N'1997-05-16' AS Date), 5, N'Viernes', 16, 136, 20, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970519, CAST(N'1997-05-19' AS Date), 1, N'Lunes', 19, 139, 21, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970521, CAST(N'1997-05-21' AS Date), 3, N'Miércoles', 21, 141, 21, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970522, CAST(N'1997-05-22' AS Date), 4, N'Jueves', 22, 142, 21, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970523, CAST(N'1997-05-23' AS Date), 5, N'Viernes', 23, 143, 21, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970526, CAST(N'1997-05-26' AS Date), 1, N'Lunes', 26, 146, 22, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970527, CAST(N'1997-05-27' AS Date), 2, N'Martes', 27, 147, 22, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970528, CAST(N'1997-05-28' AS Date), 3, N'Miércoles', 28, 148, 22, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970529, CAST(N'1997-05-29' AS Date), 4, N'Jueves', 29, 149, 22, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970530, CAST(N'1997-05-30' AS Date), 5, N'Viernes', 30, 150, 22, N'Mayo', 5, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970602, CAST(N'1997-06-02' AS Date), 1, N'Lunes', 2, 153, 23, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970603, CAST(N'1997-06-03' AS Date), 2, N'Martes', 3, 154, 23, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970605, CAST(N'1997-06-05' AS Date), 4, N'Jueves', 5, 156, 23, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970606, CAST(N'1997-06-06' AS Date), 5, N'Viernes', 6, 157, 23, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970610, CAST(N'1997-06-10' AS Date), 2, N'Martes', 10, 161, 24, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970611, CAST(N'1997-06-11' AS Date), 3, N'Miércoles', 11, 162, 24, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970612, CAST(N'1997-06-12' AS Date), 4, N'Jueves', 12, 163, 24, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970613, CAST(N'1997-06-13' AS Date), 5, N'Viernes', 13, 164, 24, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970616, CAST(N'1997-06-16' AS Date), 1, N'Lunes', 16, 167, 25, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970617, CAST(N'1997-06-17' AS Date), 2, N'Martes', 17, 168, 25, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970618, CAST(N'1997-06-18' AS Date), 3, N'Miércoles', 18, 169, 25, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970619, CAST(N'1997-06-19' AS Date), 4, N'Jueves', 19, 170, 25, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970620, CAST(N'1997-06-20' AS Date), 5, N'Viernes', 20, 171, 25, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970623, CAST(N'1997-06-23' AS Date), 1, N'Lunes', 23, 174, 26, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970624, CAST(N'1997-06-24' AS Date), 2, N'Martes', 24, 175, 26, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970626, CAST(N'1997-06-26' AS Date), 4, N'Jueves', 26, 177, 26, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970627, CAST(N'1997-06-27' AS Date), 5, N'Viernes', 27, 178, 26, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970630, CAST(N'1997-06-30' AS Date), 1, N'Lunes', 30, 181, 27, N'Junio', 6, 2, 1997, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970701, CAST(N'1997-07-01' AS Date), 2, N'Martes', 1, 182, 27, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970702, CAST(N'1997-07-02' AS Date), 3, N'Miércoles', 2, 183, 27, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970703, CAST(N'1997-07-03' AS Date), 4, N'Jueves', 3, 184, 27, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970704, CAST(N'1997-07-04' AS Date), 5, N'Viernes', 4, 185, 27, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970707, CAST(N'1997-07-07' AS Date), 1, N'Lunes', 7, 188, 28, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970708, CAST(N'1997-07-08' AS Date), 2, N'Martes', 8, 189, 28, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970709, CAST(N'1997-07-09' AS Date), 3, N'Miércoles', 9, 190, 28, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970710, CAST(N'1997-07-10' AS Date), 4, N'Jueves', 10, 191, 28, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970711, CAST(N'1997-07-11' AS Date), 5, N'Viernes', 11, 192, 28, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970715, CAST(N'1997-07-15' AS Date), 2, N'Martes', 15, 196, 29, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970716, CAST(N'1997-07-16' AS Date), 3, N'Miércoles', 16, 197, 29, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970717, CAST(N'1997-07-17' AS Date), 4, N'Jueves', 17, 198, 29, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970718, CAST(N'1997-07-18' AS Date), 5, N'Viernes', 18, 199, 29, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970722, CAST(N'1997-07-22' AS Date), 2, N'Martes', 22, 203, 30, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970723, CAST(N'1997-07-23' AS Date), 3, N'Miércoles', 23, 204, 30, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970724, CAST(N'1997-07-24' AS Date), 4, N'Jueves', 24, 205, 30, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970725, CAST(N'1997-07-25' AS Date), 5, N'Viernes', 25, 206, 30, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970729, CAST(N'1997-07-29' AS Date), 2, N'Martes', 29, 210, 31, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970730, CAST(N'1997-07-30' AS Date), 3, N'Miércoles', 30, 211, 31, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970731, CAST(N'1997-07-31' AS Date), 4, N'Jueves', 31, 212, 31, N'Julio', 7, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970804, CAST(N'1997-08-04' AS Date), 1, N'Lunes', 4, 216, 32, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970805, CAST(N'1997-08-05' AS Date), 2, N'Martes', 5, 217, 32, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970806, CAST(N'1997-08-06' AS Date), 3, N'Miércoles', 6, 218, 32, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970807, CAST(N'1997-08-07' AS Date), 4, N'Jueves', 7, 219, 32, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970808, CAST(N'1997-08-08' AS Date), 5, N'Viernes', 8, 220, 32, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970811, CAST(N'1997-08-11' AS Date), 1, N'Lunes', 11, 223, 33, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970812, CAST(N'1997-08-12' AS Date), 2, N'Martes', 12, 224, 33, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970814, CAST(N'1997-08-14' AS Date), 4, N'Jueves', 14, 226, 33, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970815, CAST(N'1997-08-15' AS Date), 5, N'Viernes', 15, 227, 33, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970818, CAST(N'1997-08-18' AS Date), 1, N'Lunes', 18, 230, 34, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970819, CAST(N'1997-08-19' AS Date), 2, N'Martes', 19, 231, 34, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970820, CAST(N'1997-08-20' AS Date), 3, N'Miércoles', 20, 232, 34, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970821, CAST(N'1997-08-21' AS Date), 4, N'Jueves', 21, 233, 34, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970822, CAST(N'1997-08-22' AS Date), 5, N'Viernes', 22, 234, 34, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970825, CAST(N'1997-08-25' AS Date), 1, N'Lunes', 25, 237, 35, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970826, CAST(N'1997-08-26' AS Date), 2, N'Martes', 26, 238, 35, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970827, CAST(N'1997-08-27' AS Date), 3, N'Miércoles', 27, 239, 35, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970828, CAST(N'1997-08-28' AS Date), 4, N'Jueves', 28, 240, 35, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970829, CAST(N'1997-08-29' AS Date), 5, N'Viernes', 29, 241, 35, N'Agosto', 8, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970901, CAST(N'1997-09-01' AS Date), 1, N'Lunes', 1, 244, 36, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970902, CAST(N'1997-09-02' AS Date), 2, N'Martes', 2, 245, 36, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970904, CAST(N'1997-09-04' AS Date), 4, N'Jueves', 4, 247, 36, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970905, CAST(N'1997-09-05' AS Date), 5, N'Viernes', 5, 248, 36, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970908, CAST(N'1997-09-08' AS Date), 1, N'Lunes', 8, 251, 37, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970909, CAST(N'1997-09-09' AS Date), 2, N'Martes', 9, 252, 37, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970910, CAST(N'1997-09-10' AS Date), 3, N'Miércoles', 10, 253, 37, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970912, CAST(N'1997-09-12' AS Date), 5, N'Viernes', 12, 255, 37, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970915, CAST(N'1997-09-15' AS Date), 1, N'Lunes', 15, 258, 38, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970916, CAST(N'1997-09-16' AS Date), 2, N'Martes', 16, 259, 38, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970917, CAST(N'1997-09-17' AS Date), 3, N'Miércoles', 17, 260, 38, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970918, CAST(N'1997-09-18' AS Date), 4, N'Jueves', 18, 261, 38, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970919, CAST(N'1997-09-19' AS Date), 5, N'Viernes', 19, 262, 38, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970922, CAST(N'1997-09-22' AS Date), 1, N'Lunes', 22, 265, 39, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970923, CAST(N'1997-09-23' AS Date), 2, N'Martes', 23, 266, 39, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970925, CAST(N'1997-09-25' AS Date), 4, N'Jueves', 25, 268, 39, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970926, CAST(N'1997-09-26' AS Date), 5, N'Viernes', 26, 269, 39, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970929, CAST(N'1997-09-29' AS Date), 1, N'Lunes', 29, 272, 40, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19970930, CAST(N'1997-09-30' AS Date), 2, N'Martes', 30, 273, 40, N'Septiembre', 9, 3, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971001, CAST(N'1997-10-01' AS Date), 3, N'Miércoles', 1, 274, 40, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971003, CAST(N'1997-10-03' AS Date), 5, N'Viernes', 3, 276, 40, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971006, CAST(N'1997-10-06' AS Date), 1, N'Lunes', 6, 279, 41, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971007, CAST(N'1997-10-07' AS Date), 2, N'Martes', 7, 280, 41, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971008, CAST(N'1997-10-08' AS Date), 3, N'Miércoles', 8, 281, 41, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971009, CAST(N'1997-10-09' AS Date), 4, N'Jueves', 9, 282, 41, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971010, CAST(N'1997-10-10' AS Date), 5, N'Viernes', 10, 283, 41, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971013, CAST(N'1997-10-13' AS Date), 1, N'Lunes', 13, 286, 42, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971014, CAST(N'1997-10-14' AS Date), 2, N'Martes', 14, 287, 42, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971015, CAST(N'1997-10-15' AS Date), 3, N'Miércoles', 15, 288, 42, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971016, CAST(N'1997-10-16' AS Date), 4, N'Jueves', 16, 289, 42, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971017, CAST(N'1997-10-17' AS Date), 5, N'Viernes', 17, 290, 42, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971021, CAST(N'1997-10-21' AS Date), 2, N'Martes', 21, 294, 43, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971022, CAST(N'1997-10-22' AS Date), 3, N'Miércoles', 22, 295, 43, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971023, CAST(N'1997-10-23' AS Date), 4, N'Jueves', 23, 296, 43, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971024, CAST(N'1997-10-24' AS Date), 5, N'Viernes', 24, 297, 43, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971027, CAST(N'1997-10-27' AS Date), 1, N'Lunes', 27, 300, 44, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971028, CAST(N'1997-10-28' AS Date), 2, N'Martes', 28, 301, 44, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971029, CAST(N'1997-10-29' AS Date), 3, N'Miércoles', 29, 302, 44, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971030, CAST(N'1997-10-30' AS Date), 4, N'Jueves', 30, 303, 44, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971031, CAST(N'1997-10-31' AS Date), 5, N'Viernes', 31, 304, 44, N'Octubre', 10, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971103, CAST(N'1997-11-03' AS Date), 1, N'Lunes', 3, 307, 45, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971104, CAST(N'1997-11-04' AS Date), 2, N'Martes', 4, 308, 45, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971105, CAST(N'1997-11-05' AS Date), 3, N'Miércoles', 5, 309, 45, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971106, CAST(N'1997-11-06' AS Date), 4, N'Jueves', 6, 310, 45, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971107, CAST(N'1997-11-07' AS Date), 5, N'Viernes', 7, 311, 45, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971110, CAST(N'1997-11-10' AS Date), 1, N'Lunes', 10, 314, 46, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971111, CAST(N'1997-11-11' AS Date), 2, N'Martes', 11, 315, 46, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971112, CAST(N'1997-11-12' AS Date), 3, N'Miércoles', 12, 316, 46, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971113, CAST(N'1997-11-13' AS Date), 4, N'Jueves', 13, 317, 46, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971114, CAST(N'1997-11-14' AS Date), 5, N'Viernes', 14, 318, 46, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971117, CAST(N'1997-11-17' AS Date), 1, N'Lunes', 17, 321, 47, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971118, CAST(N'1997-11-18' AS Date), 2, N'Martes', 18, 322, 47, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971119, CAST(N'1997-11-19' AS Date), 3, N'Miércoles', 19, 323, 47, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971120, CAST(N'1997-11-20' AS Date), 4, N'Jueves', 20, 324, 47, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971121, CAST(N'1997-11-21' AS Date), 5, N'Viernes', 21, 325, 47, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971124, CAST(N'1997-11-24' AS Date), 1, N'Lunes', 24, 328, 48, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971125, CAST(N'1997-11-25' AS Date), 2, N'Martes', 25, 329, 48, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971126, CAST(N'1997-11-26' AS Date), 3, N'Miércoles', 26, 330, 48, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971127, CAST(N'1997-11-27' AS Date), 4, N'Jueves', 27, 331, 48, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971128, CAST(N'1997-11-28' AS Date), 5, N'Viernes', 28, 332, 48, N'Noviembre', 11, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971201, CAST(N'1997-12-01' AS Date), 1, N'Lunes', 1, 335, 49, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971202, CAST(N'1997-12-02' AS Date), 2, N'Martes', 2, 336, 49, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971203, CAST(N'1997-12-03' AS Date), 3, N'Miércoles', 3, 337, 49, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971204, CAST(N'1997-12-04' AS Date), 4, N'Jueves', 4, 338, 49, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971205, CAST(N'1997-12-05' AS Date), 5, N'Viernes', 5, 339, 49, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971208, CAST(N'1997-12-08' AS Date), 1, N'Lunes', 8, 342, 50, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971209, CAST(N'1997-12-09' AS Date), 2, N'Martes', 9, 343, 50, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971210, CAST(N'1997-12-10' AS Date), 3, N'Miércoles', 10, 344, 50, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971211, CAST(N'1997-12-11' AS Date), 4, N'Jueves', 11, 345, 50, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971212, CAST(N'1997-12-12' AS Date), 5, N'Viernes', 12, 346, 50, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971215, CAST(N'1997-12-15' AS Date), 1, N'Lunes', 15, 349, 51, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971216, CAST(N'1997-12-16' AS Date), 2, N'Martes', 16, 350, 51, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971217, CAST(N'1997-12-17' AS Date), 3, N'Miércoles', 17, 351, 51, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971218, CAST(N'1997-12-18' AS Date), 4, N'Jueves', 18, 352, 51, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971219, CAST(N'1997-12-19' AS Date), 5, N'Viernes', 19, 353, 51, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971222, CAST(N'1997-12-22' AS Date), 1, N'Lunes', 22, 356, 52, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971223, CAST(N'1997-12-23' AS Date), 2, N'Martes', 23, 357, 52, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971224, CAST(N'1997-12-24' AS Date), 3, N'Miércoles', 24, 358, 52, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971225, CAST(N'1997-12-25' AS Date), 4, N'Jueves', 25, 359, 52, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971226, CAST(N'1997-12-26' AS Date), 5, N'Viernes', 26, 360, 52, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971229, CAST(N'1997-12-29' AS Date), 1, N'Lunes', 29, 363, 53, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971230, CAST(N'1997-12-30' AS Date), 2, N'Martes', 30, 364, 53, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19971231, CAST(N'1997-12-31' AS Date), 3, N'Miércoles', 31, 365, 53, N'Diciembre', 12, 4, 1997, 2)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980101, CAST(N'1998-01-01' AS Date), 4, N'Jueves', 1, 1, 1, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980102, CAST(N'1998-01-02' AS Date), 5, N'Viernes', 2, 2, 1, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980105, CAST(N'1998-01-05' AS Date), 1, N'Lunes', 5, 5, 2, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980106, CAST(N'1998-01-06' AS Date), 2, N'Martes', 6, 6, 2, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980107, CAST(N'1998-01-07' AS Date), 3, N'Miércoles', 7, 7, 2, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980108, CAST(N'1998-01-08' AS Date), 4, N'Jueves', 8, 8, 2, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980109, CAST(N'1998-01-09' AS Date), 5, N'Viernes', 9, 9, 2, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980112, CAST(N'1998-01-12' AS Date), 1, N'Lunes', 12, 12, 3, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980113, CAST(N'1998-01-13' AS Date), 2, N'Martes', 13, 13, 3, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980114, CAST(N'1998-01-14' AS Date), 3, N'Miércoles', 14, 14, 3, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980115, CAST(N'1998-01-15' AS Date), 4, N'Jueves', 15, 15, 3, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980116, CAST(N'1998-01-16' AS Date), 5, N'Viernes', 16, 16, 3, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980119, CAST(N'1998-01-19' AS Date), 1, N'Lunes', 19, 19, 4, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980120, CAST(N'1998-01-20' AS Date), 2, N'Martes', 20, 20, 4, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980121, CAST(N'1998-01-21' AS Date), 3, N'Miércoles', 21, 21, 4, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980122, CAST(N'1998-01-22' AS Date), 4, N'Jueves', 22, 22, 4, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980123, CAST(N'1998-01-23' AS Date), 5, N'Viernes', 23, 23, 4, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980126, CAST(N'1998-01-26' AS Date), 1, N'Lunes', 26, 26, 5, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980127, CAST(N'1998-01-27' AS Date), 2, N'Martes', 27, 27, 5, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980128, CAST(N'1998-01-28' AS Date), 3, N'Miércoles', 28, 28, 5, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980129, CAST(N'1998-01-29' AS Date), 4, N'Jueves', 29, 29, 5, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980130, CAST(N'1998-01-30' AS Date), 5, N'Viernes', 30, 30, 5, N'Enero', 1, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980202, CAST(N'1998-02-02' AS Date), 1, N'Lunes', 2, 33, 6, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980203, CAST(N'1998-02-03' AS Date), 2, N'Martes', 3, 34, 6, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980204, CAST(N'1998-02-04' AS Date), 3, N'Miércoles', 4, 35, 6, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980205, CAST(N'1998-02-05' AS Date), 4, N'Jueves', 5, 36, 6, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980206, CAST(N'1998-02-06' AS Date), 5, N'Viernes', 6, 37, 6, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980209, CAST(N'1998-02-09' AS Date), 1, N'Lunes', 9, 40, 7, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980210, CAST(N'1998-02-10' AS Date), 2, N'Martes', 10, 41, 7, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980211, CAST(N'1998-02-11' AS Date), 3, N'Miércoles', 11, 42, 7, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980212, CAST(N'1998-02-12' AS Date), 4, N'Jueves', 12, 43, 7, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980213, CAST(N'1998-02-13' AS Date), 5, N'Viernes', 13, 44, 7, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980216, CAST(N'1998-02-16' AS Date), 1, N'Lunes', 16, 47, 8, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980217, CAST(N'1998-02-17' AS Date), 2, N'Martes', 17, 48, 8, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980218, CAST(N'1998-02-18' AS Date), 3, N'Miércoles', 18, 49, 8, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980219, CAST(N'1998-02-19' AS Date), 4, N'Jueves', 19, 50, 8, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980220, CAST(N'1998-02-20' AS Date), 5, N'Viernes', 20, 51, 8, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980223, CAST(N'1998-02-23' AS Date), 1, N'Lunes', 23, 54, 9, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980224, CAST(N'1998-02-24' AS Date), 2, N'Martes', 24, 55, 9, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980225, CAST(N'1998-02-25' AS Date), 3, N'Miércoles', 25, 56, 9, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980226, CAST(N'1998-02-26' AS Date), 4, N'Jueves', 26, 57, 9, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980227, CAST(N'1998-02-27' AS Date), 5, N'Viernes', 27, 58, 9, N'Febrero', 2, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980302, CAST(N'1998-03-02' AS Date), 1, N'Lunes', 2, 61, 10, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980303, CAST(N'1998-03-03' AS Date), 2, N'Martes', 3, 62, 10, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980304, CAST(N'1998-03-04' AS Date), 3, N'Miércoles', 4, 63, 10, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980305, CAST(N'1998-03-05' AS Date), 4, N'Jueves', 5, 64, 10, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980306, CAST(N'1998-03-06' AS Date), 5, N'Viernes', 6, 65, 10, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980309, CAST(N'1998-03-09' AS Date), 1, N'Lunes', 9, 68, 11, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980310, CAST(N'1998-03-10' AS Date), 2, N'Martes', 10, 69, 11, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980311, CAST(N'1998-03-11' AS Date), 3, N'Miércoles', 11, 70, 11, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980312, CAST(N'1998-03-12' AS Date), 4, N'Jueves', 12, 71, 11, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980313, CAST(N'1998-03-13' AS Date), 5, N'Viernes', 13, 72, 11, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980316, CAST(N'1998-03-16' AS Date), 1, N'Lunes', 16, 75, 12, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980317, CAST(N'1998-03-17' AS Date), 2, N'Martes', 17, 76, 12, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980318, CAST(N'1998-03-18' AS Date), 3, N'Miércoles', 18, 77, 12, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980319, CAST(N'1998-03-19' AS Date), 4, N'Jueves', 19, 78, 12, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980320, CAST(N'1998-03-20' AS Date), 5, N'Viernes', 20, 79, 12, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980323, CAST(N'1998-03-23' AS Date), 1, N'Lunes', 23, 82, 13, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980324, CAST(N'1998-03-24' AS Date), 2, N'Martes', 24, 83, 13, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980325, CAST(N'1998-03-25' AS Date), 3, N'Miércoles', 25, 84, 13, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980326, CAST(N'1998-03-26' AS Date), 4, N'Jueves', 26, 85, 13, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980327, CAST(N'1998-03-27' AS Date), 5, N'Viernes', 27, 86, 13, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980330, CAST(N'1998-03-30' AS Date), 1, N'Lunes', 30, 89, 14, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980331, CAST(N'1998-03-31' AS Date), 2, N'Martes', 31, 90, 14, N'Marzo', 3, 1, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980401, CAST(N'1998-04-01' AS Date), 3, N'Miércoles', 1, 91, 14, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980402, CAST(N'1998-04-02' AS Date), 4, N'Jueves', 2, 92, 14, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980403, CAST(N'1998-04-03' AS Date), 5, N'Viernes', 3, 93, 14, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980406, CAST(N'1998-04-06' AS Date), 1, N'Lunes', 6, 96, 15, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980407, CAST(N'1998-04-07' AS Date), 2, N'Martes', 7, 97, 15, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980408, CAST(N'1998-04-08' AS Date), 3, N'Miércoles', 8, 98, 15, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980409, CAST(N'1998-04-09' AS Date), 4, N'Jueves', 9, 99, 15, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980410, CAST(N'1998-04-10' AS Date), 5, N'Viernes', 10, 100, 15, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980413, CAST(N'1998-04-13' AS Date), 1, N'Lunes', 13, 103, 16, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980414, CAST(N'1998-04-14' AS Date), 2, N'Martes', 14, 104, 16, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980415, CAST(N'1998-04-15' AS Date), 3, N'Miércoles', 15, 105, 16, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980416, CAST(N'1998-04-16' AS Date), 4, N'Jueves', 16, 106, 16, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980417, CAST(N'1998-04-17' AS Date), 5, N'Viernes', 17, 107, 16, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980420, CAST(N'1998-04-20' AS Date), 1, N'Lunes', 20, 110, 17, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980421, CAST(N'1998-04-21' AS Date), 2, N'Martes', 21, 111, 17, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980422, CAST(N'1998-04-22' AS Date), 3, N'Miércoles', 22, 112, 17, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980423, CAST(N'1998-04-23' AS Date), 4, N'Jueves', 23, 113, 17, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980424, CAST(N'1998-04-24' AS Date), 5, N'Viernes', 24, 114, 17, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980427, CAST(N'1998-04-27' AS Date), 1, N'Lunes', 27, 117, 18, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980428, CAST(N'1998-04-28' AS Date), 2, N'Martes', 28, 118, 18, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980429, CAST(N'1998-04-29' AS Date), 3, N'Miércoles', 29, 119, 18, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980430, CAST(N'1998-04-30' AS Date), 4, N'Jueves', 30, 120, 18, N'Abril', 4, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980501, CAST(N'1998-05-01' AS Date), 5, N'Viernes', 1, 121, 18, N'Mayo', 5, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980504, CAST(N'1998-05-04' AS Date), 1, N'Lunes', 4, 124, 19, N'Mayo', 5, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980505, CAST(N'1998-05-05' AS Date), 2, N'Martes', 5, 125, 19, N'Mayo', 5, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (19980506, CAST(N'1998-05-06' AS Date), 3, N'Miércoles', 6, 126, 19, N'Mayo', 5, 2, 1998, 1)
INSERT [dbo].[DimDate] ([DateKey], [FullDate], [DayNumberOfWeek], [DayNameOfWeek], [DayNumberOfMonth], [DayNumberOfYear], [WeekNumberOfYear], [MonthName], [MonthNumberOfYear], [CalendarQuarter], [CalendarYear], [CalendarSemester]) VALUES (0, CAST(N'2021-07-22' AS Date), 0, N'N/A', 0, 0, 0, N'N/A', 0, 0, 0, 0)



GO

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
