CREATE DATABASE RestaurantMaknyus
use RestaurantMaknyus

CREATE TABLE Pegawai (
	ID_P		varchar(5)		NOT NULL	PRIMARY KEY,
	Nama_P		varchar(30)		NOT NULL,
	Jalan		varchar(40)		NOT NULL,
	Kelurahan	varchar(30)		NOT NULL,
	JobDesk		varchar(16)		NOT NULL	CHECK(JobDesk in ('Pemimpin', 'Koki', 'Kasir', 'Pelayan', 'Cleaning Service')),
	Gaji		int
)

CREATE TABLE Email_Pegawai (
	ID_P		varchar(5)		FOREIGN KEY REFERENCES Pegawai(ID_P),	
	Email_P		varchar(30),
	PRIMARY KEY (ID_P, Email_P)
)

CREATE TABLE Telepon_Pegawai (
	ID_P		varchar(5)		FOREIGN KEY REFERENCES Pegawai(ID_P),
	Telepon_P	varchar(13),
	PRIMARY KEY (ID_P, Telepon_P)
)

CREATE TABLE Supplier(
	ID_Sup		varchar(6)	NOT NUll	PRIMARY KEY,
	Nama_Sup	varchar(30) NOT NULL,
	Jalan		varchar(40) NOT NULL,
	Kelurahan	varchar(20) NOT NULL,
	Kota		varchar(15) NOT NULL
)

CREATE TABLE Email_Supplier(
	ID_Sup		varchar(6)	FOREIGN KEY REFERENCES Supplier(ID_Sup),
	Email_Sup	varchar(45) NOT NULL,
	PRIMARY KEY (ID_Sup, Email_Sup)
)

CREATE TABLE Telepon_Supplier(
	ID_Sup		varchar(6)	FOREIGN KEY REFERENCES Supplier(ID_Sup),
	Telepon_Sup	varchar(13) NOT NULL,
	PRIMARY KEY (ID_Sup, Telepon_Sup)
)

CREATE TABLE Pembelian(
	StrukBeli	varchar(8)	NOT NULL	PRIMARY KEY,
	B_Tanggal	date	NOT NULL,
	TotalBeli	int			NOT NULL,
	ID_P		varchar(5)	FOREIGN KEY REFERENCES Pegawai(ID_P),
	ID_Sup		varchar(6)	FOREIGN KEY REFERENCES Supplier(ID_Sup)
)

CREATE TABLE Stock_Bahan (
	Kode_Bahan	varchar(5)	NOT NULL	PRIMARY KEY,
	Nama_Bahan	varchar(15) NOT NULL,
	JumlahBahan	int
)

CREATE TABLE Memeriksa (
	Kode_Bahan	varchar(5)	FOREIGN KEY REFERENCES Stock_Bahan(Kode_Bahan),
	ID_P		varchar(5)	FOREIGN KEY REFERENCES Pegawai(ID_P),
	M_Tanggal	date	NOT NULL,
	PRIMARY KEY (Kode_Bahan,ID_P)
)

CREATE TABLE Menyuplai(
	Kode_Bahan	varchar(5)	FOREIGN KEY REFERENCES Stock_Bahan(Kode_Bahan),
	StrukBeli	varchar(8)	FOREIGN KEY REFERENCES Pembelian(StrukBeli),
	JumlahBeli	int			NOT NULL,
	HargaSatuan int			NOT NULL
	PRIMARY KEY (Kode_Bahan, StrukBeli)
)

CREATE TABLE Makanan (
	ID_Makanan		varchar(5)	NOT NULL	PRIMARY KEY,
	Nama_Makanan	varchar(30)	NOT NULL,
	Harga_Makanan	int			NOT NULL
)

CREATE TABLE Minuman (
	ID_Minuman		varchar(5)	NOT NULL	PRIMARY KEY,
	Nama_Minuman	varchar(30)	NOT NULL,
	Harga_Minuman	int			NOT NULL
)

create table Menjadi_Makanan (
	Kode_Bahan		varchar(5)		not null	foreign key references Stock_Bahan,
	ID_Makanan		varchar(5)		foreign key references Makanan,
	PRIMARY KEY (Kode_Bahan, ID_Makanan)
);

create table Menjadi_Minuman (
	Kode_Bahan		varchar(5)		not null	foreign key references Stock_Bahan,
	ID_Minuman		varchar(5)		foreign key references Minuman,
	PRIMARY KEY (Kode_Bahan, ID_Minuman)
);

CREATE TABLE Penjualan (
	StrukJual		varchar(6)	NOT NULL	PRIMARY KEY,
	J_Tanggal		date		NOT NULL,
	J_HargaTotal	int			NOT NULL,
	ID_P			varchar(5)	FOREIGN KEY REFERENCES Pegawai(ID_P)
)

create table Menghasilkan_Makanan (
	StrukJual		varchar(6)		not null	foreign key references Penjualan,
	ID_Makanan		varchar(5)		foreign key references Makanan,
	JumlahJual		int,
	PRIMARY KEY (StrukJual , ID_Makanan)
);

create table Menghasilkan_Minuman (
	StrukJual		varchar(6)		not null	foreign key references Penjualan,
	ID_Minuman		varchar(5)		foreign key references Minuman,
	JumlahJual		int,
	PRIMARY KEY (StrukJual , ID_Minuman)
);


CREATE TABLE Pemesan_Antar (
	P_No		varchar(8)		NOT NULL	PRIMARY KEY,
	P_Nama		varchar(30)		NOT NULL,
	Jalan		varchar(40)		NOT NULL,
	Kelurahan	varchar(30)		NOT NULL,
	P_Telepon	varchar(13)		NOT NULL,
	StrukJual	varchar(6)		FOREIGN KEY REFERENCES Penjualan(StrukJual),
	ID_P		varchar(5)		FOREIGN KEY REFERENCES Pegawai(ID_P)
)

create table Memesan_Makanan (
	P_No			varchar(8)		not null	foreign key references Pemesan_Antar,
	ID_Makanan		varchar(5)		foreign key references Makanan,
	JumlahPesanan	int,
	PRIMARY KEY (P_No, ID_Makanan)
);

create table Memesan_Minuman (
	P_No			varchar(8)		not null	foreign key references Pemesan_Antar,
	ID_Minuman		varchar(5)		foreign key references Minuman,
	JumlahPesanan	int,
	PRIMARY KEY (P_No, ID_Minuman)
);


CREATE TABLE Meja(
	No_Meja		varchar(3)	NOT NULL	PRIMARY KEY,
	M_Kuota		varchar(2),
	Lantai		varchar(1),
	ID_P		varchar(5)	FOREIGN KEY REFERENCES Pegawai(ID_P)
)

CREATE TABLE Reservasi_Meja(
	R_ID		varchar(8)	NOT NULL	PRIMARY KEY,
	R_Nama		varchar(30) NOT NULL,
	Jam			time		NOT NULL,
	R_Tanggal	date		NOT NULL,
	R_Kuota		varchar(15) NOT NULL
)

CREATE TABLE Memilih(
	No_Meja		varchar(3)	FOREIGN KEY REFERENCES Meja(No_Meja),
	R_ID		varchar(8)	FOREIGN KEY REFERENCES Reservasi_Meja(R_ID),
	PRIMARY KEY (No_Meja, R_ID)
)

