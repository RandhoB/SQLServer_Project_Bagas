-- ====================================================================
-- Project 2: Advanced Performance Tuning
-- Topik: Covering Index & Filtered Index
-- ====================================================================

-- 1. SETUP: Tabel dengan banyak data
CREATE TABLE BigTransactions (
    TxID INT IDENTITY(1,1) PRIMARY KEY, -- Clustered Index (Default)
    CustomerID INT,
    TxDate DATETIME,
    Amount DECIMAL(18,2),
    Status VARCHAR(20) -- 'Pending', 'Success', 'Failed'
);

-- Simulasi insert data (hanya contoh kecil, bayangkan ini jutaan baris)
INSERT INTO BigTransactions (CustomerID, TxDate, Amount, Status) VALUES
(1, '2023-01-01', 100, 'Success'),
(2, '2023-01-02', 200, 'Pending'),
(3, '2023-01-03', 300, 'Success'),
(1, '2023-01-04', 150, 'Failed'),
(4, '2023-01-05', 400, 'Pending');

-- 2. PROBLEM: Table Scan/Index Scan
-- Kueri di bawah akan menyebabkan lambat karena harus mengecek seluruh tabel
-- jika kita hanya butuh Amount untuk transaksi Pending.
-- (Bisa dilihat di Execution Plan 'Ctrl+M' di SSMS)
SELECT CustomerID, Amount 
FROM BigTransactions 
WHERE Status = 'Pending';

-- 3. SOLUSI A: Covering Index
-- Index biasa (hanya kolom Status), tetap akan menyebabkan 'Key Lookup'
-- Covering Index menyertakan (INCLUDE) kolom CustomerID dan Amount di level leaf.
CREATE NONCLUSTERED INDEX IX_BigTransactions_Status
ON BigTransactions (Status)
INCLUDE (CustomerID, Amount);

-- 4. SOLUSI B: Filtered Index (Paling optimal jika data 'Pending' sangat sedikit)
-- Filtered index berukuran sangat kecil dan cepat karena hanya menyimpan yang Pending
CREATE NONCLUSTERED INDEX FIX_BigTransactions_Pending
ON BigTransactions (CustomerID, Amount)
WHERE Status = 'Pending';

-- Jalankan kueri lagi, optimizer akan otomatis memilih index yang paling optimal
SELECT CustomerID, Amount 
FROM BigTransactions 
WHERE Status = 'Pending';
