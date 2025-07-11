# InventoryTracker-SQLServer
# 🔎Project Overview
#
This Inventory Tracker is a backend database system designed using Microsoft SQL Server. It automates stock management, transaction logging, and shipment tracking. It's optimized for scalability and built to demonstrate real-world business operations using SQL procedures, triggers, and views.
#
Database Schema
Entities:
Products
Suppliers
InventoryTransactions
ShippingDetails
# 🔩Key Features
#
# Stored Procedures
UpdateProductStock: Automatically adjusts stock levels\
AddNewProduct: Adds new products into inventory\
ProcessShipment: Logs a shipment and updates stock
# Triggers
OnStockUpdate_LogTxn: Records every stock update\
OnInsert Product_LogNewProduct: Logs new product additions\
OnShipmentArrival_UpdateStock: Auto-updates stock when a shipment arrives
# Views
LowStockView: Lists products with stock below threshold\
RecentTransactions: Shows last 10 inventory transactions\
Inventory Snapshot: Combines product info with latest transaction\
PendingShipmentsView: Tracks undelivered shipments
