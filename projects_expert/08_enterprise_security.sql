-- ====================================================================
-- Project 8: Enterprise Security
-- Topik: Row-Level Security (RLS) & Dynamic Data Masking (DDM)
-- ====================================================================

-- 1. SETUP: Dynamic Data Masking (DDM)
CREATE TABLE PatientRecords (
    PatientID INT PRIMARY KEY,
    PatientName VARCHAR(100) MASKED WITH (FUNCTION = 'partial(1, "XXX", 1)'), -- Menjadi AXXXs
    CreditCard VARCHAR(20) MASKED WITH (FUNCTION = 'default()'),             -- Menjadi XXXX
    Email VARCHAR(100) MASKED WITH (FUNCTION = 'email()'),                   -- Menjadi aXXX@XXXX.com
    DoctorID INT -- Akan digunakan untuk RLS
);

INSERT INTO PatientRecords VALUES 
(1, 'Agus Santoso', '1234-5678-9012', 'agus@email.com', 101),
(2, 'Budi Gunawan', '9876-5432-1098', 'budi@email.com', 102);

-- Buat User tanpa hak admin
-- CREATE USER TestUser WITHOUT LOGIN;
-- GRANT SELECT ON PatientRecords TO TestUser;
-- EKSEKUSI SEBAGAI USER BIASA: Data akan tertutup (Masked)
-- EXECUTE AS USER = 'TestUser';
-- SELECT * FROM PatientRecords;
-- REVERT;

-- 2. SETUP: Row-Level Security (RLS)
-- Skenario: Dokter hanya boleh melihat pasiennya sendiri.

-- A. Membuat Security Predicate Function (Logika Akses)
-- (Butuh grant schema dll pada real case)
GO
CREATE FUNCTION dbo.fn_SecurityPredicateDoctor (@DoctorID INT)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN (
    -- Return 1 jika user yang sedang login adalah dokter tersebut, ATAU user adalah Admin
    SELECT 1 AS fn_SecurityPredicateResult
    -- Untuk demo, kita hardcode, namun di real world kita gunakan USER_NAME() atau SUSER_SNAME()
    -- WHERE @DoctorID = CAST(USER_NAME() AS INT) 
);
GO

-- B. Mengaplikasikan Security Policy ke Tabel
CREATE SECURITY POLICY PatientSecurityPolicy
ADD FILTER PREDICATE dbo.fn_SecurityPredicateDoctor(DoctorID)
ON dbo.PatientRecords
WITH (STATE = ON);
GO

-- Setelah Policy aktif, kueri otomatis terfilter di level kernel database.
-- Nonaktifkan untuk cleanup:
-- DROP SECURITY POLICY PatientSecurityPolicy;
-- DROP FUNCTION dbo.fn_SecurityPredicateDoctor;
