create database QLGiaoVien
go
use QLGiaoVien
go
create table GIAOVIEN
(
	magv nchar(5),
	hoten nvarchar(100) not null,
	luong float,
	phai nvarchar(3) constraint chk CHECK (phai in('Nam', 'Nu')) not null,
	ngsinh date,
	diachi nvarchar(100),
	constraint PK_GV primary key (magv)
)

create table BOMON
(
	mabm nchar(4),
	tenbm nvarchar(50) not null,
	phong nchar(3) not null,
	dienthoai nchar(10),
	truongbm nchar(5),
	makhoa nchar(5) not null,
	ngaynhanchuc date,
	constraint PK_BM primary key (mabm)
)

create table KHOA
(
	makhoa nchar(5),
	tenkhoa nvarchar(50) not null,
	namtl nchar(4) not null,
	phong nchar(3), 
	dienthoai nchar(10),
	truongkhoa nchar(5),
	ngaynhanchuc date,
	constraint PK_KHOA primary key (makhoa)
)

create table DETAI
(
	madt nchar(3),
	tendt nvarchar(100), 
	capql nvarchar (50), 
	kinhphi float, 
	ngaybd date,
	ngaykt date,
	macd nchar(4),
	gvcndt nchar(5),
	constraint PK_DT primary key (madt)
)

create table CHUDE
(
macd nchar(4),
tencd nvarchar(100)
constraint PK_CD primary key (macd)
)

create table GV_DT
(
	magv nchar(5),
	dienthoai nchar(10),
	constraint PK_GVDT primary key (magv, dienthoai)
)

create table CV
(
madt char(3),stt int,tencv nvarchar(100), ngaybd date, ngaykt date,
constraint PK_CV primary key (madt, stt)
)

create table THAMGIADT
(
	magv nchar(5), madt nchar(3), stt int, phucap float, ketqua nvarchar(10) constraint chik CHECK (ketqua in('Đạt', 'Chưa đạt', null)),
	constraint PK_TGDT primary key (magv, madt, stt)
)
create table NGUOI_THAN
(
magv nchar(5), ten nvarchar(100), ngsinh date, phai nvarchar(3) constraint chiki CHECK (phai in('Nam', 'Nu')) not null,
constraint PK_NT primary key (magv, ten)
)

go

alter table GV_DT
add constraint FK_GVDT_GV
foreign key (magv) references GIAOVIEN(magv)
go

alter table BOMON
add constraint FK_BOMON_GV
foreign key (truongbm) references GIAOVIEN(magv)
go

alter table BOMON
add constraint FK_BOMON_KHOA
foreign key (makhoa) references KHOA(makhoa)
go






