-- ====================================================================
-- Project 2: Bulk Import & Export Data
-- Topik: BULK INSERT, OPENROWSET
-- ====================================================================

-- 1. SETUP: Tabel Tujuan
CREATE TABLE ImportedSales (
    SaleID INT,
    SaleDate DATE,
    Amount DECIMAL(18,2)
);

-- 2. SOLUSI 1: BULK INSERT (Untuk File Teks / CSV ukuran raksasa)
-- Ini adalah cara tercepat memasukkan jutaan baris data ke SQL Server.
-- Catatan: Path file di bawah harus bisa diakses oleh service SQL Server (bukan cuma user komputer).
/*
BULK INSERT ImportedSales
FROM 'C:\Data\SalesData.csv'
WITH (
    FIELDTERMINATOR = ',',  -- Pemisah kolom (Koma)
    ROWTERMINATOR = '\n',   -- Pemisah baris (Enter)
    FIRSTROW = 2,           -- Jika baris 1 adalah Header
    TABLOCK                 -- Table Lock untuk optimasi kecepatan insert massal
);
*/

-- 3. SOLUSI 2: OPENROWSET (Membaca file tanpa insert)
-- Sangat berguna jika Anda ingin mem-filter datanya (WHERE) sebelum di-insert.
/*
SELECT *
FROM OPENROWSET(
    BULK 'C:\Data\SalesData.csv',
    FORMATFILE = 'C:\Data\Format.xml' -- Jika butuh format file khusus
) AS DataFile;
*/

-- 4. EXPORT DATA MENGGUNAKAN bcp (Command Line)
-- Di dunia nyata, ekspor ke CSV biasanya dilakukan lewat CMD/Powershell menggunakan bcp utility
-- Contoh perintah CMD (Dijalankan di luar SQL Server):
-- bcp "SELECT * FROM DBName.dbo.ImportedSales" queryout "C:\Data\ExportedSales.csv" -c -t, -T -S ServerName
