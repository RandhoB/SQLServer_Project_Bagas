-- =======================================================================
-- CASE 3 SETUP: HACKER & SECURITY AUDIT
-- =======================================================================

CREATE DATABASE KeamananDB;
GO

USE KeamananDB;
GO

-- 1. Membuat tabel dengan data sensitif
CREATE TABLE DataKaryawan (
    ID INT IDENTITY(1,1),
    Nama VARCHAR(50),
    Jabatan VARCHAR(50),
    Gaji DECIMAL(18,2), -- Data Sensitif!
    KartuKredit VARCHAR(20) -- Sangat Sensitif!
);
GO

INSERT INTO DataKaryawan (Nama, Jabatan, Gaji, KartuKredit)
VALUES 
('Budi', 'Manager', 25000000, '4111-2222-3333-4444'),
('Siti', 'Staff', 8000000, '5555-6666-7777-8888');
GO

-- 2. Mensimulasikan pembuatan akun Vendor Nakal yang diberi akses SYSADMIN!
-- (Login dibuat di level Master/Server)
USE master;
GO

-- Hapus login jika sudah ada
IF EXISTS (SELECT * FROM sys.server_principals WHERE name = 'VendorLamaIT')
    DROP LOGIN VendorLamaIT;
GO

CREATE LOGIN VendorLamaIT WITH PASSWORD = 'PasswordLemah123';
-- Memberikan kunci kerajaan (sysadmin) ke vendor (TINDAKAN BERBAHAYA!)
EXEC master..sp_addsrvrolemember @loginame = N'VendorLamaIT', @rolename = N'sysadmin';
GO

PRINT 'Simulasi Security Audit Selesai. Ada akun sysadmin gelap!';
GO
