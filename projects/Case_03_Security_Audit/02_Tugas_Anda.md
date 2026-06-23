# Case 3: "Hacker / Vendor Nakal & Security Audit"

## Latar Belakang Masalah
Klien baru saja memberhentikan paksa perusahaan IT *outsourcing* yang lama karena sengketa. Mereka menyewa Anda karena takut IT lama memasang *backdoor* atau masih memiliki akses `sysadmin` (akses level dewa) ke data keuangan gaji dan kartu kredit.

## Langkah Persiapan (Setup)
Jalankan file **`01_Setup_Problem.sql`**. Script ini membuat tabel data gaji dan kartu kredit. Di luar sepengetahuan klien, ada akun bernama `VendorLamaIT` yang memiliki peran `sysadmin`.

## Tugas Anda (Sebagai DBA)
1. **Audit Akun 'Dewa' (Sysadmin)**
   Jari-jari hacker biasanya masuk menggunakan akun `sysadmin`. Cek siapa saja yang punya hak akses ini di server Anda menggunakan script ini:
   ```sql
   SELECT loginname FROM syslogins WHERE sysadmin = 1;
   ```
   **Tugas 1:** Cabut akses `sysadmin` dari `VendorLamaIT` dan `DISABLE` login tersebut (jangan di-DROP langsung untuk barang bukti forensik).

2. **Membuat Role Khusus yang Aman (Least Privilege Principle)**
   Ada karyawan baru di tim Marketing bernama `Anwar`. Dia butuh akses ke tabel Karyawan, tetapi **tidak boleh melihat** kolom `Gaji` dan `KartuKredit`.
   
   **Tugas 2:** 
   - Buat `LOGIN Anwar` dan `USER Anwar` di `KeamananDB`.
   - Gunakan `GRANT SELECT ON DataKaryawan (Nama, Jabatan) TO Anwar;` agar Anwar hanya bisa melihat kolom yang aman. Jangan berikan akses full `db_datareader`.

3. **Bonus (Standar Enterprise): Dynamic Data Masking**
   Untuk tingkat lebih *expert*, SQL Server memiliki fitur *Data Masking*. Terapkan *masking* pada kolom `KartuKredit` sehingga yang tampil bagi user biasa hanya format: `XXXX-XXXX-XXXX-4444`.
