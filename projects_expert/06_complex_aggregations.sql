-- ====================================================================
-- Project 6: Complex Aggregations
-- Topik: CUBE, ROLLUP, & GROUPING SETS
-- ====================================================================

-- 1. SETUP
CREATE TABLE RegionalSales (
    Region VARCHAR(50),
    Category VARCHAR(50),
    SaleYear INT,
    Revenue DECIMAL(18,2)
);

INSERT INTO RegionalSales VALUES
('Jawa', 'Elektronik', 2022, 1000),
('Jawa', 'Pakaian', 2022, 500),
('Jawa', 'Elektronik', 2023, 1200),
('Bali', 'Elektronik', 2022, 800),
('Bali', 'Pakaian', 2023, 600);

-- 2. SOLUSI A: ROLLUP (Subtotal secara Hierarkis)
-- Akan menghasilkan subtotal per Region, lalu Grand Total
SELECT 
    ISNULL(Region, 'GRAND TOTAL') AS Region,
    ISNULL(Category, 'ALL CATEGORIES') AS Category,
    SUM(Revenue) AS TotalRevenue
FROM RegionalSales
GROUP BY ROLLUP (Region, Category);

-- 3. SOLUSI B: CUBE (Subtotal untuk Semua Kombinasi)
-- Menghasilkan Grand Total, Subtotal per Region, DAN Subtotal per Kategori
SELECT 
    ISNULL(Region, 'ALL REGIONS') AS Region,
    ISNULL(Category, 'ALL CATEGORIES') AS Category,
    SUM(Revenue) AS TotalRevenue
FROM RegionalSales
GROUP BY CUBE (Region, Category);

-- 4. SOLUSI C: GROUPING SETS (Paling Fleksibel)
-- Kita bisa mendefinisikan persis kombinasi grouping apa yang kita mau
SELECT 
    Region, Category, SaleYear,
    SUM(Revenue) AS TotalRevenue,
    GROUPING(Region) AS IsRegionGrandTotal -- Fungsi GROUPING me-return 1 jika itu adalah baris total
FROM RegionalSales
GROUP BY GROUPING SETS (
    (Region, Category, SaleYear), -- Detail biasa
    (Region),                     -- Subtotal per Region
    ()                            -- Grand Total
);
