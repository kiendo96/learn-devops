# 4 nhóm lệnh chính
- SQL(Structured Query Language) : `select`, `count/distinct(loại bỏ trùng lặp)/limit`
- DML(Data Manipulation Language): `insert`, `update`, `delete` thay đổi về mặt dữ liệu
- DDL(Data Definition Language): `create/drop table`
- DCL(Data Control Language)

# Create/Drop Table

```
create table tablename(
    column1 datatype,
    column2 datatype,
    column3 datatype,
    ....
);
```

### Các kiểu dữ liệu (datatype) thường dùng:
- Number:
    + `SMALLINT`: Số nguyên 2 bytes, từ `-32768` to `+32768`
    + `INTEGER hoặc INT`: số nguyên 4 bytes, từ `-2147483648` to `+2147483648`
    + `BIGINT`: 8 bit, từ `-9223372036854775808` to `+9223372036854775808`
    + `FLOAT`: số thực 4 bytes, từ `-7.2E+75` to `+7.2E+75`
    + `DOUBLE`: số thực 8 bytes
- String:
    + `CHAR(n)`: Chuỗi có độ dài cố định n bytes (với n từ 1 -> 255)
    + `VARCHAR(n)`: Chuỗi có độ dài khác nhau với tối đa n bytes (với n từ 1 -> 32704)
    + `BINARY(n)`: Chuỗi nhị phân có độ dài cố định n bytes (với n từ 1-> 255)
    + `VARBINARY(n)`: Chuỗi nhị phân có độ dài khác nhau với tối đa n bytes (với n từ 1 -> 32704)

- Datetime:
    + `DATE`: Kiểu ngày với 3 giá trị năm, tháng, ngày (từ 0001-01-01 đến 9999-12-31)
    + `TIME`: Kiểu giờ với 3 giá trị giờ, phút, giây (từ 00.00.00 đến 24.0.0)
    + `TIMESTAMP`: Kiểu ngày giờ với bảy giá trị năm, tháng, ngày, giờ, phút, giây và micro giây (9999-12-31-24.00.00.000000000)
- Kiểu dữ liệu lớn (LOB large object):
    + `CLOB(n)`: Chuỗi có độ dài khác nhau với tối đa n ký tự (n< 2.147.483.647)
    + `DBCLOB(n)`: Chuỗi các ký tự 2 bytes có độ dài khác nhau với tối đa n ký tự (n < 1.073.741.824)
    + `BLOB(n)`: Chuỗi nhị phân có độ dài khác nhau với tối đa n ký tự (n < 2.147.483.647)

### Example
Ex1:Create a table COUNTRY with 3 column: ID, CountryCode and CountryName

```
create table COUNTRY(
    ID int,
    CountryCode char(3),
    CountryName varchar(60)
);
```

Ex2: Create a COUNTRY with 3 column: ID, CountryCode and CountryName. In that, ID is primary key
```
create table COUNTRY(
    ID int primary key not null,
    CountryCode char(3),
    CountryName varchar(60)
);
```

### DROP TABLE
- Syntax: `drop table tablename;`
- Note:
    + Not null: dữ liệu của cột không được phép Null
    + Tên bảng và Tên cột không có khoảng trắng và các ký tự đặc biệt, không phân biệt hoa thường.
    + Tên bảng và Tên cột phải được bắt đầu bằng ký tự chữ hoặc _



# Select
- Dùng để truy vấn (lựa chọn) dữ liệu từ các
bảng dữ liệu
- Syntax:

```
select *| COLUMN1, COLUMN2, ...| EXPRESSION1, EXPRESSION2, …
from TABLENAME;
select COLUMN1, COLUMN2, ...
from TABLENAME
where CONDITION;
```

- Lưu ý:
    + Dùng ký tự * để thay thế cho tất cả các cột (Column) trong bảng
    + Có thể đặt bí danh cho cột thông qua từ khóa `As`
    + Các phép toán so sánh trong mệnh đề điều kiện
        + =, >, >=, <, <=, != (hoặc <>)
        + Between … and…
        + IN (list)


