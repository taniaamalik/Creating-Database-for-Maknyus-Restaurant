# Creating-Database-for-Maknyus-Restaurant
Creating Database for Maknyus Restaurant using SQL and Java.

Pada Restaurant Maknyus, persediaan bahan baku dan transaksi belum diarsipkan secara terperinci. Selain itu sistem pengelolaan menu pesanan pelanggan juga masih dicatat dalam nota pesanan kemudian diberikan kepada bagian dapur dan kasir untuk dilakukan proses pengolahan hidangan dan rekapitulasi tagihan (Manual).

1.	Membuat sistem basis data berdasarkan studi kasus yang ada.
2.	Mengimplementasikan DDL, DML, Join, Operator, Grouping, Union, Intersection, Subquery, Transaction, 3.4.8	Pemrograman Database T-SQL.
7.	Menghubungkan database yang telah dibuat dengan SQL server ke java.

Entitas  terdiri dari : 
1.	Pegawai
2.	Meja
3.	Pemesan_Antar
4.	Stock_Bahan
5.	Pembelian
6.	Supplier
7.	Reservasi_Meja
8.	Minuman
9.	Makanan
10.	Penjualan

Atribut terdiri dari :
•	Pegawai : ID_P, Nama_P, Alamat_P, Email_P, Telepon_P, JobDesk, Gaji
•	Meja : Nomor_Meja, M_Kuota, Lantai
•	Pemesan_Antar : P_No, P_nama, P_Alamat, P_Telepon
•	Stock_Bahan : Kode_Bahan, NamaBahan, JumlahBahan
•	Pembelian : StrukBeli, WaktuBeli, TotalBeli, ID_Supplier
•	Supplier : ID_Supplier, Nama_Supplier, Alamat_Supplier, Email_Supplier, Telepon_Supplier
•	Reservasi_Meja : R_ID, R_Nama, R_Waktu, R_Kuota
•	Minuman : ID_Minuman, Harga_Minuman, Nama_Minuman
•	Makanan : ID_Makanan, Harga_Makanan, Nama_Makanan
•	Penjualan : StrukJual, WaktuJual, J_HargaTotal

Relasi terdiri dari : unary,  binary, ternary

Relasi :
1.	Pemesan_Antar menambah Penjualan -> one to one -> total-parsial 
2.	Pemesan_Antar memesan Makanan -> many to many -> parsial-parsial 
3.	Pemesan_Antar memesan Minuman -> many to many -> parsial-parsial 
4.	Minuman menghasilkan Penjualan -> many to many -> parsial-total
5.	Makanan menghasilkan Penjualan -> many to many -> parsial-total
6.	Stock_Bahan menjadi Makanan -> many to many -> total-parsial
7.	Stock_Bahan menjadi Minuman -> many to many -> total-parsial
8.	Pegawai memeriksa Stock_Bahan -> one to many -> parsial-total
9.	Pegawai melayani Pemesan_Antar -> one to many -> parsial-total
10.	Pegawai memimpin Pegawai -> one to many -> parsial-parsial
11.	Pegawai mengatur Meja -> one to many -> parsial-total
12.	Pegawai membeli Pembelian -> one to many ->  parsial-total
13.	Pembelian menyuplai Stock_Bahan -> many to many -> total-total
14.	Supplier menfasilitasi Pembelian -> one to many -> total-total
15.	Reservasi_Meja memilih Meja -> one to many -> total-parsial
