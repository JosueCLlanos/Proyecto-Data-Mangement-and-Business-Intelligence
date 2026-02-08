CREATE TABLE [staging].[FactOrders](
	[OrderID] [int] NOT NULL,
	[ItemID] [int] NOT NULL,
	[CustomerIDSK] [nchar](5) NOT NULL,
	[EmployeeIDSK] [int] NOT NULL,
	[ShipperIDSK] [int] NOT NULL,
	[ProductIDSK] [int] NOT NULL,
	[OrderDateKey] [int] NOT NULL,
	[RequiredDateKey] [int] NOT NULL,
	[ShippedDateKey] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL
) ON [PRIMARY]
GO


