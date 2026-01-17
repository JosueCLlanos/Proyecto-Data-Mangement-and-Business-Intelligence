CREATE TABLE [dbo].[EmployeeTerritories]
(
	[EmployeeID] [int] NOT NULL CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED ,
	[TerritoryID] [nvarchar](20) NOT NULL,
	[rowversion] [timestamp] NULL
);

GO

ALTER TABLE [dbo].[EmployeeTerritories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO

ALTER TABLE [dbo].[EmployeeTerritories] CHECK CONSTRAINT [FK_EmployeeTerritories_Employees]
GO

ALTER TABLE [dbo].[EmployeeTerritories]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY([TerritoryID])
REFERENCES [dbo].[Territories] ([TerritoryID])
GO

ALTER TABLE [dbo].[EmployeeTerritories] CHECK CONSTRAINT [FK_EmployeeTerritories_Territories]
GO

