-- cho biet cac vdv dat huy chuong vang trong tvh 2012
SELECT *
FROM medals
WHERE Year=2012 AND Medal='Gold';

-- cho biet cac vdv dat huy chuong vang trong tvh 2012
SELECT *
FROM medals
WHERE Year=2012 AND Medal='Gold'
ORDER BY Sport, Athlete;

-- cho biet cac nhan vien cua phong 80 va phong 90, sap tang theo ma phong
SELECT *
FROM employees
WHERE DEPARTMENT_ID=80 OR DEPARTMENT_ID=90
ORDER BY DEPARTMENT_ID;

-- cho biet cac nhan vien cua phong 80 va phong 90, sap tang theo ma phong
SELECT *
FROM employees
WHERE DEPARTMENT_ID IN (80,90)
ORDER BY DEPARTMENT_ID;

-- dinh dang du lieu hien thi
-- gop firstname va lastname
-- dinh dang hiredate: dd/mm/yyyy
-- dinh dang salary: $23,456.00
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS name, 
	DATE_FORMAT(HIRE_DATE, '%d/%m/%Y') AS hiredate, CONCAT('$',FORMAT(SALARY,2)) AS sal
FROM employees
ORDER BY SALARY DESC;

-- dinh dang du lieu hien thi
-- gop firstname va lastname
-- dinh dang hiredate: dd/mm/yyyy
-- dinh dang salary: $23,456.00
SELECT EMPLOYEE_ID, CONCAT(FIRST_NAME, ' ', LAST_NAME) AS name, 
	DATE_FORMAT(HIRE_DATE, '%d/%m/%Y') AS hiredate, CONCAT('$',FORMAT(SALARY,2)) AS sal,
    SALARY+500 AS bonus
FROM employees
ORDER BY SALARY DESC;

-- tinh toan du lieu ...
SELECT COUNT(*), SUM(SALARY), MIN(SALARY), MAX(SALARY), AVG(SALARY)
FROM employees;

SELECT COUNT(*), SUM(SALARY), MIN(SALARY), MAX(SALARY), AVG(SALARY), STDDEV(SALARY)
FROM employees
WHERE DEPARTMENT_ID=50;

-- tinh toan du lieu ...
SELECT COUNT(*), SUM(SALARY), MIN(SALARY), MAX(SALARY), AVG(SALARY), STDDEV(SALARY)
FROM employees
WHERE DEPARTMENT_ID=50;

-- tong hop du lieu va tinh toan (group)
-- cho biet moi phong va co tong luong la bao nhieu?
SELECT DEPARTMENT_ID, SUM(SALARY) AS sum_sal
FROM employees
GROUP BY DEPARTMENT_ID
ORDER BY sum_sal DESC;

-- cho phong nao co tong luong lon nhat
SELECT DEPARTMENT_ID, SUM(SALARY) AS sum_sal
FROM employees
GROUP BY DEPARTMENT_ID
ORDER BY sum_sal DESC
LIMIT 1;

-- tong hop du lieu va tinh toan (group)
SELECT DEPARTMENT_ID, SUM(SALARY) AS sum_sal, AVG(SALARY) AS avg_sal, COUNT(*) AS count_emp
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

SELECT DEPARTMENT_ID, SUM(SALARY) AS sum_sal, AVG(SALARY) AS avg_sal, COUNT(*) AS count_emp
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>=20
ORDER BY DEPARTMENT_ID;

SELECT * FROM `country` WHERE `CountryCode`='VIE';
SELECT * FROM country WHERE CountryCode LIKE 'VI%'

-- cho biet cac nhan vien co luong tu 5000 den 7000
SELECT * 
FROM employees
WHERE SALARY>=5000 AND SALARY<=7000;

SELECT * 
FROM employees
WHERE SALARY BETWEEN 5000 AND 7000;

-- cho biet cac don dat hang cua thang 8 nam 2012
SELECT *
FROM orders
WHERE MONTH(OrderDate)=8 AND YEAR(OrderDate)=2012
ORDER BY OrderDate DESC;

SELECT *
FROM orders
WHERE OrderDate BETWEEN '2012-08-01' AND '2012-08-31'
ORDER BY OrderDate DESC;

SELECT *
FROM orders
WHERE OrderDate BETWEEN '2012-08-01 00:00:00' AND '2012-08-31 23:59:59'
ORDER BY OrderDate DESC;

SELECT COUNT(*), COUNT(DEPARTMENT_ID), COUNT(COMMISSION_PCT)
FROM employees;

SELECT `empid` AS `Ma nhan vien`, CONCAT(`firstname`, ' ', `lastname`) AS `Ho va ten`, 
	`title` `Chuc danh`, DATE_FORMAT(`hiredate`, '%d/%m/%Y') AS `Ngay vao lam`
FROM employees;

-- liet ke cac nhan vien co ngay vao lam la thu bay
SELECT `empid` AS `Ma nhan vien`, CONCAT(`firstname`, ' ', `lastname`) AS `Ho va ten`, 
	`title` `Chuc danh`, DATE_FORMAT(`hiredate`, '%d/%m/%Y') AS `Ngay vao lam`
FROM employees
WHERE DAYOFWEEK(hiredate)=7;

SELECT
  products.productid,
  LPAD(products.productid, 10, '0') AS New_ID
FROM products

-- tim cac nhan vien co last_name bat dau la chu K
SELECT * FROM employees WHERE LAST_NAME LIKE 'K%';

SELECT * FROM employees WHERE LAST_NAME LIKE 'K_n%';

(SELECT * FROM employees ORDER BY SALARY LIMIT 1)
UNION 
(SELECT * FROM employees ORDER BY SALARY DESC LIMIT 1)

SELECT CountryCode, COUNT(*) AS so_hcv
FROM medals
WHERE Year=2012 AND CountryCode!='' -- khac empty
GROUP BY CountryCode;

SELECT CountryCode, COUNT(*) AS so_hcv
FROM medals
WHERE Year=2012 AND CountryCode!='' -- khac empty
GROUP BY CountryCode
ORDER BY so_hcv DESC
LIMIT 10;

-- trong tvh 2012, thong ke theo cac gender, dem so hcv
SELECT Gender, Medal, COUNT(Medal) as count_medal 
FROM `medals` 
WHERE Year = 2012
GROUP By Gender, Medal;

