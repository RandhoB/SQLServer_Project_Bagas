# Panduan Intermediate SQL Server untuk Freelance DBA

Selamat! Anda telah memahami fundamental dari SQL Server. Di level *intermediate* ini, kita akan masuk ke dalam fitur-fitur yang akan sangat sering Anda temui atau buat, baik untuk mempermudah pekerjaan developer (programmer) maupun untuk mengamankan & mengoptimalkan database.

Sebagai Freelance DBA, klien sering meminta Anda untuk memperbaiki *query* yang lambat, membuat alur logika otomatis di dalam database, atau mencatat (audit) perubahan data yang sensitif.

Berikut adalah 6 konsep utama di level *Intermediate*:

## 1. Views
**View** adalah *virtual table* (tabel virtual) yang merupakan hasil dari query `SELECT`.
- **Fungsi**: Menyederhanakan query yang rumit (seperti `JOIN` dari 5 tabel berbeda) menjadi satu panggilan sederhana. View juga berguna untuk keamanan (menyembunyikan kolom rahasia seperti gaji atau password dari *user* biasa).

## 2. Stored Procedures (SP)
**Stored Procedure** adalah sekumpulan perintah T-SQL yang disimpan di database dan bisa dieksekusi berkali-kali. 
- **Fungsi**: Mengenkapsulasi logika bisnis, menerima parameter input, dan mencegah **SQL Injection**. Mayoritas aplikasi profesional tidak memanggil perintah `INSERT` / `UPDATE` langsung dari kode (misal Python/C#), melainkan memanggil Stored Procedure.

## 3. User Defined Functions (UDF)
Hampir sama seperti SP, tetapi **Function** harus selalu mengembalikan nilai (return value) dan dapat disematkan langsung di dalam query `SELECT`.
- **Contoh**: Membuat fungsi untuk menghitung total pajak (PPN) dari suatu nominal.

## 4. Triggers
**Trigger** adalah prosedur spesial yang akan *otomatis tereksekusi* ketika terjadi *event* `INSERT`, `UPDATE`, atau `DELETE` pada suatu tabel.
- **Fungsi (Penting untuk DBA)**: Sering digunakan untuk **Audit Log** (mencatat riwayat perubahan data, siapa yang mengubah, dan kapan).

## 5. Indexes (Fundamental Performance Tuning)
Jika database ibarat sebuah buku yang tebal, **Index** adalah daftar isi. Tanpa index, SQL Server harus membaca data dari baris pertama hingga terakhir (Full Table Scan) yang sangat lambat.
- **Clustered Index**: Secara fisik mengurutkan baris data di tabel. Hanya bisa ada 1 per tabel (biasanya `PRIMARY KEY`).
- **Non-Clustered Index**: Menyimpan daftar indeks secara terpisah dari data asli. Sangat bagus untuk kolom yang sering dicari di `WHERE`.

## 6. Transactions & Error Handling (TRY...CATCH)
Sebuah **Transaction** menjamin bahwa kumpulan perintah SQL berhasil semua secara penuh, atau tidak sama sekali (*ACID properties*).
- Jika terjadi error di tengah proses, perubahan data akan di-batalkan (`ROLLBACK`).
- Jika semua sukses, maka akan disimpan permanen (`COMMIT`).
- Dikombinasikan dengan blok `TRY...CATCH` untuk menangani error dengan elegan.

---
**Langkah Selanjutnya**:
Buka file **`02_Query_Intermediate.sql`** untuk mencoba dan mempraktikkan langsung semua konsep di atas menggunakan database `FreelanceDB` yang telah kita buat sebelumnya.
