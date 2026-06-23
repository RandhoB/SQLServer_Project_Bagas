-- =======================================================================
-- PRAKTIK EXPERT SQL SERVER 
-- =======================================================================
-- Script ini berisi teknik Troubleshooting & Advanced T-SQL yang sering dipakai DBA konsultan.

USE FreelanceDB;
GO

-- ---------------------------------------------------------
-- 1. ADVANCED T-SQL: COMMON TABLE EXPRESSION (CTE)
-- Menyederhanakan query yang kompleks menjadi sub-query yang mudah dibaca
-- ---------------------------------------------------------

-- Menghitung jumlah proyek per Klien menggunakan CTE
WITH CTE_RingkasanProyek AS (
    SELECT 
        KlienID,
        COUNT(ProyekID) AS TotalProyek,
        SUM(NilaiKontrak) AS TotalNilai
    FROM Proyek
    GROUP BY KlienID
)
SELECT 
    k.NamaPerusahaan,
    c.TotalProyek,
    c.TotalNilai
FROM Klien k
JOIN CTE_RingkasanProyek c ON k.KlienID = c.KlienID;
GO

-- ---------------------------------------------------------
-- 2. ADVANCED T-SQL: WINDOW FUNCTIONS
-- Membuat Ranking (Peringkat) tanpa mengubah struktur jumlah baris (tanpa GROUP BY biasa)
-- ---------------------------------------------------------

-- Menampilkan peringkat Klien berdasarkan Nilai Kontrak paling tinggi 
SELECT 
    k.NamaPerusahaan,
    p.NamaProyek,
    p.NilaiKontrak,
    ROW_NUMBER() OVER(PARTITION BY p.KlienID ORDER BY p.NilaiKontrak DESC) AS RankingProyekPerKlien
FROM Proyek p
JOIN Klien k ON p.KlienID = k.KlienID;
GO

-- ---------------------------------------------------------
-- 3. MENGUKUR PERFORMA QUERY (Query Statistics)
-- Sering digunakan saat akan melakukan Tuning Query
-- ---------------------------------------------------------

-- Menyalakan pengukur waktu dan bacaan ke memori
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

-- Jalankan query untuk diuji
SELECT * FROM Proyek WHERE NamaProyek LIKE '%Data%';

-- Matikan kembali
SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
-- (Cek tab "Messages" di SSMS untuk melihat berapa Logical Reads yang digunakan query di atas)
GO

-- ---------------------------------------------------------
-- 4. PERFORMANCE TUNING: MELIHAT FRAGMENTASI INDEX
-- Menentukan apakah Index butuh Rebuild atau Reorganize
-- ---------------------------------------------------------

-- Cek Fragmentasi di database 'FreelanceDB' (Sangat penting bagi DBA!)
SELECT 
    dbschemas.[name] AS NamaSchema,
    dbtables.[name] AS NamaTabel,
    dbindexes.[name] AS NamaIndex,
    indexstats.avg_fragmentation_in_percent AS PersentaseFragmentasi
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, 'LIMITED') AS indexstats
INNER JOIN sys.tables dbtables ON dbtables.[object_id] = indexstats.[object_id]
INNER JOIN sys.schemas dbschemas ON dbtables.[schema_id] = dbschemas.[schema_id]
INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id] 
AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.database_id = DB_ID()
AND indexstats.avg_fragmentation_in_percent > 5.0; -- Hanya tampilkan yg > 5%
GO

-- Cara merapikan index jika persentase di atas 30% (REBUILD)
ALTER INDEX [NamaIndex] ON [NamaSchema].[NamaTabel] REBUILD;
-- Cara merapikan index jika persentase antara 5% - 30% (REORGANIZE)
ALTER INDEX [NamaIndex] ON [NamaSchema].[NamaTabel] REORGANIZE;

-- ---------------------------------------------------------
-- 5. TROUBLESHOOTING: DMVs (Dynamic Management Views)
-- Mencari Query mana yang paling membebani CPU (Top 5 Paling Berat)
-- ---------------------------------------------------------

-- Menemukan 5 Query terberat di server berdasarkan penggunaan Total Worker Time (CPU)
SELECT TOP 5
    st.text AS [Teks Query],
    qs.execution_count AS [Jumlah Eksekusi],
    qs.total_worker_time AS [Total CPU Time],
    (qs.total_worker_time / qs.execution_count) AS [Rata-rata CPU Time],
    qs.total_logical_reads AS [Total Bacaan Logikal],
    qp.query_plan AS [Rencana Eksekusi (Execution Plan)]
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st
CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) AS qp
ORDER BY qs.total_worker_time DESC;
GO

-- ---------------------------------------------------------
-- 6. DETEKSI BLOCKING / DEADLOCK
-- Siapa (Session ID) yang mengunci data dan membuat aplikasi hang?
-- ---------------------------------------------------------

-- Melihat Session ID (SPID) yang sedang mengeblok proses lain
SELECT 
    session_id AS [SPID Yang Diblokir],
    blocking_session_id AS [SPID Pengeblok],
    wait_time AS [Waktu Menunggu (ms)],
    wait_type AS [Tipe Tunggu],
    text AS [Query yang Menunggu]
FROM sys.dm_exec_requests
CROSS APPLY sys.dm_exec_sql_text(sql_handle)
WHERE blocking_session_id > 0;
GO

-- Jika sudah dipastikan SPID Pengeblok harus dihentikan:
KILL [SPID Pengeblok]; -- Hati-hati menggunakan ini di Production!

-- =======================================================================
-- AKHIR DARI PRAKTIK EXPERT
-- =======================================================================
