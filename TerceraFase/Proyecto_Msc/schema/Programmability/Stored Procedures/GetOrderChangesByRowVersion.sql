CREATE PROCEDURE [dbo].[GetOrderChangesByRowVersion]
(
    @startRow BIGINT,
    @endRow   BIGINT
)
AS
BEGIN

    SELECT DISTINCT
           o.OrderID,
           o.CustomerID,
           o.EmployeeID,
           o.OrderDate,
           o.RequiredDate,
           o.ShippedDate,
           o.ShipVia,
           o.Freight,
           o.ShipName,
           o.ShipCity,
           o.ShipCountry,
           c.CompanyName AS CustomerName,
           e.LastName + ', ' + e.FirstName AS EmployeeName,
           s.CompanyName AS ShipperName
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