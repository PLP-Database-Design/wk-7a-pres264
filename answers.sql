-- Question 1: Transforming ProductDetail table to 1NF
-- Original table violates 1NF by storing multiple products in a single column
-- Solution: Split into separate rows for each product

-- First, create the normalized table structure
CREATE TABLE OrderProducts_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert the normalized data (one product per row)
INSERT INTO OrderProducts_1NF (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Question 2: Transforming OrderDetails table to 2NF
-- Original table has partial dependency (CustomerName depends only on OrderID)
-- Solution: Split into two tables - Orders and OrderItems

-- Create Orders table (contains customer information)
CREATE TABLE Orders_2NF (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table (contains product details)
CREATE TABLE OrderItems_2NF (
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders_2NF(OrderID)
);

-- Insert data into normalized tables
-- First insert into Orders table (one row per order)
INSERT INTO Orders_2NF (OrderID, CustomerName)
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Then insert into OrderItems table (all product items)
INSERT INTO OrderItems_2NF (OrderID, Product, Quantity)
SELECT OrderID, Product, Quantity
FROM OrderDetails;
