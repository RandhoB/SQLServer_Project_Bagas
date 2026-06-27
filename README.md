# SQL Server Mastery Portfolio 🚀

Selamat datang di repositori portofolio SQL Server saya! Repositori ini merupakan kumpulan lengkap proyek-proyek database yang dirancang untuk mensimulasikan kasus-kasus nyata di dunia industri. Proyek diurutkan dari pemahaman fundamental hingga studi kasus skala *Enterprise* yang biasa ditangani oleh *Database Administrator* (DBA) dan *Data Engineer* profesional.

## 📂 Struktur Repositori

Repositori ini dibagi menjadi 5 tingkatan utama (berdasarkan folder):

### 1. `dasar/` (Fundamental)
Berisi kueri-kueri esensial dan konsep dasar manipulasi data menggunakan T-SQL. Sangat cocok sebagai pengenalan atau *refresher* logika dasar SQL.

### 2. `projects_simple/` (Basic DBA Cases)
Fokus pada tugas-tugas fundamental seorang Database Administrator. Anda akan menemukan simulasi pemecahan masalah seperti:
- Performance Tuning Dasar
- Storage Maintenance
- Security & Auditing Dasar
- Disaster Recovery (Backup/Restore)
- Data Migration (ETL Dasar)

### 3. `projects_intermediete/` (Data Analyst & Backend Dev)
Kumpulan 10 proyek analitik dan *backend* tingkat menengah yang menggunakan fitur T-SQL modern:
- Window Functions (`SUM OVER`, `RANK`)
- Common Table Expressions (CTE) & Recursive CTE
- Pembuatan Trigger dan Stored Procedures
- Teknik *Pivot* dan *Data Deduplication*
- *MERGE* Statement untuk ETL

### 4. `projects_expert/` (Data Architect & Senior DBA)
Studi kasus tingkat lanjut yang berfokus pada performa skala besar dan arsitektur data:
- Desain Data Warehouse (Star Schema & SCD Type 2)
- Table Partitioning untuk *Big Data* (Archiving)
- *JSON/XML Shredding* menggunakan `OPENJSON`
- Keamanan tingkat *Enterprise* (*Row-Level Security* & *Dynamic Data Masking*)
- Fitur *Graph Database* (Node & Edge)

### 5. `projects_masterclass/` (Freelance & Job-Ready Secrets)
Modul pamungkas berisi trik dan rahasia industri yang sering ditanyakan saat *technical interview* atau di-request oleh klien *freelance*:
- Menyelesaikan masalah performa kronis akibat **Parameter Sniffing**
- Trik optimasi kueri lambat: Refactoring kode *Cursor* (RBAR) dan *Scalar UDF* menjadi *Set-Based* dan *iTVF*
- Penggunaan *Indexed Views* (Materialized) untuk mempercepat muat *Dashboard BI*
- *Spatial Data* (Geolocation / Peta Bumi) untuk perhitungan jarak koordinat GPS
- *Bulk Import/Export* data raksasa dalam hitungan detik
- Strategi Kompresi Data (Page/Row) untuk penghematan tajam pada *storage server*

---

## 🛠️ Cara Menggunakan Repositori Ini

1. **Jelajahi setiap folder secara berurutan** jika Anda ingin belajar dari nol hingga mahir.
2. Setiap proyek dibuat dalam format file **`.sql`** mandiri yang terisolasi.
3. Di dalam setiap file `.sql`, sudah tertulis urutan lengkap: **DDL** (pembuatan tabel), **DML** (pengisian data *dummy*/uji coba), dan **solusi pemecahan masalahnya**.
4. **Sangat disarankan** untuk mengeksekusi skrip-skrip ini pada database uji coba (*sandbox*) di SQL Server Management Studio (SSMS) atau Azure Data Studio Anda agar tidak mengotori tabel produksi.

## 💼 Tentang Penulis
Repositori ini didedikasikan untuk mendemonstrasikan keahlian *End-to-End* pada ekosistem Microsoft SQL Server. Jika Anda merekrut untuk peran *Data Engineer*, *Database Administrator*, atau mencari *Freelancer* untuk membasmi kueri lambat di sistem Anda, silakan hubungi saya melalui profil GitHub ini!

---
*Dibangun dengan dedikasi untuk industri Data. Happy Querying!*
