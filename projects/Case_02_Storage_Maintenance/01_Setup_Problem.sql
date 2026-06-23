-- =======================================================================
-- CASE 2 SETUP: BENCANA FILE LOG MEMBENGKAK
-- =======================================================================

CREATE DATABASE LogBengkakDB;
GO

-- Mengatur arsitektur log ke FULL (yang menyebabkan log tidak otomatis terpotong)
ALTER DATABASE LogBengkakDB SET RECOVERY FULL;
GO

USE LogBengkakDB;
GO

-- Membuat tabel sampah untuk memenuhi Transaction Log
CREATE TABLE SampahLog (
    ID INT IDENTITY(1,1),
    DataSampah CHAR(8000) -- Memakan 8KB per baris
);
GO

-- PERINGATAN: Di dunia nyata, transaksi jutaan baris tanpa di-backup LOG nya akan membuat hardisk penuh.
-- Kita simulasikan dengan memasukkan 50.000 baris (akan memakan sekitar 400MB space Log).
SET NOCOUNT ON;
BEGIN TRAN;
DECLARE @i INT = 1;
WHILE @i <= 50000
BEGIN
    INSERT INTO SampahLog (DataSampah) VALUES ('Membuat Log Server Bengkak Karena Transaksi Besar');
    @i = @i + 1;
END
COMMIT TRAN;
GO

-- Menghapus data (Delete juga dicatat di Log, sehingga Log makin bengkak!)
DELETE FROM SampahLog;
GO

PRINT 'Simulasi Log Bengkak Selesai. Silakan cek ukuran file .ldf Anda!';
GO