insert into Pegawai values ('10201', 'Muhammad Ali', 'Jl. Depok 1', 'Kel. Klojen', 'Pemimpin', 12000000)
insert into Pegawai values ('20201', 'Amir Rusli', 'Jl. Akses', 'Kel. Langsa', 'Koki', 3500000)
insert into Pegawai values ('20302', 'Diana Rosma', 'Jl. Bogor', 'Kel. Pauh', 'Koki', 3500000)
insert into Pegawai values ('50201', 'Susanti', 'Jl. Kenanga', 'Kel. Karang', 'Kasir', 3000000)
insert into Pegawai values ('40201', 'Pungki Aribowo', 'Jl. Sudirman', 'Kel. Gempo', 'Pelayan', 3000000)
insert into Pegawai values ('40202', 'Salimar Adijaya', 'Jl. Kenanga', 'Kel. Pinang', 'Pelayan', 3000000)
insert into Pegawai values ('30201', 'Budiman', 'Jl. Teratai', 'Kel. Tengah', 'Cleaning Service', 2250000)
insert into Pegawai values ('40303', 'Yuana Frans', 'Jl. Saturnus', 'Kel. Paya', 'Pelayan', 3000000)
insert into Pegawai values ('20303', 'Reynold', 'Jl. Kalimalang', 'Kel. Alue', 'Koki', 3500000)
insert into Pegawai values ('30202', 'Brata Lesmana',	'Jl. Sudirman', 'Kel. Sampo', 'Cleaning Service', 2250000)
insert into Pegawai values ('20404', 'Prananingrum', 'Jl. Kencana', 'Kel. Sidodadi', 'Koki', 3500000)
insert into Pegawai values ('40304', 'Kirana Surya',' Jl. Bougenvil', 'Kel. Barah', 'Pelayan', 3000000)
insert into Pegawai values ('40305', 'Yasamin', 'Jl. Jakarta', 'Kel. Sidorejo', 'Pelayan', 3000000)
insert into Pegawai values ('50702', 'Baharudin', 'Jl. Margonda', 'Kel. Pondok', 'Kasir', 3000000)
insert into Pegawai values ('20605', 'Nurhayati',	'Jl. Gambir', 'Kel. Sidodadi', 'Koki', 4000000)
insert into Pegawai values ('30503', 'Dian Purwanto',	'Jl. Bandung', 'Kel.Sukareja', 'Cleaning Service', 2250000)
insert into Pegawai values ('30504', 'Izdi Pahlevi', 'Jl. Tretes', 'Kel. Merbau', 'Cleaning Service', 2250000)
insert into Pegawai values ('40506', 'Vincent', 'Jl. Bendungan', 'Kel. Tebing', 'Pelayan', 3000000)
insert into Pegawai values ('40707', 'Anton Tunjung', 'Jl. Djuanda', 'Kel. Rintis', 'Pelayan', 2750000)
insert into Pegawai values ('40808',' Brian Aldama', 'Jl. Cilincing', 'Kel. Wonorejo', 'Pelayan', 2750000)

select*from Email_Pegawai

insert into Email_Pegawai values ('10201', 'ali09@gmail.com')
insert into Email_Pegawai values ('20201', 'amirmir@gmail.com')
insert into Email_Pegawai values ('20302', 'dianarosma@yahoo.com')
insert into Email_Pegawai values ('50201', 'susanti07@gmail.com')
insert into Email_Pegawai values ('40201', 'aribowopungki@yahoo.com')
insert into Email_Pegawai values ('40202', 'salimaradi@gmail.com')
insert into Email_Pegawai values ('30201', 'budimann@gmail.com')
insert into Email_Pegawai values ('40303', 'yuanafrans@gmail.com')
insert into Email_Pegawai values ('20303', 'rey_97@gmail.com')
insert into Email_Pegawai values ('30202', 'bratales@yahoo.com')
insert into Email_Pegawai values ('20404', 'prana11_@gmail.com')
insert into Email_Pegawai values ('40304', 'kiranasurya@gmail.com')
insert into Email_Pegawai values ('40305', 'yasamin@gmail.com')
insert into Email_Pegawai values ('50702', 'bahar77@gmail.com')
insert into Email_Pegawai values ('20605', 'nurha03@gmail.com')
insert into Email_Pegawai values ('30503', 'dian_dian@yahoo.com')
insert into Email_Pegawai values ('30504', 'izdi_levi@gmail.com')
insert into Email_Pegawai values ('40506', 'vincentcent@gmail.com')
insert into Email_Pegawai values ('40707', 'antonie@gmail.com')
insert into Email_Pegawai values ('40808', 'brianalda@gmail.com')

insert into Telepon_Pegawai values ('10201', '085232801511')
insert into Telepon_Pegawai values ('20201', '087398299123')
insert into Telepon_Pegawai values ('20302', '082231501800')
insert into Telepon_Pegawai values ('50201', '083379856937')
insert into Telepon_Pegawai values ('40201', '089999756034')
insert into Telepon_Pegawai values ('40202', '082233793501')
insert into Telepon_Pegawai values ('30201', '085537986113')
insert into Telepon_Pegawai values ('40303', '082234156798')
insert into Telepon_Pegawai values ('20303', '087731859446')
insert into Telepon_Pegawai values ('30202', '082251798246')
insert into Telepon_Pegawai values ('20404', '082233793185')
insert into Telepon_Pegawai values ('40304', '089738165233')
insert into Telepon_Pegawai values ('40305', '087773571800')
insert into Telepon_Pegawai values ('50702', '085233293799')
insert into Telepon_Pegawai values ('20605', '085981705136')
insert into Telepon_Pegawai values ('30503', '089793156800')
insert into Telepon_Pegawai values ('30504', '085233197441')
insert into Telepon_Pegawai values ('40506', '082232936111')
insert into Telepon_Pegawai values ('40707', '085193536497')
insert into Telepon_Pegawai values ('40808', '085273841226')

INSERT INTO Supplier VALUES ('AR1001', 'Muhammad Eko', 'Jl. Astatinggi', 'Kel. Ds. Kebonagung', 'Sumenep')
INSERT INTO Supplier VALUES ('ZT0902', 'Putri Utami', 'Jl. Rajekwesi', 'Kel. Ledok Kulon', 'Bojonegoro')
INSERT INTO Supplier VALUES ('RM0703', 'Nur Dwi', 'Jl. Langsep', 'Kel. Patrang', 'Jember')
INSERT INTO Supplier VALUES ('MZ1105', 'Wahyu Tri Agus', 'Jl. Seroja', 'Kel. Ds. Jombang', 'Jombang')
INSERT INTO Supplier VALUES ('QY0107', 'Agung Kurniawan', 'Jl. Dr. Wahidin', 'Kel. Sukabumi', 'Probolinggo')
INSERT INTO Supplier VALUES ('ZY0311', 'Arif Putra', 'Jl. Akhmad Yani', 'Kel. Magersari', 'Mojokerto')
INSERT INTO Supplier VALUES ('AP1215', 'Rizki Ari', 'Jl. Jambangan', 'Kel. Purworejo', 'Pasuruan')
INSERT INTO Supplier VALUES ('OR0299', 'Fitria Novita', 'Jl. Basuki Rahmat', 'Kel. Kutorejo', 'Tuban')
INSERT INTO Supplier VALUES ('RP0997', 'Aditya Nugroho', 'Jl. Dr. Sutomo', 'Kel. Badean', 'Bondowoso')
INSERT INTO Supplier VALUES ('CL1094', 'Abdul Ade', 'Jl. Jendral Sudirman', 'Kel. Karet Semanggi', 'Jakarta')
INSERT INTO Supplier VALUES ('EF1205', 'Bagus Hidayat', 'Jl. Jeruk', 'Kel. Kraton', 'Tegal')
INSERT INTO Supplier VALUES ('LB0603', 'Prima Angga', 'Jl. Perintis Kemerdekaan', 'Kel. Kraton Lor', 'Pekalongan')
INSERT INTO Supplier VALUES ('WX0516', 'Hadi Saputra', 'Jl. Ciliwung', 'Kel. Taman', 'Madiun')
INSERT INTO Supplier VALUES ('DZ0107', 'Surya Setiawan', 'Jl. Tidar', 'Kel. Sawahan', 'Surabaya')
INSERT INTO Supplier VALUES ('GH0815', 'Indra Fajar', 'Jl. Gondo Wardoyo', 'Kel. Payaman', 'Nganjuk')
INSERT INTO Supplier VALUES ('IR0107', 'Adi Rahmat', 'Jl. Ir. Sutami', 'Kel. Banjaran', 'Kediri')
INSERT INTO Supplier VALUES ('JK1109', 'Andi Wicaksono', 'Jl. Veteran', 'Kel. Penanggungan', 'Malang')
INSERT INTO Supplier VALUES ('NP1010', 'Ika Yuni', 'Jl. Pangeran Diponegoro', 'Kel. Kauman', 'Tulungagung')
INSERT INTO Supplier VALUES ('SU1105', 'Rio Andrean', 'Jl. Pahlawan', 'Kel. Sidokumpul', 'Sidorajo')
INSERT INTO Supplier VALUES ('TU1212', 'Febri Maulana', 'Jl. Pemungkur', 'Kel. Blitar', 'Blitar')

