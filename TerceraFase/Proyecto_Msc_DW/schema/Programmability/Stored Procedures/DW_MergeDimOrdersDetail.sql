CREATE PROCEDURE [dbo].[Merge_DimOrdersDetail]
AS
BEGIN
    SET NOCOUNT ON;

    MERGE dbo.DimOrdersDetail AS target
    USING staging.OrdersDetail AS source
        ON  target.OrderID  = source.OrderID
        AND target.ProductID = source.ProductID

    WHEN MATCHED AND
    (
        target.UnitPrice <> source.UnitPrice OR
        target.Quantity  <> source.Quantity  OR
        target.Discount  <> source.Discount
    )
    THEN
        UPDATE SET
            target.UnitPrice = source.UnitPrice,
            target.Quantity  = source.Quantity,
            target.Discount  = source.Discount
            -- rowversion se actualiza solo

    WHEN NOT MATCHED BY TARGET
    THEN
        INSERT
        (
            OrderID,
            ProductID,
            UnitPrice,
            Quantity,
            Discount
        )
        VALUES
        (
            source.OrderID,
            source.ProductID,
            source.UnitPrice,
            source.Quantity,
            source.Discount
        );

    -- ⚠️ No hacemos DELETE por seguridad

END
GO