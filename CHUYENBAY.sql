CREATE DATABASE QLCHUYENBAY
GO

CREATE TABLE KHACHHANG
(
	MAKH NVARCHAR(15),
	TEN NVARCHAR(15),
	DCHI NVARCHAR(50),
	DTHOAI NCHAR(12),
	constraint PK_KH primary key (MAKH)
)
GO

CREATE TABLE NHANVIEN
(
	MANV NVARCHAR(15),
	TEN NVARCHAR(15),
	DCHI NVARCHAR(50),
	DTHOAI  NCHAR(12),
	LUONG FLOAT,
	LOAINV BIT,
	constraint PK_NV primary key (MANV)
)
GO

CREATE TABLE LOAIMB
(
	MALOAI NVARCHAR(15),
	HANGSX NVARCHAR(15),
	constraint PK_LMB primary key (MALOAI)
)
GO

CREATE TABLE MAYBAY
(
	SOHIEU INT,
	MALOAI NVARCHAR(15),
	constraint PK_MB primary key (SOHIEU,MALOAI)
) 
GO

CREATE TABLE CHUYENBAY
(
	MACB NVARCHAR(4),
	SBDI NVARCHAR(3),
	SBDEN NVARCHAR(3),
	GIODI TIME,
	GIODEN TIME,
	constraint PK_CB primary key (MACB)
) 
GO

CREATE TABLE LICHBAY
(
	NGAYDI DATE,
	MACB NVARCHAR(4),
	SOHIEU INT,
	MALOAI NVARCHAR(15),
	constraint PK_LB primary key (NGAYDI,  MACB)
) 
GO

CREATE TABLE DATCHO
(
	MAKH NVARCHAR(15),
	NGAYDI DATE,
	MACB NVARCHAR(4),
	constraint PK_DC primary key (MAKH,  NGAYDI,  MACB)
)
GO

CREATE TABLE KHANANG
(
	MANV NVARCHAR(15),
	MALOAI NVARCHAR(15)
	constraint PK_KN primary key (MANV,  MALOAI)
) 
GO

CREATE TABLE PHANCONG
(
	MANV NVARCHAR(15),
	NGAYDI DATE,
	MACB NVARCHAR(4),
	constraint PK_PC primary key (MANV,  NGAYDI,  MACB)
)
GO

alter table DATCHO 
ADD CONSTRAINT FK_DATCHO_KHACHHANG
FOREIGN KEY (MAKH)
REFERENCES KHACHHANG(MAKH)
GO

alter table DATCHO 
ADD CONSTRAINT FK_DATCHO_LICHBAY
FOREIGN KEY (NGAYDI, MACB)
REFERENCES LICHBAY(NGAYDI, MACB)
GO

alter table LICHBAY 
ADD CONSTRAINT FK_LICH_CHUYENBAY
FOREIGN KEY (MACB)
REFERENCES CHUYENBAY (MACB)
GO

alter table LICHBAY 
ADD CONSTRAINT FK_LICHBAY_MAYBAY
FOREIGN KEY (SOHIEU, MALOAI)
REFERENCES MAYBAY (SOHIEU, MALOAI)
GO

alter table MAYBAY 
ADD CONSTRAINT FK_MAYBAY_LOAIMB
FOREIGN KEY (MALOAI)
REFERENCES LOAIMB(MALOAI)
GO

alter table PHANCONG 
ADD CONSTRAINT FK_PHANCONG_LICHBAY
FOREIGN KEY (NGAYDI, MACB)
REFERENCES LICHBAY(NGAYDI, MACB)
GO

alter table PHANCONG 
ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV)
GO

alter table KHANANG 
ADD CONSTRAINT FK_KHANANG_NHANVIEN
FOREIGN KEY (MANV)
REFERENCES NHANVIEN(MANV)
GO

alter table KHANANG 
ADD CONSTRAINT FK_KHANANG_LOAIMB
FOREIGN KEY (MALOAI)
REFERENCES LOAIMB(MALOAI)
GO

