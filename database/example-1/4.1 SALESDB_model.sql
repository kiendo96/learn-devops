create table Customers (
   Id                   int not null,
   FirstName            varchar(40)         not null,
   LastName             varchar(40)         not null,
   City                 varchar(40)         null,
   Country              varchar(40)         null,
   Phone                varchar(20)         null,
   constraint PK_CUSTOMERS primary key (Id)
);
create table Orders (
   Id                   int,
   OrderDate            datetime not null,
   OrderNumber          varchar(10)         null,
   CustomerId           int                  not null,
   TotalAmount          decimal(12,2)        null,
   constraint PK_ORDERS primary key (Id)
);
create table OrderItems (
   Id                   int,
   OrderId              int not null,
   ProductId            int not null,
   UnitPrice            decimal(12,2) not null,
   Quantity             int not null,
   constraint PK_ORDERITEMS primary key (Id)
);
create table Products (
   Id                   int,
   ProductName          varchar(50)         not null,
   SupplierId           int                  not null,
   UnitPrice            decimal(12,2)        null,
   Package              varchar(30)         null,
   IsDiscontinued       bit                  not null,
   constraint PK_PRODUCTS primary key (Id)
);
create table Suppliers (
   Id                   int AUTO_INCREMENT,
   CompanyName          varchar(40)         not null,
   ContactName          varchar(50)         null,
   ContactTitle         varchar(40)         null,
   City                 varchar(40)         null,
   Country              varchar(40)         null,
   Phone                varchar(30)         null,
   Fax                  varchar(30)         null,
   constraint PK_SUPPLIERS primary key (Id)
);