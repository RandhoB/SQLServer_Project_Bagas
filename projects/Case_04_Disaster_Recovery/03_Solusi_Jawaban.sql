-- =======================================================================
-- KUNCI JAWABAN CASE 4: DISASTER RECOVERY (POINT-IN-TIME)
-- =======================================================================
-- PERINGATAN: Harus dijalankan berurutan. (Asumsi data sudah terhapus/DROP).
-- Pastikan tidak ada koneksi lain ke database DisasterDB (ubah koneksi di atas ke master terlebih dahulu).

USE master;
GO

-- ---------------------------------------------------------
-- LANGKAH 1: Tail-Log Backup (Menyelamatkan transaksi sisa yang belum terbackup)
-- ---------------------------------------------------------
BACKUP LOG DisasterDB 
TO DISK = '/var/opt/mssql/data/DisasterDB_TailLog.trn' 
WITH NORECOVERY, INIT;
GO
-- Setelah script ini, database akan masuk ke mode "Restoring..." (terkunci)

-- ---------------------------------------------------------
-- LANGKAH 2: Mulai Proses Restore (Urut: Full -> Log 1 -> Tail Log)
-- ---------------------------------------------------------
-- Restore Full Backup (Mode NORECOVERY agar bisa ditambah log lain)
RESTORE DATABASE DisasterDB 
FROM DISK = '/var/opt/mssql/data/DisasterDB_Full.bak' 
WITH NORECOVERY, REPLACE;
GO

-- Restore Log Backup pertama (Jam 09.00)
RESTORE LOG DisasterDB 
FROM DISK = '/var/opt/mssql/data/DisasterDB_Log1.trn' 
WITH NORECOVERY;
GO

-- ---------------------------------------------------------
-- LANGKAH 3: Puncak Ilmu DBA (Point in Time Recovery)
-- Memutar balik waktu tepat SEBELUM kejadian drop (10:04:59 pagi)
-- ---------------------------------------------------------
RESTORE LOG DisasterDB 
FROM DISK = '/var/opt/mssql/data/DisasterDB_TailLog.trn' 
WITH STOPAT = '2024-01-01 10:04:59', RECOVERY;
GO

-- ---------------------------------------------------------
-- PENGECEKAN:
-- Jika Anda mengecek sekarang, tabel penjualan akan utuh beserta data transaksi jam 10:00!
-- ---------------------------------------------------------
-- USE DisasterDB;
-- SELECT * FROM DataPenjualan;