insert into CHUYENBAY
VALUES ('100',  'SLC',   'BOS',   '08:00',    '17:50')
insert into CHUYENBAY
VALUES ('112',   'DCA' ,  'DEN' ,  '14:00'  ,  '18:07')
insert into CHUYENBAY
VALUES ('121' ,  'STL'  , 'SLC' ,  '07:00'  ,  '09:13')
insert into CHUYENBAY
VALUES ('122' ,  'STL' ,  'YYV'  ,  '08:30' ,   '10:19')
insert into CHUYENBAY
VALUES ('206' ,  'DFW'  ,  'STL' ,  '09:00'  ,  '11:40')
insert into CHUYENBAY
VALUES ('330' ,  'JFK'  ,  'YYV'  , '16:00'  ,  '18:53')
insert into CHUYENBAY
VALUES ('334'  , 'ORD'  ,  'MIA'  , '12:00'  ,  '14:14')
insert into CHUYENBAY
VALUES ('335'   ,'MIA'  ,  'ORD' ,  '15:00'  ,  '17:14')
insert into CHUYENBAY
VALUES ('336'  , 'ORD'   , 'MIA' ,  '18:00'  ,  '20:14')
insert into CHUYENBAY
VALUES ('337' ,  'MIA'  ,  'ORD' ,   '20:30'  ,  '23:53')
insert into CHUYENBAY
VALUES ('394'  , 'DFW' ,   'MIA' ,  '19:00'  ,  '21:30')
insert into CHUYENBAY
VALUES ('395'  , 'MIA'  ,  'DFW' ,  '21:00' ,  '23:43')
insert into CHUYENBAY
VALUES ('449' ,  'CDG'  ,  'DEN'  , '10:00' ,  '19:29')
insert into CHUYENBAY
VALUES ('930' ,  'YYV'  ,  'DCA'  ,  '13:00' ,   '16:10')
insert into CHUYENBAY
VALUES ('931' ,  'DCA'   , 'YYV' ,  '17:00'  ,  '18:10')
insert into CHUYENBAY
VALUES ('932' ,  'DCA'  ,  'YYV' ,   '18:00' ,  '19:10' )
insert into CHUYENBAY
VALUES ('991'  , 'BOS'   , 'ORD' ,  '17:00 ' ,  '18:22')
GO

insert into KHACHHANG
VALUES ('0009',		'Nga' ,  '223 Nguyen Trai',    '8932320' )
insert into KHACHHANG
VALUES ('0101',  'Anh'  , '567 Tran Phu',    '8826729' )
insert into KHACHHANG
VALUES ('0045' , 'Thu' ,  '285 Le Loi',    '8932203')
insert into KHACHHANG
VALUES ('0012' ,  'Ha' ,  '435 Quang Trung',    '8933232' )
insert into KHACHHANG
VALUES ('0238' ,'Hung'  , '456 Pasteur',   '9812101' )
insert into KHACHHANG
VALUES ('0397' , 'Thanh' ,  '234 Le Van Si',    '8952943')
insert into KHACHHANG
VALUES ('0582' , 'Mai'  , '789 Nguyen Du',   NULL)
insert into KHACHHANG
VALUES ('0934' ,  'Minh' ,  '678 Le Lai',   NULL)
insert into KHACHHANG
VALUES ('0091' ,  'Hai' ,  '345 Hung Vuong',    '8893223')
insert into KHACHHANG
VALUES ('0314' ,  'Phuong' ,  '395 Vo Van Tan',    '8232320' )
insert into KHACHHANG
VALUES ('0613' ,  'Vu' ,  '348 CMT8',    '8343232' )
insert into KHACHHANG
VALUES ('0586' ,  'Son' ,  '123 Bach Dang',    '8556223')
insert into KHACHHANG
VALUES ('0422' ,  'Tien',   '75  Nguyen  Thong',    '8332222')

GO

insert into NHANVIEN
VALUES ('1006',   'Chi',   '12/6  Nguyen  Kiem',   '8120012',   150000,    0)
insert into NHANVIEN
VALUES ('1005',   'Giao',   '65  Nguyen  Thai  Son',   '8324467',   500000 ,  0 )
insert into NHANVIEN
VALUES ('1001',   'Huong',   '8  Dien  Bien  Phu',   '8330733',   500000  ,  1)
insert into NHANVIEN
VALUES ('1002',   'Phong',   '1  Ly  Thuong  Kiet',   '8308117',  450000  , 1)
insert into NHANVIEN
VALUES ('1004',  'Phuong',   '351  Lac  Long  Quan',  '8308155',   250000  ,  0 )
insert into NHANVIEN
VALUES ('1003',   'Quang',   '78  Truong  Dinh',   '8324461',  350000 ,   1 )
insert into NHANVIEN
VALUES ('1007',  'Tam',   '36  Nguyen  Van  Cu',   '8458188',   500000  ,  0 )
GO

insert into LOAIMB
VALUES ('A310','Airbus'  )
insert into LOAIMB
 VALUES (  'A320', 'Airbus')
insert into LOAIMB
VALUES ( 'A330','Airbus')
insert into LOAIMB
VALUES (   'A340','Airbus')
insert into LOAIMB
VALUES (   'B727','Boeing')
insert into LOAIMB
VALUES (   'B747','Boeing')
insert into LOAIMB
VALUES (   'B757','Boeing')
insert into LOAIMB
VALUES (  'DC10','MD')
insert into LOAIMB
VALUES ( 'DC9' ,'MD')
GO

