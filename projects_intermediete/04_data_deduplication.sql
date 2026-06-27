-- ====================================================================
-- Project 4: Data Deduplication & Data Cleansing
-- Topik: ROW_NUMBER(), CTEs, DELETE
-- ====================================================================

-- 1. SETUP
CREATE TABLE UserContacts (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Email VARCHAR(100),
    PhoneNumber VARCHAR(20),
    LastUpdated DATETIME
);

INSERT INTO UserContacts (Email, PhoneNumber, LastUpdated) VALUES
('agus@email.com', '081234', '2023-01-01'),
('agus@email.com', '081234', '2023-05-01'), -- Duplikat (update terbaru)
('bagas@email.com', '085555', '2023-02-01'),
('cinta@email.com', '089999', '2023-03-01'),
('bagas@email.com', '085555', '2023-06-01'), -- Duplikat (update terbaru)
('bagas@email.com', '085555', '2023-04-01'); -- Duplikat

-- 2. SOLUSI: Menghapus Duplikat
-- Kita ingin menyimpan data yang paling baru (LastUpdated terbesar) untuk setiap Email

-- Langkah 1: Cek datanya menggunakan CTE dan ROW_NUMBER
WITH DuplicateCTE AS (
    SELECT 
        ID, Email, PhoneNumber, LastUpdated,
        ROW_NUMBER() OVER(
            PARTITION BY Email 
            ORDER BY LastUpdated DESC
        ) AS RowNum
    FROM UserContacts
)
-- SELECT * FROM DuplicateCTE; -- (Uncomment untuk melihat hasilnya sebelum di-delete)

-- Langkah 2: Lakukan penghapusan baris yang RowNum > 1
DELETE FROM DuplicateCTE 
WHERE RowNum > 1;

-- Cek hasilnya, seharusnya hanya tersisa 1 record per Email (yang paling baru)
SELECT * FROM UserContacts;
