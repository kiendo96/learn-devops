CREATE TABLE Employees
(
  empid           INT          NOT NULL,
  lastname        VARCHAR(20) NOT NULL,
  firstname       VARCHAR(10) NOT NULL,
  title           VARCHAR(30) NOT NULL,
  titleofcourtesy VARCHAR(25) NOT NULL,
  birthdate       DATETIME     NOT NULL,
  hiredate        DATETIME     NOT NULL,
  address         VARCHAR(60) NOT NULL,
  city            VARCHAR(15) NOT NULL,
  region          VARCHAR(15) NULL,
  postalcode      VARCHAR(10) NULL,
  country         VARCHAR(15) NOT NULL,
  phone           VARCHAR(24) NOT NULL,
  mgrid           INT          NULL,
  CONSTRAINT PK_Employees PRIMARY KEY(empid)
);
CREATE TABLE Suppliers
(
  supplierid   INT          NOT NULL,
  companyname  VARCHAR(40) NOT NULL,
  contactname  VARCHAR(30) NOT NULL,
  contacttitle VARCHAR(30) NOT NULL,
  address      VARCHAR(60) NOT NULL,
  city         VARCHAR(15) NOT NULL,
  region       VARCHAR(15) NULL,
  postalcode   VARCHAR(10) NULL,
  country      VARCHAR(15) NOT NULL,
  phone        VARCHAR(24) NOT NULL,
  fax          VARCHAR(24) NULL,
  CONSTRAINT PK_Suppliers PRIMARY KEY(supplierid)
);
CREATE TABLE Categories
(
  categoryid   INT           NOT NULL,
  categoryname VARCHAR(15)  NOT NULL,
  description  VARCHAR(200) NOT NULL,
  CONSTRAINT PK_Categories PRIMARY KEY(categoryid)
);
CREATE TABLE Products
(
  productid    INT          NOT NULL,
  productname  VARCHAR(40) NOT NULL,
  supplierid   INT          NOT NULL,
  categoryid   INT          NOT NULL,
  unitprice    DECIMAL(13,2)        NOT NULL,
  discontinued BIT          NOT NULL,
  CONSTRAINT PK_Products PRIMARY KEY(productid)
);
CREATE TABLE Customers
(
  custid       INT          NOT NULL,
  companyname  VARCHAR(40) NOT NULL,
  contactname  VARCHAR(30) NOT NULL,
  contacttitle VARCHAR(30) NOT NULL,
  address      VARCHAR(60) NOT NULL,
  city         VARCHAR(15) NOT NULL,
  region       VARCHAR(15) NULL,
  postalcode   VARCHAR(10) NULL,
  country      VARCHAR(15) NOT NULL,
  phone        VARCHAR(24) NOT NULL,
  fax          VARCHAR(24) NULL,
  CONSTRAINT PK_Customers PRIMARY KEY(custid)
);
CREATE TABLE Shippers
(
  shipperid   INT          NOT NULL,
  companyname VARCHAR(40) NOT NULL,
  phone       VARCHAR(24) NOT NULL,
  CONSTRAINT PK_Shippers PRIMARY KEY(shipperid)
);
CREATE TABLE Orders
(
  orderid        INT          NOT NULL,
  custid         INT          NULL,
  empid          INT          NOT NULL,
  orderdate      DATETIME     NOT NULL,
  requireddate   DATETIME     NOT NULL,
  shippeddate    DATETIME     NULL,
  shipperid      INT          NOT NULL,
  freight        DECIMAL(13,2)        NOT NULL,
  shipname       VARCHAR(40) NOT NULL,
  shipaddress    VARCHAR(60) NOT NULL,
  shipcity       VARCHAR(15) NOT NULL,
  shipregion     VARCHAR(15) NULL,
  shippostalcode VARCHAR(10) NULL,
  shipcountry    VARCHAR(15) NOT NULL,
  CONSTRAINT PK_Orders PRIMARY KEY(orderid)
);
CREATE TABLE OrderDetails
(
  orderid   INT           NOT NULL,
  productid INT           NOT NULL,
  unitprice DECIMAL(13,2)         NOT NULL,
  qty       SMALLINT      NOT NULL,
  discount  DECIMAL(4, 3) NOT NULL,
  CONSTRAINT PK_OrderDetails PRIMARY KEY(orderid, productid)
);