INSERT INTO Email_Supplier VALUES ('AR1001', 'Muh_eko@gmail.com')
INSERT INTO Email_Supplier VALUES ('AR1001', 'EkoMuhammad@yahoo.com')
INSERT INTO Email_Supplier VALUES ('ZT0902', 'Putri_Ut93@gmail.com')
INSERT INTO Email_Supplier VALUES ('ZT0902', 'Puput918@yahoo.com')
INSERT INTO Email_Supplier VALUES ('RM0703', 'Nur_dwi@gmail.com')
INSERT INTO Email_Supplier VALUES ('RM0703', 'Dwi_dw2@yahoo,com')
INSERT INTO Email_Supplier VALUES ('MZ1105', 'Wahyu_TA@gmail.com')
INSERT INTO Email_Supplier VALUES ('QY0107', 'Agung_Ko@gmail.com')
INSERT INTO Email_Supplier VALUES ('ZY0311', 'Arifputra@gmail.com')
INSERT INTO Email_Supplier VALUES ('ZY0311', 'Arif1212@yahoo.com')
INSERT INTO Email_Supplier VALUES ('AP1215', 'RizkiAri@gmail.com')
INSERT INTO Email_Supplier VALUES ('OR0299', 'Fitrianov@gmail.com')
INSERT INTO Email_Supplier VALUES ('RP0997', 'AdityaNugroho@gmail.com')
INSERT INTO Email_Supplier VALUES ('CL1094', 'Abdul_Ade@gmail.com')
INSERT INTO Email_Supplier VALUES ('EF1205', 'BagusH@gmail.com')
INSERT INTO Email_Supplier VALUES ('EF1205', 'HidayatB@yahoo.com')
INSERT INTO Email_Supplier VALUES ('LB0603', 'Prima_Angga@gmail.com')
INSERT INTO Email_Supplier VALUES ('WX0516', 'HadiS@gmail.com')
INSERT INTO Email_Supplier VALUES ('DZ0107', 'SuryaSet@gmail.com')
INSERT INTO Email_Supplier VALUES ('DZ0107', 'SuryaSetiawan@yahoo.com')
INSERT INTO Email_Supplier VALUES ('GH0815', 'IndraF02@gmail.com')
INSERT INTO Email_Supplier VALUES ('IR0107', 'Adi_Rahmat@gmail.com')
INSERT INTO Email_Supplier VALUES ('JK1109', 'Andiiii938@gmail.com')
INSERT INTO Email_Supplier VALUES ('NP1010', 'Ika_Yuni@gmail.com')
INSERT INTO Email_Supplier VALUES ('SU1105', 'Rio_Andre@gmail.com')
INSERT INTO Email_Supplier VALUES ('TU1212', 'FebriFM@gmail.com')

INSERT INTO Telepon_Supplier VALUES ('AR1001', '082187734123')
INSERT INTO Telepon_Supplier VALUES ('ZT0902', '083861245712')
INSERT INTO Telepon_Supplier VALUES ('RM0703', '085742225010')
INSERT INTO Telepon_Supplier VALUES ('MZ1105', '089898979695')
INSERT INTO Telepon_Supplier VALUES ('MZ1105', '081323786283')
INSERT INTO Telepon_Supplier VALUES ('QY0107', '081400040302')
INSERT INTO Telepon_Supplier VALUES ('QY0107', '083823765273')
INSERT INTO Telepon_Supplier VALUES ('ZY0311', '087812343210')
INSERT INTO Telepon_Supplier VALUES ('AP1215', '087810121345')
INSERT INTO Telepon_Supplier VALUES ('OR0299', '089851234587')
INSERT INTO Telepon_Supplier VALUES ('RP0997', '085711110412')
INSERT INTO Telepon_Supplier VALUES ('CL1094', '082137380503')
INSERT INTO Telepon_Supplier VALUES ('CL1094', '089836262782')
INSERT INTO Telepon_Supplier VALUES ('EF1205', '083841656509')
INSERT INTO Telepon_Supplier VALUES ('EF1205', '081337652388')
INSERT INTO Telepon_Supplier VALUES ('EF1205', '088273723628')
INSERT INTO Telepon_Supplier VALUES ('LB0603', '089810053241')
INSERT INTO Telepon_Supplier VALUES ('WX0516', '087821215009')
INSERT INTO Telepon_Supplier VALUES ('DZ0107', '083863251520')
INSERT INTO Telepon_Supplier VALUES ('DZ0107', '083732686328')
INSERT INTO Telepon_Supplier VALUES ('GH0815', '085778910123')
INSERT INTO Telepon_Supplier VALUES ('IR0107', '082131012152')
INSERT INTO Telepon_Supplier VALUES ('JK1109', '087861328501')
INSERT INTO Telepon_Supplier VALUES ('NP1010', '081417202325')
INSERT INTO Telepon_Supplier VALUES ('NP1010', '085734862892')
INSERT INTO Telepon_Supplier VALUES ('SU1105', '085738160511')
INSERT INTO Telepon_Supplier VALUES ('TU1212', '087821401922')
INSERT INTO Telepon_Supplier VALUES ('TU1212', '083826382928')

INSERT INTO Pembelian VALUES ('92001001', '20171213', 2500000, '40201', 'AR1001')
INSERT INTO Pembelian VALUES ('91902001', '20180110', 1000000, '40202', 'ZT0902')
INSERT INTO Pembelian VALUES ('90703001', '20180110', 1500000, '40303', 'RM0703')
INSERT INTO Pembelian VALUES ('92001002', '20180203', 1000000, '40304', 'AR1001')
INSERT INTO Pembelian VALUES ('94105001', '20180217', 1500000, '40305', 'MZ1105')
INSERT INTO Pembelian VALUES ('95107001', '20180303', 2500000, '40506', 'QY0107')
INSERT INTO Pembelian VALUES ('96311001', '20180317', 2000000, '40707', 'ZY0311')
INSERT INTO Pembelian VALUES ('90703002', '20180331', 2000000, '40808', 'RM0703')
INSERT INTO Pembelian VALUES ('93215001', '20180414', 1550000, '40202', 'AP1215')
INSERT INTO Pembelian VALUES ('97299001', '20180428', 1750000, '40304', 'OR0299')
INSERT INTO Pembelian VALUES ('95107002', '20180512', 2128000, '40506', 'QY0107')
INSERT INTO Pembelian VALUES ('98997001', '20180526', 2175000, '40808', 'RP0997')
INSERT INTO Pembelian VALUES ('99094001', '20180609', 2130000, '40201', 'CL1094')
INSERT INTO Pembelian VALUES ('81205001', '20180723', 1550000, '40303', 'EF1205')
INSERT INTO Pembelian VALUES ('96311002', '20180806', 1125000, '40305', 'ZY0311')
INSERT INTO Pembelian VALUES ('94105002', '20180820', 1300000, '40707', 'MZ1105')
INSERT INTO Pembelian VALUES ('93215002', '20180904', 2750000, '40808', 'AP1215')
INSERT INTO Pembelian VALUES ('82603001', '20180910', 2350000, '40201', 'LB0603')
INSERT INTO Pembelian VALUES ('82603002', '20180920', 755000, '40506', 'LB0603')
INSERT INTO Pembelian VALUES ('83997001', '20180924', 500000, '40305', 'RP0997')

