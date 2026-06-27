# Case 4: "Point-in-Time Recovery dari Serangan Ransomware"

## Latar Belakang Masalah
Klien menangis saat menelepon Anda jam 10:15 pagi.
*"Database kami terhapus (di-DROP) secara tidak sengaja oleh tim internal jam 10:05 pagi tadi! Padahal banyak transaksi masuk antara jam 09:00 sampai 10:00! Apakah data penjualan jam 10 pagi akan hilang selamanya?"*

## Langkah Persiapan (Setup)
Jalankan file **`01_Setup_Problem.sql`**. **PENTING**: Anda harus menjalankan secara manual perintah `BACKUP DATABASE` dan `BACKUP LOG` yang ada di dalam komen script tersebut (sesuaikan path foldernya dengan OS Mac/Docker/Windows Anda).

Lalu, **BUAT BENCANANYA**: Jalankan perintah ini untuk menghapus tabel dan datanya secara tidak sengaja:
```sql
USE DisasterDB;
DROP TABLE DataPenjualan; -- UPS!
```

## Tugas Anda (Sebagai DBA)
Bisakah Anda mengembalikan data jam 10:00 pagi tanpa kehilangan satu transaksi pun?

1. **Amankan Log Ekor (Tail-Log Backup)**
   Sesaat setelah tabel terhapus, SQL Server MASIH mencatat transaksi (termasuk perintah DROP) di file Log aktif. Lakukan backup darurat dengan `BACKUP LOG ... WITH NORECOVERY` (Ini disebut Tail-Log Backup).

2. **Proses Recovery (Restore)**
   Lakukan langkah berurutan secara hati-hati:
   - Restore **FULL BACKUP** (Jam 08:00) menggunakan `WITH NORECOVERY`.
   - Restore **LOG BACKUP 1** (Jam 09:00) menggunakan `WITH NORECOVERY`.
   - Restore **TAIL-LOG BACKUP** menggunakan metode **STOPAT**:
     `WITH STOPAT = '2024-01-01 10:04:59', RECOVERY`.
     *Artinya: "SQL Server, putar ulang semua transaksi dari log ini, TAPI BERHENTI 1 detik sebelum si pelaku mengeksekusi perintah DROP TABLE"*.

Jika setelah `RESTORE` Anda melakukan `SELECT * FROM DataPenjualan` dan data jam 10:00 masih ada, Anda adalah **Dewa Penyelamat (Hero)** di mata Klien!
