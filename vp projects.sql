-- Create the InventoryMS Database
CREATE DATABASE InventoryManagementSystems;

-- Use the InventoryMS Database
USE InventoryManagementSystems;

-- Table: Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100) NOT NULL,            
    ProductSKU NVARCHAR(50) UNIQUE NOT NULL,       
    ProductCategory NVARCHAR(50) NULL,             
    ProductQuantity INT DEFAULT 0,                 
    UnitPrice DECIMAL(10,2),                       
    ProductBarcode NVARCHAR(50) NULL,              
    CreatedAt DATETIME DEFAULT GETDATE(),          
    UpdatedAt DATETIME DEFAULT GETDATE()           
);
-- Insert data into Products
INSERT INTO Products (ProductName, ProductSKU, ProductCategory, ProductQuantity, UnitPrice, ProductBarcode)
VALUES 
('Laptop', 'SKU001', 'Electronics', 50, 1200.00, '123456789012'),
('Smartphone', 'SKU002', 'Electronics', 80, 800.00, '223456789012'),
('Tablet', 'SKU003', 'Electronics', 30, 600.00, '323456789012'),
('Printer', 'SKU004', 'Office', 20, 200.00, '423456789012'),
('Desk Chair', 'SKU005', 'Furniture', 15, 150.00, '523456789012'),
('Bookshelf', 'SKU006', 'Furniture', 10, 100.00, '623456789012'),
('Headphones', 'SKU007', 'Accessories', 40, 50.00, '723456789012'),
('Monitor', 'SKU008', 'Electronics', 25, 300.00, '823456789012'),
('Keyboard', 'SKU009', 'Accessories', 60, 20.00, '923456789012'),
('Mouse', 'SKU010', 'Accessories', 70, 15.00, '1023456789012');
select * from Products;


-- Table: Suppliers
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(100) NOT NULL,      
    SupplierContact NVARCHAR(100) NULL,           
    SupplierPhone NVARCHAR(15) NULL,              
    SupplierEmail NVARCHAR(100) NULL,             
    SupplierAddress NVARCHAR(255) NULL            
);

-- Insert data into Suppliers
INSERT INTO Suppliers (SupplierName, SupplierContact, SupplierPhone, SupplierEmail, SupplierAddress)
VALUES 
('Tech Supplies Co.', 'John Smith', '555-1234', 'john@techsupplies.com', '123 Tech Street'),
('Office Depot', 'Jane Doe', '555-5678', 'jane@officedepot.com', '456 Office Lane'),
('Furniture World', 'Mike Ross', '555-4321', 'mike@furnitureworld.com', '789 Furniture Ave'),
('Gadget Hub', 'Sara Lee', '555-8765', 'sara@gadgethub.com', '101 Gadget Blvd'),
('ElectroMart', 'Paul Brown', '555-6789', 'paul@electromart.com', '202 Electro Rd'),
('Home Store', 'Nina Perez', '555-1111', 'nina@homestore.com', '303 Home Dr'),
('Media Center', 'Tom Green', '555-2222', 'tom@mediacenter.com', '404 Media Way'),
('Warehouse Supplies', 'Amy Blue', '555-3333', 'amy@warehousesupplies.com', '505 Warehouse St'),
('TechMart', 'Chris Black', '555-4444', 'chris@techmart.com', '606 TechMart Rd'),
('MegaMart', 'Linda White', '555-5555', 'linda@megamart.com', '707 MegaMart Blvd');

select * from Suppliers;
-- Table: Purchase Orders
CREATE TABLE PurchaseOrders (
    PurchaseOrderID INT PRIMARY KEY IDENTITY(1,1), 
    SupplierID INT,                                
    OrderDate DATETIME DEFAULT GETDATE(),          
    OrderStatus NVARCHAR(20) CHECK (OrderStatus IN ('Pending', 'Completed', 'Cancelled')),
    TotalAmount DECIMAL(10,2) NULL,                
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);
INSERT INTO PurchaseOrders (SupplierID, OrderStatus, TotalAmount)
VALUES 
(1, 'Pending', 6000.00),
(2, 'Completed', 2000.00),
(3, 'Cancelled', NULL),
(4, 'Pending', 1500.00),
(5, 'Completed', 800.00),
(6, 'Pending', 1200.00),
(7, 'Completed', 3000.00),
(8, 'Cancelled', NULL),
(9, 'Pending', 4000.00),
(10, 'Completed', 2500.00);