INSERT INTO Stock_Bahan VALUES ('SS001', 'Sosis', 5)
INSERT INTO Stock_Bahan VALUES ('TL002', 'Telur', 14)
INSERT INTO Stock_Bahan VALUES ('AY003', 'Ayam', 16)
INSERT INTO Stock_Bahan VALUES ('DG004', 'Daging', 10)
INSERT INTO Stock_Bahan VALUES ('BR005', 'Beras', 13)
INSERT INTO Stock_Bahan VALUES ('BW006', 'Bawang', 19)
INSERT INTO Stock_Bahan VALUES ('JG007', 'Jagung', 6)
INSERT INTO Stock_Bahan VALUES ('GR008', 'Garam', 11)
INSERT INTO Stock_Bahan VALUES ('LD009', 'Lada', 9)
INSERT INTO Stock_Bahan VALUES ('GL010', 'Gula', 12)
INSERT INTO Stock_Bahan VALUES ('JR011', 'Jeruk', 10)
INSERT INTO Stock_Bahan VALUES ('LM012', 'Lemon', 6)
INSERT INTO Stock_Bahan VALUES ('WR013', 'Wortel', 10)
INSERT INTO Stock_Bahan VALUES ('CB014', 'Cabai', 9)
INSERT INTO Stock_Bahan VALUES ('MT015', 'Mentega', 7)
INSERT INTO Stock_Bahan VALUES ('AQ016', 'Air', 16)
INSERT INTO Stock_Bahan VALUES ('ML017', 'Susu', 15)
INSERT INTO Stock_Bahan VALUES ('IK018', 'Ikan', 10)
INSERT INTO Stock_Bahan VALUES ('ST019', 'Strawberry', 7)
INSERT INTO Stock_Bahan VALUES ('TP020', 'Tepung', 6)

INSERT INTO Memeriksa VALUES ('SS001', '40201', '20171214')
INSERT INTO Memeriksa VALUES ('TL002', '40202', '20171228')
INSERT INTO Memeriksa VALUES ('AY003', '40303', '20180111')
INSERT INTO Memeriksa VALUES ('DG004', '40304', '20180204')
INSERT INTO Memeriksa VALUES ('BR005', '40305', '20180218')
INSERT INTO Memeriksa VALUES ('BW006', '40506', '20180304')
INSERT INTO Memeriksa VALUES ('JG007', '40707', '20180318')
INSERT INTO Memeriksa VALUES ('GR008', '40808', '20180401')
INSERT INTO Memeriksa VALUES ('LD009', '40304', '20180415')
INSERT INTO Memeriksa VALUES ('GL010', '40506', '20180429')
INSERT INTO Memeriksa VALUES ('JR011', '40303', '20180513')
INSERT INTO Memeriksa VALUES ('LM012', '40808', '20180527')
INSERT INTO Memeriksa VALUES ('WR013', '40201', '20180610')
INSERT INTO Memeriksa VALUES ('CB014', '40305', '20180724')
INSERT INTO Memeriksa VALUES ('MT015', '40707', '20180807')
INSERT INTO Memeriksa VALUES ('AQ016', '40506', '20180821')
INSERT INTO Memeriksa VALUES ('ML017', '40808', '20180905')
INSERT INTO Memeriksa VALUES ('IK018', '40202', '20180911')
INSERT INTO Memeriksa VALUES ('ST019', '40303', '20180921')
INSERT INTO Memeriksa VALUES ('TP020', '40305', '20180925')

INSERT INTO Menyuplai VALUES ('SS001', '92001001', 1, 10000)
INSERT INTO Menyuplai VALUES ('BR005', '92001001', 12, 12000)
INSERT INTO Menyuplai VALUES ('AQ016', '92001001', 5, 17000)
INSERT INTO Menyuplai VALUES ('GR008', '92001001', 2, 6000)
INSERT INTO Menyuplai VALUES ('TP020', '92001001', 5, 7000)
INSERT INTO Menyuplai VALUES ('TL002', '92001001', 12, 8000)
INSERT INTO Menyuplai VALUES ('BW006', '92001001', 2, 8000)
INSERT INTO Menyuplai VALUES ('CB014', '92001001', 6, 10000)
INSERT INTO Menyuplai VALUES ('MT015', '92001001', 3, 5000)
INSERT INTO Menyuplai VALUES ('WR013', '92001001', 3, 4000)
INSERT INTO Menyuplai VALUES ('JR011', '90703001', 7, 9000)
INSERT INTO Menyuplai VALUES ('LM012', '90703001', 7, 15000)
INSERT INTO Menyuplai VALUES ('GL010', '90703001', 2, 7000)
INSERT INTO Menyuplai VALUES ('LD009', '90703001', 2, 6000)
INSERT INTO Menyuplai VALUES ('ML017', '90703001', 10, 12000)
INSERT INTO Menyuplai VALUES ('JG007', '92001002', 3, 6000)
INSERT INTO Menyuplai VALUES ('AY003', '92001002', 9, 25000)
INSERT INTO Menyuplai VALUES ('DG004', '92001002', 10, 40000)
INSERT INTO Menyuplai VALUES ('IK018', '92001002', 12, 15000)
INSERT INTO Menyuplai VALUES ('ST019', '92001002', 5, 10000)

insert into Makanan values ('4111', 'Spagheti Bolognise', 21000)
insert into Makanan values ('4112', 'French Fries', 18000)
insert into Makanan values ('2816', 'Nasi + Ayam Teriyaki', 28000)
insert into Makanan values ('2817', 'Nasi + Ayam Katsu', 30000)
insert into Makanan values ('2417', 'Mie + Ayam Katsu', 30000)
insert into Makanan values ('2818', 'Nasi + Ayam Krispi', 23000)
insert into Makanan values ('4920', 'Nasi + Ayam Blackpepper', 25000)
insert into Makanan values ('4317', 'Chicken Cordon Bleu', 40000)
insert into Makanan values ('4316', 'Chicken Mozarella', 40000)
insert into Makanan values ('4319', 'Chicken Steak Cheesy', 42000)
insert into Makanan values ('0920', 'Nasi + Cumi Goreng Tepung', 34000)
insert into Makanan values ('0921', 'Nasi + Cumi Goreng Mentega', 34000)
insert into Makanan values ('0410', 'Mie Ayam Bakso', 21000)
insert into Makanan values ('0412', 'Mie Kuah Ayam', 23000)
insert into Makanan values ('0513', 'Mie Siram Sapi', 27000)
insert into Makanan values ('0515', 'Mie Goreng Seafood', 29000)
insert into Makanan values ('0710', 'Nasi Goreng Spesial', 28000)
insert into Makanan values ('0720', 'Nasi Goreng Sosis', 28000)
insert into Makanan values ('0731', 'Nasi Goreng Udang', 31000)
insert into Makanan values ('0733', 'Nasi + Ayam Asam Manis', 32000)

insert into Minuman values ('2113', 'Coffee Float', 18000)
insert into Minuman values ('2115', 'Tea Light', 18000)
insert into Minuman values ('2122', 'Avocado Coffee', 16000)
insert into Minuman values ('2172', 'Pink Punch', 14000)
insert into Minuman values ('2231', 'Lime Squash', 13000)
insert into Minuman values ('2174', 'Melonie', 12000)
insert into Minuman values ('4111', 'Cappucino Frappe', 15000)
insert into Minuman values ('4113', 'Choco Surprise', 17000)
insert into Minuman values ('4115', 'Orange Juice', 10000)
insert into Minuman values ('4116', 'Tomato Juice', 10000)
insert into Minuman values ('4117', 'Guava Juice', 10000)
insert into Minuman values ('4118', 'Melon Juice', 10000)
insert into Minuman values ('4119', 'Mango Juice', 10000)
insert into Minuman values ('5813', 'Coffee Milk', 10000)
insert into Minuman values ('5825', 'Es Teh Manis', 5000)
insert into Minuman values ('5827', 'Soda Gembira', 12000)
insert into Minuman values ('5831', 'Megamendung', 12000)
insert into Minuman values ('1864', 'Tuti Frutti', 15000)
insert into Minuman values ('1973', 'Strawberry Milkshake', 17000)
insert into Minuman values ('1985', 'Chocolate Milkshake', 17000)

