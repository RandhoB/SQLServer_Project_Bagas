-- ====================================================================
-- Project 9: Data Auditing & Historical Tracking
-- Topik: Temporal Tables (System-Versioned)
-- Catatan: Fitur Temporal Table tersedia mulai SQL Server 2016
-- ====================================================================

-- 1. SETUP: Membuat Temporal Table
-- Menggunakan System-Versioned table untuk mencatat otomatis histori perubahan (Audit Trail)
CREATE TABLE EmployeeSalary (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(100),
    Salary DECIMAL(18,2),
    ValidFrom DATETIME2 GENERATED ALWAYS AS ROW START HIDDEN NOT NULL,
    ValidTo DATETIME2 GENERATED ALWAYS AS ROW END HIDDEN NOT NULL,
    PERIOD FOR SYSTEM_TIME (ValidFrom, ValidTo)
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmployeeSalaryHistory));

-- Insert Data Awal
INSERT INTO EmployeeSalary (EmpID, EmpName, Salary) VALUES 
(1, 'Agus', 5000),
(2, 'Bagas', 6000);

-- 2. SIMULASI PERUBAHAN
-- Agus naik gaji
UPDATE EmployeeSalary SET Salary = 7000 WHERE EmpID = 1;
WAITFOR DELAY '00:00:02'; -- Tunggu 2 detik
-- Agus naik gaji lagi
UPDATE EmployeeSalary SET Salary = 8000 WHERE EmpID = 1;
-- Bagas resign
DELETE FROM EmployeeSalary WHERE EmpID = 2;

-- 3. SOLUSI / QUERY AUDIT
-- Melihat data terkini
SELECT * FROM EmployeeSalary;

-- Melihat riwayat historis Agus
SELECT * FROM EmployeeSalaryHistory WHERE EmpID = 1;

-- Menggunakan clause FOR SYSTEM_TIME ALL untuk melihat gabungan data aktif dan history
SELECT * FROM EmployeeSalary FOR SYSTEM_TIME ALL WHERE EmpID = 1 ORDER BY ValidFrom;

-- Note untuk pembersihan (jika ingin menghapus tabel):
-- ALTER TABLE EmployeeSalary SET (SYSTEM_VERSIONING = OFF);
-- DROP TABLE EmployeeSalary;
-- DROP TABLE EmployeeSalaryHistory;
