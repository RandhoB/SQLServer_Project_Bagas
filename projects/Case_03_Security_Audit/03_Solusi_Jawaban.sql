-- =======================================================================
-- KUNCI JAWABAN CASE 3: SECURITY AUDIT & DATA MASKING
-- =======================================================================

-- ---------------------------------------------------------
-- TUGAS 1: Menghentikan Akses Vendor Lama
-- ---------------------------------------------------------
USE master;
GO

-- Menghapus keanggotaan (Role) sysadmin dari login vendor lama
ALTER SERVER ROLE sysadmin DROP MEMBER VendorLamaIT;
GO

-- Menonaktifkan akun (DISABLE) tanpa menghapusnya untuk bukti audit
ALTER LOGIN VendorLamaIT DISABLE;
GO

-- ---------------------------------------------------------
-- TUGAS 2: Membuat Role / User dengan "Least Privilege"
-- ---------------------------------------------------------
USE KeamananDB;
GO

CREATE LOGIN Anwar WITH PASSWORD = 'PasswordAman_456!';
CREATE USER Anwar FOR LOGIN Anwar;
GO

-- HANYA memberikan akses untuk SELECT pada kolom Nama dan Jabatan saja
GRANT SELECT ON DataKaryawan (Nama, Jabatan) TO Anwar;
GO

-- ---------------------------------------------------------
-- TUGAS 3: BONUS (Data Masking untuk Kartu Kredit)
-- ---------------------------------------------------------
-- Mengubah kolom agar disensor oleh database otomatis bagi user yang tidak punya hak UNMASK
ALTER TABLE DataKaryawan 
ALTER COLUMN KartuKredit ADD MASKED WITH (FUNCTION = 'partial(0,"XXXX-XXXX-XXXX-",4)');
GO

-- Jika Anda login sebagai Anwar dan men-select tabel, hasilnya:
-- EXECUTE AS USER = 'Anwar';
-- SELECT * FROM DataKaryawan;
-- REVERT;
