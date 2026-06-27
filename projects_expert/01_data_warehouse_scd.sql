-- ====================================================================
-- Project 1: Data Warehouse - Star Schema & SCD Type 2
-- Topik: Surrogate Keys, Slowly Changing Dimensions
-- ====================================================================

-- 1. SETUP: Membuat Tabel Dimensi dengan Surrogate Key & Atribut SCD
CREATE TABLE DimCustomer (
    CustomerKey INT IDENTITY(1,1) PRIMARY KEY, -- Surrogate Key
    CustomerID INT NOT NULL,                   -- Business/Natural Key
    CustomerName VARCHAR(100),
    City VARCHAR(100),
    -- Kolom untuk SCD Type 2
    EffectiveDate DATE NOT NULL,
    EndDate DATE NULL,
    IsCurrent BIT NOT NULL DEFAULT 1
);

-- Membuat Tabel Fakta
CREATE TABLE FactSales (
    SaleKey INT IDENTITY(1,1) PRIMARY KEY,
    CustomerKey INT FOREIGN KEY REFERENCES DimCustomer(CustomerKey),
    SaleDate DATE,
    Amount DECIMAL(18,2)
);

-- 2. DML: Insert Data Awal
INSERT INTO DimCustomer (CustomerID, CustomerName, City, EffectiveDate)
VALUES (101, 'Budi Santoso', 'Jakarta', '2023-01-01');

-- Mendapatkan CustomerKey yang aktif untuk transaksi
DECLARE @CustKey INT = (SELECT CustomerKey FROM DimCustomer WHERE CustomerID = 101 AND IsCurrent = 1);

INSERT INTO FactSales (CustomerKey, SaleDate, Amount)
VALUES (@CustKey, '2023-02-15', 500000);

-- 3. SKENARIO PERUBAHAN: Pelanggan Pindah Kota (SCD Type 2)
-- Budi pindah dari Jakarta ke Bandung pada tanggal 2023-06-01

-- Langkah A: Non-aktifkan record lama
UPDATE DimCustomer
SET 
    EndDate = '2023-05-31',
    IsCurrent = 0
WHERE CustomerID = 101 AND IsCurrent = 1;

-- Langkah B: Insert record baru
INSERT INTO DimCustomer (CustomerID, CustomerName, City, EffectiveDate)
VALUES (101, 'Budi Santoso', 'Bandung', '2023-06-01');

-- Transaksi baru setelah pindah
SET @CustKey = (SELECT CustomerKey FROM DimCustomer WHERE CustomerID = 101 AND IsCurrent = 1);
INSERT INTO FactSales (CustomerKey, SaleDate, Amount)
VALUES (@CustKey, '2023-07-10', 750000);

-- 4. ANALISA HASIL
SELECT * FROM DimCustomer;
SELECT 
    f.SaleDate, c.CustomerName, c.City, f.Amount
FROM FactSales f
JOIN DimCustomer c ON f.CustomerKey = c.CustomerKey;
