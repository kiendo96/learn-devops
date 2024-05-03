# 4 nhóm lệnh chính
- SQL(Structured Query Language) : `select`, `count/distinct(loại bỏ trùng lặp)/limit`
- DML(Data Manipulation Language): `insert`, `update`, `delete` thay đổi về mặt dữ liệu
- DDL(Data Definition Language): `create/drop table`
- DCL(Data Control Language)

# Create/Drop Table

>create table tablename(
    column1 datatype,
    column2 datatype,
    column3 datatype,
    ....
);

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
