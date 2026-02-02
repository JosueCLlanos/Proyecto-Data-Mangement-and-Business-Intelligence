CREATE PROCEDURE [dbo].[GetOrderDetailChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow   BIGINT
)
AS
BEGIN

    SELECT
        od.OrderID,
        od.ProductID,
        od.UnitPrice,
        od.Quantity,
        od.Discount,
        o.OrderDate,
        p.ProductName,
        p.UnitPrice AS ProductUnitPrice
    FROM OrderDetails od
    INNER JOIN Orders o
        ON od.OrderID = o.OrderID
    INNER JOIN Products p
        ON od.ProductID = p.ProductID
    WHERE
    (
        od.rowversion > CONVERT(ROWVERSION, @startRow)
        AND od.rowversion <= CONVERT(ROWVERSION, @endRow)
    )
    OR
    (
        o.rowversion > CONVERT(ROWVERSION, @startRow)
        AND o.rowversion <= CONVERT(ROWVERSION, @endRow)
    )
    OR
    (
        p.rowversion > CONVERT(ROWVERSION, @startRow)
        AND p.rowversion <= CONVERT(ROWVERSION, @endRow)
    );

END
GO
