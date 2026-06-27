-- ====================================================================
-- Project 3: Customer Churn & Retention Analysis
-- Topik: Date Functions, Left/Anti Joins
-- ====================================================================

-- 1. SETUP
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    JoinDate DATE
);

CREATE TABLE Transactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    TransactionDate DATE,
    Amount DECIMAL(18,2)
);

INSERT INTO Customers VALUES 
(1, 'Agus', '2022-01-01'), (2, 'Bagas', '2022-03-15'), (3, 'Cinta', '2023-01-10');

INSERT INTO Transactions (CustomerID, TransactionDate, Amount) VALUES
(1, '2023-05-10', 100), -- Agus aktif
(1, '2023-11-01', 150),
(2, '2022-12-05', 200); -- Bagas churn (tidak ada transaksi di 2023)
-- Cinta belum pernah transaksi sama sekali

-- 2. SOLUSI
-- Asumsikan tanggal saat ini adalah '2023-12-01'
-- Kita cari customer yang tidak ada transaksi dalam 6 bulan terakhir (sejak 2023-06-01)

DECLARE @CurrentDate DATE = '2023-12-01';
DECLARE @ThresholdDate DATE = DATEADD(MONTH, -6, @CurrentDate);

-- Menggunakan LEFT JOIN dan IS NULL (Anti-Join Pattern)
SELECT 
    c.CustomerID,
    c.CustomerName,
    MAX(t.TransactionDate) AS LastTransactionDate,
    DATEDIFF(MONTH, ISNULL(MAX(t.TransactionDate), c.JoinDate), @CurrentDate) AS MonthsSinceLastActivity,
    'Churned' AS Status
FROM Customers c
LEFT JOIN Transactions t ON c.CustomerID = t.CustomerID AND t.TransactionDate >= @ThresholdDate
WHERE t.TransactionID IS NULL
GROUP BY c.CustomerID, c.CustomerName, c.JoinDate;
