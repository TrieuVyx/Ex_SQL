
-----------------------------------phân quyền Quyền truy cập cơ sở dữ liệu (SELECT, INSERT, UPDATE, DELETE)-----------------------------

USE awesome
--Tạo Người Dùng
CREATE LOGIN TrieuVy WITH PASSWORD = '0837441290Aa@';
CREATE USER TrieuVy1 FOR LOGIN TrieuVy;
------------------------------- Phân quyền select -------------------------------
--gán quyền
GRANT SELECT ON Products TO Trieuvy1;
-- xem quyền
EXEC sp_helprotect @username = TrieuVy1;

-- Thực hiện quyền 
EXECUTE AS USER = 'TrieuVy1'; 
GO
SELECT *
FROM products


------------------------------- Phân quyền insert -------------------------------
--gán quyền
GRANT INSERT ON Products TO Trieuvy1;

-- xem quyền
EXEC sp_helprotect @username = TrieuVy1;

-- Thực hiện quyền 
EXECUTE AS USER = 'TrieuVy1';
GO
INSERT INTO Products VALUES
('P23','Milk Bars','Bars','LARGE',3.52);
-- XEM KẾT QUẢ
SELECT *
FROM products
WHERE PID = 'P23';

------------------------------- Phân quyền update -------------------------------

--gán quyền
GRANT UPDATE ON Products TO Trieuvy1;

-- xem quyền
EXEC sp_helprotect @username = TrieuVy1;
-- Thực hiện quyền
EXECUTE AS USER = 'TrieuVy1';
GO
UPDATE Products
SET Product = 'Milk Teas', Category = 'Bites', Size = 'SMALL', Cost_per_box = 3.4
WHERE PID = 'P23';
-- XEM KẾT QUẢ
SELECT *
FROM products
WHERE PID = 'P23';

------------------------------- Phân quyền delete -------------------------------

--gán quyền
GRANT DELETE ON Products TO Trieuvy1;
-- xem quyền
EXEC sp_helprotect @username = TrieuVy1;

-- Thực hiện quyền
EXECUTE AS USER = 'TrieuVy1';
GO
DELETE FROM Products
WHERE PID = 'P23';
-- XEM KẾT QUẢ
SELECT *
FROM products
WHERE PID = 'P23';