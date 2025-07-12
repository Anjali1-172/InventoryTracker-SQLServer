use [Inventory Control system] ];

Create Table SupplierS(
SupplierID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
SupplierName varchar(20),
Contact varchar(20),
Address_ varchar(50)
);
INSERT INTO SupplierS values(1, 'NovaTech', +919977397,'Sector-15 near IGM AirPort'); 
INSERT INTO SupplierS values(2, 'GadgetFlow', +919977377,'Clock Point, Old City Road Punjab');
INSERT INTO SupplierS values(3, 'SmartWork', +9199788397,'Sector-60, newMarket , Hyderabad'); 
INSERT INTO SupplierS values(4, 'OfficeHub', +919977897,'Sangam Complex, Haryana'); 
INSERT INTO SupplierS values(5, 'ITOffice', +919944397,'PinkCity Road, Rajasthan'); 
INSERT INTO SupplierS values(6, 'TechTook', +919877397,'Sector-34, RamRaj Chowk, near New AirPort'); 
 

CREATE TABLE Product(
ProductID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
ProductName varchar(30),
Category varchar(40),
SupplierID int FOREIGN KEY REFERENCES Supplier(SupplierID),
Price Float,
QuantityInStock int
);
INSERT INTO Product( ProductName,Category,SupplierID,Price,QuantityInStock) values
('WirelessMouse','Computer Accessories', 1 ,1500, 300),
('Bluetooth Speaker','Gadgets', 3 ,4000, 200),
('Smart Plug','Gadgets', 3 ,400, 150),
('Notebook Pack','Office Supplies', 2 ,250, 250),
('Desk Organiser','Office Supplies', 2 ,899, 177),
('Monitor Riser','Ergonomic Tools', 4 ,250, 400),
('WhiteBoard Markers','Office Supplies', 4 ,149, 600),
('Smart KeyBoard','Computer Accessories', 6 ,3000, 400),
('cable Board','Computer Accessories', 6 ,499, 350);

CREATE TABLE InventoryTransactions (
TransactionID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
ProductID int FOREIGN KEY REFERENCES Products(ProductID),
QuantityChanged int,
TransactionType varchar(15),
Time_stamp varchar(20)
);
INSERT INTO InventoryTransactions (ProductID,QuantityChanged,TransactionType,Time_stamp)values
(101,-20,'Sale','2025-06-09'),
(105,+200,'Restock','2025-06-12'),
(103,-18,'Sale','2025-07-20'),
(107,-2,'Sale','2025-07-23'),
(104,+230,'Restock','2025-04-02'),
(102,+34,'Restock','2025-06-04'),
(109,-20,'Sale','2025-05-09');

CREATE TABLE ShippingDetails (
ShippingID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
TransactionID int FOREIGN KEY REFERENCES InventoryTransactions(TransactionID),
ShippingDate DateTime,
CarrierName Varchar(20),
TrackingNumber int,
DeliveryStatus Varchar(15)
);
INSERT INTO ShippingDetails(TransactionID, ShippingDate, CarrierName, TrackingNumber, DeliveryStatus)
SELECT v.TransactionID, v.ShippingDate, v.CarrierName, v.TrackingNumber, v.DeliveryStatus
FROM (VALUES
  (2,'2025-06-10 10:30:00','FedEx',1234565,'Delivered'),
  (1,'2025-06-07 11:30:00','BlueDart',2234565,'Delivered'),
  (3,'2025-05-10 10:00:00','ShipRocket',5234565,'Pending'),
  (4,'2025-06-25 10:40:00','AmazonDelivery',5634560,'Delivered'),
  (5,'2025-05-31 10:30:00','VolvoFast',7637568,'In Transit'),
  (6,'2025-05-21 09:30:00','BlueDart',6734565,'Delivered'),
  (7,'2025-05-23 09:30:00','FedEx',8234580,'Returned')
) AS v(TransactionID, ShippingDate, CarrierName, TrackingNumber, DeliveryStatus)
WHERE EXISTS (
  SELECT 1 FROM InventoryTransactions it
  WHERE it.TransactionID = v.TransactionID
);



