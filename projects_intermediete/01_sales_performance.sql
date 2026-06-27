-- ====================================================================
-- Project 1: Sales Performance & Commission Calculation
-- Topik: Window Functions, CTE
-- ====================================================================

-- 1. SETUP: Membuat Tabel dan Data Dummy
CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    SalesPerson VARCHAR(50),
    SaleDate DATE,
    Amount DECIMAL(18,2)
);

INSERT INTO Sales (SalesPerson, SaleDate, Amount) VALUES
('Andi', '2023-01-05', 5000),
('Andi', '2023-01-15', 7000),
('Budi', '2023-01-10', 4000),
('Citra', '2023-01-12', 15000),
('Budi', '2023-01-20', 8000),
('Andi', '2023-02-05', 3000),
('Citra', '2023-02-15', 5000);

-- 2. SOLUSI: 
-- Menghitung total penjualan bulanan, memberikan ranking, 
-- dan menghitung komisi berdasarkan tier (Berjenjang)
-- Tier: > 10000 = 10%, > 5000 = 5%, <= 5000 = 2%

WITH MonthlySales AS (
    SELECT 
        SalesPerson,
        MONTH(SaleDate) AS SaleMonth,
        YEAR(SaleDate) AS SaleYear,
        SUM(Amount) AS TotalSales
    FROM Sales
    GROUP BY SalesPerson, MONTH(SaleDate), YEAR(SaleDate)
),
RankedSales AS (
    SELECT 
        *,
        RANK() OVER(PARTITION BY SaleYear, SaleMonth ORDER BY TotalSales DESC) AS SalesRank,
        CASE 
            WHEN TotalSales > 10000 THEN TotalSales * 0.10
            WHEN TotalSales > 5000 THEN TotalSales * 0.05
            ELSE TotalSales * 0.02
        END AS Commission
    FROM MonthlySales
)
SELECT * FROM RankedSales ORDER BY SaleYear, SaleMonth, SalesRank;
