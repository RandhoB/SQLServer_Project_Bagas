-- =======================================================================
-- CASE 4 SETUP: RANSOMWARE & DISASTER RECOVERY
-- =======================================================================
-- Catatan: Eksekusi ini membutuhkan setting folder backup di server lokal.

CREATE DATABASE DisasterDB;
GO
ALTER DATABASE DisasterDB SET RECOVERY FULL;
GO

USE DisasterDB;
GO

CREATE TABLE DataPenjualan (
    Waktu DATETIME,
    Nominal DECIMAL(18,2)
);
GO

-- 1. Insert Penjualan Jam 08:00 Pagi
INSERT INTO DataPenjualan VALUES ('2024-01-01 08:00:00', 50000);
GO

-- 2. Anggap Klien melakukan FULL BACKUP jam 08:00 Pagi (Wajib Anda jalankan!)

BACKUP DATABASE DisasterDB 
TO DISK = '/var/opt/mssql/data/DisasterDB_Full.bak'  -- (Sesuaikan path OS Anda, C:\Backup\ misal di Windows)
WITH INIT;
GO


-- 3. Insert Penjualan Jam 09:00 Pagi
INSERT INTO DataPenjualan VALUES ('2024-01-01 09:00:00', 100000);
GO

-- 4. Anggap Klien melakukan TRANSACTION LOG BACKUP jam 09:00 Pagi

BACKUP LOG DisasterDB 
TO DISK = '/var/opt/mssql/data/DisasterDB_Log1.trn'
WITH INIT;
GO


-- 5. Insert Penjualan Jam 10:00 Pagi
INSERT INTO DataPenjualan VALUES ('2024-01-01 10:00:00', 150000);
GO

PRINT 'Setup Disaster Selesai. Siap untuk diserang (di-Drop)!';
GO
