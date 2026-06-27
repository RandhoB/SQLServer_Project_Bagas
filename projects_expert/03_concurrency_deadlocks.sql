-- ====================================================================
-- Project 3: Concurrency & Isolation Levels
-- Topik: Handling Deadlocks, RCSI
-- ====================================================================

-- 1. SETUP
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    Balance DECIMAL(18,2)
);
INSERT INTO Accounts VALUES (1, 1000), (2, 500);

-- 2. MASALAH DEADLOCK (Simulasi konseptual)
-- Sesi 1: Update Account 1, lalu Account 2
-- Sesi 2: Update Account 2, lalu Account 1
-- Keduanya akan saling menunggu lock.

-- 3. SOLUSI 1: Urutan eksekusi yang konsisten (Selalu update dari ID terkecil)

-- 4. SOLUSI 2: Mencegah Reader memblokir Writer dengan RCSI
-- Di environment skala enterprise, kita sering menyalakan Read Committed Snapshot Isolation
-- Memungkinkan transaksi baca untuk membaca versi data sebelumnya dari tempdb tanpa menggunakan shared lock.

-- Skrip Administratif (Dijalankan di luar transaksi):
-- ALTER DATABASE [NamaDatabaseAnda] SET READ_COMMITTED_SNAPSHOT ON;

-- 5. SOLUSI 3: Advanced TRY...CATCH untuk Deadlock Retry
-- Error Code 1205 adalah Error code untuk Deadlock
DECLARE @RetryCount INT = 0;
DECLARE @Success BIT = 0;

WHILE @RetryCount < 3 AND @Success = 0
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Transfer Uang
        UPDATE Accounts SET Balance = Balance - 100 WHERE AccountID = 1;
        -- Bayangkan delay di sini yang memicu deadlock
        UPDATE Accounts SET Balance = Balance + 100 WHERE AccountID = 2;
        
        COMMIT TRANSACTION;
        SET @Success = 1; -- Berhasil
    END TRY
    BEGIN CATCH
        IF ERROR_NUMBER() = 1205 -- Deadlock Victim
        BEGIN
            ROLLBACK TRANSACTION;
            SET @RetryCount = @RetryCount + 1;
            WAITFOR DELAY '00:00:02'; -- Tunggu 2 detik sebelum coba lagi
        END
        ELSE
        BEGIN
            ROLLBACK TRANSACTION;
            THROW; -- Lempar error selain deadlock
        END
    END CATCH
END;

SELECT * FROM Accounts;
