-- =======================================================================
-- KUNCI JAWABAN CASE 5: DATA MIGRATION & ETL (CLEANSING)
-- =======================================================================
USE MigrasiDataDB;
GO

-- Memasukkan data bersih ke Fact_Penjualan dengan teknik CLEANSING dalam T-SQL
INSERT INTO Fact_Penjualan (TanggalTransaksi, NamaPelanggan, TotalHarga)
SELECT 
    -- 1. Membersihkan Format TANGGAL
    CASE 
        -- Jika isinya teks 'NULL' atau Kosong, ganti dengan tanggal hari ini
        WHEN Tanggal = 'NULL' OR Tanggal = '' THEN GETDATE()
        -- Jika isinya pakai strip (Contoh: 24-02-2024), convert jadi Date format (DD-MM-YYYY)
        WHEN Tanggal LIKE '%-%' THEN TRY_CONVERT(DATE, Tanggal, 105) 
        -- Jika isinya pakai miring (Contoh: 2024/01/01), convert jadi format standar (YYYY/MM/DD)
        WHEN Tanggal LIKE '%/%' THEN TRY_CONVERT(DATE, Tanggal, 111) 
        -- Sisanya set hari ini
        ELSE GETDATE() 
    END AS TanggalBersih,

    -- 2. Mengambil Nama Pelanggan (Sudah Aman)
    Pelanggan,

    -- 3. Membersihkan Format UANG (Menghilangkan titik dan koma)
    CAST(
        REPLACE(
            REPLACE(
                -- Ubah teks 'NULL' menjadi angka '0'
                CASE WHEN TotalHarga = 'NULL' THEN '0' ELSE TotalHarga END, 
            '.', ''), -- Hapus titik (50.000 -> 50000)
        ',', '')      -- Hapus koma (100,000 -> 100000)
    AS DECIMAL(18,2)) AS HargaBersih

FROM Staging_DataExcel;
GO

-- ---------------------------------------------------------
-- HASIL PENGECEKAN:
-- ---------------------------------------------------------
SELECT * FROM Fact_Penjualan;
GO
-- Hasilnya harus bersih, tipe datanya sudah baku tanpa error!
