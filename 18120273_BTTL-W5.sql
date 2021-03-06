﻿--q35
select max(luong)
from GIAOVIEN
go

--Q36
SELECT GIAOVIEN.*
FROM GIAOVIEN
WHERE LUONG = (select max(luong)
				from GIAOVIEN)
GO

SELECT MAX(LUONG)
FROM GIAOVIEN
WHERE GIAOVIEN.mabm = 'HTTT'
GO

SELECT *
FROM GIAOVIEN
WHERE GIAOVIEN.ngsinh = (SELECT MIN(NGSINH) FROM GIAOVIEN WHERE GIAOVIEN.mabm = 'HTTT') AND GIAOVIEN.mabm = 'HTTT'
GO

SELECT *
FROM GIAOVIEN
JOIN BOMON
ON BOMON.mabm = GIAOVIEN.mabm
JOIN KHOA
ON BOMON.makhoa = KHOA.makhoa AND KHOA.makhoa = 'CNTT' WHERE ngsinh = (SELECT MAX(NGSINH) FROM GIAOVIEN
JOIN BOMON
ON BOMON.mabm = GIAOVIEN.mabm
JOIN KHOA
ON BOMON.makhoa = KHOA.makhoa AND KHOA.makhoa = 'CNTT' )
GO

SELECT GIAOVIEN.hoten, KHOA.tenkhoa
FROM GIAOVIEN
JOIN BOMON
ON BOMON.mabm = GIAOVIEN.mabm
JOIN KHOA
ON BOMON.makhoa = KHOA.makhoa
WHERE GIAOVIEN.LUONG >= ALL(SELECT LUONG FROM GIAOVIEN)
GO

SELECT GV1.HOTEN, GV1.mabm
FROM GIAOVIEN GV1
WHERE GV1.LUONG >= ALL (SELECT GV2.LUONG FROM GIAOVIEN GV2
						WHERE GV1.mabm = GV2.mabm)

GO

SELECT DETAI.*
FROM DETAI
WHERE DETAI.madt NOT IN(
SELECT DETAI.madt
FROM THAMGIADT
JOIN DETAI
ON DETAI.madt = THAMGIADT.madt
JOIN GIAOVIEN
ON GIAOVIEN.magv = THAMGIADT.magv
WHERE GIAOVIEN.HOTEN = N'Nguyễn Hoài An')
GO

SELECT DETAI.*, GIAOVIEN.HOTEN AS TEN_GVCN
FROM DETAI, GIAOVIEN
WHERE DETAI.madt NOT IN(
SELECT DETAI.madt
FROM THAMGIADT
JOIN DETAI
ON DETAI.madt = THAMGIADT.madt
JOIN GIAOVIEN
ON GIAOVIEN.magv = THAMGIADT.magv
WHERE GIAOVIEN.HOTEN = N'Nguyễn Hoài An') 
AND GIAOVIEN.magv = DETAI.gvcndt
GO

SELECT GIAOVIEN.*
FROM GIAOVIEN
JOIN BOMON
ON GIAOVIEN.mabm = BOMON.mabm AND BOMON.makhoa = 'CNTT'
WHERE GIAOVIEN.magv NOT IN (SELECT THAMGIADT.MAGV FROM THAMGIADT)
GO


SELECT GIAOVIEN.*
FROM GIAOVIEN
WHERE GIAOVIEN.magv NOT IN (SELECT THAMGIADT.MAGV FROM THAMGIADT)
GO

--Q46
SELECT GIAOVIEN.*
FROM GIAOVIEN
WHERE GIAOVIEN.LUONG > (SELECT GIAOVIEN.LUONG FROM GIAOVIEN WHERE GIAOVIEN.hoten = N'Nguyễn Hoài An')
go

--q47
select GIAOVIEN.*
from GIAOVIEN
join BOMON
on GIAOVIEN.magv = bomon.truongbm
where count(