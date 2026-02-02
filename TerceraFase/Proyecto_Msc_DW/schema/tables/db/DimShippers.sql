CREATE TABLE [dbo].[DimShippers]
(
	[ShipperIDSK] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ,
	[ShipperID] [int] NOT NULL  ,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Phone] [nvarchar](24) NULL,
)
