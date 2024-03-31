
-----------------------------------phân quyền Quyền truy cập cơ sở dữ liệu (SELECT, INSERT, UPDATE, DELETE)-----------------------------
--Tạo Người Dùng
CREATE LOGIN TrieuVy WITH PASSWORD = '0837441290Aa@';
CREATE USER TrieuVy1 FOR LOGIN TrieuVy;
--Tạo Người Dùng khác
CREATE LOGIN Test WITH PASSWORD = '0837441290Aa@';
CREATE USER Test1 FOR LOGIN Test;

-----------------------------------Trở về Root-----------------------------------
-- new query để xem root user 
-- kiểm tra phiên làm việc của user đang hiện hữu
-- hiểu rõ chỗ này sẽ phân quyền được
SELECT SUSER_SNAME() AS CurrentUser;
		-- quyền phải do root user 
-- tìm Id phiên làm việc hiện tại
EXEC sp_who; --- tìm spid là sessionID cần KILL  ---
-- xoá phiên làm việc tại new Query để về root user nếu đã dùng EXCUTE AS USER = 'other user';
-- nếu lỗi khi dùng KILL --> phiên làm việc hiện tại đang của user chứ không phải root 
/*
Msg 6102, Level 14, State 2, Line 19
User does not have permission to use the KILL statement.
*/
-- new query để dùng
KILL 57


--- xem được 2 user này tức là đang ở root user 
-- Xem Quyền
USE awesome;
EXEC sp_helprotect @username = Test1;
-- Xem Quyền
USE awesome;
EXEC sp_helprotect @username = TrieuVy1;



--ví dụ để xem User select không phải là root user
--xem user 
SELECT SUSER_SNAME() AS CurrentUser;

-- đổi user
EXECUTE AS USER = 'TrieuVy1'; 
GO
--kiểm tra user
SELECT SUSER_SNAME() AS CurrentUser;

SELECT * FROM Products;
GO
/*
Message
Msg 229, Level 14, State 5, Line 42
The SELECT permission was denied on the object 'Products', database 'awesome', schema 'dbo'.
*/
---------Trở về Root để thực hiện phân quyền cho user TrieuVy--------










--------------------------- thực hiện phân quyền SELECT--------------------

-- Cấp Quyền Select chỉ được thực hiện ở user có quyền root
USE awesome;
GRANT SELECT ON Products TO Trieuvy1;

-- Xem Quyền
USE awesome;
EXEC sp_helprotect @username = TrieuVy1;

/*

-- Sang Tab mới Kiểm tra CTRL + N
EXECUTE AS USER = 'TrieuVy1';
GO
SELECT *
FROM products

*/ 


-- Xoá Quyền Select chỉ được thực hiện ở user có quyền root
REVOKE SELECT ON Products FROM TrieuVy1;

--------------------------- thực hiện phân quyền INSERT--------------------
/*
THỬ THỰC HIỆN INSERT Ở NEW QUERY
EXECUTE AS USER = 'TrieuVy1';
GO
INSERT INTO Products VALUES
('P23','Milk Bars','Bars','LARGE',3.52);


-- Lỗi
Msg 229, Level 14, State 5, Line 3
The INSERT permission was denied on the object 'Products', database 'awesome', schema 'dbo'.

*/

----cấp quyền INSERT---
USE awesome;
GRANT INSERT ON Products TO Trieuvy1;

-- Xoá Quyền INSERT chỉ được thực hiện ở user có quyền root
REVOKE INSERT ON Products FROM TrieuVy1;
--------------------------- thực hiện phân quyền UPDATE --------------------

/*
THỬ THỰC HIỆN INSERT Ở NEW QUERY

--xem trước
SELECT *
FROM Products p
WHERE p.PID = 'P23'
thực hiện update ở new query
EXECUTE AS USER = 'TrieuVy1';
GO
UPDATE Products
SET Product = 'Milk Teas', Category = 'Bites', Size = 'SMALL', Cost_per_box = 3.4
WHERE PID = 'P23';

-- Lỗi
Msg 229, Level 14, State 5, Line 3
The UPDATE permission was denied on the object 'Products', database 'awesome', schema 'dbo'.

*/


----cấp quyền UPDATE---
USE awesome;
GRANT UPDATE ON Products TO Trieuvy1;

-- Xoá Quyền UPDATE chỉ được thực hiện ở user có quyền root
REVOKE UPDATE ON Products FROM TrieuVy1;

--------------------------- thực hiện phân quyền DELETE --------------------

/*
THỬ THỰC HIỆN INSERT Ở NEW QUERY

--xem trước
SELECT *
FROM Products p
WHERE p.PID = 'P23'
thực hiện update ở new query
EXECUTE AS USER = 'TrieuVy1';
GO
DELETE FROM Products
WHERE PID = 'P23';

-- Lỗi
Msg 229, Level 14, State 5, Line 3
The DELETE permission was denied on the object 'Products', database 'awesome', schema 'dbo'

*/
----cấp quyền DELETE---
USE awesome;
GRANT DELETE ON Products TO Trieuvy1;

-- Xoá Quyền DELETE chỉ được thực hiện ở user có quyền root
REVOKE DELETE ON Products FROM TrieuVy1;