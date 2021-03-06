﻿CREATE DATABASE QLTHUVIEN
GO
USE QLTHUVIEN
GO
CREATE TABLE DOCGIA 
(
	MADG VARCHAR(5),
	HOTEN NVARCHAR(50),
	SOCMND VARCHAR(10),
	NGSINH DATE,
	GIOITINH NVARCHAR(3),
	DIACHI NVARCHAR(100),
	EMAIL VARCHAR(50),
	MATKHAU VARCHAR(50),
	TONGTIENPHAT INT,
	PRIMARY KEY (MADG)
)

CREATE TABLE DAUSACH
(
	ISBN VARCHAR(10),
	TENSACH NVARCHAR(50),
	TACGIA NVARCHAR(50),
	NAMXB INT,
	NHAXB NVARCHAR(50),
	SOLUONG INT,
	MUCGIAPHAT INT,
	THELOAI NVARCHAR(30),
	TONGLUONGMUON INT,
	PRIMARY KEY (ISBN)
)

CREATE TABLE CUONSACH
(
	ISBN VARCHAR(10),
	MASACH VARCHAR(10),
	TINHTRANG NVARCHAR(30),

	PRIMARY KEY (ISBN, MASACH)
)

CREATE TABLE PHIEUMUON
(
	MAPM VARCHAR(10),
	MADG VARCHAR(5),
	NGAYMUON DATE,
	SOLANTRA INT,
	PRIMARY KEY (MAPM)
)

CREATE TABLE CT_PHIEUMUON
(
	MAPM VARCHAR(10),
	ISBN VARCHAR(10),
	MASACH VARCHAR(10),
	SONGAYQUYDINH INT,
	NGAYTRADUKIEN DATE,
	PRIMARY KEY (MAPM, ISBN, MASACH)
)

CREATE TABLE PHIEUTRA
(
	MAPM VARCHAR(10),
	MAPT VARCHAR(10),
	NGAYTRA DATE,

	PRIMARY KEY (MAPT)
)

CREATE TABLE CT_PHIEUTRA
(
	MAPT VARCHAR(10),
	ISBN VARCHAR(10),
	MASACH VARCHAR(10),
	MUCGIAPHAT INT,
	TIENPHAT INT,
	PRIMARY KEY (MAPT, ISBN, MASACH)
)

ALTER TABLE CUONSACH
ADD constraint FK_CS_DS
FOREIGN KEY (ISBN)
REFERENCES DAUSACH(ISBN)
GO

ALTER TABLE CT_PHIEUMUON
ADD constraint FK_PM_CS
FOREIGN KEY (ISBN, MASACH)
REFERENCES CUONSACH(ISBN, MASACH)
GO

ALTER TABLE CT_PHIEUMUON
ADD constraint FK_CTPM_PM
FOREIGN KEY (MAPM)
REFERENCES PHIEUMUON(MAPM)
GO

ALTER TABLE PHIEUMUON
ADD constraint FK_PM_DG
FOREIGN KEY (MADG)
REFERENCES DOCGIA(MADG)
GO

ALTER TABLE PHIEUTRA
ADD constraint FK_PT_PM
FOREIGN KEY (MAPM)
REFERENCES PHIEUMUON(MAPM)
GO

ALTER TABLE CT_PHIEUTRA
ADD constraint FK_CTPT_PT
FOREIGN KEY (MAPT)
REFERENCES PHIEUTRA(MAPT)
GO

ALTER TABLE CT_PHIEUTRA
ADD constraint FK_CTPT_CS
FOREIGN KEY (ISBN, MASACH)
REFERENCES CUONSACH(ISBN, MASACH)
GO

INSERT INTO DAUSACH VALUES ('AAA123',N'GIẾT CON CHIM NHẠI', N'Harper Lee', '2011', 'NHÃ NAM', 5000, 10000, N'TIỂU THUYẾT', 0)
INSERT INTO DAUSACH VALUES ('AAA124',N'SÁCH A', N'TG A', '2011', 'NHÃ NAM', 5000, 150000, N'TIỂU THUYẾT', 0)
INSERT INTO DAUSACH VALUES ('AAA125',N'SÁCH B', N'TG B', 2015, 'NHÃ NAM', 5200, 150000, N'TIỂU THUYẾT', 0)
INSERT INTO DAUSACH VALUES ('AAA126',N'SÁCH C', N'TG A', 2016, 'TAO ĐÀN', 200, 15000, N'TIỂU THUYẾT', 0)
INSERT INTO DAUSACH VALUES ('AAA127',N'SÁCH D', N'TG C', 2015, 'TAO ĐÀN', 500, 120000, N'TIỂU THUYẾT', 0)
GO

