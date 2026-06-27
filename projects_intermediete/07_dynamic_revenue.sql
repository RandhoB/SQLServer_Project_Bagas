-- ====================================================================
-- Project 7: Dynamic Revenue Reporting
-- Topik: Dynamic SQL, PIVOT
-- ====================================================================

-- 1. SETUP
CREATE TABLE MonthlySales (
    Category VARCHAR(50),
    SalesMonth VARCHAR(10), -- Format 'YYYY-MM'
    Revenue DECIMAL(18,2)
);

INSERT INTO MonthlySales VALUES
('Elektronik', '2023-01', 10000), ('Pakaian', '2023-01', 5000),
('Elektronik', '2023-02', 12000), ('Pakaian', '2023-02', 6000),
('Elektronik', '2023-03', 15000), ('Pakaian', '2023-03', 7000);

-- 2. SOLUSI: Dynamic SQL untuk PIVOT
-- Kita ingin nama bulan menjadi kolom (2023-01, 2023-02, dst) secara dinamis
DECLARE @Columns NVARCHAR(MAX) = '';
DECLARE @SQL NVARCHAR(MAX) = '';

-- Membuat daftar kolom bulan yang unik
SELECT @Columns += QUOTENAME(SalesMonth) + ','
FROM (SELECT DISTINCT SalesMonth FROM MonthlySales) AS Months
ORDER BY SalesMonth;

-- Menghapus koma terakhir
SET @Columns = LEFT(@Columns, LEN(@Columns) - 1);

-- Query Dinamis
SET @SQL = '
    SELECT Category, ' + @Columns + '
    FROM 
    (
        SELECT Category, SalesMonth, Revenue 
        FROM MonthlySales
    ) AS SourceTable
    PIVOT
    (
        SUM(Revenue)
        FOR SalesMonth IN (' + @Columns + ')
    ) AS PivotTable;
';

-- Mengeksekusi Query Dinamis
EXEC sp_executesql @SQL;
