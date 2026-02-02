CREATE TABLE [dbo].[DimOrdersDetail]
(
	[OrderIDSK] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [money] NOT NULL,
	[Quantity] [smallint] NOT NULL,
	[Discount] [real] NOT NULL,
	[rowversion] [timestamp] NULL,
 
);