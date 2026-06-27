# 10 Project SQL Server - Tingkat Intermediate (Kasus Dunia Nyata)

Berikut adalah 10 daftar proyek SQL Server tingkat intermediate yang mencakup kasus-kasus yang sering terjadi di dunia kerja nyata:

## 1. Sales Performance & Commission Calculation
**Topik:** Window Functions, CTE (Common Table Expressions)
**Deskripsi:** Menghitung performa penjualan bulanan setiap karyawan, memberikan peringkat (ranking), dan menghitung komisi dinamis berdasarkan target penjualan berjenjang (tiered commission).

## 2. Inventory Management & Auto-Reorder Alerts
**Topik:** Stored Procedures, Triggers, Transactions
**Deskripsi:** Memonitor stok barang masuk dan keluar. Membuat sistem trigger yang otomatis memasukkan data ke tabel peringatan (alert) atau membuat draft order ketika stok barang berada di bawah ambang batas (reorder level).

## 3. Customer Churn & Retention Analysis
**Topik:** Date Functions, Left/Anti Joins, Aggregation
**Deskripsi:** Mengidentifikasi pelanggan yang tidak melakukan transaksi dalam 6 bulan terakhir (churn). Menghitung metrik *churn rate* dan retensi pelanggan bulanan untuk tim marketing.

## 4. Data Deduplication & Data Cleansing
**Topik:** `ROW_NUMBER()`, CTEs, `DELETE`
**Deskripsi:** Membersihkan database pelanggan yang kotor dan memiliki banyak duplikat. Menggunakan CTE dan `ROW_NUMBER()` untuk menyimpan data terbaru (paling update) dan menghapus baris duplikat dengan aman.

## 5. Employee Hierarchy & Reporting Tree
**Topik:** Recursive CTEs
**Deskripsi:** Mengelola data karyawan yang memiliki relasi atasan-bawahan (ManagerID). Membangun struktur organisasi (org chart) dinamis untuk mencari tahu kedalaman level manajemen dan siapa saja bawahan dari seorang manajer tertentu.

## 6. E-Commerce Shopping Cart Abandonment
**Topik:** PIVOT, Subqueries, Temp Tables
**Deskripsi:** Menganalisis log sesi (session logs) dan funnel transaksi e-commerce. Mencari tahu di tahap mana (misal: View Item -> Add to Cart -> Checkout -> Payment) pengguna paling banyak berhenti/membatalkan pembelian.

## 7. Dynamic Revenue Reporting
**Topik:** Dynamic SQL, PIVOT
**Deskripsi:** Membangun laporan pendapatan (revenue) per kategori produk yang kolom-kolom bulannya di-generate secara dinamis. Sangat berguna untuk reporting bulanan/tahunan di mana jumlah bulan terus bertambah.

## 8. ETL: Sinkronisasi Data Staging ke Production
**Topik:** `MERGE` Statement (Upsert)
**Deskripsi:** Mensimulasikan proses ETL sederhana. Menggunakan perintah `MERGE` untuk melakukan update pada data yang sudah ada (berdasarkan ID) dan insert untuk data baru, dari tabel *staging* (data sementara) ke tabel *production*.

## 9. Data Auditing & Historical Tracking
**Topik:** Temporal Tables (System-Versioned) / Auditing Triggers
**Deskripsi:** Membangun sistem pelacakan riwayat (audit trail) untuk data sensitif seperti gaji karyawan atau limit kredit pelanggan. Memungkinkan kita untuk melihat data "seperti apa kondisinya" pada waktu tertentu di masa lalu.

## 10. Financial Running Totals & Moving Averages
**Topik:** Window Functions (`SUM OVER`, `ROWS UNBOUNDED PRECEDING`)
**Deskripsi:** Menghitung kumulatif saldo rekening berjalan (running totals), rata-rata pergerakan 7 harian (7-day moving average), serta perhitungan *Year-to-Date* (YTD) untuk data transaksi keuangan harian.

---

**Tahapan Implementasi:**
Setiap project akan diimplementasikan ke dalam folder/file SQL terpisah yang berisi script pembuatan tabel (DDL), insert data dummy (DML), dan script query solusi (DQL).
