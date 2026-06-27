-- ====================================================================
-- Project 4: Scalar UDF vs Inline Table-Valued Function (iTVF)
-- Topik: Refactoring fungsi skalar untuk performa
-- ====================================================================

-- 1. SETUP
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    BaseSalary DECIMAL(18,2),
    Bonus DECIMAL(18,2)
);
INSERT INTO Employees VALUES (1, 5000, 1000), (2, 6000, 500);

-- 2. MASALAH: SCALAR UDF (The Silent Killer)
-- Fungsi yang mengembalikan 1 nilai skalar. 
-- Kekurangan utama: dieksekusi SECARA BERULANG untuk SETIAP BARIS di tabel (RBAR - Row By Agonizing Row).
GO
CREATE FUNCTION dbo.fn_CalculateTotalSalary_Scalar (@Base DECIMAL(18,2), @Bonus DECIMAL(18,2))
RETURNS DECIMAL(18,2)
AS
BEGIN
    RETURN @Base + @Bonus;
END;
GO

-- Coba jalankan ini pada jutaan data, dijamin CPU akan spike 100%.
SELECT EmpID, dbo.fn_CalculateTotalSalary_Scalar(BaseSalary, Bonus) AS TotalSalary 
FROM Employees;


-- 3. SOLUSI: INLINE TABLE-VALUED FUNCTION (iTVF)
-- Mengembalikan tabel. 
-- Keunggulan utama: di-expand (seperti macro) oleh query optimizer ke dalam execution plan utama.
-- Kecepatannya setara dengan menuliskan logikanya langsung di SELECT.
GO
CREATE FUNCTION dbo.fn_CalculateTotalSalary_iTVF (@Base DECIMAL(18,2), @Bonus DECIMAL(18,2))
RETURNS TABLE
AS
RETURN (
    SELECT (@Base + @Bonus) AS TotalSalary
);
GO

-- Cara memanggil iTVF (Menggunakan CROSS APPLY)
SELECT 
    e.EmpID, 
    fn.TotalSalary 
FROM Employees e
CROSS APPLY dbo.fn_CalculateTotalSalary_iTVF(e.BaseSalary, e.Bonus) fn;
