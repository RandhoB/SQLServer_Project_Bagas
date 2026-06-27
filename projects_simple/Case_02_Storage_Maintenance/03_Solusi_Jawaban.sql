-- =======================================================================
-- KUNCI JAWABAN CASE 2: STORAGE MAINTENANCE (SHRINK LOG)
-- =======================================================================
USE LogBengkakDB;
GO

-- ---------------------------------------------------------
-- LANGKAH 1: Analisa Ruang Penyimpanan Log
-- ---------------------------------------------------------
DBCC SQLPERF(LOGSPACE);
GO

-- ---------------------------------------------------------
-- LANGKAH 2: Penyelamatan Darurat Shrink Log
-- Dalam kondisi darurat dan data log belum tentu dipakai (atau sudah terbackup), 
-- cara tergokil DBA adalah mengubah recovery model sementara.
-- ---------------------------------------------------------

-- A. Ubah ke SIMPLE agar SQL Server mengosongkan Log secara internal
ALTER DATABASE LogBengkakDB SET RECOVERY SIMPLE;
GO

-- B. Lakukan Shrink File log ke ukuran minimal (misal 10 MB)
DBCC SHRINKFILE (N'LogBengkakDB_log', 10);
GO

-- C. Kembalikan ke FULL model (Sangat penting agar bisa melakukan Point-in-Time recovery ke depannya)
ALTER DATABASE LogBengkakDB SET RECOVERY FULL;
GO

-- ---------------------------------------------------------
-- LANGKAH 3 (Ekspektasi): Mengatur Maintenance Plan
-- (Sebagai DBA, setelah ini Anda wajib mengatur SQL Server Agent Job 
-- untuk menjalankan perintah BACKUP LOG LogBengkakDB TO DISK = '...' setiap jam).
-- ---------------------------------------------------------
