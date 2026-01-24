CREATE TABLE [staging].[PackageConfig]
(
	[PackageID] [int] NOT NULL ,
	[TableName] [varchar](50) NOT NULL,
	[LastRowVersion] [bigint] NULL,
)
