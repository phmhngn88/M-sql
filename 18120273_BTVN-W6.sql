USE QLCHUYENBAY
GO
--Q51
SELECT CB.*
FROM CHUYENBAY CB
WHERE NOT EXISTS (SELECT MB.SOHIEU
					FROM MAYBAY MB, LOAIMB LMB
					WHERE MB.MALOAI = LMB.MALOAI AND LMB.HANGSX = 'Boeing'
					EXCEPT
					SELECT LICHBAY.SOHIEU
					FROM LICHBAY
					WHERE LICHBAY.MACB = CB.MACB)
GO

--Q52
SELECT NV.MANV, NV.TEN
FROM NHANVIEN NV
WHERE NV.LOAINV = 1 AND NOT EXISTS (
					SELECT MB.MALOAI
					FROM MAYBAY MB, LOAIMB LMB
					WHERE MB.MALOAI = LMB.MALOAI AND LMB.HANGSX = 'Airbus'
					EXCEPT
					SELECT KN.MALOAI
					FROM KHANANG KN
					WHERE KN.MANV = NV.MANV
)
GO
--q53
SELECT NV.TEN
FROM NHANVIEN NV
WHERE NV.LOAINV = 0 AND NOT EXISTS  (
	SELECT LB.MACB, NGAYDI
	FROM LICHBAY LB
	WHERE LB.MACB = '100'
	EXCEPT
	SELECT PC.MACB, PC.NGAYDI
	FROM PHANCONG PC
	WHERE PC.MANV = NV.MANV AND PC.MACB = '100'
)
GO

--Q54
SELECT LB.NGAYDI
FROM LICHBAY LB
WHERE NOT EXISTS(
	SELECT MB.SOHIEU
	FROM MAYBAY MB, LOAIMB LMB
	WHERE MB.MALOAI = LMB.MALOAI AND LMB.HANGSX = 'Boeing'
	EXCEPT
	SELECT LB2.SOHIEU
	FROM LICHBAY LB2
	WHERE  LB2.MACB = LB.MACB
)

--Q55
SELECT LMB.MALOAI
FROM LOAIMB LMB
WHERE LMB.HANGSX = 'Boeing' AND NOT EXISTS (
	SELECT DISTINCT LB1.NGAYDI 
	FROM LICHBAY LB1
	EXCEPT 
	SELECT LB2.NGAYDI  
	FROM LICHBAY LB2
	WHERE LB2.MALOAI = LMB.MALOAI
)
GO

--Q56

SELECT KH.MAKH, KH.TEN
FROM KHACHHANG KH
WHERE NOT EXISTS (
	SELECT LB.MACB
	FROM LICHBAY LB
	WHERE NGAYDI BETWEEN '1/1/2000' AND '10/31/2000'
	EXCEPT
	SELECT DC.MACB
	FROM DATCHO DC
	WHERE KH.MAKH = DC.MAKH AND DC.NGAYDI BETWEEN '1/1/2000' AND '10/31/2000'
)
GO

--Q57
SELECT NV.MANV, NV.TEN
FROM NHANVIEN NV
WHERE NV.LOAINV = 1 AND EXISTS (
					SELECT MB.MALOAI
					FROM MAYBAY MB, LOAIMB LMB
					WHERE MB.MALOAI = LMB.MALOAI AND LMB.HANGSX = 'Airbus'
					EXCEPT
					SELECT KN.MALOAI
					FROM KHANANG KN
					WHERE KN.MANV = NV.MANV
)
GO


--Q58
SELECT CB.SBDI
FROM CHUYENBAY CB
WHERE NOT EXISTS (
SELECT LB.MACB
FROM LICHBAY LB, LOAIMB LMB
WHERE LB.MALOAI = LMB.MALOAI AND LMB.HANGSX = 'Boeing'
EXCEPT
SELECT CB1.MACB
FROM CHUYENBAY CB1
WHERE CB1.SBDI = CB.SBDI
)