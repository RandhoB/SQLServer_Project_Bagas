-- =======================================================================
-- PRAKTIK DASAR SQL SERVER UNTUK CALON DBA
-- =======================================================================
-- Jalankan query di bawah ini secara bertahap (blok per bagian, lalu tekan F5 atau Execute)

-- ---------------------------------------------------------
-- BAGIAN 1: DDL (DATA DEFINITION LANGUAGE)
-- Digunakan untuk membuat struktur database dan tabel
-- ---------------------------------------------------------

-- 1. Membuat Database Baru
CREATE DATABASE FreelanceDB;
GO

-- 2. Berpindah menggunakan database yang baru dibuat
USE FreelanceDB;
GO

-- 3. Membuat Tabel
CREATE TABLE Klien (
    KlienID INT IDENTITY(1,1) PRIMARY KEY, -- IDENTITY berarti angka otomatis bertambah (1, 2, 3...)
    NamaPerusahaan VARCHAR(100) NOT NULL,
    KontakEmail VARCHAR(50),
    TanggalDaftar DATETIME DEFAULT GETDATE()
);
GO

-- 4. Membuat Tabel Kedua dengan Relasi (Foreign Key)
CREATE TABLE Proyek (
    ProyekID INT IDENTITY(1,1) PRIMARY KEY,
    KlienID INT FOREIGN KEY REFERENCES Klien(KlienID), -- Relasi ke tabel Klien
    NamaProyek VARCHAR(100) NOT NULL,
    NilaiKontrak DECIMAL(18,2)
);
GO

-- ---------------------------------------------------------
-- BAGIAN 2: DML (DATA MANIPULATION LANGUAGE)
-- Digunakan untuk memasukkan, mengubah, menghapus, dan melihat data
-- ---------------------------------------------------------

-- 1. Memasukkan Data (INSERT)
INSERT INTO Klien (NamaPerusahaan, KontakEmail)
VALUES 
('PT Teknologi Maju', 'info@tekno.com'),
('CV Sejahtera Abadi', 'kontak@sejahtera.com');
GO

INSERT INTO Proyek (KlienID, NamaProyek, NilaiKontrak)
VALUES 
(1, 'Migrasi Database', 15000000.00),
(1, 'Tuning Performance Server', 5000000.00),
(2, 'Setup High Availability', 25000000.00);
GO

-- 2. Melihat Data (SELECT)
-- Melihat semua klien
SELECT * FROM Klien;

-- Melihat proyek dan nama perusahaan klien (menggunakan JOIN)
SELECT 
    p.NamaProyek,
    k.NamaPerusahaan,
    p.NilaiKontrak
FROM Proyek p
JOIN Klien k ON p.KlienID = k.KlienID;
GO

-- 3. Mengubah Data (UPDATE)
-- PERINGATAN DBA: Selalu gunakan WHERE saat UPDATE!
UPDATE Proyek
SET NilaiKontrak = 6000000.00
WHERE ProyekID = 2;
GO

-- 4. Menghapus Data (DELETE)
-- PERINGATAN DBA: Selalu gunakan WHERE saat DELETE!
-- Hapus proyek yang ID-nya 3
DELETE FROM Proyek
WHERE ProyekID = 3;
GO

-- ---------------------------------------------------------
-- BAGIAN 3: TUGAS WAJIB DBA (BACKUP)
-- Sebagai DBA, ini adalah perintah yang akan menyelamatkan hidup Anda
-- ---------------------------------------------------------

-- Catatan: Pastikan path folder "C:\Backup\" ada di server Anda.
-- Jika Anda menggunakan Mac (via Docker), ubah path ke path lokal container, misalnya: '/var/opt/mssql/data/'


-- Full Backup Database
BACKUP DATABASE FreelanceDB
TO DISK = '/var/opt/mssql/data/FreelanceDB_Full.bak'
WITH FORMAT, 
     MEDIANAME = 'SQLServerBackups',
     NAME = 'Full Backup of FreelanceDB';
GO


-- ---------------------------------------------------------
-- BAGIAN 4: DCL (DATA CONTROL LANGUAGE) & SECURITY
-- Mengatur siapa yang bisa mengakses apa
-- ---------------------------------------------------------

-- 1. Membuat Login (di level Server)
CREATE LOGIN ProgrammerUser WITH PASSWORD = 'StrongPassword123!';
GO

-- 2. Membuat User untuk Login tersebut (di level Database)
USE FreelanceDB;
CREATE USER ProgrammerUser FOR LOGIN ProgrammerUser;
GO

-- 3. Memberikan akses (GRANT) agar bisa membaca data saja (Read Only)
EXEC sp_addrolemember 'db_datareader', 'ProgrammerUser';
GO

-- =======================================================================
-- AKHIR DARI PRAKTIK DASAR
-- =======================================================================
