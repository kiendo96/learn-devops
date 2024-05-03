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