# COUNT/DISTINCT/LIMIT
- Dùng để tính toán trong câu lệnh truy vấn dữ liệu từ các bảng dữ liệu
- `COUNT`: Dùng để đếm số lượng mẩu tin(column) được truy vấn: `select count(*) from tablename;`
- `DISTINCT`: Dùng loại bảo các dòng dữ liệu trùng trong câu lệnh truy vấn: `select DISTINCT columnname from tablename`
- `LIMIT`: Dùng giới hạn số dòng dữ liệu trong câu lệnh truy vấn `select * from tablename limit Number_of_rows`;

# INSERT
- Dùng để thêm mẩu tin (dòng dữ liệu) mới vào bảng dữ liệu
- Cú pháp chung:
```
Insert into tablename [([ColumnName1],[ColumnName2],…)]
Values([Value1], [Value2],…);
```
- Có thể thêm nhiều dòng dữ liệu đồng thời
Ex:

```
Insert into COUNTRY (Id, CountryCode, CountryName)
Values (1, 'VIE', 'Việt Nam'), (2, 'USA', 'United State');
```

# Update
- Dùng để cập nhật (sửa) mẩu tin (dòng dữ liệu) trong bảng dữ liệu
- Cú pháp chung:

```
Update tablename
Set [[ColumnName1]=[Value1],[ColumnName1]=[Value1],… ][Where <Condition>];
```

- Example:
```
Update COUNTRY
Set CountryName = 'United State of American'
Where CountryCode = 'USA';
```

# Delete
- Dùng để xóa data in tables
- Syntax:
```
delete from tablename
[where <condition>];
```

# CONSTRAINT
- Constraint là các quy tắc được áp đặt cho các cột dữ liệu trên table
- Constraint được sử dụng để giới hạn kiểu dữ liệu nhập vào một bảng. Điều này đảm bảo tính chính xác và tính đáng tin cậy cho dữ liệu trong DB
- Constraint có 2 cấp độ:
    + Column Level: Chỉ được áp dụng cho cột
    + Table Level: áp dụng cho toàn bộ table

- Có thể khai báo constraint trong câu lện CREATE TABLE hoặc ALTER TABLE (sửa đổi bảng)
- Các loại Constraint phổ biến:
    + NOT NULL: Bảo đảm một cột không thể có giá trị NULL
    + DEFAULT: Cung cấp một giá trị mặc định cho cột khi không được xác định
    + UNIQUE: Bảo đảm tất cả các giá trị trong một cột là khác nhau
    + PRIMARY KEY: Xác định giá trị trên tập các cột làm khóa chỉnh phải duy nhất, không được trùng lặp. Việc khai báo ràng buộc khóa chỉnh yêu cầu các cột phải NOT NULL
    + FOREIGN KEY: Dùng để tham chiếu đến bảng khác thông qua giá trị của cột được liên kết. Giá trị của cột được liên kết phải là duy nhất trong bảng kia
    + CHECK: Đảm bảo tất cả các giá trị trong cột thỏa mãn điều kiện nào đó

- Ex1: Thiết lập ràng buộc NOT NULL trên cột CountryName khi tạo table
```
create table country(
    ID int,
    CountryCode char(3),
    CountryName varchar(60) NOT NULL,
    Modify date
);
```

- Ex2: thiết lập ràng buộc NOT NULL trên cột CountryName khi sửa đổi Table
```
alter table Country modify CountryName varchar(60) NOT NULL;
```

- Ex3: thiết lập ràng buộc DEFAULT lấy giá trị mặc định là ngày hiện tại trên cột ModifyDate
```
create table country(
    id int,
    countrycode char(3),
    countryname varchar(60) not null,
    modifydate TimeStamp Default CURRENT_TIMESTAMP
);
```

- Ex4: hiết lập ràng buộc DEFAULT lấy giá trị mặc định là ngày hiện tại trên cột ModifyDate khi sửa đổi table
```
alter table country modify modifydate timestamp default CURRENT_TIMESTAMP;
```

- Ex5: hiết lập ràng buộc PRIMARY KEY cho cột ID (Định nghĩa trực tiếp khi khai báo cột – Constraint mức cột)
```
create table country(
    id int primary key, --chi dung cho column
    countrycode char(3),
    contryname varchar(60) not null,
    modifydate date
);
```

