-- ====================================================================
-- Project 5: Table Partitioning (Konseptual)
-- Topik: Partition Functions & Schemes
-- ====================================================================

-- Catatan: Eksekusi script ini membutuhkan Enterprise Edition pada versi lama,
-- namun sejak SP1 SQL Server 2016, fitur ini tersedia di Standard Edition.

-- 1. Membuat Fungsi Partisi (Membagi batas data per tahun)
-- Misal data sebelum 2022, 2023, 2024, dst.
CREATE PARTITION FUNCTION pf_YearlyPartition (DATETIME)
AS RANGE RIGHT FOR VALUES ('2022-01-01', '2023-01-01', '2024-01-01');

-- 2. Membuat Skema Partisi (Memetakan fungsi partisi ke Filegroups)
-- Idealnya diletakkan di filegroup fisik berbeda di harddisk berbeda.
-- Di sini kita asumsikan semua di filegroup [PRIMARY] demi demo.
CREATE PARTITION SCHEME ps_YearlyPartition
AS PARTITION pf_YearlyPartition
ALL TO ([PRIMARY]);

-- 3. Membuat Tabel menggunakan Partition Scheme
CREATE TABLE PartitionedSales (
    SaleID INT IDENTITY(1,1),
    SaleDate DATETIME,
    Amount DECIMAL(18,2),
    CONSTRAINT PK_PartitionedSales PRIMARY KEY (SaleID, SaleDate) -- PK harus mencakup kolom partisi
) ON ps_YearlyPartition(SaleDate);

-- 4. INSERT DATA
INSERT INTO PartitionedSales (SaleDate, Amount) VALUES
('2021-06-15', 100), -- Masuk ke partisi 1
('2022-05-10', 200), -- Masuk ke partisi 2
('2023-11-20', 300), -- Masuk ke partisi 3
('2024-02-14', 400); -- Masuk ke partisi 4

-- 5. MELIHAT DATA BERADA DI PARTISI MANA
SELECT 
    p.partition_number,
    p.rows,
    fg.name AS FileGroupName
FROM sys.partitions p
JOIN sys.indexes i ON p.object_id = i.object_id AND p.index_id = i.index_id
JOIN sys.partition_schemes ps ON i.data_space_id = ps.data_space_id
JOIN sys.destination_data_spaces dds ON ps.data_space_id = dds.partition_scheme_id AND p.partition_number = dds.destination_id
JOIN sys.filegroups fg ON dds.data_space_id = fg.data_space_id
WHERE p.object_id = OBJECT_ID('PartitionedSales') AND i.index_id <= 1;

-- CLEANUP
-- DROP TABLE PartitionedSales;
-- DROP PARTITION SCHEME ps_YearlyPartition;
-- DROP PARTITION FUNCTION pf_YearlyPartition;
