-- ====================================================================
-- Project 10: Database Mail & Automated Alerts
-- Topik: sp_send_dbmail
-- ====================================================================

-- 1. SETUP: Konsep (Tidak bisa dijalankan jika Database Mail belum dikonfigurasi)
-- Syaratnya, Admin SQL (DBA) harus mengatur profil email SMTP terlebih dahulu 
-- lewat SSMS (Management -> Database Mail).

-- 2. KASUS PENGGUNAAN: 
-- Anda diminta membuat script yang memantau tabel error. 
-- Jika hari ini ada error, kirim email rekap (format HTML) ke IT Support.

CREATE PROCEDURE sp_CheckAndAlertErrors
AS
BEGIN
    SET NOCOUNT ON;

    -- A. Cek apakah ada error (Misal kita query ke tabel ErrorLogs dari project sebelumnya)
    -- DECLARE @ErrorCount INT = (SELECT COUNT(*) FROM ErrorLogs WHERE CAST(LogDate AS DATE) = CAST(GETDATE() AS DATE));
    
    DECLARE @ErrorCount INT = 5; -- Simulasi ada 5 error
    
    -- B. Jika ada error, kirim Email
    IF @ErrorCount > 0
    BEGIN
        DECLARE @EmailBody NVARCHAR(MAX);
        SET @EmailBody = N'<h2>Peringatan Sistem!</h2>' +
                         N'<p>Telah terjadi <b>' + CAST(@ErrorCount AS VARCHAR) + N'</b> error hari ini pada database.</p>' +
                         N'<p>Harap segera periksa tabel <i>ErrorLogs</i> untuk detail lebih lanjut.</p>';
        
        -- C. Eksekusi pengiriman email
        /*
        EXEC msdb.dbo.sp_send_dbmail
            @profile_name = 'AlertProfile', -- Profil SMTP yang sudah disetting
            @recipients = 'itsupport@perusahaan.com',
            @subject = 'URGENT: Laporan Error Database Harian',
            @body = @EmailBody,
            @body_format = 'HTML';
        */
        
        PRINT 'Email peringatan disimulasikan terkirim ke IT Support.';
    END
    ELSE
    BEGIN
        PRINT 'Tidak ada error hari ini. Sistem aman.';
    END
END;
GO

-- Eksekusi Prosedurnya
EXEC sp_CheckAndAlertErrors;
