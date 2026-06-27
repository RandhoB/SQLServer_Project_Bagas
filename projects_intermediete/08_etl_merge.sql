-- ====================================================================
-- Project 8: ETL Sinkronisasi Data Staging ke Production
-- Topik: MERGE Statement (Upsert)
-- ====================================================================

-- 1. SETUP
-- Tabel Production (Tabel Utama)
CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(18,2)
);
INSERT INTO DimProduct VALUES (1, 'Laptop', 1000), (2, 'Mouse', 20);

-- Tabel Staging (Data harian/mingguan baru yang masuk)
CREATE TABLE StgProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(18,2)
);
-- Skenario: Laptop harganya naik (Update), Keyboard adalah barang baru (Insert)
INSERT INTO StgProduct VALUES (1, 'Laptop Gaming', 1200), (3, 'Keyboard', 50);

-- 2. SOLUSI: Menggunakan MERGE
MERGE DimProduct AS target
USING StgProduct AS source
ON target.ProductID = source.ProductID

WHEN MATCHED THEN
    -- Jika ID cocok, lakukan UPDATE
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

WHEN NOT MATCHED BY TARGET THEN
    -- Jika ID ada di source tapi tidak ada di target, lakukan INSERT
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

-- Optional: Jika data di target tidak ada di source, kita bisa hapus/nonaktifkan
-- WHEN NOT MATCHED BY SOURCE THEN DELETE 

OUTPUT $action, inserted.*, deleted.*; -- Untuk melihat log aksi yang terjadi

-- Cek hasil akhirnya di Production
SELECT * FROM DimProduct;
