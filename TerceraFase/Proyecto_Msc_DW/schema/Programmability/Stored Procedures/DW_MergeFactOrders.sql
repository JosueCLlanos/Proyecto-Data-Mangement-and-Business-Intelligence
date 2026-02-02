CREATE PROCEDURE [dbo].[DW_MergeFactOrders]
AS
BEGIN
    UPDATE fo
    SET [CustomerIDSK] = so.[CustomerIDSK],
        [ItemID]= so.[ItemID],
        [EmployeeIDSK] = so.[EmployeeIDSK],
        [OrderDateKey] = so.[OrderDateKey],
        [RequiredDateKey] = so.[RequiredDateKey],
        [ShippedDateKey] = so.[ShippedDateKey],
        [ShipViaIDSK] = so.[ShipViaIDSK],
        [Freight] = so.[Freight],
        [ShipName] = so.[ShipName],
        [ShipAddress] = so.[ShipAddress],
        [ShipCity] = so.[ShipCity],
        [ShipRegion] = so.[ShipRegion],
        [ShipPostalCode] = so.[ShipPostalCode],
        [ShipCountry] = so.[ShipCountry],
        [ProductIDSK] = so.[ProductIDSK],
        [UnitPrice] = so.[UnitPrice],
        [Quantity] = so.[Quantity],
        [Discount] = so.[Discount]
    FROM [dbo].[FactOrders] fo
    INNER JOIN [staging].[FactOrders] so 
        ON fo.[OrderID] = so.[OrderID] 
        AND fo.[ItemID] = so.[ItemID];
END
GO