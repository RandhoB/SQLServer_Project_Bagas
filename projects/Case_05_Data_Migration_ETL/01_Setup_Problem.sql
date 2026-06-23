-- =======================================================================
-- CASE 5 SETUP: MIGRASI DATA (ETL) DARI FORMAT KOTOR
-- =======================================================================

CREATE DATABASE MigrasiDataDB;
GO

USE MigrasiDataDB;
GO

-- Tabel Staging: Tempat penampungan sementara sebelum dibersihkan
-- Tipe datanya dibuat VARCHAR semua agar error tidak langsung membatalkan proses import
CREATE TABLE Staging_DataExcel (
    Tanggal VARCHAR(50),
    Pelanggan VARCHAR(100),
    TotalHarga VARCHAR(50)
);
GO

-- Simulasi Import dari CSV Kuno yang kotor (Data Mentah)
INSERT INTO Staging_DataExcel (Tanggal, Pelanggan, TotalHarga)
VALUES 
('2024/01/01', 'Ahmad', '50.000'), -- Pemisah pakai titik
('24-02-2024', 'Siti', '100,000'), -- Format tanggal kebalik, pakai koma
('NULL', 'Budi', 'NULL'),          -- String 'NULL', bukan nilai NULL beneran
('', 'Tono', '20000');             -- Kosong
GO

-- Tabel Tujuan (Data Warehouse Bersih)
CREATE TABLE Fact_Penjualan (
    PenjualanID INT IDENTITY(1,1) PRIMARY KEY,
    TanggalTransaksi DATE,
    NamaPelanggan VARCHAR(100),
    TotalHarga DECIMAL(18,2)
);
GO

PRINT 'Tabel Staging kotor dan Tabel Bersih siap digunakan untuk ETL.';
GO
