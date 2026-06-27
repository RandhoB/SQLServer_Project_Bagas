-- ====================================================================
-- Project 10: Dynamic DB Maintenance
-- Topik: Automated Index Rebuild menggunakan DMV
-- ====================================================================

-- Catatan: Script ini sangat lazim dijalankan oleh SQL Server Agent tiap akhir pekan

-- 1. SOLUSI: Dynamic Cursor + DMV
DECLARE @TableName VARCHAR(255);
DECLARE @IndexName VARCHAR(255);
DECLARE @Fragmentation FLOAT;
DECLARE @SQL NVARCHAR(MAX);

-- Membuat Cursor untuk iterasi setiap Index yang fragmentasinya tinggi
DECLARE IndexCursor CURSOR FOR
SELECT 
    OBJECT_NAME(ps.object_id) AS TableName, 
    i.name AS IndexName, 
    ps.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') ps
JOIN sys.indexes i ON ps.object_id = i.object_id AND ps.index_id = i.index_id
WHERE ps.avg_fragmentation_in_percent > 10.0 -- Hanya proses yang terfragmentasi di atas 10%
  AND i.index_id > 0 -- Abaikan Heap
  AND i.name IS NOT NULL;

OPEN IndexCursor;
FETCH NEXT FROM IndexCursor INTO @TableName, @IndexName, @Fragmentation;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Logika IF: Reorganize untuk fragmentasi sedang, Rebuild untuk fragmentasi parah
    IF @Fragmentation < 30.0
    BEGIN
        SET @SQL = 'ALTER INDEX [' + @IndexName + '] ON [' + @TableName + '] REORGANIZE;';
        PRINT 'Reorganizing Index: ' + @IndexName + ' on ' + @TableName + ' (Frag: ' + CAST(@Fragmentation AS VARCHAR) + '%)';
    END
    ELSE
    BEGIN
        SET @SQL = 'ALTER INDEX [' + @IndexName + '] ON [' + @TableName + '] REBUILD WITH (ONLINE = ON);'; 
        -- ONLINE=ON (hanya jalan di Enterprise Edition), ganti ke OFF jika error di versi Standard
        PRINT 'Rebuilding Index: ' + @IndexName + ' on ' + @TableName + ' (Frag: ' + CAST(@Fragmentation AS VARCHAR) + '%)';
    END
    
    -- Eksekusi Dynamic SQL (Uncomment line di bawah untuk menjalankan beneran)
    -- EXEC sp_executesql @SQL;

    FETCH NEXT FROM IndexCursor INTO @TableName, @IndexName, @Fragmentation;
END;

CLOSE IndexCursor;
DEALLOCATE IndexCursor;

PRINT 'Maintenance Selesai.';
