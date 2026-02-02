CREATE TABLE [dbo].[PackageConfig]
(
	[PackageID] [int] IDENTITY(1,1) NOT NULL CONSTRAINT [PackageID] PRIMARY KEY CLUSTERED ,
	[TableName] [varchar](50) NOT NULL,
	[LastRowVersion] [bigint] NULL,

)
