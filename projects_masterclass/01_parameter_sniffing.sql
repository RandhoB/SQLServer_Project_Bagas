-- ====================================================================
-- Project 1: Parameter Sniffing & Query Optimization
-- Topik: Stored Procedure, OPTION (RECOMPILE), Local Variables
-- ====================================================================

-- 1. SETUP: Simulasi Data Tidak Rata (Data Skew)
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    Status VARCHAR(20),
    Amount DECIMAL(18,2)
);

-- Bikin Index
CREATE NONCLUSTERED INDEX IX_Orders_Status ON Orders(Status);

-- Insert data (99% 'Completed', 1% 'Pending')
-- Bayangkan ini ada jutaan baris di dunia nyata.
INSERT INTO Orders (Status, Amount) VALUES ('Pending', 100);
INSERT INTO Orders (Status, Amount) VALUES ('Pending', 150);
-- Sisanya Completed (Simulasi)
INSERT INTO Orders (Status, Amount) VALUES ('Completed', 200), ('Completed', 300), ('Completed', 400);

GO

-- 2. MASALAH: Parameter Sniffing
-- SP ini akan meng-cache Execution Plan berdasarkan parameter pertama kali dijalankan.
CREATE PROCEDURE sp_GetOrdersByStatus
    @Status VARCHAR(20)
AS
BEGIN
    SELECT * FROM Orders WHERE Status = @Status;
END
GO

-- Skenario Bencana:
-- Jika pertama kali dijalankan dengan 'Completed' (99% data), SQL Server bikin plan Table Scan.
-- Lalu dijalankan dengan 'Pending', ia tetap pakai Table Scan! Padahal harusnya Index Seek.
-- Inilah yang disebut Parameter Sniffing (Terkadang lambat, terkadang cepat).

-- 3. SOLUSI 1: Menggunakan Local Variables
-- Mencegah SQL Server "mengendus" nilai parameter saat kompilasi.
GO
CREATE PROCEDURE sp_GetOrdersByStatus_LocalVar
    @Status VARCHAR(20)
AS
BEGIN
    DECLARE @LocalStatus VARCHAR(20) = @Status;
    SELECT * FROM Orders WHERE Status = @LocalStatus;
END
GO

-- 4. SOLUSI 2: Menggunakan OPTION (RECOMPILE)
-- Jika tabel tidak terlalu dipanggil ribuan kali per detik, recompile adalah cara paling aman.
-- Ini memaksa SQL Server membuat execution plan baru setiap kali dijalankan.
GO
CREATE PROCEDURE sp_GetOrdersByStatus_Recompile
    @Status VARCHAR(20)
AS
BEGIN
    SELECT * FROM Orders WHERE Status = @Status OPTION (RECOMPILE);
END
GO