- Ex6: thiết lập ràng buộc PRIMARY KEY cho cột ID (Định nghĩa constraint mức bảng)
```
create table country(
    id int,
    countrycode char(3),
    contryname varchar(60) not null,
    modifydate date,
    CONSTRAINT pk_id primary key (id) --doi voi ca table
);
```

- Ex7: thiết lập ràng buộc PRIMARY KEY cho cột ID (Thiết lập ràng buộc khi sửa đổi table)
```
alter table country add constraint pk_id primary key (id);
``` 

- Ex8: thiết lập ràng buộc FOREIGN KEY cho cột CountryID (Định nghĩa trực tiếp khi khai báo cột)
```
Create TABLE MEDALS (
    Id Int PRIMARY KEY,
    Year Int,
    City Varchar(30),
    Sport Varchar(30),
    Discipline Varchar(30),
    Athlete Varchar(60),
    CountryID Int FOREIGN KEY REFERENCES Country(ID),
    CountryCode Char(3),
    Gender Varchar(5),
    Event Varchar(80),
    Medal Varchar(8)
);
```

- Ex9: thiết lập ràng buộc FOREIGN KEY cho cột CountryID (Định nghĩa constraint)
```
Create TABLE MEDALS (
    Id Int PRIMARY KEY,
    Year Int,
    City Varchar(30),
    Sport Varchar(30),
    Discipline Varchar(30),
    Athlete Varchar(60),
    CountryID Int ,
    CountryCode Char(3),
    Gender Varchar(5),
    Event Varchar(80),
    Medal Varchar(8)
    CONSTRAINT FK_CountryID FOREIGN KEY (CountryID) REFERENCES Country(ID)
);
```

- Ex10: thiết lập ràng buộc FOREIGN KEY cho cột CountryID (Thiết lập ràng buộc khi sửa đổi table)
```
alter table MEDALS Add Constraint FK_CountryID FOREIGN KEY (CountryID) REFERENCES Country(ID);
```

- Ex11: thiết lập ràng buộc CHECK cho các cột của bảng VayNo (Định nghĩa trực tiếp khi khai báo cột)
```
CREATE TABLE Vay (
    MaVay char(10) NOT NULL,
    MaKH char(10),
    MaTaiSan char(10),
    MaNV char(10),
    NgayVay date,
    ThoiHan int,
    LaiSuat float,
    SoTienVay float Check (SoTienVay > 0),
    NgayHetHan date
);
```

- Ex12: thiết lập ràng buộc CHECK cho các cột của bảng VayNo (khi sửa đổi Table):
    + Tạo ràng buộc check trên cột SoTienVay > 0
    ```
    ALTER TABLE VayNo ADD CONSTRAINT check_SoTienVay CHECK (SoTienVay > 0);
    ```
    + Tạo ràng buộc check trên cột NgayHetHan phải lớn hơn NgayVay
    ```
    alter table vayno add constraint check_ngayhethan check(ngayhethan > ngayvay);
    ```
    + Tạo ràng buộc kiểm tra trên cột ThoiHan nằm trong khoảng 1 đến 36 tháng
    ```
    alter able vayno add constraint check_thoihan check(thoihan between 1 and 36);
    ```

### Xóa bỏ Constraint
- Syntax:
```
ALTER TABLE <tên table chứa ràng buộc>
DROP CONSTRAINT <tên ràng buộc muốn xóa>
```

- Example: `alter table vayno drop constraint check_sotienvay;`
- Áp dụng MariaDB 10.x.x và MySQL 8.x.x

- Xóa Primary key:
```
alter table <tên table chứa ràng buộc>
DROP PRIMARY KEY;
```

- Xóa Foreign Key:
```
alter table <tên table chứa ràng buộc>
DROP FOREIGN KEY <tên foreign key>;
```

- Xóa các constraint theo tên:
```
ALTER TABLE <tên table chứa ràng buộc>
DROP <Loại Constraint> <Tên Constraint>;
```

### Kích hoạt/Bỏ kích hoạt constraint
- Bỏ kích hoạt:
```
ALTER TABLE <tên table chứa ràng buộc>
NOCHECK CONSTRAINT <tên ràng buộc muốn bỏ kích hoạt> 
```

