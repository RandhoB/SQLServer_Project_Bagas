-- ====================================================================
-- Project 6: Full-Text Search
-- Topik: CONTAINS, FREETEXT (Bukan LIKE)
-- ====================================================================

-- 1. SETUP (Hanya jalan jika komponen Full-Text Search di-install di SQL Server)
CREATE TABLE ProductsInfo (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100),
    Description NVARCHAR(MAX)
);

INSERT INTO ProductsInfo (ProductName, Description) VALUES 
('Laptop Pro', 'Laptop ringan cocok untuk bisnis dan gaming dengan prosesor kencang.'),
('Gaming Mouse', 'Mouse dengan DPI tinggi dan lampu RGB, enak untuk main game FPS.'),
('Office Chair', 'Kursi ergonomis, baik untuk kesehatan tulang belakang, cocok untuk kerja lama.');

-- 2. SETUP: Full-Text Catalog & Index (Dijalankan sekali oleh DBA)
/*
-- A. Buat Catalog (Wadah)
CREATE FULLTEXT CATALOG CatalogProduk AS DEFAULT;

-- B. Buat Index (Tentukan kolom mana yang bisa di-search dengan cepat)
CREATE FULLTEXT INDEX ON ProductsInfo (Description)
KEY INDEX PK__Products__B40CC6EDXXXXXX -- (Sesuaikan dengan nama PK aktual)
ON CatalogProduk;
*/

-- 3. MASALAH: LIKE lambat dan bodoh
-- 'LIKE' akan melakukan scan seluruh baris. Dan kalau user typo atau bahasanya diputar, tidak ketemu.
SELECT * FROM ProductsInfo WHERE Description LIKE '%gaming%'; 

-- 4. SOLUSI: Menggunakan CONTAINS (Pencarian Cerdas dan Cepat)
-- Hanya bekerja jika Full-Text Index sudah dibuat.
-- CONTAINS menggunakan index khusus sehingga tidak table scan.
/*
SELECT * 
FROM ProductsInfo 
WHERE CONTAINS(Description, 'gaming OR game');

-- Mencari kalimat dengan pendekatan infleksi (contoh bahasa inggris: run, ran, running akan ter-index)
SELECT * 
FROM ProductsInfo 
WHERE FREETEXT(Description, 'gaming');
*/
