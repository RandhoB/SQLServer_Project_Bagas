# Case 1: "Query Super Lambat di Aplikasi E-Commerce"

## Latar Belakang Masalah
Klien menghubungi Anda dengan panik: 
*"Aplikasi kami sangat lambat! Saat tim manajemen mau menarik laporan total penjualan status 'PENDING' untuk rentang waktu bulan lalu, sistem kami hang dan loading tidak selesai-selesai."*

## Langkah Persiapan (Setup)
Silakan eksekusi file **`01_Setup_Problem.sql`** di SSMS / Azure Data Studio Anda. Script ini akan membuat database `TokoOnlineDB` dan mengisi **500.000 baris** data penjualan secara acak. (Tunggu sekitar 1-3 menit sampai selesai).

## Tugas Anda (Sebagai DBA)
Jalankan skenario pemecahan masalah berikut:

1. **Simulasikan Masalahnya**
   Jalankan query ini dan nyalakan fitur `STATISTICS IO` dan tampilkan *Execution Plan* (Ctrl+M di SSMS).
   ```sql
   SET STATISTICS IO ON;
   SELECT * FROM TransaksiPenjualan
   WHERE StatusPesanan = 'PENDING' 
     AND TanggalTransaksi >= '2024-01-01' 
     AND TanggalTransaksi <= '2024-12-31';
   ```
   *Perhatikan berapa besar "Logical Reads" di tab Messages. Anda akan melihat SQL Server harus membaca seluruh tabel dari awal sampai akhir (Table Scan).*

2. **Perbaiki Strukturnya (Indexing)**
   Sebagai DBA, Anda tahu bahwa mencari data di tabel tanpa *Index* ibarat mencari nama orang di buku telepon yang halamannya teracak.
   **Tugas 1**: Tambahkan `PRIMARY KEY` (Clustered Index) pada tabel `TransaksiPenjualan`.
   **Tugas 2**: Buat `NONCLUSTERED INDEX` khusus pada kolom yang dicari di klausa `WHERE` (yaitu `StatusPesanan` dan `TanggalTransaksi`).

3. **Uji Coba Hasil Tuning**
   Setelah Index dibuat, jalankan kembali query nomor 1.
   Bandingkan angka "Logical Reads" sebelum dan sesudahnya. Jika angkanya turun drastis dari puluhan ribu menjadi hanya puluhan/ratusan saja, maka Anda **BERHASIL** menjadi Performance Tuning DBA!

---
**Beritahu saya jika Anda berhasil memecahkan Case 1 ini, atau jika Anda butuh contekan jawaban dari DBA Profesional!**
