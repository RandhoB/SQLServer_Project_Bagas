# 10 Project SQL Server - Tingkat Expert (Advanced & Enterprise Cases)

Berikut adalah daftar proyek SQL Server tingkat Expert (Mahir). Proyek-proyek ini difokuskan pada arsitektur data, optimalisasi performa tingkat lanjut (performance tuning), keamanan data (security), dan administrasi database skala Enterprise:

## 1. Data Warehouse: Star Schema & Surrogate Keys
**Topik:** OLAP Design, Fact & Dimension Tables, Surrogate Keys
**Deskripsi:** Merancang struktur *Data Warehouse* (Star Schema) menggunakan tabel Fakta (Fact) dan Dimensi (Dimension), serta mengimplementasikan teknik Slowly Changing Dimension (SCD) Tipe 2 untuk merekam perubahan historis dari suatu dimensi (misalnya perubahan alamat pelanggan).

## 2. Advanced Performance Tuning & Indexing Strategy
**Topik:** Execution Plans, Non-clustered Indexes, Covering Indexes
**Deskripsi:** Menganalisis dan mengoptimalkan *slow-running query*. Membuat simulasi *Table Scan* besar-besaran, kemudian menyelesaikannya dengan pembuatan *Covering Index* dan *Filtered Index* untuk menurunkan *cost* eksekusi secara drastis.

## 3. Concurrency, Isolation Levels & Handling Deadlocks
**Topik:** Transaction Isolation Levels (RCSI, Serializable, Repeatable Read)
**Deskripsi:** Membuat skenario transaksi konkuren (bersamaan) yang berpotensi menghasilkan *Deadlock* atau *Dirty Read*. Menggunakan `TRY...CATCH` dan level isolasi (misalnya *Snapshot Isolation*) untuk menjamin konsistensi data finansial.

## 4. Advanced JSON & XML Data Shredding
**Topik:** `OPENJSON`, `FOR JSON`, XML `nodes()`
**Deskripsi:** Mengekstrak, mem-parsing (shredding), dan mengubah jutaan log data mentah berbentuk JSON/XML (dari NoSQL/API) menjadi bentuk relasional yang rapi agar bisa di-*join* dengan tabel standar.

## 5. Table Partitioning for Big Data
**Topik:** Partition Functions, Partition Schemes, Sliding Window
**Deskripsi:** Mengimplementasikan partisi tabel pada tabel transaksi yang berukuran raksasa berdasarkan tahun/bulan (misal: memisahkan partisi file untuk data 2022, 2023, 2024). Ini berguna untuk manajemen *archiving* (*sliding window partition*).

## 6. Complex Aggregations: CUBE, ROLLUP, & GROUPING SETS
**Topik:** Advanced `GROUP BY`
**Deskripsi:** Menulis satu kueri *Grand Total* dan *Subtotal* multi-dimensi (Berdasarkan Kategori, Region, dan Tahun) secara bersamaan menggunakan `GROUPING SETS` dan `CUBE`, yang biasa digunakan untuk *dashboarding*.

## 7. Graph Database Capabilities (Nodes & Edges)
**Topik:** SQL Graph (Tersedia mulai SQL Server 2017+)
**Deskripsi:** Membangun *Recommendation Engine* atau analisis relasi (mirip *Social Media* "Teman dari Teman") menggunakan tabel tipe `NODE` dan `EDGE` serta klausa fungsi `MATCH()`.

## 8. Enterprise Security: Row-Level Security (RLS) & Dynamic Data Masking (DDM)
**Topik:** RLS, DDM
**Deskripsi:** Mengamankan data medis atau finansial. *Row-Level Security* membatasi tenaga penjual/dokter agar hanya bisa melihat datanya sendiri. *Dynamic Data Masking* akan menyembunyikan/menyamarkan nomor kartu kredit (menjadi `XXXX-XXXX-...`) bagi user tanpa hak akses khusus.

## 9. Advanced Error Handling & Custom Logging
**Topik:** `TRY...CATCH`, `XACT_ABORT`, `THROW`, Error Logging Tables
**Deskripsi:** Membangun *Framework* penanganan error (*Error Handling*) standar Enterprise. Jika transaksi gagal, prosedur akan melakukan `ROLLBACK`, merekam detail error (Error Line, Error State, Error Message) ke tabel log otomatis, dan melakukan *re-throw* error tersebut.

## 10. Dynamic DB Maintenance: Automated Index Rebuild
**Topik:** Dynamic SQL, System Catalog Views (`sys.dm_db_index_physical_stats`)
**Deskripsi:** Membuat skrip *maintenance* cerdas berbasis DMV (Dynamic Management Views). Skrip ini akan secara otomatis mencari indeks mana saja yang mengalami fragmentasi di atas 30%, lalu men-generate dan mengeksekusi perintah `ALTER INDEX REBUILD` secara dinamis.

---

**Tahapan Implementasi:**
Sama seperti pada folder sebelumnya, setiap project akan dibuat dalam file skrip `.sql` terpisah yang berisi DDL, DML, dan solusi T-SQL tingkat lanjutnya.
