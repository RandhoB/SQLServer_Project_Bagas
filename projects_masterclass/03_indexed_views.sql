-- ====================================================================
-- Project 3: Indexed Views (Materialized Views)
-- Topik: WITH SCHEMABINDING, UNIQUE CLUSTERED INDEX
-- ====================================================================

-- 1. SETUP: Tabel Transaksi Besar
CREATE TABLE SalesHeader (
    InvoiceID INT IDENTITY(1,1) PRIMARY KEY,
    SaleDate DATE
);

CREATE TABLE SalesDetail (
    DetailID INT IDENTITY(1,1) PRIMARY KEY,
    InvoiceID INT,
    Qty INT,
    Price DECIMAL(18,2)
);

-- 2. MASALAH: Dashboard BI yang melambat
-- Kueri ini harus menghitung ulang jutaan baris setiap kali dashboard di-refresh
/*
SELECT sh.SaleDate, SUM(sd.Qty * sd.Price) AS TotalRevenue, COUNT_BIG(*) AS RecordCount
FROM SalesHeader sh
JOIN SalesDetail sd ON sh.InvoiceID = sd.InvoiceID
GROUP BY sh.SaleDate;
*/

-- 3. SOLUSI: INDEXED VIEW
-- Kita akan melakukan Pre-Aggregate (menyimpan hasil perhitungannya secara fisik di disk)

GO
-- Syarat 1: Harus menggunakan WITH SCHEMABINDING (tabel aslinya tidak boleh di-alter strukturnya)
-- Syarat 2: Jika ada GROUP BY, harus menyertakan COUNT_BIG(*)
CREATE VIEW vw_DailySalesSummary
WITH SCHEMABINDING
AS
SELECT 
    sh.SaleDate, 
    SUM(sd.Qty * sd.Price) AS TotalRevenue, 
    COUNT_BIG(*) AS RecordCount
FROM dbo.SalesHeader sh
JOIN dbo.SalesDetail sd ON sh.InvoiceID = sd.InvoiceID
GROUP BY sh.SaleDate;
GO

-- Syarat 3: Membuat UNIQUE CLUSTERED INDEX pada view tersebut
-- Sejak index ini dibuat, data agregasi ini TERSIMPAN FISIK di harddisk layaknya tabel.
-- Performa kueri dashboard akan melesat dari menit menjadi milidetik!
CREATE UNIQUE CLUSTERED INDEX CIX_vw_DailySalesSummary 
ON vw_DailySalesSummary(SaleDate);

-- Penggunaan:
-- SELECT * FROM vw_DailySalesSummary WITH (NOEXPAND); -- Hint NOEXPAND wajib di versi Standard Edition
