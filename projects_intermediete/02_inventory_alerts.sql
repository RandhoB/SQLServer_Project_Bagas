-- ====================================================================
-- Project 2: Inventory Management & Auto-Reorder Alerts
-- Topik: Stored Procedures, Triggers, Transactions
-- ====================================================================

-- 1. SETUP
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    StockQuantity INT,
    ReorderLevel INT
);

CREATE TABLE ReorderAlerts (
    AlertID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    AlertDate DATETIME DEFAULT GETDATE(),
    Message VARCHAR(255)
);

INSERT INTO Inventory (ProductID, ProductName, StockQuantity, ReorderLevel) VALUES
(1, 'Laptop', 50, 10),
(2, 'Mouse', 100, 20),
(3, 'Keyboard', 15, 15);

GO

-- 2. SOLUSI: TRIGGER
-- Trigger untuk mengecek stok setelah ada perubahan (UPDATE)
CREATE TRIGGER trg_CheckStock
ON Inventory
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    INSERT INTO ReorderAlerts (ProductID, Message)
    SELECT 
        i.ProductID, 
        'Stok untuk ' + i.ProductName + ' berada di bawah batas aman (' + CAST(i.StockQuantity AS VARCHAR) + ')'
    FROM inserted i
    WHERE i.StockQuantity < i.ReorderLevel;
END;
GO

-- Mari kita tes trigger-nya dengan mengurangi stok Laptop
UPDATE Inventory 
SET StockQuantity = 5 
WHERE ProductID = 1;

-- Cek hasilnya
SELECT * FROM Inventory;
SELECT * FROM ReorderAlerts;
