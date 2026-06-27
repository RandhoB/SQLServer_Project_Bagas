# Case 5: "Migrasi Data Warisan dari Excel ke Database" (Data Engineering)

## Latar Belakang Masalah
Klien memiliki bisnis yang berumur 10 tahun. Selama ini pencatatan penjualan hanya di Excel yang dikerjakan oleh 10 admin berbeda. Akibatnya format tanggal, format mata uang, dan teks sangat tidak standar (*Data Dirty*). Klien menugaskan Anda (DBA & Data Engineer) untuk membersihkannya dan memindahkannya ke tabel yang *Strict* tipe datanya.

## Langkah Persiapan (Setup)
Jalankan file **`01_Setup_Problem.sql`**. Script ini membuat tabel penampung sementara (`Staging_DataExcel`) yang tipe datanya sengaja dibuat teks `VARCHAR` semua karena isinya kotor.

Lalu, dibuat juga tabel tujuan utama (`Fact_Penjualan`) yang ketat (`DATE`, `DECIMAL`). Jika data kotor langsung dimasukkan ke tabel tujuan, SQL Server akan langsung memunculkan "Conversion failed error".

## Tugas Anda (Sebagai DBA / Data Engineer)
Tulislah sebuah **Script T-SQL (atau Stored Procedure)** yang membaca data dari tabel `Staging_DataExcel`, lalu *membersihkannya* (Data Cleansing) saat dalam perjalanan dimasukkan (INSERT) ke `Fact_Penjualan`.

**Aturan Pembersihan yang harus Anda buat (Logika ETL):**
1. Jika "Tanggal" berisi string `'NULL'` atau kosong `''`, ubah menjadi tanggal hari ini (`GETDATE()`).
2. Format tanggal yang berantakan seperti `24-02-2024` (DD-MM-YYYY) atau pakai garis miring `2024/01/01`, harus diconvert dengan aman menggunakan fungsi `TRY_CAST` atau `TRY_CONVERT`.
3. Format harga yang mengandung titik (`50.000`) atau koma (`100,000`) harus dihilangkan karakter tanda bacanya menggunakan fungsi `REPLACE()`, sehingga menjadi tipe angka `50000` dan `100000`.

**Cek Keberhasilan:**
Jika berhasil, query ini:
```sql
SELECT * FROM Fact_Penjualan;
```
Harus menampilkan data rapi tanpa ada *error conversion*!
