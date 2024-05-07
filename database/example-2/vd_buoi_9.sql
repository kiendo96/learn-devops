- tao db dvdrental
- chon db dvdrental, phai chuot, chon restore

departments (parent): department_id, department_name, ...
employees (child): employee_id, first_name, ..., department_id

departments.department_id --> primary key
employees.department_id --> foreign key

create table pets(id int, name varchar(30) not null);
insert into pets values(1,'cat'); -- ok
insert into pets values(2,null); -- error
insert into pets(id) values(2); -- ok

create table pets(id int, name varchar(30) not null) engine=innodb;

create table pets
(id int, name varchar(30) not null, age int default 1)
engine=innodb;
insert into pets(id, name) values(1,'cat');

-- muc cot
create table pets
(id int primary key, 
 name varchar(30) not null, 
 age int default 1)
engine=innodb;
insert into pets values(1,'cat',2);
insert into pets values(1,'lion',2);

-- muc bang
create table pets
(id int, 
 name varchar(30) not null, 
 age int default 1,
 primary key(id)
)
engine=innodb;

-- tao bang dat_hang gom id, ngaydat, ngaygiaodukien
-- id kieu int, primary key
-- ngaydat kieu date, not null, default la ngay hien tai
-- ngaygiaodukien kieu date, not null, >= ngaydat (CHECK)
create table dat_hang
(
    id int primary key,
    ngaydat date not null default(CURRENT_DATE),
    ngaygiaodukien date not null,
    CONSTRAINT ck_dh_ngaygiaodukien CHECK(ngaygiaodukien>=ngaydat)
);

insert into dat_hang(id,ngaygiaodukien) values(1,'2021-06-20');
insert into dat_hang(id,ngaygiaodukien) values(2,'2021-06-18');

create table dat_hang
(
    id int primary key,
    ngaydat date not null default(CURRENT_DATE),
    ngaygiaodukien date not null
);
alter table dat_hang
add CONSTRAINT ck_dh_ngaygiaodukien CHECK(ngaygiaodukien>=ngaydat);

create table khach_hang
(
  id int primary key,
    tenkh varchar(50)
) engine=innodb;    

create table dat_hang
(
    id int primary key,
    ngaydat date not null default(CURRENT_DATE),
    idkh int
) engine=innodb;

alter table dat_hang
add constraint fk_dh_idkh
FOREIGN key(idkh) REFERENCES khach_hang(id);

insert into khach_hang values(1,'An Tu');
insert into khach_hang values(2,'Tuan Kiet');
insert into dat_hang(id, idkh) values(1,1);
insert into dat_hang(id, idkh) values(2,3);