- Kích hoạt:
```
ALTER TABLE <tên table chứa ràng buộc>
WITH CHECK CHECK CONSTRAINT <tên ràng buộc muốn kích hoạt>
```

- Bỏ kích hoạt check constraint:
```
ALTER TABLE <tên table chứa ràng buộc>
ALTER CHECK <tên constraint> NOT ENFORCED;
```

- Bỏ kích hoạt các constraint khác:
```
ALTER TABLE <tên table chứa ràng buộc>
ALTER CONSTRAINT<tên constraint> NOT ENFORCED;
```

- Kích hoạt lại check constraint
```
ALTER TABLE <tên table chứa ràng buộc>
ALTER CHECK <tên constraint> ENFORCED;
```

- Kích hoạt lại các constraint khác:
```
ALTER TABLE <tên table chứa ràng buộc>
ALTER CONSTRAINT <tên constraint> ENFORCED;
```

# WHERE AND/OR
- Dùng để giới hạn số lượng mẩu tin (dòng dữ liệu) trả về trong câu truy vấn
    + `AND`: phối hợp hai biểu thức so sánh, kết quả trả về TRUE khi cả hai biểu thức so sánh đều trả về TRUE
    + `OR`: : phối hợp hai biểu thức so sánh, kết quả trả về FALSE khi cả hai biểu thức so sánh đều trả về FALSE

- Ex1: cho biết danh sách các vận động viên đoạt huy chương vàng năm 2012
```
select Athlete
from medals
where medal = 'GOLD' and Year = '2012';
```

- Ex2: cho biết danh sách các vận động viên đoạt huy chương bạc năm 2012 và 2016
```
select DISTINCT Athlete
from medals
where medal = 'silver' and (year = 2012 or year = 2016)
```

# String Patterns, Ranges
### String Patterns
- Là một chuỗi các ký tự đại diện dùng tìm kiếm trong cột hoặc biểu thức:
    + `%`: đại diện cho không có ký tự hoặc nhiều ký tự
    + `_`: đại diện cho 1 ký tự
- Lưu ý: khi sử dụng ký tự đại diện (pattern) trong điều kiện so sánh phải sử dụng toán tử LIKE hoặc NOT LIKE
- Ex1:Liệt kê danh sách các vận động viên đạt huy chương vàng có tên bắt đầu là chữ H:
```
Select *
From MEDALS
Where Athlete like 'H%' and Medal = 'Gold'
```

- Ex2: Liệt kê danh sách các vận động viên đạt huy chương vàng có tên bắt đầu là chữ H và chữ kế cuối là A (ví dụ: ‘HAINLE, Max’ )
```
select *
from medals
where athlete like 'H%A_' and medal = 'Gold';
```

### Ranges
- Là dãy các giá trị dùng tìm kiếm trong cột hoặc biểu thức. Các giá trị trong range có thể là:
    + Kiểu số
    + Kiểu chuỗi
    + Kiểu ngày giờ

- Các phép toán so sánh khi sử dụng range:
    + `BETWEEN Min AND Max`: Giá trị nằm trong khoảng từ Min đến Max
    + `IN`: Giá trị nằm trong danh sách được chọn
    + `NOT IN`: Giá trị không nằm trong danh sách được chọn

- Ex1: Liệt kê danh sách các quốc gia có vận động viên đạt huy chương vàng từ năm 1990 đến 2012
```
select distinct countrycode
from medals
where medal = 'gold' and year >= 1990 and year <= 2012;
```

- Ex1.1: Liệt kê danh sách các quốc gia có vận động viên đạt huy chương vàng từ năm 1990 đến 2012 (Sử dụng between)
```
select distinct countrycode
from medals
where medal='gold' and year between 1990 and 2012;
```

- Ex2: Liệt kê danh sách các vận động viên đạt huy chương vàng có tên bắt đầu từ chữ A đến chữ D
```
select distinct athlete
from medals
where medal='Gold' and athlete between 'A%' and 'D%';
```

- Ex3: Liệt kê danh sách các vận động viên đạt huy chương vàng vào các năm 2000, 2008 và 2012
```
select distinct athlete
from medals
where medal='Gold' and year in (2000,2008,2012);
```

