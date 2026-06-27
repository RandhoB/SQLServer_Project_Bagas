# Walkthrough: 10 Project SQL Server Masterclass (Freelance & Job Ready)

Modul pamungkas Anda sudah selesai! Folder `projects_masterclass/` kini berisi 10 rahasia dapur industri yang sangat jarang diajarkan di bangku kuliah, namun sering keluar di tes wawancara *Database Engineer/DBA* atau menjadi keluhan utama klien *freelance*.

## Mengapa 10 Modul Ini Penting?

Berikut adalah wawasan berharga dari masing-masing skrip:

1. **[01_parameter_sniffing.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/01_parameter_sniffing.sql)**: Menyelesaikan misteri "kenapa query kadang cepat kadang lambat" menggunakan trik Local Variables dan `OPTION (RECOMPILE)`. Ini adalah ilmu tingkat dewa dalam *Performance Tuning*.
2. **[02_bulk_import_export.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/02_bulk_import_export.sql)**: Demonstrasi cara menggunakan `BULK INSERT` dan `OPENROWSET`. Sangat berguna ketika Anda di-hire freelance untuk memindahkan data CSV bergiga-giga ke SQL Server tanpa nge-hang.
3. **[03_indexed_views.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/03_indexed_views.sql)**: Trik curang (namun legal dan efisien) mempercepat kueri *Dashboard BI* yang berat dari menit ke milidetik, yakni dengan mengunci agregasi langsung ke *harddisk* via *Unique Clustered Index*.
4. **[04_scalar_udf_vs_itvf.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/04_scalar_udf_vs_itvf.sql)**: Inilah penyebab utama mengapa kode T-SQL peninggalan programmer lama sering terasa lambat. Anda diajarkan melakukan *refactoring* dari *Scalar Function* (RBAR) menjadi *Inline Table-Valued Function* (iTVF).
5. **[05_spatial_geolocation.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/05_spatial_geolocation.sql)**: Cara menggunakan tipe data `GEOGRAPHY` (koordinat Latitude/Longitude) untuk membangun fitur pencarian logistik ala Gojek/Grab ("Toko terdekat dari lokasiku").
6. **[06_full_text_search.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/06_full_text_search.sql)**: Selamat tinggal `LIKE '%...%'` yang membebani CPU. Kenali cara membuat indeks *Full-Text Catalog* menggunakan `CONTAINS` dan `FREETEXT` untuk fitur mesin pencari instan.
7. **[07_cursor_refactoring.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/07_cursor_refactoring.sql)**: Belajar mematikan *Cursor* lambat yang memproses baris-per-baris dan mengubahnya menjadi kueri *Set-Based* `UPDATE ... CASE` yang 100x lebih instan.
8. **[08_instead_of_triggers.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/08_instead_of_triggers.sql)**: Menggunakan `INSTEAD OF TRIGGER` untuk mem-bypass error saat seseorang mencoba melakukan `INSERT` ke sebuah *View* yang dibangun dari multi-tabel.
9. **[09_data_compression.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/09_data_compression.sql)**: Strategi Storage DBA: Mengecilkan ukuran tabel dan menghemat biaya server klien Anda menggunakan skema `DATA_COMPRESSION = PAGE` atau `ROW`.
10. **[10_database_mail_alerts.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_masterclass/10_database_mail_alerts.sql)**: Integrasi notifikasi IT: Menggunakan `sp_send_dbmail` untuk menyusun laporan HTML secara dinamis dan mengirimkannya langsung ke email jika terjadi error (atau untuk laporan harian otomatis).

> [!TIP]
> Dengan selesainya tahap *Masterclass* ini, Anda kini memiliki portofolio lengkap dari *Basic* -> *Intermediate* -> *Expert* -> *Masterclass*. Anda siap menghadapi tes *live-coding*, tes tertulis T-SQL, maupun menerima *project freelance* perbaikan *database* di Upwork/Fiverr!

## Langkah Terakhir
Jangan lupa untuk me-review skrip-skrip ini dan melakukan *Commit/Push* ke GitHub agar jejak digital *repository* Anda sempurna di mata perekrut (HR/Technical Lead).
