# Panduan Expert SQL Server untuk Freelance DBA

Luar biasa! Jika Anda sudah mencapai level *Expert*, berarti Anda sudah siap menangani *troubleshooting* berat, *Performance Tuning*, dan masalah tingkat tinggi di *production server*. Di tahap ini, Anda dibayar tinggi sebagai konsultan karena kemampuan Anda menemukan masalah yang tidak bisa diselesaikan oleh programmer biasa.

Berikut adalah pilar-pilar penting untuk level Expert DBA SQL Server:

## 1. Dynamic Management Views (DMVs)
Ini adalah "sinar-X" bagi SQL Server. DMV adalah kumpulan *view* bawaan sistem yang menyimpan data historis kinerja server secara *real-time*.
- **Contoh Kegunaan**: Mencari query mana yang memakan waktu paling lama (lambat), query mana yang menghabiskan CPU atau Memory paling besar, serta melihat tabel apa yang kehilangan index (*Missing Indexes*).
- **Awalan DMV**: Semuanya diawali dengan `sys.dm_` (contoh: `sys.dm_exec_query_stats`).

## 2. Execution Plans & Query Statistics
Sebagai pakar, Anda tidak lagi menebak-nebak kenapa sebuah query itu lambat. Anda membacanya melalui **Execution Plan** (Rencana Eksekusi).
- **Execution Plan**: Peta jalan bagaimana SQL Server mengeksekusi query (apakah menggunakan Index Seek, Index Scan, atau Hash Match).
- **Statistics IO & Time**: Mengukur berapa banyak bacaan logis (*Logical Reads*) ke disk memori dan milidetik yang dihabiskan query.

## 3. Index Maintenance (Fragmentation)
Seiring waktu berjalan (karena *Insert*, *Update*, *Delete*), susunan data di dalam disk menjadi berantakan. Ini disebut **Fragmentasi Index**.
- Jika fragmentasi **antara 5% - 30%**: Lakukan `INDEX REORGANIZE` (merapikan secara online).
- Jika fragmentasi **di atas 30%**: Lakukan `INDEX REBUILD` (membangun ulang index dari nol).
- *Catatan: Maintenance ini wajib diotomasi via SQL Server Agent Job.*

## 4. Common Table Expressions (CTE) & Window Functions
Ini adalah alat *Advanced T-SQL* untuk developer tingkat tinggi dan Data Engineer.
- **CTE (`WITH`)**: Mirip *View* tapi sangat temporer (hanya hidup selama satu eksekusi query). Sangat hebat untuk membuat *Recursive Query* (seperti struktur hierarki Karyawan dan Bos).
- **Window Functions**: Fungsi analitik canggih (`ROW_NUMBER()`, `RANK()`, `SUM() OVER(PARTITION BY...)`) untuk membuat peringkat, running total, atau deteksi data duplikat tanpa `GROUP BY` yang lambat.

## 5. Blocking & Deadlocks
Mampu mendeteksi sesi (Session/SPID) mana yang saling mengunci (*Blocking*) dan tahu kapan harus melakukan instruksi `KILL` (secara aman) adalah kemampuan survival harian seorang DBA.

---
**Langkah Selanjutnya**:
Buka file **`02_Query_Expert.sql`** untuk mencoba script andalan para DBA saat sedang menganalisis performa server dan melihat kehebatan dari fungsi analitik tingkat lanjut!