insert Menjadi_Makanan values ('SS001', '0720')
insert Menjadi_Makanan values ('AY003', '2816')
insert Menjadi_Makanan values ('AY003', '2817')
insert Menjadi_Makanan values ('BR005', '0731')
insert Menjadi_Makanan values ('BR005', '0733')
insert Menjadi_Makanan values ('LD009', '4920')
insert Menjadi_Makanan values ('BW006', '0410')
insert Menjadi_Makanan values ('BW006', '0515')
insert Menjadi_Makanan values ('BW006', '0513')
insert Menjadi_Makanan values ('BW006', '0710')
insert Menjadi_Makanan values ('AY003', '0733')
insert Menjadi_Makanan values ('TL002', '0920')
insert Menjadi_Makanan values ('TL002', '0731')
insert Menjadi_Makanan values ('TL002', '2818')
insert Menjadi_Makanan values ('CB014', '0410')
insert Menjadi_Makanan values ('CB014', '0513')
insert Menjadi_Makanan values ('GL010', '4920')
insert Menjadi_Makanan values ('GL010', '0733')
insert Menjadi_Makanan values ('TP020', '0920')
insert Menjadi_Makanan values ('MT015', '0921')

insert Menjadi_Minuman values ('AQ016', '5825')
insert Menjadi_Minuman values ('AQ016', '2172')
insert Menjadi_Minuman values ('AQ016', '4111')
insert Menjadi_Minuman values ('AQ016', '4113')
insert Menjadi_Minuman values ('AQ016', '4115')
insert Menjadi_Minuman values ('AQ016', '4116')
insert Menjadi_Minuman values ('AQ016', '4117')
insert Menjadi_Minuman values ('AQ016', '4118')
insert Menjadi_Minuman values ('AQ016', '2115')
insert Menjadi_Minuman values ('ML017', '2113')
insert Menjadi_Minuman values ('ML017', '5813')
insert Menjadi_Minuman values ('GL010', '5827')
insert Menjadi_Minuman values ('GL010', '1973')
insert Menjadi_Minuman values ('GL010', '1985')
insert Menjadi_Minuman values ('GL010', '4115')
insert Menjadi_Minuman values ('GL010', '2172')
insert Menjadi_Minuman values ('GL010', '5825')
insert Menjadi_Minuman values ('GL010', '1864')
insert Menjadi_Minuman values ('GL010', '5813')
insert Menjadi_Minuman values ('GL010', '2113')

insert into Penjualan values ('180001', '20180101', 104000, '50702')
insert into Penjualan values ('180002', '20180101',	80000, '50702')
insert into Penjualan values ('180003', '20180101', 79000, '50702')
insert into Penjualan values ('180004', '20180101', 64000, '50702')
insert into Penjualan values ('180005', '20180101',	212000, '50201')
insert into Penjualan values ('180006', '20180101',	84000, '50201')
insert into Penjualan values ('180007', '20180101',	184000, '50702')
insert into Penjualan values ('180008', '20180101',	87000, '50201')
insert into Penjualan values ('180009', '20180102',	221000, '50201')
insert into Penjualan values ('180010', '20180102',	123000,'50702')
insert into Penjualan values ('180011', '20180102',	76000, '50702')
insert into Penjualan values ('180012', '20180102', 221000, '50201')
insert into Penjualan values ('180013', '20180102', 125000, '50201')
insert into Penjualan values ('180014', '20180102', 24000, '50201')
insert into Penjualan values ('180015', '20180102', 86000, '50201')
insert into Penjualan values ('180016', '20180102', 135000, '50702')
insert into Penjualan values ('180017', '20180103', 72000, '50702')
insert into Penjualan values ('180018', '20180103', 36000, '50702')
insert into Penjualan values ('180019', '20180103', 48000, '50201')
insert into Penjualan values ('180020', '20180103', 70000, '50201')

insert Menghasilkan_Makanan values ('180001', '4111', 2)
insert Menghasilkan_Makanan values ('180002', '0410', 3)
insert Menghasilkan_Makanan values ('180003', '2816', 1)
insert Menghasilkan_Makanan values ('180004', '0733', 2)
insert Menghasilkan_Makanan values ('180005', '4316', 4)
insert Menghasilkan_Makanan values ('180006', '2817', 2)
insert Menghasilkan_Makanan values ('180007', '0410', 3)
insert Menghasilkan_Makanan values ('180008', '4319', 1)
insert Menghasilkan_Makanan values ('180009', '0921', 5)
insert Menghasilkan_Makanan values ('180010', '2818', 3)
insert Menghasilkan_Makanan values ('180001', '4317', 1)
insert Menghasilkan_Makanan values ('180011', '0710', 2)
insert Menghasilkan_Makanan values ('180012', '0515', 4)
insert Menghasilkan_Makanan values ('180005', '0412', 5)
insert Menghasilkan_Makanan values ('180013', '0513', 1)
insert Menghasilkan_Makanan values ('180014', '0720', 2)
insert Menghasilkan_Makanan values ('180015', '0731', 2)
insert Menghasilkan_Makanan values ('180016', '2417', 3)
insert Menghasilkan_Makanan values ('180010', '0920', 1)
insert Menghasilkan_Makanan values ('180012', '4920', 3)

insert Menghasilkan_Minuman values ('180017', '2113', 4)
insert Menghasilkan_Minuman values ('180018', '2115', 2)
insert Menghasilkan_Minuman values ('180019', '2122', 3)
insert Menghasilkan_Minuman values ('180020', '2172', 5)
insert Menghasilkan_Minuman values ('180005', '2231', 4)
insert Menghasilkan_Minuman values ('180006', '2174', 2)
insert Menghasilkan_Minuman values ('180007', '4111', 1)
insert Menghasilkan_Minuman values ('180008', '4113', 3)
insert Menghasilkan_Minuman values ('180009', '4115', 3)
insert Menghasilkan_Minuman values ('180010', '4116', 2)
insert Menghasilkan_Minuman values ('180001', '4117', 2)
insert Menghasilkan_Minuman values ('180011', '4118', 2)
insert Menghasilkan_Minuman values ('180012', '4119', 3)
insert Menghasilkan_Minuman values ('180005', '5813', 5)
insert Menghasilkan_Minuman values ('180013', '5825', 2)
insert Menghasilkan_Minuman values ('180014', '5827', 2)
insert Menghasilkan_Minuman values ('180015', '5831', 2)
insert Menghasilkan_Minuman values ('180016', '1864', 3)
insert Menghasilkan_Minuman values ('180010', '1973', 1)
insert Menghasilkan_Minuman values ('180012', '1985', 3)

