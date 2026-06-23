# Case 2: "Bencana File Log Membengkak 500GB"

## Latar Belakang Masalah
Klien menelepon Anda pagi-pagi sekali:
*"Aplikasi kami mati total! Muncul error 'The transaction log for database is full'. Kami cek hardisk server (Drive D:), ternyata tersisa 0 Byte! File Data (.mdf) kami hanya 2 GB, tapi file Log (.ldf) ukurannya mencapai 500 GB! Tolong perbaiki tanpa mematikan server!"*

## Langkah Persiapan (Setup)
Jalankan file **`01_Setup_Problem.sql`**. Script ini mensimulasikan situasi di mana `Recovery Model` database diset ke `FULL`, dan banyak transaksi besar (Insert/Delete) terjadi tanpa pernah ada *Log Backup*.

## Tugas Anda (Sebagai DBA)
1. **Analisa Ruang Penyimpanan Log**
   Jalankan perintah ini untuk melihat status log file:
   ```sql
   DBCC SQLPERF(LOGSPACE);
   ```
   *Anda akan melihat `LogBengkakDB` memiliki persentase Log Space Used yang tinggi.*

2. **Lakukan Penyelamatan Darurat (Backup Log & Shrink)**
   Sebagai DBA, Anda tidak boleh sembarangan menghapus file log dari Windows Explorer (itu akan membuat database *corrupt* mati total).
   
   **Tugas Anda:**
   - Lakukan **Transaction Log Backup** ke disk lain (atau ubah `Recovery Model` ke `SIMPLE` sementara jika data log historis tidak penting).
   - Setelah Log di-backup/di-truncate, jalankan perintah **SHRINK FILE** untuk mengembalikan *free space* ke Windows (Hardisk server).
   - *Clue untuk Shrink*: Gunakan `DBCC SHRINKFILE (N'LogBengkakDB_log', 10);` untuk menyusutkan log menjadi 10 MB.

3. **Mencegah Masalah Terulang**
   - Rancang jadwal (Maintenance Plan) untuk selalu mem-backup Transaction Log setiap jam agar log terpotong otomatis dan tidak terus membengkak.
