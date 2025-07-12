use [Inventory Control system];
go

CREATE TRIGGER OnStockUpdate_logTxn
  ON Product
  AFTER UPDATE
  AS
  BEGIN
  SET NOCOUNT ON;
  INSERT INTO InventoryTransactions(ProductID,QuantityChanged,TransactionType,Time_stamp)
  SELECT i.ProductID,i.QuantityInstock - d.QuantityInStock,'Stock Update',GETDATE()
  FROM inserted i
  JOIN deleted d ON i.ProductID = d.ProductID
  WHERE i.QuantityInStock<>d.QuantityInStock;
  END;
  Go

  CREATE TRIGGER ON_Insert_Product_LogNewProduct
  ON 
  Product
  After INSERT
  AS
  BEGIN 
  SET NOCOUNT ON;
  INSERT INTO InventoryTransactions(ProductID, QuantityChanged,TransactionType,Time_stamp)
  SELECT ProductID, QuantityInStock, 'New Product Added', GETDATE()
  FROM inserted;
  END;
  Go


  CREATE TRIGGER OnShipmentArrival_UpdateStock
  ON ShippingDetails 
  AFTER INSERT
  AS 
  BEGIN 
  SET NOCOUNT ON;
  
  UPDATE P
  SET P.QuantityInStock = P.QuantityInStock + it.QuantityChanged
  FROM Product P
  INNER JOIN InventoryTransactionS it ON P.ProductID = it.ProductID
  INNER JOIN inserted s ON it.TransactionID = s.TransactionID;
  END;
  Go



  CREATE TRIGGER PreventNegativeStock
  ON Product
  INSTEAD OF UPDATE
  AS
  BEGIN 
  SET NOCOUNT ON;
  IF EXISTS(SELECT * FROM inserted i WHERE i.QuantityInStock < 0 )
  BEGIN RAISERROR('Stock Cannot be Negative!!',16,1);
  END 
  ELSE
  BEGIN 
  UPDATE Product
  SET QuantityInStock = i.QuantityInStock
  FROM Product P
  JOIN inserted i ON P.ProductID = i.ProductID;
  END
  END;
  Go