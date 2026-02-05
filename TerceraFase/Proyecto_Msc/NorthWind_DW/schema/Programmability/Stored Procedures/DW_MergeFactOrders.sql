

CREATE PROCEDURE  [dbo].[DW_MergeFactOrders]
AS
BEGIN
    UPDATE fo
    SET [CustomerIDSK] = so.[CustomerIDSK],
        [EmployeeIDSK] = so.[EmployeeIDSK],
        [ShipperIDSK] = so.[ShipperIDSK],
        [OrderDateKey] = so.[OrderDateKey],
        [RequiredDateKey] = so.[RequiredDateKey],
        [ShippedDateKey] = so.[ShippedDateKey],
        [ProductIDSK] = so.[ProductIDSK],
        [UnitPrice] = so.[UnitPrice],
        [Quantity] = so.[Quantity],
        [Discount] = so.[Discount]
    FROM [dbo].[FactOrders] fo
    INNER JOIN [staging].[factOrders] so 
        ON fo.[OrderID] = so.[OrderID] 
        AND fo.[ItemID] = so.[ItemID];
END
GO


