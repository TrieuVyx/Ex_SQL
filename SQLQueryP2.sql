/*
Th?ng kê (phân phối) số lu?ng s?n ph?m theo: nhóm hàng (catelogogy), kích c? (size) (b?ng product)
*/

SELECT CAST(p.Category AS VARCHAR(255)) AS Category,CAST( p.Size AS VARCHAR(255)) AS Size,COUNT(*) AS AmountProduct
FROM Products p
GROUP BY CAST(p.Category AS VARCHAR(255)),CAST( p.Size AS VARCHAR(255))

/*
1.2 Thống kê (phân phối) số lượng đơn hàng bán ra của sản phẩm theo: nhóm hàng (catelogogy), kích cỡ (size) (bảng sales và bảng product)

*/

SELECT CAST(p.Category AS VARCHAR(255)) AS Category,CAST( p.Size AS VARCHAR(255)) AS Size,COUNT(CAST(s.PID AS VARCHAR(255))) AS AmountProduct
FROM Sales s, Products p
WHERE CAST(s.PID AS VARCHAR(255)) = p.PID
GROUP BY CAST(p.Category AS VARCHAR(255)),CAST( p.Size AS VARCHAR(255))
/*
2.1 Gom nhóm dữ liệu bảng product theo giá trị trên từng hộp (cost per boxes):
+ Nhóm sản phẩm dưới 1$ - Giá rẻ
+ Nhóm sản phẩm từ 1-3$ - Bình dân
+ Nhóm sản phẩm từ 3-5$ - Tầm Trung
+ Nhóm sản phẩm  trên 5$ - cao cấp
*/

SELECT 
	CASE 
		WHEN p.Cost_per_box < 1 THEN 'Giá Rẻ'
		WHEN p.Cost_per_box >= 1 AND P.Cost_per_box < 3 THEN 'Bình dân'
		WHEN p.Cost_per_box >=3 AND P.Cost_per_box < 5 THEN 'Tầm Trung'
		WHEN p.Cost_per_box >= 5 THEN 'Cao cấp'
	END  AS CostRange ,
	COUNT(*) AS AmountProduct

FROM Products p
GROUP BY 
	CASE 
		WHEN p.Cost_per_box < 1 THEN 'Giá Rẻ'
		WHEN p.Cost_per_box >= 1 AND p.Cost_per_box < 3 THEN 'Bình dân'
		WHEN p.Cost_per_box >= 3 AND p.Cost_per_box < 5 THEN 'Tầm Trung'
		WHEN p.Cost_per_box >= 5 THEN 'Cao cấp'
	END;

/*
2.2  Thống kê (phân phối) số lượng đơn hàng bán ra của sản phẩm theo phân khúc giá thành
*/

SELECT 
	CASE 
		WHEN p.Cost_per_box < 1 THEN 'Giá Rẻ'
		WHEN p.Cost_per_box >= 1 AND P.Cost_per_box < 3 THEN 'Bình dân'
		WHEN p.Cost_per_box >=3 AND P.Cost_per_box < 5 THEN 'Tầm Trung'
		WHEN p.Cost_per_box >= 5 THEN 'Cao cấp'
	END  AS CostRange ,
	COUNT(*) AS AmountProduct

FROM Products p, Sales s
WHERE CAST(s.PID AS VARCHAR(255)) = p.PID
GROUP BY 
	CASE 
		WHEN p.Cost_per_box < 1 THEN 'Giá Rẻ'
		WHEN p.Cost_per_box >= 1 AND p.Cost_per_box < 3 THEN 'Bình dân'
		WHEN p.Cost_per_box >= 3 AND p.Cost_per_box < 5 THEN 'Tầm Trung'
		WHEN p.Cost_per_box >= 5 THEN 'Cao cấp'
	END;

/*
3. 1 Thống kê (phân phối) số lượng đơn hàng bán ra theo: vị trí (location), team (bảng sales và bảng people)
*/

SELECT CAST(ps.Team AS VARCHAR(255)) AS Team, CAST(ps.Location AS VARCHAR(255)) AS Location, COUNT(*) AS AmountSale
FROM Sales s, People ps
WHERE CAST(s.SPID AS VARCHAR(255)) = ps.SPID
GROUP BY CAST(ps.Team AS VARCHAR(255)), CAST(ps.Location AS VARCHAR(255))