insert Pemesan_Antar values ('801001', 'Wisnu Mukti', 'Jl. Dieng', 'Kel. Bangunsari', '083331801321', '180001', '40303')
insert Pemesan_Antar values ('801002', 'Roni Wicaksono', 'Jl. Welirang', 'Kel. Banyudana', '08237941756', '180002', '40305')
insert Pemesan_Antar values ('801003', 'Vian Endrayudha', 'JL. Krakatau ', 'Kel. Mejosari', '087984156801', '180003', '40305')
insert Pemesan_Antar values ('801004', 'Jorot Dwi Fajar', 'Jl. Kalimantan', 'Kel. Keniten', '085733293805', '180004', '40305')
insert Pemesan_Antar values ('801005', 'Ratna Ika Sari', 'Jl. Suprapto', 'Kel. Bangunsari', '082241911542', '180005', '40303')
insert Pemesan_Antar values ('801006', 'Ery Prasetyawati', 'Jl. MT Haryono', 'Kel. Jingglang', '087891994731', '180006', '40202')
insert Pemesan_Antar values ('801007', 'Dewi Aryaningrum', 'Jl.Johan', 'Kel. Sekarpura', '089733506113', '180007', '40303')
insert Pemesan_Antar values ('801008', 'Wahyu Febrianto', 'Jl. Perkutut', 'Kel. Madyopuro', '089741801211', '180008', '40202')
insert Pemesan_Antar values ('801009', 'Elia Lisnawati', 'Jl. Sadewo', 'Kel. Kepatihan', '082231801321', '180009', '40305')
insert Pemesan_Antar values ('801010', 'Novi Lutfiana', 'Jl. Imam Bonjol', 'Kel. Mangkujaya', '085333202011', '180010', '40305')
insert Pemesan_Antar values ('801011', 'Happy Tsabita', 'Jl. Yos Sudarso', 'Kel. Paju', '082231516798', '180011', '40303')
insert Pemesan_Antar values ('801012', 'Fina Yuliana', 'Jl. Tribusono', 'Kel. Nologatin', '085533794274', '180012', '40305')
insert Pemesan_Antar values ('801013', 'Miftachul Abidin', 'Jl. Gabah', 'Kel. Mangkujaya', '0897938051744', '180013', '40305')
insert Pemesan_Antar values ('801014', 'Bagas Adikara', 'Jl. Ontorejo', 'Kel. Banyudana', '087856111317', '180014', '40202')
insert Pemesan_Antar values ('801015', 'Rendy Juliansyah', 'Jl. Wibisono', 'Kel. Sukapuro', '085654931774', '180015', '40303')
insert Pemesan_Antar values ('801016', 'Sutan Diego', 'Jl. Rambutan', 'Kel. Surodikoro', '082233914154', '180016', '40305')
insert Pemesan_Antar values ('801017', 'Candra Ari', 'Jl. Basuki Rahmad', 'Kel. Wonosari', '082233888003', '180017', '40202')
insert Pemesan_Antar values ('801018', 'Dunna Wibowo', 'Jl. Pilang Sari', 'Kel. Tamanarum', '08233913064', '180018', '40202')
insert Pemesan_Antar values ('801019', 'Septa Tri Handoko', 'Jl. Sekar Pudak', 'Kel. Kalijati', '082234956004', '180019', '40303')
insert Pemesan_Antar values ('801020', 'Izzedin Malik', 'Jl. Perdana Kusuma', 'Kel. Kalijati', '085271801930', '180020', '40202')

insert Memesan_Makanan values ('801001', '4111', 2)
insert Memesan_Makanan values ('801002', '0410', 3)
insert Memesan_Makanan values ('801003', '2816', 1)
insert Memesan_Makanan values ('801004', '0733', 2)
insert Memesan_Makanan values ('801005', '4316', 4)
insert Memesan_Makanan values ('801006', '2817', 2)
insert Memesan_Makanan values ('801007', '0410', 3)
insert Memesan_Makanan values ('801008', '4319', 1)
insert Memesan_Makanan values ('801009', '0921', 5)
insert Memesan_Makanan values ('801010', '2818', 3)
insert Memesan_Makanan values ('801001', '4317', 1)
insert Memesan_Makanan values ('801011', '0710', 2)
insert Memesan_Makanan values ('801012', '0515', 4)
insert Memesan_Makanan values ('801005', '0412', 5)
insert Memesan_Makanan values ('801013', '0513', 1)
insert Memesan_Makanan values ('801014', '0720', 2)
insert Memesan_Makanan values ('801015', '0731', 2)
insert Memesan_Makanan values ('801016', '2417', 3)
insert Memesan_Makanan values ('801010', '0920', 1)
insert Memesan_Makanan values ('801012', '4920', 3)

insert Memesan_Minuman values ('801017', '2113', 4)
insert Memesan_Minuman values ('801018', '2115', 2)
insert Memesan_Minuman values ('801019', '2122', 3)
insert Memesan_Minuman values ('801020', '2172', 5)
insert Memesan_Minuman values ('801005', '2231', 4)
insert Memesan_Minuman values ('801006', '2174', 2)
insert Memesan_Minuman values ('801007', '4111', 1)
insert Memesan_Minuman values ('801008', '4113', 3)
insert Memesan_Minuman values ('801009', '4115', 3)
insert Memesan_Minuman values ('801010', '4116', 2)
insert Memesan_Minuman values ('801001', '4117', 2)
insert Memesan_Minuman values ('801011', '4118', 2)
insert Memesan_Minuman values ('801012', '4119', 3)
insert Memesan_Minuman values ('801005', '5813', 5)
insert Memesan_Minuman values ('801013', '5825', 2)
insert Memesan_Minuman values ('801014', '5827', 2)
insert Memesan_Minuman values ('801015', '5831', 2)
insert Memesan_Minuman values ('801016', '1864', 3)
insert Memesan_Minuman values ('801010', '1973', 1)
insert Memesan_Minuman values ('801012', '1985', 3)


INSERT INTO Meja VALUES ('M01', '2', '1', '40303')
INSERT INTO Meja VALUES ('M02', '4', '1', '40808')
INSERT INTO Meja VALUES ('M03', '6', '1', '40303')
INSERT INTO Meja VALUES ('M04', '8', '1', '40303')
INSERT INTO Meja VALUES ('M05', '8', '1', '40303')
INSERT INTO Meja VALUES ('M06', '6', '1', '40303')
INSERT INTO Meja VALUES ('M07', '4', '1', '40506')
INSERT INTO Meja VALUES ('M08', '2', '1', '40808')
INSERT INTO Meja VALUES ('M09', '8', '1', '40707')
INSERT INTO Meja VALUES ('M10', '8', '2', '40202')
INSERT INTO Meja VALUES ('M11', '6', '2', '40202')
INSERT INTO Meja VALUES ('M12', '4', '2', '40305')
INSERT INTO Meja VALUES ('M13', '2', '2', '40202')
INSERT INTO Meja VALUES ('M14', '8', '2', '40202')
INSERT INTO Meja VALUES ('M15', '4', '2', '40304')
INSERT INTO Meja VALUES ('M16', '4', '3', '40201')
INSERT INTO Meja VALUES ('M17', '8', '3', '40201')
INSERT INTO Meja VALUES ('M18', '6', '3', '40201')
INSERT INTO Meja VALUES ('M19', '8', '3', '40201')
INSERT INTO Meja VALUES ('M20', '2', '3', '40201')

INSERT INTO Reservasi_Meja VALUES ('01180903', 'Mutiara Sukma', '18:00', '20180903', '21')
INSERT INTO Reservasi_Meja VALUES ('02180904', 'Firdaus Dicko', '12:30', '20180904', '13')
INSERT INTO Reservasi_Meja VALUES ('03180904', 'Putri Alfia Husna', '15:00', '20180904', '7')
INSERT INTO Reservasi_Meja VALUES ('04180905', 'Hisana Zahran Dhia', '19:00', '20180905', '15')
INSERT INTO Reservasi_Meja VALUES ('05180905', 'Julian Kristian', '19:00', '20180905', '10')
INSERT INTO Reservasi_Meja VALUES ('06180905', 'Yuli Aprilia', '16:00', '20180905', '13')
INSERT INTO Reservasi_Meja VALUES ('07180906', 'Muhammad Redi', '19:30', '20180906', '15')
INSERT INTO Reservasi_Meja VALUES ('08180907', 'Sharfina Amalia', '12:00', '20180907', '18')
INSERT INTO Reservasi_Meja VALUES ('09180907', 'Tegas Wibisono', '18:45', '20180907', '8')
INSERT INTO Reservasi_Meja VALUES ('10180908', 'Ridha Farida', '20:00', '20180907', '7')
INSERT INTO Reservasi_Meja VALUES ('11180910', 'Ade Andreansyah', '19:45', '20180908', '25')
INSERT INTO Reservasi_Meja VALUES ('12180911', 'Ajeng Zahra', '17:00', '20180910', '23')
INSERT INTO Reservasi_Meja VALUES ('13180912', 'Ali Yudhistira', '16:30', '20180912', '8')
INSERT INTO Reservasi_Meja VALUES ('14180913', 'Theresia Mala', '17:00', '20180913', '16')
INSERT INTO Reservasi_Meja VALUES ('15180914', 'Rifky Dwi', '15:15', '20180914', '10')
INSERT INTO Reservasi_Meja VALUES ('16180915', 'Dewi Damayanti', '17:30', '20180915', '17')
INSERT INTO Reservasi_Meja VALUES ('17180915', 'Marco Fajar', '18:00', '20180915', '22')
INSERT INTO Reservasi_Meja VALUES ('18180915', 'Alika Bella', '19:00', '20180915', '11')
INSERT INTO Reservasi_Meja VALUES ('19180915', 'Alzy Maulana', '19:45', '20180915', '24')
INSERT INTO Reservasi_Meja VALUES ('20180916', 'Sucita Apriani', '16:00', '20180916', '9')

