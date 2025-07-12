use [Inventory Control system];
go

-- Procedure to update stock in product table 
 CREATE PROCEDURE UpdateProductStock @ProductID INT, @QuantityChange INT 
  AS 
  BEGIN 
  UPDATE Product
  SET QuantityInStock = QuantityInStock + @QuantityChange
  WHERE ProductID = @ProductID
  END;
  Go

  -- Procedure to Add a product to the Database table.
  CREATE PROCEDURE AddNewProducts
  @ProductName VARCHAR(100),
  @Category VARCHAR(50),
  @Price DECIMAL(10,2),
  @QuantityInstock INT,
  @SupplierID INT
  AS
  BEGIN 
  INSERT INTO Product(ProductName,Category,Price,QuantityInStock,SupplierID)VALUES
  (@ProductName, @Category, @Price, @QuantityInstock,@SupplierID)
  END;
  Go

  -- testing 
  exec AddNewProducts
  @ProductName = 'bench',
  @Category = 'Office Accessories',
  @Price = 3000,
  @QuantityInStock = 200,
  @SupplierID = 5;
  go


  -- Procedure To process shipments 
  CREATE PROCEDURE ProcessShipment
  @ProductID INT,
  @QuantityReceived INT,
  @CarrierName VARCHAR(50),
  @TrackingNumber VARCHAR(50),
  @Status VARCHAR(20)
  AS
  BEGIN 
  --Update Stock
  UPDATE Product
  SET QuantityInStock = QuantityInStock + @QuantityReceived
  WHERE ProductID = @ProductID;

  --Log Shipment
  INSERT INTO ShippingDetails(TransactionID,ShippingDate, CarrierName,TrackingNumber, DeliveryStatus)
  VALUES (@ProductID,GETDATE(),@CarrierName,@TrackingNumber,@Status);
  END;
  Go

  --testing 
  exec ProcessShipment
  @ProductID = 9,
  @QuantityReceived = 50,
  @CarrierName = 'VolvoFast',
  @TrackingNumber = '4567383',
  @Status = 'In Transit';
  Go
