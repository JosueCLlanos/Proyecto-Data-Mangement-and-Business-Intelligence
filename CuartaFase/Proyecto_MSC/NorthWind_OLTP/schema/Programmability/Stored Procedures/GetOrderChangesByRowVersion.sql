
CREATE PROCEDURE [dbo].[GetOrderChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow   BIGINT
)
AS
BEGIN

    SELECT 
           o.OrderID,
           p.ProductID,
           Cast(ROW_NUMBER() OVER(PARTITION BY o.OrderID ORDER BY p.ProductID) as INT) AS [ItemID],
           o.CustomerID,
           o.EmployeeID,
           s.ShipperID,
           isnull(CAST(CONVERT(VARCHAR(8), o.orderdate, 112) AS INT),0) AS OrderDateKey,
           isnull(CAST(CONVERT(VARCHAR(8), o.RequiredDate, 112) AS INT),0) AS RequiredDateKey,
           isnull(CAST(CONVERT(VARCHAR(8), o.ShippedDate  , 112) AS INT),0) AS ShippedDateKey,
           od.UnitPrice,
           od.Quantity,
           od.Discount
    FROM Orders o
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    INNER JOIN Products p ON od.ProductID = p.ProductID
    INNER JOIN Customers c ON o.CustomerID = c.CustomerID
    INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
    INNER JOIN Shippers s ON o.ShipVia = s.ShipperID
    WHERE
    (
      o.rowversion > CONVERT(ROWVERSION, @startRow)
      AND o.rowversion <= CONVERT(ROWVERSION, @endRow)
    )
    OR
    (
      od.rowversion > CONVERT(ROWVERSION, @startRow)
      AND od.rowversion <= CONVERT(ROWVERSION, @endRow)
    )
    OR
    (
      p.rowversion > CONVERT(ROWVERSION, @startRow)
      AND p.rowversion <= CONVERT(ROWVERSION, @endRow)
    )
    OR
    (
      c.rowversion > CONVERT(ROWVERSION, @startRow)
      AND c.rowversion <= CONVERT(ROWVERSION, @endRow)
    )
    OR
    (
      e.rowversion > CONVERT(ROWVERSION, @startRow)
      AND e.rowversion <= CONVERT(ROWVERSION, @endRow)
    )
    OR
    (
      s.rowversion > CONVERT(ROWVERSION, @startRow)
      AND s.rowversion <= CONVERT(ROWVERSION, @endRow)
    )

END
GO


