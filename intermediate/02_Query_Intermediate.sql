-- =======================================================================
-- PRAKTIK INTERMEDIATE SQL SERVER 
-- =======================================================================
-- Pastikan Anda sudah membuat FreelanceDB dari materi Dasar.
-- Jalankan (Execute) per blok secara bertahap.

USE FreelanceDB;
GO

-- ---------------------------------------------------------
-- 1. VIEWS (Tabel Virtual)
-- Menyederhanakan Query Join yang sering dipakai
-- ---------------------------------------------------------

-- Membuat View untuk Laporan Proyek
CREATE VIEW vw_LaporanProyekKlien
AS
SELECT 
    p.ProyekID,
    p.NamaProyek,
    k.NamaPerusahaan,
    p.NilaiKontrak,
    k.KontakEmail
FROM Proyek p
JOIN Klien k ON p.KlienID = k.KlienID;
GO

-- Cara memanggil View (Sangat sederhana bagi Programmer)
SELECT * FROM vw_LaporanProyekKlien;
GO

-- ---------------------------------------------------------
-- 2. STORED PROCEDURE (SP)
-- Membungkus logika bisnis agar aman & bisa pakai parameter
-- ---------------------------------------------------------

-- Membuat Procedure untuk tambah Proyek Baru
CREATE PROCEDURE sp_TambahProyek
    @KlienID INT,
    @NamaProyek VARCHAR(100),
    @NilaiKontrak DECIMAL(18,2)
AS
BEGIN
    -- Set NOCOUNT ON bagus untuk performa (tidak mengirim pesan "(1 row affected)")
    SET NOCOUNT ON; 

    INSERT INTO Proyek (KlienID, NamaProyek, NilaiKontrak)
    VALUES (@KlienID, @NamaProyek, @NilaiKontrak);

    PRINT 'Data Proyek berhasil ditambahkan!';
END
GO

-- Cara memanggil (Execute) Stored Procedure
EXEC sp_TambahProyek @KlienID = 2, @NamaProyek = 'Maintenance Bulanan', @NilaiKontrak = 2000000.00;
GO

-- ---------------------------------------------------------
-- 3. USER DEFINED FUNCTION (UDF)
-- Menghitung PPN 11% dari Nilai Kontrak
-- ---------------------------------------------------------

CREATE FUNCTION fn_HitungPPN (
    @Nilai DECIMAL(18,2)
)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Hasil DECIMAL(18,2);
    SET @Hasil = @Nilai * 0.11; -- PPN 11%
    RETURN @Hasil;
END
GO

-- Cara memanggil fungsi di dalam query SELECT
SELECT NamaProyek, NilaiKontrak, dbo.fn_HitungPPN(NilaiKontrak) AS PPN_11_Persen FROM Proyek;
GO

-- ---------------------------------------------------------
-- 4. TRIGGERS (Otomasi & Audit)
-- Mencatat ke tabel Audit jika ada perubahan nilai kontrak
-- ---------------------------------------------------------

-- Pertama, kita buat tabel Audit Log
CREATE TABLE ProyekAuditLog (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    ProyekID INT,
    NilaiLama DECIMAL(18,2),
    NilaiBaru DECIMAL(18,2),
    TanggalUbah DATETIME DEFAULT GETDATE(),
    UserUbah VARCHAR(50)
);
GO

-- Membuat Trigger yang aktif otomatis setiap kali tabel Proyek di-UPDATE
CREATE TRIGGER trg_AuditPerubahanProyek
ON Proyek
AFTER UPDATE
AS
BEGIN
    -- SQL Server memiliki tabel *magic* bernama 'inserted' (data baru) dan 'deleted' (data lama)
    IF UPDATE(NilaiKontrak) -- Jika kolom NilaiKontrak yang diubah
    BEGIN
        INSERT INTO ProyekAuditLog (ProyekID, NilaiLama, NilaiBaru, UserUbah)
        SELECT 
            i.ProyekID, 
            d.NilaiKontrak AS NilaiLama, 
            i.NilaiKontrak AS NilaiBaru, 
            SYSTEM_USER -- Mencatat username SQL/Windows yg mengubah
        FROM inserted i
        JOIN deleted d ON i.ProyekID = d.ProyekID;
    END
END
GO

-- Tes Trigger (Jalankan UPDATE dan cek tabel ProyekAuditLog)
UPDATE Proyek SET NilaiKontrak = 2500000.00 WHERE ProyekID = 1;
SELECT * FROM ProyekAuditLog;

-- ---------------------------------------------------------
-- 5. INDEXES (Performance Tuning)
-- Membuat pencarian data menjadi super cepat
-- ---------------------------------------------------------

-- Membuat Non-Clustered Index pada kolom NamaPerusahaan
-- Jika suatu saat programmer sering menggunakan: SELECT * FROM Klien WHERE NamaPerusahaan = 'X'
CREATE NONCLUSTERED INDEX IX_Klien_NamaPerusahaan
ON Klien (NamaPerusahaan);
GO

-- ---------------------------------------------------------
-- 6. TRANSACTIONS & TRY...CATCH
-- Memastikan integritas data jika terjadi error
-- ---------------------------------------------------------

BEGIN TRY
    -- Memulai transaksi
    BEGIN TRAN;

    -- Proses 1: Update Email Klien
    UPDATE Klien SET KontakEmail = 'ceo@tekno.com' WHERE KlienID = 1;

    -- Proses 2: Simulasi Error (misal, update dengan format salah atau tipe data tidak cocok)
    -- Membagi dengan nol untuk memancing error
    DECLARE @ErrorInt INT = 1 / 0; 

    -- Jika sampai di sini (tidak error), transaksi disimpan permanen
    COMMIT TRAN;
    PRINT 'Transaksi Sukses!';

END TRY
BEGIN CATCH
    -- Jika terjadi error di baris manapun di dalam TRY, lari ke sini
    IF @@TRANCOUNT > 0
    BEGIN
        ROLLBACK TRAN; -- Kembalikan data ke awal, batalkan proses 1
    END
    
    -- Mencetak pesan error sistem
    PRINT 'Transaksi Dibatalkan! Error: ' + ERROR_MESSAGE();
END CATCH
GO

-- =======================================================================
-- AKHIR DARI PRAKTIK INTERMEDIATE
-- =======================================================================
