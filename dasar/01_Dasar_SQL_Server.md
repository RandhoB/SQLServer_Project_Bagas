# Panduan Dasar SQL Server untuk Calon Freelance DBA

Halo! Menjadi seorang Database Administrator (DBA) SQL Server freelance yang handal adalah tujuan yang sangat bagus dan prospektif. Untuk mencapai tahap itu, Anda harus menguasai pondasi dasar SQL Server sebelum masuk ke tingkat lanjut (seperti Performance Tuning, High Availability, dll).

Folder ini berisikan konsep dan praktik dasar yang **wajib** Anda kuasai sebagai langkah pertama.

## 1. Arsitektur Dasar Database SQL Server
Setiap kali Anda menginstal SQL Server, Anda akan memiliki **System Databases** yang mengatur berjalannya server, yaitu:
- **master**: Jantung dari SQL Server. Menyimpan semua konfigurasi level server, daftar login, dan informasi semua database lain.
- **model**: Template untuk membuat database baru. Jika Anda ingin setiap database baru memiliki tabel atau standar tertentu, ubah di database model.
- **msdb**: Digunakan oleh SQL Server Agent untuk menjadwalkan pekerjaan (jobs), peringatan (alerts), dan menyimpan histori backup.
- **tempdb**: Ruang kerja sementara. Menyimpan tabel sementara (`#temp`), variabel tabel, dan hasil sorting yang besar. Akan di-reset setiap kali SQL Server di-restart.

## 2. Kategori Perintah SQL (T-SQL)
SQL Server menggunakan bahasa **Transact-SQL (T-SQL)**. T-SQL dibagi menjadi beberapa kategori utama:
1. **DDL (Data Definition Language)**: Perintah untuk mendefinisikan struktur objek database (contoh: `CREATE`, `ALTER`, `DROP`).
2. **DML (Data Manipulation Language)**: Perintah untuk memanipulasi data di dalam tabel (contoh: `SELECT`, `INSERT`, `UPDATE`, `DELETE`).
3. **DCL (Data Control Language)**: Perintah untuk mengontrol hak akses (penting untuk DBA) (contoh: `GRANT`, `REVOKE`, `DENY`).
4. **TCL (Transaction Control Language)**: Perintah untuk mengelola transaksi database (contoh: `BEGIN TRAN`, `COMMIT`, `ROLLBACK`).

## 3. Apa yang biasa dilakukan Freelance DBA?
Sebagai freelancer, klien biasanya akan menyewa Anda untuk tugas-tugas berikut:
1. **Instalasi & Konfigurasi Awal**: Memastikan SQL Server diinstal dengan *best practice* (memisahkan partisi untuk Data, Log, dan TempDB).
2. **Backup & Restore**: Merancang strategi backup agar jika server rusak, data tidak hilang.
3. **User Management**: Memberikan akses kepada programmer atau analis data, tapi membatasi agar mereka tidak bisa merusak sistem (Security).
4. **Performance Tuning**: Membuat query yang lambat menjadi cepat, serta menambahkan index.
5. **Monitoring & Maintenance**: Mengecek apakah ada file database yang hampir penuh, merapikan index (Rebuild/Reorganize), dan mengecek *error logs*.

## 4. Langkah Selanjutnya
Silakan buka file **`02_Query_Praktik.sql`** di folder ini. Anda bisa meng-copy script tersebut dan menjalankannya (Execute) secara bertahap di aplikasi **SQL Server Management Studio (SSMS)** atau **Azure Data Studio**. Script tersebut berisi perintah dasar yang paling sering digunakan sehari-hari.
