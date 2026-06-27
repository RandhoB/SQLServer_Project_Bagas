-- ====================================================================
-- Project 9: Data Compression Strategy
-- Topik: ROW and PAGE Compression
-- ====================================================================

-- 1. SETUP
-- Tabel Log yang memakan banyak spasi harddisk (Misal banyak tipe data CHAR(100) yang kosong)
CREATE TABLE AuditLogs (
    LogID INT IDENTITY(1,1),
    ActionName VARCHAR(50),
    Description CHAR(200), -- Menghabiskan 200 byte per baris, biarpun isinya cuma 5 huruf
    CreatedDate DATETIME DEFAULT GETDATE()
);

-- Insert dummy data
INSERT INTO AuditLogs (ActionName, Description) VALUES 
('LOGIN', 'User Logged In'),
('LOGOUT', 'User Logged Out'),
('ERROR', 'System Failure');

-- 2. MASALAH: Storage Bengkak
-- Jika data ini ada 100 Juta baris, CHAR(200) akan membuang storage ber-gigabyte dengan spasi kosong.

-- 3. SOLUSI A: ROW COMPRESSION
-- Menghilangkan padding spasi kosong (seperti merubah CHAR menjadi VARCHAR secara internal).
-- Lebih ringan untuk CPU.
ALTER TABLE AuditLogs 
REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = ROW);

-- 4. SOLUSI B: PAGE COMPRESSION
-- Mengecilkan data yang berulang-ulang di dalam satu halaman memory (Page).
-- Cocok untuk data log yang nilainya itu-itu saja (seperti 'LOGIN', 'LOGOUT').
-- Lebih butuh CPU tinggi, tapi sangat menghemat ukuran harddisk (I/O).
ALTER TABLE AuditLogs 
REBUILD PARTITION = ALL WITH (DATA_COMPRESSION = PAGE);

-- Untuk mengecek estimasi penghematan storage (Hanya bisa jalan jika ada cukup banyak data):
-- EXEC sp_estimate_data_compression_savings 'dbo', 'AuditLogs', NULL, NULL, 'PAGE';
