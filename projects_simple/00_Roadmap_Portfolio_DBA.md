# Roadmap Proyek Portofolio Freelance DBA SQL Server

Untuk bisa "menjual diri" di platform *freelance* seperti Upwork, Fiverr, atau ke perusahaan lokal, Anda tidak bisa hanya bermodal teori. Klien mencari pemecah masalah (*problem solver*).

Berikut adalah **5 Kasus Dunia Nyata** yang mencakup 100% tugas harian seorang DBA profesional. Jadikan kelima kasus ini sebagai **Portofolio** Anda. Jika Anda berhasil memecahkan kelimanya, Anda sudah siap menerima bayaran profesional.

---

## 💼 Proyek 1: "Query Super Lambat di Aplikasi E-Commerce" (Performance Tuning)
- **Konteks Bisnis**: Klien memiliki toko *online*. Saat ada promo besar, halaman pencarian produk sangat lambat (memakan waktu 15 detik), menyebabkan pelanggan kabur.
- **Tugas Anda**: 
  1. Melakukan *generate* jutaan baris data dummy.
  2. Menganalisis *Execution Plan* dan *DMV* untuk menemukan leher botol (*bottleneck*).
  3. Merancang **Index** yang tepat tanpa membebani proses transaksi kasir.
- **Lokasi File**: Folder `Case_01_Performance_Tuning`

## 💼 Proyek 2: "Bencana File Log Membengkak 500GB" (Storage & Maintenance)
- **Konteks Bisnis**: Klien panik pada hari Senin pagi karena aplikasi error dengan pesan *"Transaction log for database is full"*. File `.ldf` membengkak hingga ratusan Gigabyte sedangkan kapasitas Hardisk Server sudah merah (0 Byte tersisa).
- **Tugas Anda**:
  1. Menemukan alasan kenapa file Log tidak terpotong otomatis (*truncate*).
  2. Melakukan *Shrink File* darurat dengan aman tanpa merusak database.
  3. Mengubah arsitektur *Recovery Model* dan mengatur *Automated Maintenance Plan*.

## 💼 Proyek 3: "Hacker / Vendor Nakal & Security Audit" (Security & Compliance)
- **Konteks Bisnis**: Perusahaan klien baru saja bermasalah dengan vendor IT lama dan mencabut kontrak. Klien takut ada data keuangan yang dicuri atau *backdoor* (akses tersembunyi).
- **Tugas Anda**:
  1. Melakukan audit semua *Logins* dengan hak akses `sysadmin` bawaan.
  2. Membuat *Custom Database Roles* sesuai standar ISO. Tim Marketing hanya boleh `SELECT`, Tim Developer tidak boleh perintah `DROP` tabel, dll.
  3. Mengaktifkan fitur *Transparent Data Encryption (TDE)* atau *Data Masking* untuk menyembunyikan nomor kartu kredit pelanggan.

## 💼 Proyek 4: "Point-in-Time Recovery dari Serangan Ransomware" (Disaster Recovery)
- **Konteks Bisnis**: Hari Rabu pukul 10:15 pagi, server terkena Ransomware yang mengenkripsi semua file. Klien memiliki *Full Backup* dari jam 00:00 tengah malam, dan *Transaction Log Backup* setiap jam.
- **Tugas Anda**:
  1. Menyelamatkan sistem (Restore Database).
  2. Melakukan teknik **Tail-Log Backup** dan **Point-in-Time Recovery** untuk mengembalikan database persis ke jam **10:14:59 pagi** sehingga data penjualan dari jam 8 pagi tidak hilang.

## 💼 Proyek 5: "Migrasi Data Warisan dari Excel ke Database" (Data Engineering / ETL)
- **Konteks Bisnis**: Klien memiliki data penjualan 10 tahun ke belakang dalam bentuk ribuan file CSV/Excel yang formatnya berantakan. Mereka ingin memindahkannya ke SQL Server agar bisa diproses ke PowerBI.
- **Tugas Anda**:
  1. Merancang skema *Data Warehouse* dasar (Tabel Fakta dan Dimensi).
  2. Menulis *script* `BULK INSERT` untuk menyedot data dari CSV ratusan MB dalam hitungan detik.
  3. Membuat proses pembersihan data (T-SQL untuk mengubah format tanggal yang salah atau menghapus duplikat).

---
**💡 Catatan:**
Untuk mulai berlatih, saya telah menyiapkan bahan-bahan untuk **Proyek 1** di dalam folder `Case_01_Performance_Tuning`. Silakan buka folder tersebut dan ikuti instruksi pertamanya!