- Ex4: Liệt kê danh sách các vận động viên đạt huy chương vàng nhưng không đạt huy chương vàng vào các năm 2000, 2008 và 2012
```
select distinct athlete
from medals
where medal='Gold' and year not in (2000,2008,2012);
```

# ORDER BY
- Sắp xếp dữ liệu sau khi thực hiện truy vấn
- Cú pháp chung:
```
select COLUMN1, COLUMN2, ...
from TABLENAME
where CONDITION
order by COLUMN1 [Asc|Desc], COLUMN2,… ;
ORDER BY
```

- Lưu ý:
    + Có thể sắp xếp theo tên cột hoặc theo số thứ tự của cột trong câu lệnh truy vấn
    + Có thể sắp xếp tăng dần (Asc – mặc định) hoặc giảm dần (Desc)
    + Nếu sắp xếp theo nhiều cột thì thứ tự ưu tiên từ trái sang phải

- Ex1.1: Liệt kê danh sách các vận động viên đạt huy chương năm 2012, dữ liệu sắp xếp tăng dần theo môn thi đấu và tên vận động viên
```
Select Discipline, Athlete, Medal
From MEDALS
Where Year = 2012
Order By Discipline, Athlete
ORDER BY
```

- Ex1.2: Liệt kê danh sách các vận động viên đạt huy chương năm 2012, dữ liệu sắp xếp tăng dần theo môn thi đấu và giảm dần theo tên vận động viên
```
Select Discipline, Athlete, Medal
From MEDALS
Where Year = 2012
Order By Discipline, Athlete Desc
ORDER BY
```


- Ex2: sắp xếp theo thứ tự cột
```
Select Discipline, Athlete, Medal
From MEDALS
Where Year = 2012
Order By Discipline, 2 Desc
```

# GROUP BY, HAVING
### Group By:
- Dùng để gom nhóm dữ liệu sau khi thực hiện tính toán trong mệnh đề Select
- Cú pháp chung:
```
select COLUMN1, COLUMN2, <Expression>,...
from TABLENAME
where CONDITION
Group by COLUMN1, COLUMN2,…
Order by COLUMN1 [Asc|Desc], COLUMN2,… ;
```

- Lưu ý:
    + Mệnh đề Group By phải nằm sau mệnh đề Where và trước Order By
    + Các cột không được tính toán thống kê trong mệnh đề Select phải được Group By

- Ex1: Liệt kê danh sách và tổng số lượng huy chương mỗ quốc gia đạt được trong năm 2012
```
Select CountryCode, Count(Medal)
From MEDALS
Where Year = 2012
Group By CountryCode
```

- Ex2: Liệt kê danh sách và tổng số lượng huy chương theo từng loại của mỗi quốc gia đạt được trong năm 2012
```
Select CountryCode, Medal, Count(Medal)
From MEDALS
Where Year = 2012
Group By CountryCode, Medal
```
### Having:
- Dùng để lọc dữ liệu của nhóm
- Cú pháp chung:
```
select COLUMN1, COLUMN2, <Expression>,...
from TABLENAME
where CONDITION
Group by COLUMN1, COLUMN2,…
Having CONDITION
Order by COLUMN1 [Asc|Desc], COLUMN2,… ;
```

- Lưu ý: Mệnh đề Having phải nằm sau mệnh đề Group By
và trước Order By
- Ex1: Liệt kê danh sách các quốc gia đạt được nhiều hơn 100 huy chương trong năm 2012
```
Select CountryCode, Count(Medal)
From MEDALS
Where Year = 2012
Group By CountryCode
Having Count(Medal) > 100
```

- Ex2: Liệt kê danh sách và tổng số lượng huy chương theo từng loại của mỗi quốc gia đạt được trong năm 2012. Chỉ liệt kê các quốc gia có tổng số huy chương theo từng loại > 100
```
Select CountryCode, Medal, Count(Medal)
From MEDALS
Where Year = 2012
Group By CountryCode, Medal
Having Count(Medal) > 100
```

# Built-in Function, Date, Timestamps

### Built-in Function: 
- Các hàm được định nghĩa sẵn trong SQL, bao gồm:
    + Các hàm tính toán tổng hợp
    + Các hàm xử lý trên chuỗi
    + Các hàm xử lý thời gian