INSERT INTO Memilih VALUES ('M04', '01180903')
INSERT INTO Memilih VALUES ('M05', '01180903')
INSERT INTO Memilih VALUES ('M06', '01180903')
INSERT INTO Memilih VALUES ('M14', '02180904')
INSERT INTO Memilih VALUES ('M05', '02180904')
INSERT INTO Memilih VALUES ('M04', '04180905')
INSERT INTO Memilih VALUES ('M05', '04180905')
INSERT INTO Memilih VALUES ('M10', '05180905')
INSERT INTO Memilih VALUES ('M13', '05180905')
INSERT INTO Memilih VALUES ('M18', '06180905')
INSERT INTO Memilih VALUES ('M19', '06180905')
INSERT INTO Memilih VALUES ('M17', '07180906')
INSERT INTO Memilih VALUES ('M19', '07180906')
INSERT INTO Memilih VALUES ('M10', '08180907')
INSERT INTO Memilih VALUES ('M14', '08180907')
INSERT INTO Memilih VALUES ('M13', '08180907')
INSERT INTO Memilih VALUES ('M05', '09180907')
INSERT INTO Memilih VALUES ('M18', '10180908')
INSERT INTO Memilih VALUES ('M20', '10180908')
INSERT INTO Memilih VALUES ('M16', '11180910')
INSERT INTO Memilih VALUES ('M17', '11180910')
INSERT INTO Memilih VALUES ('M18', '11180910')
INSERT INTO Memilih VALUES ('M19', '11180910')
INSERT INTO Memilih VALUES ('M10', '12180911')
INSERT INTO Memilih VALUES ('M11', '12180911')
INSERT INTO Memilih VALUES ('M13', '12180911')
INSERT INTO Memilih VALUES ('M14', '12180911')
INSERT INTO Memilih VALUES ('M10', '13180912')
INSERT INTO Memilih VALUES ('M17', '14180913')
INSERT INTO Memilih VALUES ('M19', '14180913')
INSERT INTO Memilih VALUES ('M02', '14180913')
INSERT INTO Memilih VALUES ('M03', '14180913')
INSERT INTO Memilih VALUES ('M16', '16180915')
INSERT INTO Memilih VALUES ('M18', '16180915')
INSERT INTO Memilih VALUES ('M19', '16180915')
INSERT INTO Memilih VALUES ('M03', '17180915')
INSERT INTO Memilih VALUES ('M04', '17180915')
INSERT INTO Memilih VALUES ('M05', '17180915')
INSERT INTO Memilih VALUES ('M04', '18180915')
INSERT INTO Memilih VALUES ('M07', '18180915')
INSERT INTO Memilih VALUES ('M11', '19180915')
INSERT INTO Memilih VALUES ('M12', '19180915')
INSERT INTO Memilih VALUES ('M13', '19180915')
INSERT INTO Memilih VALUES ('M14', '19180915')
INSERT INTO Memilih VALUES ('M15', '19180915')
INSERT INTO Memilih VALUES ('M01', '20180916')
INSERT INTO Memilih VALUES ('M05', '20180916')

SELECT * FROM Pegawai
SELECT * FROM Email_Pegawai
SELECT * FROM Telepon_Pegawai
SELECT * FROM Supplier
SELECT * FROM Email_Supplier
SELECT * FROM Telepon_Supplier
SELECT * FROM Pembelian
SELECT * FROM Stock_Bahan
SELECT * FROM Memeriksa
SELECT * FROM Menyuplai
SELECT * FROM Makanan
SELECT * FROM Minuman
SELECT * FROM Menjadi_Makanan
SELECT * FROM Menjadi_Minuman
SELECT * FROM Penjualan
SELECT * FROM Menghasilkan_Makanan
SELECT * FROM Menghasilkan_Minuman
SELECT * FROM Pemesan_Antar
SELECT * FROM Memesan_Makanan
SELECT * FROM Memesan_Minuman
SELECT * FROM Meja
SELECT * FROM Reservasi_Meja
SELECT * FROM Memilih

select ID_P, Nama_P, JobDesk, Gaji from Pegawai 
where Gaji > 3000000

select * from Penjualan 
where J_HargaTotal between 50000 and 100000

select P_No, P_Nama, StrukJual from Pemesan_Antar
order by P_Nama asc

insert into Reservasi_Meja values ('01180951', 'Asyifa Kelana', 
'20:00', '20180903', '12')

delete from Reservasi_Meja where R_Nama = 'Asyifa Kelana'

select Pegawai.ID_P, Pegawai.Nama_P, Memeriksa.M_Tanggal 
from Pegawai join Memeriksa 
on Pegawai.ID_P = Memeriksa.ID_P

select * 
from Memesan_Makanan left outer join Makanan
on Makanan.ID_Makanan = Memesan_Makanan.ID_Makanan

select * 
from Minuman right outer join Menjadi_Minuman
on Minuman.ID_Minuman = Menjadi_Minuman.ID_Minuman

select * 
from Penjualan full outer join Menghasilkan_Minuman
on Penjualan.StrukJual = Menghasilkan_Minuman.StrukJual

SELECT * FROM Pegawai
where JobDesk != 'Koki'

SELECT * FROM Pegawai
where Gaji > 2250000

Select q.P_No, q.P_Nama, p. ID_P, p.Nama_P from Pegawai p
join Pemesan_Antar q
ON p.ID_P = q.ID_P
where q.Kelurahan = 'Kel. Kalijati'

select q.P_No, q.P_Nama, q.Kelurahan from Pegawai p
join Pemesan_Antar q 
ON p.ID_P = q.ID_P
where p.Nama_P = 'Yasamin'

select p.Nama_P, r.B_Tanggal,
CONCAT ( p.Nama_p, ' membeli stock bahan pada ', r.B_Tanggal ) as Jadwal_Pembelian_Pegawai
from Pegawai p
join Pembelian r 
on p.ID_P = r.ID_P

select JobDesk, count(*) as Gaji_lebihDari_3500000 
from Pegawai
where Gaji > 3500000
GROUP BY JobDesk

SELECT peg.ID_P, peg.Gaji FROM Pegawai Peg
WHERE peg.ID_P like '%20%' 
UNION
SELECT peg.ID_P, peg.Gaji FROM Pegawai Peg
WHERE peg.Gaji > 3500000

SELECT peg.Nama_P, peg.JobDesk, peg.Gaji, pen.J_HargaTotal FROM Pegawai peg
join Penjualan pen on pen.ID_P=peg.ID_P
WHERE peg.JobDesk = 'Kasir'
INTERSECT 
SELECT peg.Nama_P, peg.JobDesk, peg.Gaji, pen.J_HargaTotal FROM Pegawai peg
join Penjualan pen on pen.ID_P=peg.ID_P
WHERE pen.J_HargaTotal > 100000

