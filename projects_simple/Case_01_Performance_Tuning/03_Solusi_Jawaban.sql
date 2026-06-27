-- =======================================================================
-- KUNCI JAWABAN CASE 1: PERFORMANCE TUNING
-- =======================================================================
USE TokoOnlineDB;
GO

-- ---------------------------------------------------------
-- TUGAS 1: Menambahkan Clustered Index (Primary Key)
-- Ini akan menyusun baris data secara berurutan di dalam disk
-- ---------------------------------------------------------
ALTER TABLE TransaksiPenjualan
ADD CONSTRAINT PK_TransaksiPenjualan PRIMARY KEY CLUSTERED (TransaksiID);
GO

-- ---------------------------------------------------------
-- TUGAS 2: Membuat Non-Clustered Index pada kolom pencarian
-- Query klien mencari berdasarkan StatusPesanan dan TanggalTransaksi
-- ---------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_TransaksiPenjualan_Status_Tanggal
ON TransaksiPenjualan (StatusPesanan, TanggalTransaksi);
GO

-- ---------------------------------------------------------
-- UJI COBA: 
-- Jalankan kembali query klien di bawah ini. Anda akan melihat 
-- "Logical Reads" turun drastis (dari puluhan ribu menjadi hanya hitungan jari), 
-- dan Execution Plan berubah menjadi "Index Seek".
-- ---------------------------------------------------------
SET STATISTICS IO ON;
SELECT * FROM TransaksiPenjualan
WHERE StatusPesanan = 'PENDING' 
  AND TanggalTransaksi >= '2024-01-01' 
  AND TanggalTransaksi <= '2024-12-31';
SET STATISTICS IO OFF;
GO
