CREATE PROCEDURE [dbo].[DW_MergeDimEmployees]
AS
BEGIN
    UPDATE de
    SET [LastName] = se.[LastName],
        [FirstName] = se.[FirstName],
        [Title] = se.[Title],
        [TitleOfCourtesy] = se.[TitleOfCourtesy],
        [BirthDate] = se.[BirthDate],
        [HireDate] = se.[HireDate],
        [Address] = se.[Address],
        [City] = se.[City],
        [Region] = se.[Region],
        [PostalCode] = se.[PostalCode],
        [Country] = se.[Country],
        [HomePhone] = se.[HomePhone],
        [Extension] = se.[Extension],
        [Photo] = se.[Photo],
        [Notes] = se.[Notes],
        [ReportsTo] = se.[ReportsTo],
        [PhotoPath] = se.[PhotoPath],
        [RegionDescription] = se.[RegionDescription],
        [TerritoryDescription] = se.[TerritoryDescription]
    FROM [dbo].[DimEmployees] de
    INNER JOIN [staging].[employees] se ON de.[EmployeeID] = se.[EmployeeID];
END
GO