insert into MAYBAY
VALUES (10   ,'B747') 
insert into MAYBAY
VALUES (11   ,'B727') 
insert into MAYBAY
VALUES (13   ,'B727') 
insert into MAYBAY
VALUES (13   ,'B747') 
insert into MAYBAY
VALUES (21   ,'DC10') 
insert into MAYBAY
VALUES (21   ,'DC9') 
insert into MAYBAY
VALUES (22   ,'B757') 
insert into MAYBAY
VALUES (22   ,'DC9') 
insert into MAYBAY
VALUES (23   ,'DC9') 
insert into MAYBAY
VALUES (24   ,'DC9') 
insert into MAYBAY
VALUES (70   ,'A310') 
insert into MAYBAY
VALUES (80   ,'A310') 
insert into MAYBAY
VALUES (93   ,'B757') 
GO

insert into LICHBAY
VALUES ('11/1/2000'  ,'100' ,  80 ,  'A310' )
insert into LICHBAY
VALUES ('11/1/2000'  ,'112' ,  21 ,  'DC10' )
insert into LICHBAY
VALUES ('11/1/2000'  ,'206' ,  22 ,  'DC9 ')
insert into LICHBAY
VALUES ('11/1/2000'  ,'334' ,  10 , 'B747 ')
insert into LICHBAY
VALUES ('11/1/2000'  ,'395'  , 23 ,  'DC9' )
insert into LICHBAY
VALUES ('11/1/2000' ,'991' ,  22  , 'B757' )
insert into LICHBAY
VALUES ('11/01/2000'  ,'337' ,  10 ,  'B747' )
insert into LICHBAY
VALUES ('10/31/2000'  ,'100'  , 11  , 'B727 ')
insert into LICHBAY
VALUES ('10/31/2000' ,'112' ,  11  , 'B727 ')
insert into LICHBAY
VALUES ('10/31/2000'  ,'206'  , 13 ,  'B727' )
insert into LICHBAY
VALUES ('10/31/2000' ,'334'  , 10 ,  'B747' )
insert into LICHBAY
VALUES ('10/31/2000'  ,'335' ,  10 ,  'B747' )
insert into LICHBAY
VALUES ('10/31/2000'  ,'337'  , 24  , 'DC9' )
insert into LICHBAY
VALUES ('10/31/2000'  ,'449'  , 70 ,  'A310' )
GO

insert into PHANCONG
VALUES ('1001','11/01/2000','100') 
insert into PHANCONG
VALUES ('1001','10/31/2000','100') 
insert into PHANCONG
VALUES ('1002','11/01/2000','100') 
insert into PHANCONG
VALUES ('1002','10/31/2000','100') 
insert into PHANCONG
VALUES ('1003','10/31/2000','100') 
insert into PHANCONG
VALUES ('1003','10/31/2000','337') 
insert into PHANCONG
VALUES ('1004','10/31/2000','100') 
insert into PHANCONG
VALUES ('1004','10/31/2000','337') 
insert into PHANCONG
VALUES ('1005','10/31/2000','337') 
insert into PHANCONG
VALUES ('1006','11/01/2000','991') 
insert into PHANCONG
VALUES ('1006','10/31/2000','337') 
insert into PHANCONG
VALUES ('1007','11/01/2000','112') 
insert into PHANCONG
VALUES ('1007','11/01/2000','991') 
insert into PHANCONG
VALUES ('1007','10/31/2000','206') 
GO

insert into DATCHO
VALUES ('0009',   '11/01/2000',   '100') 
insert into DATCHO
VALUES ('0009',   '10/31/2000',   '449') 
insert into DATCHO
VALUES ('0045',   '11/01/2000',   '991') 
insert into DATCHO
VALUES ('0012',   '10/31/2000',   '206') 
insert into DATCHO
VALUES ('0238',   '10/31/2000',   '334') 
insert into DATCHO
VALUES ('0582',   '11/01/2000',   '991') 
insert into DATCHO
VALUES ('0091',   '11/01/2000',   '100') 
insert into DATCHO
VALUES ('0314',   '10/31/2000',   '449') 
insert into DATCHO
VALUES ('0613',   '11/01/2000',   '100') 
insert into DATCHO
VALUES ('0586',   '11/01/2000',   '991') 
insert into DATCHO
VALUES ('0586',   '10/31/2000',   '100') 
insert into DATCHO
VALUES ('0422',   '10/31/2000',   '449') 
GO

insert into KHANANG
VALUES('1001','B727') 
insert into KHANANG
VALUES('1001','B747') 
insert into KHANANG
VALUES('1001','DC10') 
insert into KHANANG
VALUES('1001','DC9') 
insert into KHANANG
VALUES('1002','A320') 
insert into KHANANG
VALUES('1002','A340') 
insert into KHANANG
VALUES('1002','B757') 
insert into KHANANG
VALUES('1002','DC9') 
insert into KHANANG
VALUES('1003','A310') 
insert into KHANANG
VALUES('1003','DC9')
GO