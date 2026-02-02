CREATE PROCEDURE [dbo].[Ten Most Expensive Products]
as
SET ROWCOUNT 10
SELECT Products.ProductName AS TenMostExpensiveProducts, Products.UnitPrice
FROM Products
ORDER BY Products.UnitPrice DESC
GO