/*
	4. Quý  nào bán được nhiều đơn hàng hơn:
	1 quý 3 tháng
*/
SELECT DATEPART(QUARTER, s.saleDate)  AS Quater, COUNT(*) AS AmountSales
FROM Sales s
GROUP BY DATEPART(QUARTER, s.saleDate)
/*
5.1 Cho biết loại sản phẩm bán ra theo từng ngày trong tháng 1 năm 2022
*/
SELECT DATEPART(DAY, s.SaleDate)  AS DAY,DATEPART(YEAR, s.SaleDate)  AS YEAR, COUNT(*) AS AmountSales
FROM Sales s
WHERE DATEPART(YEAR, s.SaleDate) =2021
GROUP BY DATEPART(DAY, s.SaleDate) ,DATEPART(YEAR, s.SaleDate)
/*
5.2 Tính doanh thu của theo từng ngày, tháng, quý, năm.
*/

--DAY
SELECT 
DATEPART(DAY, s.SaleDate) AS DAY, SUM(s.Amount) AS AmountSales
FROM Sales s
GROUP BY DATEPART(DAY, s.SaleDate)
--MONTH
SELECT 
DATEPART(MONTH, s.SaleDate) AS MONTH, SUM(s.Amount) AS AmountSales
FROM Sales s
GROUP BY DATEPART(MONTH, s.SaleDate)
--QUARTER
SELECT 
DATEPART(QUARTER, s.SaleDate) AS QUARTER, SUM(s.Amount) AS AmountSales
FROM Sales s
GROUP BY DATEPART(QUARTER, s.SaleDate)
--YEAR
SELECT 
DATEPART(YEAR, s.SaleDate) AS YEAR, SUM(s.Amount) AS AmountSales
FROM Sales s
GROUP BY DATEPART(YEAR, s.SaleDate)


--DAY,MONTH,YEAR AND QUARTER
SELECT 
	DATEPART(DAY, s.SaleDate) AS DAY, 
	DATEPART(MONTH, s.SaleDate) AS MONTH, 
	DATEPART(YEAR, s.SaleDate) AS YEAR,
	DATEPART(QUARTER, s.SaleDate) AS QUARTER, SUM(s.Amount) AS Amount
FROM Sales s
GROUP BY
	DATEPART(DAY, s.SaleDate), 
	DATEPART(MONTH, s.SaleDate), 
	DATEPART(YEAR, s.SaleDate) ,
	DATEPART(QUARTER, s.SaleDate) 
ORDER BY
	DATEPART(YEAR, s.SaleDate) DESC

/*
6. Quý nào trong cơ sở dữ liệu có:
*/
SELECT 
	DATEPART(YEAR, s.SaleDate) AS YEAR,
	DATEPART(QUARTER, s.SaleDate) AS QUARTER
FROM Sales s
GROUP BY
	DATEPART(YEAR, s.SaleDate) ,
	DATEPART(QUARTER, s.SaleDate) 
ORDER BY 
	DATEPART(QUARTER, s.SaleDate) ASC

/*
6.1 nhiều khách hàng hơn nhưng bán được ít đơn hàng hơn
*/
SELECT
	 CAST(s.PID AS VARCHAR(255)) AS PID, SUM(s.Customers) AS ToTalCustomer, COUNT(CAST(s.PID AS VARCHAR(255))) AS TotalProduct
FROM Sales s
GROUP BY CAST(s.PID AS VARCHAR(255))
ORDER BY ToTalCustomer ASC

/*
6.2 nhiều đơn hàng hơn nhưng doanh thu ít hơn
*/
SELECT
	 CAST(s.PID AS VARCHAR(255)) AS PID, SUM(s.Amount) AS ToTalAmount, COUNT(CAST(s.PID AS VARCHAR(255))) AS TotalProduct
FROM Sales s
GROUP BY CAST(s.PID AS VARCHAR(255))
ORDER BY TotalProduct DESC, ToTalAmount ASC