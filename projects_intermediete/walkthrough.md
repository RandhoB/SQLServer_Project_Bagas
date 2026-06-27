# Walkthrough: 10 Project SQL Server Intermediate

Semua project telah berhasil diimplementasikan! Anda kini memiliki 10 file `.sql` terpisah di dalam folder `projects_intermediete/`. Masing-masing file berisi DDL (pembuatan tabel dummy), DML (pengisian data uji), dan skrip penyelesaian masalah.

## Apa Saja yang Telah Dibuat?

Berikut adalah ringkasan teknis dari setiap skrip yang bisa Anda pelajari:

1. **[01_sales_performance.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/01_sales_performance.sql)**: Anda akan belajar tentang `SUM() OVER`, `RANK()`, dan struktur `WITH` (CTE) untuk mengkalkulasi komisi berjenjang.
2. **[02_inventory_alerts.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/02_inventory_alerts.sql)**: Praktik membuat `TRIGGER AFTER UPDATE` di SQL Server dan menggunakan tabel virtual `inserted`.
3. **[03_customer_churn.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/03_customer_churn.sql)**: Analisis Churn (berhenti bertransaksi) menggunakan trik *Anti-Join* (`LEFT JOIN` dengan kondisi `IS NULL`).
4. **[04_data_deduplication.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/04_data_deduplication.sql)**: Cara paling standar di industri untuk menghapus duplikat secara aman dengan kombinasi `ROW_NUMBER()`, CTE, dan perintah `DELETE`.
5. **[05_employee_hierarchy.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/05_employee_hierarchy.sql)**: Teknik tingkat lanjut: *Recursive CTE* yang memanggil dirinya sendiri secara rekursif untuk membuat struktur hirarki atasan-bawahan.
6. **[06_cart_abandonment.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/06_cart_abandonment.sql)**: Penggunaan *Temp Tables* (`#TempTable`) dan operasi `PIVOT` untuk mengubah struktur tabel event memanjang (long) menjadi kolom (wide) funnel marketing.
7. **[07_dynamic_revenue.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/07_dynamic_revenue.sql)**: Implementasi *Dynamic SQL* (`sp_executesql`) saat Anda tidak mengetahui atau tidak ingin men-hardcode nama-nama kolom tabel (kolom bulan yang dinamis).
8. **[08_etl_merge.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/08_etl_merge.sql)**: Praktik skrip sinkronisasi atau *Upsert* (Update jika ada, Insert jika baru) dengan statement `MERGE`.
9. **[09_data_auditing.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/09_data_auditing.sql)**: Pembuatan *System-Versioned Temporal Tables* yang secara ajaib merekam history tanpa trigger rumit.
10. **[10_financial_running_totals.sql](file:///Users/randhobagaskara/SQL_Server_Project_Bagas/projects_intermediete/10_financial_running_totals.sql)**: Penggunaan fungsi window agregat lanjutan (`ROWS UNBOUNDED PRECEDING`, `LAG`) untuk menghitung performa finansial seperti YTD dan Moving Average.

## Langkah Selanjutnya

Anda bisa membuka masing-masing file dan menyalin isinya, lalu mengeksekusinya (Execute) di SQL Server Management Studio (SSMS) atau Azure Data Studio.
> [!TIP]
> Eksekusi script ini pada *database kosong* (misal: buat database baru bernama `TestProjects`) agar tabel dummy dari setiap project tidak bentrok dengan tabel produksi Anda yang sebenarnya.

Selamat belajar!