### Các hàm tính toán tổng hợp:
- COUNT: Đếm tổng số lượng các dòng (mẩu tin)
- SUM: Tính tổng các giá trị
- MIN: Tìm giá trị nhỏ nhất
- MAX: Tìm giá trị lớn nhất
- AVG: Tìm giá trị trung bình
- STDDEV: Tính standard deviation của biểu thức

- Xem xét bảng PETSALE có cấu trúc và dữ liệu
như sau:

- Ex1:
    +  Tính tổng số tiền đã bán thú nuôi
    +  Tính tổng số tiền đã bán thú nuôi, kết quả hiển thị cột tổng tiền là SUM_OF_SALEPRICE
```
select SUM(SALEPRICE)
from PETSALE
```

```
select SUM(SALEPRICE) as SUM_OF_SALEPRICE
from PETSALE
```

- Ex2:
    +  Tìm số lượng bán nhỏ nhất và lớn nhất
    +  Tính Số tiền trung bình và Đơn giá trung bình đã bán thú nuôi là 'Dog'
```
select AVG(SALEPRICE), AVG(SALEPRICE / QUANTITY)
from PETSALE
Where Animal = 'Dog'
```

```
select MIN(QUANTITY), MAX(QUANTITY)
from PETSALE
```

### Các hàm xử lý chuỗi và làm tròn số:
- ROUND: Làm tròn số đến vị trí được chỉ định, mặc định làm tròn đến dấu chấm thập phân
- LENGTH: Số ký tự có trong chuỗi
- UCASE: Đổi thành chuỗi chữ hoa
- LCASE: Đổi thành chuỗi chữ thường
- SUBSTR: Trả về chuỗi con có trong chuỗi ban đầu

- Ex1:
    +  ROUND(<chuỗi>, <vị trí làm tròn>)
    +  Tính tổng tiền đã bán thú nuôi là 'Dog‘, làm tròn số đến phần nguyên (không lấy số lẻ)
```
select ROUND(SUM(SALEPRICE)) as SUM_OF_SALEPRICE
from PETSALE
Where Animal = 'Dog'
```

- Ex2:
    +  ROUND(<chuỗi>, <vị trí làm tròn>)
    +  Tính tổng tiền đã bán thú nuôi là 'Dog‘, làm tròn 2 số lẻ
```
select ROUND(SUM(SALEPRICE), 2) as SUM_OF_SALEPRICE
from PETSALE
Where Animal = 'Dog'
```

- Ex3:
    +  ROUND(<chuỗi>, <vị trí làm tròn>)
    +  Tính tổng tiền đã bán thú nuôi là 'Dog‘, làm tròn đến hàng chục
```
select ROUND(SUM(SALEPRICE), -1) as SUM_OF_SALEPRICE
from PETSALE
Where Animal = 'Dog'
```

- Ex4: Tính số ký tự có trong tên thú nuôi
```
select Animal, LENGTH(Animal) as LENGTH_OF_ANIMAL
from PETSALE
```

- Ex5:
```
select Animal, UCASE(Animal) as UCASE_OF_ANIMAL,LCASE(Animal) as LCASE_OF_ANIMAL
from PETSALE;
```

- Ex6:
    + SUBSTR(<chuỗi>, <vị trí bắt đầu>, <Số lượng ký tự>)

```
select Animal, SUBSTR(Animal, 2) as SUBSTR_2, SUBSTR(Animal, 2, 2) as SUBSTR_2_2
from PETSALE
```

### Các hàm xử lý thời gian:
-  Các hàm xử lý ngày: DAY, MONTH, YEAR, DAYOFMONTH, DAYOFWEEK, DAYOFYEAR, WEEK
-  Các hàm xử lý giờ: HOUR, MINUTE, SECOND,
-  Ngày giờ hiện tại: CURRENT_DATE, CURRENT_TIME, CURRENT_TIMESTAMP
-  Ngày giờ hiện tại (DB2): CURRENT DATE, CURRENTTIME, CURRENT TIMESTAMP

