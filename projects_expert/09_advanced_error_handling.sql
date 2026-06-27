-- ====================================================================
-- Project 9: Advanced Error Handling & Custom Logging
-- Topik: TRY...CATCH, XACT_ABORT, THROW
-- ====================================================================

-- 1. SETUP: Tabel Log Error
CREATE TABLE ErrorLogs (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    ErrorNumber INT,
    ErrorSeverity INT,
    ErrorState INT,
    ErrorProcedure VARCHAR(255),
    ErrorLine INT,
    ErrorMessage NVARCHAR(MAX),
    LogDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE DemoProducts (
    ProductID INT PRIMARY KEY,
    Price DECIMAL(18,2)
);
INSERT INTO DemoProducts VALUES (1, 100);

GO

-- 2. SOLUSI: Stored Procedure dengan Robust Error Handling
CREATE PROCEDURE sp_UpdateProductPrice
    @ProductID INT,
    @NewPrice DECIMAL(18,2)
AS
BEGIN
    -- XACT_ABORT ON memastikan transaksi langsung rollback jika error kritikal
    SET XACT_ABORT ON; 
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Simulasi proses 1
        UPDATE DemoProducts SET Price = @NewPrice WHERE ProductID = @ProductID;
        
        -- Simulasi Error Sengaja (Bagi dengan nol)
        DECLARE @DivZero INT = 1 / 0; 
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Masuk ke sini jika ada error apa pun di blok TRY
        
        -- Aman me-rollback jika transaksi masih open
        IF XACT_STATE() <> 0 
        BEGIN
            ROLLBACK TRANSACTION;
        END

        -- Merekam Error ke Tabel Log
        INSERT INTO ErrorLogs (ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
        VALUES (
            ERROR_NUMBER(), ERROR_SEVERITY(), ERROR_STATE(), ERROR_PROCEDURE(), ERROR_LINE(), ERROR_MESSAGE()
        );

        -- Mengembalikan error ke aplikasi pemanggil (C# / Java) agar mereka juga tahu ada error
        -- THROW adalah versi modern dari RAISERROR
        THROW; 
    END CATCH
END;
GO

-- 3. UJI COBA
-- Menjalankan SP yang pasti akan error (karena 1/0)
-- EXEC sp_UpdateProductPrice @ProductID = 1, @NewPrice = 200;

-- Cek log, data tidak ter-update (ter-rollback) dan log error tercatat
-- SELECT * FROM ErrorLogs;
-- SELECT * FROM DemoProducts;
