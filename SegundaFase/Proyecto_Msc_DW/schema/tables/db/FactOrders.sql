CREATE TABLE [dbo].[FactOrders]
(
	[OrderID] [int] NOT NULL ,
	[ItemID] [int] NOT NULL ,
	[CustomerIDSK] [nchar](5) NOT NULL,
	[EmployeeIDSK] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[RequiredDateKey] [int] NOT NULL,
	[ShippedDateKey] [int] NOT NULL,
	[ShipViaIDSK] [int] NOT NULL,
	[Freight] [money] NULL,
	[ShipName] [nvarchar](40) NULL,
	[ShipAddress] [nvarchar](60) NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipRegion] [nvarchar](15) NULL,
	[ShipPostalCode] [nvarchar](10) NULL,
	[ShipCountry] [nvarchar](15) NULL,
	[ProductIDSK] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
);

GO

ALTER TABLE [dbo].[FactOrders] add constraint PK_Fact_Orders PRIMARY KEY ([OrderID],[ItemID])
GO

ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_FactOrders_DimCustomers]
FOREIGN KEY ([CustomerIDSK]) REFERENCES [dbo].[DimCustomers] ([CustomerIDSK]);
GO
ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_FactOrders_DimEmployees]
FOREIGN KEY ([EmployeeIDSK]) REFERENCES [dbo].[DimEmployees] ([EmployeeIDSK]);
GO
ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_FactOrders_DimProducts]
FOREIGN KEY ([ProductIDSK]) REFERENCES [dbo].[DimProducts] ([ProductIDSK]);
GO
ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_FactOrders_DimShippers]
FOREIGN KEY ([ShipViaIDSK]) REFERENCES [dbo].[DimShippers] ([ShipperIDSK]);

GO
ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_OrderDate]
FOREIGN KEY ([OrderDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);
GO
ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_RequiredDate]
FOREIGN KEY ([RequiredDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);
GO
ALTER TABLE [dbo].[FactOrders] ADD CONSTRAINT [FK_DimDate_ShippedDate]
FOREIGN KEY ([ShippedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]);