- Ex:
```
select Saledate, Dayofmonth(saledate) As Dayofmonth, Dayofweek(saledate) As Dayofweek, Dayofyear(saledate) As Dayofyear, Week(saledate) As Week
from PETSALE;
```

# Sub-Query, Nested-Select

### Đặt vấn đề
- Liệt kê danh sách các thú nuôi có tổng tiền bán lớn hơn giá trị trung bình của tổng tiền bán
```
select * from PETSALE
where SALEPRICE > AVG(SALEPRICE);
```

=> `Invalid use of an aggregate function or OLAP function.. SQLCODE=-120, SQLSTATE=42903, DRIVER=4.24.92`

- MySQL said:
```
#1111 - Invalid use of group function
Sub-Query, Nested-Select
```

-  Liệt kê danh sách các thú nuôi được bán kèm theo tiền bán và giá trị trung bình của tổng tiền bán
```
select Animal, SalePrice, AVG(SalePrice)
from PETSALE
Group By Animal, SalePrice;
```

- Sub-Query (Truy vấn con), Nested-Select (Truy vấn Select lồng nhau):
    +  Là truy vấn Select được sử dụng lồng vào nhau để làm điều kiện so sánh trong mệnh đề WHERE, HAVING hoặc làm nguồn dữ liệu cho mệnh đề Select.
    +  Nếu làm điều kiện so sánh trong mệnh đề WHERE hoặc HAVING thì chỉ được trả về một giá trị hoặc một cột giá trị
    + Sử dụng phép toán so sánh: =, >, >=, <, <=, != khi truy vấn con trả về một giá trị
    + Sử dụng phép toán so sánh: IN, NOT IN, >= ALL, và <= ANY khi truy vấn con trả về một cột giá trị

- Ex1: Liệt kê danh sách các thú nuôi có tổng tiền bán lớn hơn giá trị trung bình của tổng tiền bán
```
select *
from PETSALE
where SALEPRICE > (Select AVG(SALEPRICE)
from PETSALE);
```

- Ex2: Liệt kê danh sách các thú nuôi được bán kèm theo tiền bán và giá trị trung bình của tổng tiền bán
```
select Animal, SalePrice, (Select AVG(SalePrice) from PETSALE) as AVG_SalePrice
from PETSALE;
```

- Ex3: Liệt thông tin các quốc gia đạt huy chương vàng năm 2012
```
select *
from COUNTRY
where CountryCode IN (Select CountryCode From MEDALS Where Medal = 'Gold' and Year = 2012);
```

- Ex4: Sử dụng làm nguồn cho mệnh đề Select
```
Select * From (Select Animal, Quantity, SalePrice from PETSALE) as Tbl;
```

# Query in Multiple Table
- Sử dụng Sub-Query
    + Sử dụng truy vấn con (truy vấn select lồng nhau) để truy xuất dữ liệu trên nhiều bảng khác nhau
    + Ví dụ: Cho bảng EMPLOYEES và DEPARTMENTS như sau:
- Bảng DEPARTMENTS :
`A table...`

Bảng EMPLOYEES:
`A table...`

- Ex1:
    +  Liệt kê danh sách các nhân viên với tên phòng ban
    +  HD: sử dụng 2 bảng: EMPLOYEES và DEPARTMENTS

- Sử dụng điều kiện liên kết dữ liệu trong mệnh đề WHERE
    +  Liệt kê danh sách nhân viên của từng phòng ban, thông tin bao gồm: EMP_ID, F_NAME, L_NAME, DEP_NAME
```
select EMP_ID, F_NAME, L_NAME, DEP_NAME
from employees, departments
where employees.DEP_ID = departments.DEPT_ID_DEP;
```

- Sử dụng điều kiện liên kết dữ liệu trong mệnh đề WHERE
    +  Có thể đặt bí danh cho các bảng dữ liệu
```
select EMP_ID, F_NAME, L_NAME, DEP_NAME
from employees e, departments d
where e.DEP_ID = d.DEPT_ID_DEP;

select e.EMP_ID, e.F_NAME, e.L_NAME, d.DEP_NAME
from employees e, departments d
where e.DEP_ID = d.DEPT_ID_DEP;
```

