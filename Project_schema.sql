use [Inventory Control system] ];

Create Table SupplierS(
SupplierID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
SupplierName varchar(20),
Contact varchar(20),
Address_ varchar(50)
);

CREATE TABLE Product(
ProductID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
ProductName varchar(30),
Category varchar(40),
SupplierID int FOREIGN KEY REFERENCES Supplier(SupplierID),
Price Float,
QuantityInStock int
);

CREATE TABLE InventoryTransactions (
TransactionID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
ProductID int FOREIGN KEY REFERENCES Products(ProductID),
QuantityChanged int,
TransactionType varchar(15),
Time_stamp varchar(20)
);

CREATE TABLE ShippingDetails (
ShippingID int NOT NULL IDENTITY(1,1)PRIMARY KEY,
TransactionID int FOREIGN KEY REFERENCES InventoryTransactions(TransactionID),
ShippingDate DateTime,
CarrierName Varchar(20),
TrackingNumber int,
DeliveryStatus Varchar(15)
);