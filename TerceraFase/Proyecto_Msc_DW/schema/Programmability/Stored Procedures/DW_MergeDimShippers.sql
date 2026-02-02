
CREATE PROCEDURE [dbo].[DW_MergeDimShippers]
AS
BEGIN
    UPDATE ds
    SET [CompanyName] = ss.[CompanyName],
        [Phone] = ss.[Phone]
    FROM [dbo].[DimShippers] ds
    INNER JOIN [staging].[shippers] ss ON ds.[ShipperID] = ss.[ShipperID];
END
GO