INSERT INTO CUONSACH VALUES ('AAA123', '001', N'CÓ THỂ CHO MƯỢN')
INSERT INTO CUONSACH VALUES ('AAA123', '002', N'CÓ THỂ CHO MƯỢN')
INSERT INTO CUONSACH VALUES ('AAA124', '003', N'CÓ THỂ CHO MƯỢN')
INSERT INTO CUONSACH VALUES ('AAA125', '004', N'CÓ THỂ CHO MƯỢN')
INSERT INTO CUONSACH VALUES ('AAA126', '005', N'CÓ THỂ CHO MƯỢN')
INSERT INTO CUONSACH VALUES ('AAA127', '006', N'CÓ THỂ CHO MƯỢN')
GO

INSERT INTO DOCGIA VALUES ('001', 'AN', '335016878', '02/08/2000', 'NAM', 'ABC.COM', '123456', 'TRA VINH', 0)
INSERT INTO DOCGIA VALUES ('002', 'ANH', '335016879', '02/09/2000', 'NAM', 'ABC.COM', '123456', 'TRA VINH', 0)
GO


CREATE FUNCTION FN_AutoMAMUON()
RETURNS VARCHAR(3)
AS
BEGIN
	DECLARE @num int
	DECLARE @temp varchar(3)
	SET @num = 1
	
	WHILE (1=1)
	BEGIN
		IF (@num < 10)
			BEGIN
				SET @temp = '00' + CAST(@num as varchar(1))
			END
		ELSE IF (@num < 100)
			BEGIN
				SET @temp = '0' + CAST(@num as varchar(2))
			END
		ELSE
			BEGIN
				SET @temp = CAST(@num as varchar(3))
			END
		
		IF (NOT EXISTS(SELECT * FROM PHIEUMUON WHERE MAPM = @temp))
			BEGIN
				RETURN @TEMP
				BREAK
			END
		
		SET @num = @num + 1
	END
	RETURN @TEMP
END
GO
ALTER PROCEDURE SP_MUONSACH @MADG VARCHAR(3),  @ISBN VARCHAR(10), @MASACH VARCHAR(3)
AS
	IF (NOT EXISTS (SELECT *  FROM DOCGIA WHERE MADG = @MADG))
	BEGIN
		RAISERROR(N'USER NOT AVAILABLE',15,1)
		RETURN
	END

	IF (NOT EXISTS (SELECT *  FROM CUONSACH WHERE MASACH = @MASACH AND ISBN = @ISBN))
	BEGIN
		RAISERROR(N'BOOK NOT AVAILABLE',15,1)
		RETURN
	END

	IF ((SELECT TINHTRANG  FROM CUONSACH WHERE MASACH = @MASACH AND ISBN = @ISBN) LIKE N'%CÓ THỂ CHO MƯỢN')
	BEGIN
		DECLARE @MAPM VARCHAR(3)
		SET @MAPM = DBO.FN_AutoMAMUON()
		INSERT INTO PHIEUMUON VALUES (@MAPM, @MADG, GETDATE(), 0)

		INSERT INTO CT_PHIEUMUON VALUES (@MAPM, @ISBN, @MASACH, 15, '7/17/2020')
		
		UPDATE CUONSACH
		SET TINHTRANG = N'CÓ NGƯỜI MƯỢN'
		WHERE ISBN = @ISBN AND MASACH = @MASACH
		RETURN
	END
	ELSE
	BEGIN
	RAISERROR(N'CÓ NGƯỜI MƯỢN RỒI',15,1)
	RETURN
	END
	GO

EXEC SP_MUONSACH '001', 'AAA127','006'
GO

SELECT * 
FROM DOCGIA DG1
WHERE NOT EXISTS (SELECT ISBN FROM DAUSACH WHERE TACGIA = 'Harper Lee'
					EXCEPT
					SELECT ISBN
					FROM PHIEUMUON, CT_PHIEUMUON
					WHERE PHIEUMUON.MAPM = CT_PHIEUMUON.MAPM AND DG1.MADG = PHIEUMUON.MADG)