SELECT peg.Nama_P, peg.JobDesk, peg.Gaji, m.M_Kuota, m.Lantai FROM Pegawai Peg 
JOIN Meja m ON peg.ID_P=m.ID_P
WHERE peg.JobDesk = 'Pelayan' and m.M_Kuota = 6
UNION 
SELECT peg.Nama_P, peg.JobDesk, peg.Gaji, m.M_Kuota, m.Lantai FROM Pegawai Peg 
JOIN Meja m ON peg.ID_P=m.ID_P
WHERE peg.JobDesk = 'Pelayan' and m.M_Kuota = 8
EXCEPT
SELECT peg.Nama_P, peg.JobDesk, peg.Gaji, m.M_Kuota, m.Lantai FROM Pegawai Peg 
JOIN Meja m ON peg.ID_P=m.ID_P
WHERE peg.JobDesk = 'Pelayan' and m.Lantai = 3

SELECT * FROM Pegawai WHERE Gaji > (SELECT AVG(Gaji) FROM Pegawai)

SELECT * FROM Pegawai peg
WHERE peg.ID_P IN (
SELECT m.ID_P FROM Meja m
GROUP BY m.ID_P HAVING COUNT(m.ID_P) >= 2 
)

BEGIN TRAN 
BEGIN TRY
 PRINT 'BEFORE INSERT'
 insert into Pembelian values (
  '99094002', (select B_Tanggal from Pembelian where StrukBeli = '99094001'),
  '2150000', (select ID_P from Pegawai where Nama_P = 'Vincent'), 
  (select ID_Sup from Supplier where Nama_Sup = 'Ika Yuni')
 )
PRINT 'AFTER INSERT'
 IF @@TRANCOUNT > 0
 BEGIN
  COMMIT TRAN
 END
END TRY
BEGIN CATCH
 PRINT 'ERROR OCCURED : ROLLBACK ALL'
 PRINT 'ERROR CODE : '+ CAST (@@ERROR AS NVARCHAR(255))
 PRINT ERROR_MESSAGE()
 IF @@TRANCOUNT > 0
 BEGIN
  ROLLBACK TRAN
 END
END CATCH
select * from Pembelian where StrukBeli = '99094002'

create procedure TambahPemesanAntar
@NoPesanan	varchar (8),
@Nama	varchar (30),
@Jalan	varchar (40),
@Kelurahan	varchar (30),
@Telepon	varchar (13),
@StrukJual	varchar (6),
@J_Tanggal date,
@ID_P	varchar (5)
as
begin
insert into Penjualan values (@StrukJual, @J_Tanggal, 0, @ID_P)
insert into Pemesan_Antar values (@NoPesanan, @Nama, @Jalan, @Kelurahan, @Telepon, @StrukJual, @ID_P)
end
go


create procedure TambahPenjualan4
@StrukJual varchar(6),
@J_Tanggal date,
@ID_P varchar(5)
as
begin
insert into Penjualan values (@StrukJual, @J_Tanggal, 0, @ID_P)
end
go


create procedure tambahMakanan
@StrukJual varchar(6),
@jumlahMakanan int,
@IDMakanan varchar(5)
as
begin
		IF @IDMakanan = '4111'
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*21000 
		END  
		ELSE IF @IDMakanan = '4112'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*18000 
		END 
		ELSE IF @IDMakanan = '2816'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*28000 
		END 
		ELSE IF @IDMakanan = '2817'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*30000 
		END 
		ELSE IF @IDMakanan = '2417'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*30000 
		END
		ELSE IF @IDMakanan = '2818'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*23000 
		END 
		ELSE IF @IDMakanan = '4920'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*25000 
		END
		ELSE IF @IDMakanan = '4317'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*40000 
		END
		ELSE IF @IDMakanan = '4316'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*40000 
		END 
		ELSE IF @IDMakanan = '4319'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*42000
		END
		ELSE IF @IDMakanan = '0920'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*34000 
		END 
		ELSE IF @IDMakanan = '0921'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*34000 
		END  
		ELSE IF @IDMakanan = '0410'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*21000 
		END 
		ELSE IF @IDMakanan = '0412'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*23000 
		END   
		ELSE IF @IDMakanan = '0513'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*27000 
		END 
		ELSE IF @IDMakanan = '0515'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*29000 
		END
		ELSE IF @IDMakanan = '0710'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*28000 
		END
		ELSE IF @IDMakanan = '0720'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*28000 
		END
		ELSE IF @IDMakanan = '0731'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*31000 
		END
		ELSE IF @IDMakanan = '0733'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMakanan = @jumlahMakanan*32000 
		END
end
begin
update Penjualan set J_HargaTotal = J_HargaTotal + @jumlahMakanan where StrukJual = @StrukJual
end
go

create procedure tambahMinuman
@StrukJual varchar(6),
@jumlahMinuman int,
@IDMinuman varchar(5)
as
begin
		IF @IDMinuman = '2113'
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*18000 
		END  
		ELSE IF @IDMinuman = '2115'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*18000 
		END 
		ELSE IF @IDMinuman = '2122'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*16000 
		END 
		ELSE IF @IDMinuman = '2172'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*14000 
		END 
		ELSE IF @IDMinuman = '2231'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*13000 
		END
		ELSE IF @IDMinuman = '2174'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*12000 
		END 
		ELSE IF @IDMinuman = '4111'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*15000 
		END 
		ELSE IF @IDMinuman = '4113'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*17000
		END
		ELSE IF @IDMinuman = '4115'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*10000 
		END 
		ELSE IF @IDMinuman = '4116'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*10000 
		END  
		ELSE IF @IDMinuman = '4117'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*10000 
		END 
		ELSE IF @IDMinuman = '4118'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*10000 
		END   
		ELSE IF @IDMinuman = '4119'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*10000 
		END 
		ELSE IF @IDMinuman = '5813'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*10000 
		END
		ELSE IF @IDMinuman = '5825'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*5000 
		END
		ELSE IF @IDMinuman = '5827'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*12000 
		END
		ELSE IF @IDMinuman = '5831'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*12000 
		END
		ELSE IF @IDMinuman = '1864'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*15000 
		END
		ELSE IF @IDMinuman = '1973'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*17000 
		END
		ELSE IF @IDMinuman = '1985'  
		BEGIN  PRINT 'Jumlah '
			SET @jumlahMinuman = @jumlahMinuman*17000 
		END
end
begin
update Penjualan set J_HargaTotal = J_HargaTotal + @jumlahMinuman where StrukJual = @StrukJual
end
go

exec TambahPemesanAntar '801021', 'Alya', 'Jl.Veteran', 'Kel. Lowokwaru', '08223134562','180021', '20181205', '40303'
exec TambahPenjualan4 '180022', '20181205', '50702'

exec tambahMakanan '180021', 3, '4316'
exec tambahMakanan '180021', 2, '0410'
exec tambahMakanan '180022', 1, '0513'

exec tambahMinuman '180021', 2, '2113'
exec tambahMinuman '180022', 1, '1864'


select * from Pemesan_Antar
select * from Penjualan

select * from pegawai

--delete pegawai dengan kelurahan = kel. paya, harus menghapus seluruh data dari semua tabel
delete from Email_Pegawai where ID_P = (select ID_P from Pegawai  where Kelurahan ='Kel. Paya')
delete from Telepon_Pegawai where ID_P = (select ID_P from Pegawai  where Kelurahan ='Kel. Paya')
delete from Pembelian where ID_P = (select ID_P from Pegawai  where Kelurahan ='Kel. Paya')
delete from Memeriksa where ID_P = (select ID_P from Pegawai  where Kelurahan ='Kel. Paya')
delete from Penjualan where ID_P = (select ID_P from Pegawai  where Kelurahan ='Kel. Paya')
delete from Pemesan_Antar where ID_P = (select ID_P from Pegawai  where Kelurahan ='Kel. Paya')
delete from Meja where ID_P = (select ID_P from Pegawai  where Kelurahan ='Kel. Paya')

--..................................................

delete from Pegawai where Kelurahan ='Kel. Paya'