select * from PurchaseOrders; 
-- Table: Purchase Order Details
CREATE TABLE PurchaseOrderDetails (
    DetailID INT PRIMARY KEY IDENTITY(1,1), 
    PurchaseOrderID INT,                     
    ProductID INT,                          
    Quantity INT NOT NULL,                  
    PricePerUnit DECIMAL(10,2) NOT NULL,    
    FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrders(PurchaseOrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO PurchaseOrderDetails (PurchaseOrderID, ProductID, Quantity, PricePerUnit)
VALUES 
(1, 1, 10, 1200.00),
(2, 2, 20, 800.00),
(3, 3, 15, 600.00),
(4, 4, 5, 200.00),
(5, 5, 10, 150.00),
(6, 6, 20, 100.00),
(7, 7, 30, 50.00),
(8, 8, 10, 300.00),
(9, 9, 40, 20.00),
(10, 10, 50, 15.00);
select * from PurchaseOrderDetails;


-- Table: Sales Orders
CREATE TABLE SalesOrders (
    SalesOrderID INT PRIMARY KEY IDENTITY(1,1), 
    CustomerName NVARCHAR(100) NULL,            
    OrderDate DATETIME DEFAULT GETDATE(),       
    OrderStatus NVARCHAR(20) CHECK (OrderStatus IN ('Pending', 'Shipped', 'Cancelled')), 
    TotalAmount DECIMAL(10,2) NULL              
);
INSERT INTO SalesOrders (CustomerName, OrderStatus, TotalAmount)
VALUES 
('Alice', 'Pending', 500.00),
('Bob', 'Shipped', 800.00),
('Charlie', 'Cancelled', NULL),
('Diana', 'Pending', 1200.00),
('Edward', 'Shipped', 200.00),
('Fiona', 'Pending', 1500.00),
('George', 'Shipped', 700.00),
('Hannah', 'Cancelled', NULL),
('Ivan', 'Pending', 400.00),
('Julia', 'Shipped', 1000.00);
select * from SalesOrders;

-- Table: Sales Order Details
CREATE TABLE SalesOrderDetails (
    DetailID INT PRIMARY KEY IDENTITY(1,1), 
    SalesOrderID INT,                       
    ProductID INT,                          
    Quantity INT NOT NULL,                  
    PricePerUnit DECIMAL(10,2) NOT NULL,    
    FOREIGN KEY (SalesOrderID) REFERENCES SalesOrders(SalesOrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO SalesOrderDetails (SalesOrderID, ProductID, Quantity, PricePerUnit)
VALUES 
(1, 1, 2, 1200.00),
(2, 2, 1, 800.00),
(3, 3, 3, 600.00),
(4, 4, 4, 200.00),
(5, 5, 5, 150.00),
(6, 6, 2, 100.00),
(7, 7, 3, 50.00),
(8, 8, 1, 300.00),
(9, 9, 4, 20.00),
(10, 10, 5, 15.00);

select * from SalesOrderDetails;
-- Table: Stock Movements
CREATE TABLE StockMovements (
    MovementID INT PRIMARY KEY IDENTITY(1,1),                 
    ProductID INT,                                            
    MovementType NVARCHAR(20) CHECK (MovementType IN ('IN', 'OUT', 'ADJUSTMENT')),
    Quantity INT NOT NULL,                                    
    MovementDate DATETIME DEFAULT GETDATE(),                 
    MovementDescription NVARCHAR(255) NULL,                  
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
INSERT INTO StockMovements (ProductID, MovementType, Quantity, MovementDate, MovementDescription)
VALUES 
(1, 'IN', 50, '2024-11-15', 'Initial stock entry'),
(2, 'IN', 30, '2024-11-14', 'Supplier restock'),
(3, 'OUT', 20, '2024-11-13', 'Customer order'),
(4, 'IN', 10, '2024-11-12', 'Supplier restock'),
(5, 'OUT', 5, '2024-11-11', 'Damaged stock'),
(6, 'IN', 60, '2024-11-10', 'Bulk stock delivery'),
(7, 'OUT', 25, '2024-11-09', 'Customer order'),
(8, 'IN', 40, '2024-11-08', 'Supplier restock'),
(9, 'OUT', 10, '2024-11-07', 'Branch transfer'),
(10, 'IN', 80, '2024-11-06', 'Bulk delivery');

select * from StockMovements;
-- Table: Users
CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY(1,1),                     
    Username NVARCHAR(50) UNIQUE NOT NULL,                     
    PasswordHash NVARCHAR(255) NOT NULL,                       
    UserRole NVARCHAR(20) CHECK (UserRole IN ('Admin', 'Manager', 'Staff')), 
    CreatedAt DATETIME DEFAULT GETDATE()                      
);
INSERT INTO Users (Username, PasswordHash, UserRole)
VALUES 
('admin', '5f4dcc3b5aa765d61d8327deb882cf99', 'Admin'),
('manager1', '202cb962ac59075b964b07152d234b70', 'Manager'),
('manager2', '098f6bcd4621d373cade4e832627b4f6', 'Manager'),
('staff1', 'e99a18c428cb38d5f260853678922e03', 'Staff'),
('staff2', 'ab56b4d92b40713acc5af89985d4b786', 'Staff'),
('staff3', '6c569aabbf7775ef8fc570e228c16b98', 'Staff'),
('staff4', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'Staff'),
('staff5', '5d41402abc4b2a76b9719d911017c592', 'Staff'),
('manager3', '7c6a180b36896a0a8c02787eeafb0e4c', 'Manager'),
('manager4', '8d9c307cb7f3c4a32822a51922d1ceaa', 'Manager');

select * from Users;


-- Table: Audit Logs
CREATE TABLE AuditLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),                      
    UserID INT,                                               
    Action NVARCHAR(100) NOT NULL,                           
    AffectedTable NVARCHAR(50) NULL,
    ActionTime DATETIME DEFAULT GETDATE(),                    
    ActionDescription NVARCHAR(255) NULL,                    
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
INSERT INTO AuditLogs (UserID, Action, AffectedTable, ActionDescription)
VALUES 
(1, 'INSERT', 'Products', 'Added new product entry'),
(2, 'UPDATE', 'Products', 'Updated product price'),
(3, 'DELETE', 'Suppliers', 'Removed inactive supplier'),
(4, 'INSERT', 'Categories', 'Added new category'),
(5, 'UPDATE', 'StockMovements', 'Stock adjustment'),
(6, 'DELETE', 'SalesOrders', 'Cancelled order'),
(7, 'INSERT', 'PurchaseOrders', 'Created new order'),
(8, 'UPDATE', 'Users', 'Updated user role'),
(9, 'DELETE', 'Products', 'Removed old product'),
(10, 'INSERT', 'AuditLogs', 'System log recorded');
 
 select * from AuditLogs ;

-- Table: Categories
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),                  
    CategoryName NVARCHAR(100) UNIQUE NOT NULL,               
    CategoryDescription NVARCHAR(255) NULL                   
);
INSERT INTO Categories (CategoryName, CategoryDescription)
VALUES 
('Electronics', 'Devices like laptops, phones, and monitors'),
('Office', 'Office supplies and equipment'),
('Furniture', 'Chairs, tables, and other furniture'),
('Accessories', 'Complementary items like headphones and keyboards'),
('Stationery', 'Paper, pens, and related supplies'),
('Kitchenware', 'Utensils and kitchen items'),
('Sports', 'Equipment and accessories for sports'),
('Books', 'Various genres of books and publications'),
('Clothing', 'Apparel and garments'),
('Toys', 'Items for kids and play');

select * from Categories;
 

