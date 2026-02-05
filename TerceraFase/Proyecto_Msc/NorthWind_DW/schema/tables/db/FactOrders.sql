

CREATE TABLE [dbo].[FactOrders](
	[OrderID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[CustomerIDSK] [int] NOT NULL,
	[EmployeeIDSK] [int] NOT NULL,
	[ShipperIDSK] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[RequiredDateKey] [int] NOT NULL,
	[ShippedDateKey] [int] NOT NULL,
	[ProductIDSK] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
 CONSTRAINT [PK_Fact_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY([OrderDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_DimDate_OrderDate]
GO

ALTER TABLE [dbo].[FactOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_DimDate_RequiredDate] FOREIGN KEY([RequiredDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_DimDate_RequiredDate]
GO

ALTER TABLE [dbo].[FactOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_DimDate_ShippedDate] FOREIGN KEY([ShippedDateKey])
REFERENCES [dbo].[DimDate] ([DateKey])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_DimDate_ShippedDate]
GO

ALTER TABLE [dbo].[FactOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrders_DimCustomers] FOREIGN KEY([CustomerIDSK])
REFERENCES [dbo].[DimCustomers] ([CustomerIDSK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimCustomers]
GO

ALTER TABLE [dbo].[FactOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrders_DimEmployees] FOREIGN KEY([EmployeeIDSK])
REFERENCES [dbo].[DimEmployees] ([EmployeeIDSK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimEmployees]
GO

ALTER TABLE [dbo].[FactOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrders_DimProducts] FOREIGN KEY([ProductIDSK])
REFERENCES [dbo].[DimProducts] ([ProductIDSK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimProducts]
GO

ALTER TABLE [dbo].[FactOrders]  WITH NOCHECK ADD  CONSTRAINT [FK_FactOrders_DimShippers] FOREIGN KEY([ShipperIDSK])
REFERENCES [dbo].[DimShippers] ([ShipperIDSK])
GO

ALTER TABLE [dbo].[FactOrders] CHECK CONSTRAINT [FK_FactOrders_DimShippers]
GO


