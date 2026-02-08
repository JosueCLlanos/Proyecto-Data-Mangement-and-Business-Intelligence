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