- Sử dụng phép toán kết - JOIN
    + Dùng để liên kết dữ liệu giữa các bảng trong mệnh đề FROM
    + Bao gồm INNER JOIN và OUTER JOIN
        + (INNER) JOIN: Chọn các dòng dữ liệu khớp trong cả 2 bảng
        + LEFT (OUTER) JOIN: Chọn các dòng dữ liệu từ bảng đầu tiên (ngoài cùng bên trái) với các dữ liệu phù hợp của bảng bên phải

- Sử dụng phép toán kết - JOIN
    +  Dùng để liên kết dữ liệu giữa các bảng trong mệnh đề FROM
    + Bao gồm INNER JOIN và OUTER JOIN
        + RIGHT (OUTER) JOIN: Chọn các dòng dữ liệu từ bảng thứ hai (ngoài cùng bên phải) với các dữ liệu phù hợp của bảng bên trái.
        + FULL (OUTER) JOIN: Chọn tất cả các dòng dữ liệu khớp với các dòng của bảng bên phải hoặc bảng bên trái.

- Sử dụng phép toán kết - JOIN
    +  Cú pháp INNER JOIN:
    ```
    SELECT column-names
    FROM table-name1 [INNER] JOIN table-name2
    ON column-name1 = column-name2
    WHERE condition
    ```

    +  Cú pháp OUTER JOIN:
    ```
    SELECT column-names
    FROM table1 {LEFT | RIGHT | FULL} JOIN table2
    ON column-name1 = column-name2
    WHERE condition
    ```

- Ex1: Liệt kê danh sách thông tin đặt hàng gồm: OrderNumber,TotalAmount, FirstName, LastName, City, Country
```
SELECT OrderNumber, TotalAmount, FirstName, LastName, City, Country
FROM Orders JOIN Customers ON Orders.CustomerId = Customers.Id
```

- Ex2: Liệt kê danh sách thông tin đặt hàng gồm: OrderNumber, OrderDate, ProductName, Quantity, UnitPrice
```
SELECT OrderNumber, OrderDate, ProductName, Quantity, UnitPrice
FROM Orders O JOIN OrderItems I ON O.Id = I.OrderId
JOIN Products P ON P.Id = I.ProductId
ORDER BY O.OrderNumber
```

- Ex3: Liệt kê danh sách thông tin đặt hàng kể cả các khách hàng chưa có đặt hàng, bao gồm: OrderNumber, TotalAmount, FirstName, LastName, City, Country
```
SELECT OrderNumber, TotalAmount, FirstName, LastName, City, Country
FROM Customers LEFT JOIN Orders
ON Orders.CustomerId = Customers.Id
ORDER BY TotalAmount
```

- Ex4: Liệt kê danh sách thông tin đặt hàng kể cả các khách hàng chưa có đặt hàng, bao gồm: OrderNumber, TotalAmount, FirstName, LastName, City, Country
```
SELECT OrderNumber, TotalAmount, FirstName, LastName, City, Country
FROM Orders RIGHT JOIN Customers
ON Orders.CustomerId = Customers.Id
ORDER BY TotalAmount
```

- Ex5: Liệt kê danh sách tất cả khách hàng và nhà cung cấp, thông tin gồm: FirstName, LastName, CustomerCountry, SupplierCountry và CompanyName
```
SELECT C.FirstName, C.LastName, C.Country AS CustomerCountry, S.Country AS SupplierCountry, S.CompanyName
FROM Customer C FULL JOIN Supplier S ON C.Country = S.Country
ORDER BY C.Country, S.Country
```

# UNION
- Dùng để kết hợp các bộ kết quả của hai truy vấn Select với nhau.
- Các kiểu dữ liệu của các cột kết quả trong hai truy vấn phải khớp với nhau
- UNION kết hợp theo vị trí cột thay vì tên cột

- Cú pháp chung:
SELECT column-names FROM table-name
UNION
SELECT column-names FROM table-name

- Ex: liệt kê danh sách tất cả nhà cung cấp và khách hàng

```
SELECT 'Customer' As Type, Concat(Concat(FirstName, ' '), LastName) AS ContactName, City, Country, Phone
FROM Customer
UNION
SELECT 'Supplier', ContactName, City, Country, Phone
FROM Supplier
```