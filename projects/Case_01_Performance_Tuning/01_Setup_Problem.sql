-- =======================================================================
-- CASE 1 SETUP: MEMBUAT MASALAH (PERFORMANCE TUNING)
-- =======================================================================
-- PERINGATAN: Script ini akan memakan waktu 1-2 menit untuk berjalan,
-- karena sengaja membuat data yang sangat banyak agar simulasi terasa nyata.

CREATE DATABASE TokoOnlineDB;
GO

USE TokoOnlineDB;
GO

-- 1. Membuat Tabel Transaksi yang belum di-optimasi
CREATE TABLE TransaksiPenjualan (
    TransaksiID INT IDENTITY(1,1), -- Sengaja tidak dijadikan PRIMARY KEY dulu untuk simulasi
    TanggalTransaksi DATETIME,
    NamaPelanggan VARCHAR(100),
    KodeProduk VARCHAR(20),
    Jumlah INT,
    TotalHarga DECIMAL(18,2),
    StatusPesanan VARCHAR(20)
);
GO

-- 2. Mengisi 500.000 baris data dummy (Looping)
-- Ini simulasi volume transaksi selama 2 tahun terakhir
SET NOCOUNT ON;

DECLARE @i INT = 1;
DECLARE @RandomDate DATETIME;
DECLARE @RandomTotal DECIMAL(18,2);

BEGIN TRAN;
WHILE @i <= 500000
BEGIN
    -- Menghasilkan tanggal acak dalam 2 tahun terakhir
    SET @RandomDate = DATEADD(DAY, -(ABS(CHECKSUM(NEWID()) % 730)), GETDATE());
    -- Menghasilkan total harga acak
    SET @RandomTotal = ABS(CHECKSUM(NEWID()) % 5000000) + 10000.00;

    INSERT INTO TransaksiPenjualan (TanggalTransaksi, NamaPelanggan, KodeProduk, Jumlah, TotalHarga, StatusPesanan)
    VALUES (
        @RandomDate,
        'Pelanggan_' + CAST(@i AS VARCHAR(10)),
        'PRD-' + CAST(ABS(CHECKSUM(NEWID()) % 1000) AS VARCHAR(10)), -- 1000 variasi produk
        ABS(CHECKSUM(NEWID()) % 5) + 1,
        @RandomTotal,
        CASE WHEN @i % 5 = 0 THEN 'PENDING' ELSE 'SELESAI' END
    );

    @i = @i + 1;
END
COMMIT TRAN;
GO

PRINT '500,000 Data Dummy Berhasil Dimasukkan! Siap untuk studi kasus.';
GO
