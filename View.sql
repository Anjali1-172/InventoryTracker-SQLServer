use [Inventory Control system];
go
-- creating view for low stock

CREATE VIEW [Low Stock] 
AS
SELECT Product.ProductName, Product.Price, SupplierS.SupplierName
FROM Product
LEFT JOIN dbo.SupplierS 
ON product.SupplierID = SupplierS.SupplierID
WHERE QuantityInStock < 50;
Go

-- pending shipment view
CREATE VIEW [Pending_Shipments]
AS
SELECT ShippingID,ShippingDate,TrackingNumber, DeliveryStatus
FROM dbo.ShippingDetails
WHERE DeliveryStatus <> 'Delivered';
GO

-- Inventory view of the product after a Transaction
 CREATE VIEW [Inventory Snapshot]
 AS
 SELECT P.ProductName, P.QuantityInStock, S.SupplierName, I.TransactionType, I.QuantityChanged, I.Time_stamp
 FROM Product P
 JOIN SupplierS S ON P.SupplierID = S.SupplierID
 JOIN(
 SELECT ProductID, TransactionType, QuantityChanged, Time_Stamp
 FROM InventoryTransactions T1
 WHERE Time_stamp = (SELECT MAX(Time_Stamp) FROM InventoryTransactions T2 WHERE T2.ProductID = T1.ProductID)
 )
 I ON P.ProductID = I.ProductID;
 GO

 -- Last 10 Transcations
 CREATE VIEW [Recent Transactions]
 As 
 SELECT *
 FROM (
    SELECT TOP 10 *
    FROM InventoryTransactions
    ORDER BY TransactionID DESC
 ) AS Last10;
  GO