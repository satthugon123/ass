-- PizzaStore Database Creation Script for SQL Server
-- Run this script to create the database and tables with sample data

-- Create Database
CREATE DATABASE PizzaStore;
GO

USE PizzaStore;
GO

-- Create Account table
CREATE TABLE Account (
    AccountID NVARCHAR(50) PRIMARY KEY,
    UserName NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(255) NOT NULL,
    Type INT NOT NULL CHECK (Type IN (1, 2)) -- 1 = Staff, 2 = Normal User
);

-- Create Categories table
CREATE TABLE Categories (
    CategoryID NVARCHAR(50) PRIMARY KEY,
    CategoryName NVARCHAR(255) NOT NULL,
    Description NTEXT
);

-- Create Suppliers table
CREATE TABLE Suppliers (
    SupplierID NVARCHAR(50) PRIMARY KEY,
    CompanyName NVARCHAR(255) NOT NULL,
    Address NVARCHAR(500),
    Phone NVARCHAR(50)
);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID NVARCHAR(50) PRIMARY KEY,
    Password NVARCHAR(255) NOT NULL,
    ContactName NVARCHAR(255) NOT NULL,
    Address NVARCHAR(500),
    Phone NVARCHAR(50)
);

-- Create Products table
CREATE TABLE Products (
    ProductID NVARCHAR(50) PRIMARY KEY,
    ProductName NVARCHAR(255) NOT NULL,
    SupplierID NVARCHAR(50),
    CategoryID NVARCHAR(50),
    QuantityPerUnit INT DEFAULT 1,
    UnitPrice DECIMAL(10,2) NOT NULL,
    ProductImage NVARCHAR(500),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID NVARCHAR(50) PRIMARY KEY,
    CustomerID NVARCHAR(50),
    OrderDate DATETIME DEFAULT GETDATE(),
    RequiredDate DATETIME,
    ShippedDate DATETIME,
    Freight DECIMAL(10,2) DEFAULT 0,
    ShipAddress NVARCHAR(500),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    OrderID NVARCHAR(50),
    ProductID NVARCHAR(50),
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL DEFAULT 1,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample data

-- Insert Account data
INSERT INTO Account (AccountID, UserName, Password, FullName, Type) VALUES
('ACC001', 'admin', 'admin', 'Administrator', 1),
('ACC002', 'staff1', 'staff123', 'John Smith', 1),
('ACC003', 'user', 'user', 'Jane Doe', 2),
('ACC004', 'customer1', 'cust123', 'Mike Wilson', 2),
('ACC005', 'customer2', 'cust456', 'Sarah Johnson', 2);

-- Insert Categories data
INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
('CAT001', 'Standard', 'Our classic pizza selection with traditional toppings'),
('CAT002', 'Premium', 'Gourmet pizzas with premium ingredients'),
('CAT003', 'Vegetarian', 'Delicious vegetarian options'),
('CAT004', 'Specialties', 'Chef special pizzas with unique combinations'),
('CAT005', 'Vegan', 'Plant-based pizzas for vegan customers');

-- Insert Suppliers data
INSERT INTO Suppliers (SupplierID, CompanyName, Address, Phone) VALUES
('SUP001', 'Italian Food Imports', '123 Little Italy St, New York, NY', '555-0101'),
('SUP002', 'Fresh Produce Co.', '456 Farm Road, California, CA', '555-0102'),
('SUP003', 'Cheese Masters Ltd.', '789 Dairy Lane, Wisconsin, WI', '555-0103'),
('SUP004', 'Meat & More', '321 Butcher Block Ave, Texas, TX', '555-0104'),
('SUP005', 'Organic Herbs Inc.', '654 Green Valley, Oregon, OR', '555-0105');

-- Insert Customers data
INSERT INTO Customers (CustomerID, Password, ContactName, Address, Phone) VALUES
('CUST001', 'pass123', 'Alice Brown', '123 Main St, Anytown, USA', '555-1001'),
('CUST002', 'pass456', 'Bob Green', '456 Oak Ave, Somewhere, USA', '555-1002'),
('CUST003', 'pass789', 'Charlie White', '789 Pine St, Nowhere, USA', '555-1003'),
('CUST004', 'passabc', 'Diana Black', '321 Elm St, Everywhere, USA', '555-1004'),
('CUST005', 'passdef', 'Eva Grey', '654 Maple Ave, Anywhere, USA', '555-1005');

-- Insert Products data (Pizzas)
INSERT INTO Products (ProductID, ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice, ProductImage) VALUES
('PIZZA001', 'Margherita', 'SUP001', 'CAT001', 2, 15.99, 'images/margherita.jpg'),
('PIZZA002', 'Pepperoni', 'SUP004', 'CAT001', 2, 17.99, 'images/pepperoni.jpg'),
('PIZZA003', 'Hawaiian', 'SUP002', 'CAT001', 2, 18.99, 'images/hawaiian.jpg'),
('PIZZA004', 'Quattro Stagioni', 'SUP001', 'CAT002', 3, 22.99, 'images/quattro-stagioni.jpg'),
('PIZZA005', 'Vegetarian Supreme', 'SUP002', 'CAT003', 2, 19.99, 'images/vegetarian-supreme.jpg'),
('PIZZA006', 'Meat Lovers', 'SUP004', 'CAT002', 3, 24.99, 'images/meat-lovers.jpg'),
('PIZZA007', 'BBQ Chicken', 'SUP004', 'CAT002', 2, 21.99, 'images/bbq-chicken.jpg'),
('PIZZA008', 'Mushroom & Truffle', 'SUP005', 'CAT002', 2, 26.99, 'images/mushroom-truffle.jpg'),
('PIZZA009', 'Vegan Delight', 'SUP005', 'CAT005', 2, 20.99, 'images/vegan-delight.jpg'),
('PIZZA010', 'Spicy Salami', 'SUP004', 'CAT004', 2, 19.99, 'images/spicy-salami.jpg'),
('PIZZA011', 'Capricciosa', 'SUP001', 'CAT001', 2, 18.99, 'Pizza_capricciosa.jpg'),
('PIZZA012', 'Seafood Special', 'SUP001', 'CAT002', 3, 28.99, 'images/seafood-special.jpg');

-- Insert sample Orders
INSERT INTO Orders (OrderID, CustomerID, OrderDate, RequiredDate, ShippedDate, Freight, ShipAddress) VALUES
('ORD001', 'CUST001', '2024-01-15 12:30:00', '2024-01-15 13:30:00', '2024-01-15 13:15:00', 5.99, '123 Main St, Anytown, USA'),
('ORD002', 'CUST002', '2024-01-16 18:45:00', '2024-01-16 19:45:00', '2024-01-16 19:30:00', 7.99, '456 Oak Ave, Somewhere, USA'),
('ORD003', 'CUST003', '2024-01-17 20:15:00', '2024-01-17 21:15:00', NULL, 6.99, '789 Pine St, Nowhere, USA'),
('ORD004', 'CUST001', '2024-01-18 14:00:00', '2024-01-18 15:00:00', '2024-01-18 14:45:00', 8.99, '123 Main St, Anytown, USA'),
('ORD005', 'CUST004', '2024-01-19 19:30:00', '2024-01-19 20:30:00', '2024-01-19 20:15:00', 5.99, '321 Elm St, Everywhere, USA');

-- Insert sample Order Details
INSERT INTO OrderDetails (OrderID, ProductID, UnitPrice, Quantity) VALUES
('ORD001', 'PIZZA001', 15.99, 1),
('ORD001', 'PIZZA002', 17.99, 1),
('ORD002', 'PIZZA003', 18.99, 2),
('ORD002', 'PIZZA005', 19.99, 1),
('ORD003', 'PIZZA006', 24.99, 1),
('ORD003', 'PIZZA007', 21.99, 1),
('ORD004', 'PIZZA001', 15.99, 2),
('ORD004', 'PIZZA008', 26.99, 1),
('ORD005', 'PIZZA009', 20.99, 1),
('ORD005', 'PIZZA010', 19.99, 2);

-- Create indexes for better performance
CREATE INDEX IX_Products_CategoryID ON Products(CategoryID);
CREATE INDEX IX_Products_SupplierID ON Products(SupplierID);
CREATE INDEX IX_Orders_CustomerID ON Orders(CustomerID);
CREATE INDEX IX_Orders_OrderDate ON Orders(OrderDate);
CREATE INDEX IX_OrderDetails_ProductID ON OrderDetails(ProductID);

-- Create views for common queries

-- View for Product details with Category and Supplier names
CREATE VIEW vw_ProductDetails AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.UnitPrice,
    p.QuantityPerUnit,
    p.ProductImage,
    c.CategoryName,
    s.CompanyName as SupplierName
FROM Products p
LEFT JOIN Categories c ON p.CategoryID = c.CategoryID
LEFT JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- View for Order summary
CREATE VIEW vw_OrderSummary AS
SELECT 
    o.OrderID,
    o.CustomerID,
    c.ContactName,
    o.OrderDate,
    o.RequiredDate,
    o.ShippedDate,
    o.Freight,
    SUM(od.UnitPrice * od.Quantity) as SubTotal,
    SUM(od.UnitPrice * od.Quantity) + o.Freight as Total
FROM Orders o
LEFT JOIN Customers c ON o.CustomerID = c.CustomerID
LEFT JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.OrderID, o.CustomerID, c.ContactName, o.OrderDate, o.RequiredDate, o.ShippedDate, o.Freight;

-- Stored procedure for sales report
CREATE PROCEDURE sp_GetSalesReport
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(od.Quantity) as TotalQuantity,
        SUM(od.UnitPrice * od.Quantity) as TotalSales,
        COUNT(DISTINCT o.OrderID) as NumberOfOrders
    FROM Orders o
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    INNER JOIN Products p ON od.ProductID = p.ProductID
    WHERE o.OrderDate BETWEEN @StartDate AND @EndDate
    GROUP BY p.ProductID, p.ProductName
    ORDER BY TotalSales DESC;
END;

PRINT 'PizzaStore database created successfully with sample data!';
PRINT 'You can now connect your Java application to this database.';
PRINT 'Default admin credentials: admin/admin';
PRINT 'Default user credentials: user/user';