-- thu tu: vang, bac, dong
SELECT CountryCode, Medal, COUNT(*)
FROM medals
WHERE year=2012 AND CountryCode!=''
GROUP BY CountryCode, Medal
ORDER BY CountryCode, 
	CASE
    	WHEN Medal='Gold' THEN 1
        WHEN Medal='Silver' THEN 2
        ELSE 3
    END;

-- thong ke tong luong, tong so nhan vien theo 3 nhom luong
-- nhom 1: luong <=5000 --> luong thap
-- nhom 2: luong >5000 va <10000 --> luong vua
-- nhom 3: luong >10000 --> luong cao
-- HD: su dung bieu thuc dieu kien CASE + group by
SELECT 
	CASE
		WHEN SALARY <= 5000 THEN 'Thap'
		WHEN SALARY < 10000 THEN 'Vua'
		ELSE 'Cao'
	END AS salary_group,
	SUM(SALARY) AS TOTAL_SALARY,
	COUNT(EMPLOYEE_ID) AS NUMBER_EMPLOYEE
from employees
group by salary_group;

-- thong ke cac quoc gia dat bao nhieu huy chuong vang cua the van hoi 2012
-- ma quoc gia, dem so hcv
-- HD: group by, count
-- loc cac vdv cua tvh 2012
SELECT CountryCode, COUNT(*) AS so_hcv
FROM medals
WHERE Year=2012 AND Medal='Gold' AND CountryCode!=''
GROUP BY CountryCode
ORDER BY so_hcv DESC;

SELECT CountryCode, COUNT(*) AS so_hcv
FROM medals
WHERE Year=2012 AND Medal='Gold' AND CountryCode!=''
GROUP BY CountryCode 
HAVING so_hcv>=30 -- COUNT(*)>=30
ORDER BY so_hcv DESC;

SELECT *
FROM
(
SELECT CountryCode, COUNT(*) AS so_hcv
FROM medals
WHERE Year=2012 AND Medal='Gold' AND CountryCode!=''
GROUP BY CountryCode 
) q
WHERE so_hcv>=30
ORDER BY so_hcv DESC;

-- dem last_name cua cac nhan vien
-- last_name, so nhan vien
SELECT LAST_NAME, COUNT(*) AS count_emp
FROM employees
GROUP BY LAST_NAME
HAVING count_emp>1;

SELECT *
FROM employees
WHERE LAST_NAME IN
(
SELECT LAST_NAME
FROM employees
GROUP BY LAST_NAME
HAVING COUNT(*)>1)
ORDER BY LAST_NAME;

SELECT STDDEV(SALARY)
FROM employees; -- 3891.267781
-- thu tinh toan do lech chuan cua luong
-- can bac 2 cua: tong cac binh phuong: xi-x_ va chia cho N
SELECT 
	SQRT(SUM((SALARY-(SELECT AVG(SALARY) FROM employees))*(SALARY-(SELECT AVG(SALARY) FROM employees)))/
    (SELECT COUNT(*) FROM employees))
FROM employees

-- sub query tra ve 1: cho biet cac nhan vien co luong > luong cua nhan vien 105
SELECT SALARY FROM employees WHERE EMPLOYEE_ID=105;

SELECT *
FROM employees
WHERE SALARY > (SELECT SALARY FROM employees WHERE EMPLOYEE_ID=105);

-- sub query tra ve n: cho biet cac nhan vien co luong > luong cua nhan vien co last_name King
SELECT SALARY FROM employees WHERE LAST_NAME='King';

SELECT *
FROM employees
WHERE SALARY > ANY(SELECT SALARY FROM employees WHERE LAST_NAME='King'); -- ALL/ANY

-- cho biet cac nhan vien lam nhan vien quan ly
SELECT * FROM employees
WHERE EMPLOYEE_ID IN (SELECT DISTINCT MANAGER_ID FROM employees WHERE MANAGER_ID IS NOT NULL);

-- cho biet cac phong chua co nhan vien
SELECT * FROM departments
WHERE DEPARTMENT_ID NOT IN
(
SELECT DISTINCT`DEPARTMENT_ID`
FROM employees
WHERE `DEPARTMENT_ID` is not null
);

-- cho biet cac nhan vien co luong lon nhat
-- cho biet cac nhan vien cua phong 50 co luong lon nhat
SELECT * FROM employees
WHERE SALARY = (SELECT MAX(SALARY) FROM employees);

SELECT * FROM employees
WHERE SALARY = (SELECT MAX(SALARY) FROM employees WHERE DEPARTMENT_ID=50) AND DEPARTMENT_ID=50;

-- cho biet cac nhan vien co luong lon nhat
-- cho biet cac nhan vien cua phong 50 co luong lon nhat
SELECT * FROM employees
WHERE SALARY = (SELECT MAX(SALARY) FROM employees);

SELECT * FROM employees
WHERE SALARY = (SELECT MAX(SALARY) FROM employees WHERE DEPARTMENT_ID=50) AND DEPARTMENT_ID=50;

SELECT * FROM employees
ORDER BY SALARY DESC
LIMIT 1;

-- xep hang, danh so thu tu
SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS STT, 
	FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees;

SELECT ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS STT, 
	FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees;

SELECT RANK() OVER(ORDER BY SALARY DESC) AS STT, 
	FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees;

SELECT DENSE_RANK() OVER(ORDER BY SALARY DESC) AS STT, 
	FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees;

SELECT ROW_NUMBER() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS STT, 
	FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees;

SELECT DENSE_RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS HANG, 
	FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL;

-- cho biet cac nhan vien co luong lon nhat trong moi phong
select department_id,
		employee_id,
		first_name,
		last_name,
		salary
from 
	(select 
		department_id,
		employee_id,
		first_name,
		last_name,
		salary,
		DENSE_RANK() OVER(PARTITION BY department_id ORDER BY SALARY DESC) AS ranking
	from employees
	where department_id is not null) t
where t.ranking = 1
order by department_id;

-- correlative sub query (truy van con ket hop)
-- liet ke cac phong, tong luong theo phong
SELECT DEPARTMENT_ID, department_name, 
	(SELECT SUM(SALARY) FROM employees WHERE DEPARTMENT_ID=d.DEPARTMENT_ID) AS sum_sal
FROM departments d;

SELECT DEPARTMENT_ID, department_name, 
	IFNULL((SELECT SUM(SALARY) FROM employees WHERE DEPARTMENT_ID=d.DEPARTMENT_ID),0) AS sum_sal
FROM departments d;

SELECT EMPLOYEE_ID, FIRST_NAME, SALARY, MANAGER_ID,
	(SELECT FIRST_NAME FROM employees WHERE EMPLOYEE_ID=e.MANAGER_ID) AS mgr_name
FROM employees e;

-- cho biet cac nhan vien lam truong phong
SELECT * FROM employees
WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID FROM departments);

-- cho biet cac nhan vien khong lam truong phong
SELECT * FROM employees
WHERE EMPLOYEE_ID NOT IN (SELECT MANAGER_ID FROM departments WHERE MANAGER_ID IS NOT NULL);

-- giai thich:
x IN (a,b)
x=a OR x=b

x NOT IN (a,b)
x!=a AND x!=b

gia su b la NULL
x=a OR x=NULL
x!=a AND x!=NULL

-- cach 1
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM employees e, departments d
WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID -- inner join

-- cach 2
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM employees e INNER JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID;

-- liet ke cac nhan vien lam viec tai cac phong co vi tri 1700
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.DEPARTMENT_NAME, d.LOCATION_ID
FROM employees e INNER JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID
WHERE d.LOCATION_ID=1700;

-- bang tu ket, liet ke cac nhan vien co ten nguoi quan ly
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.MANAGER_ID, m.FIRST_NAME
FROM employees e JOIN employees m ON e.MANAGER_ID=m.EMPLOYEE_ID

-- SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
-- FROM employees e INNER JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID; -- 106
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.SALARY, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM employees e LEFT OUTER JOIN departments d ON e.DEPARTMENT_ID=d.DEPARTMENT_ID; 
-- INNER JOIN ~ JOIN
-- LEFT OUTER JOIN ~ LEFT JOIN

-- liet ke sodh, ngaydh, ma kh, tenkh, masp, tensp, thanh tien
-- orders, customers, orderitems, products
SELECT i.OrderId, i.ProductId, i.UnitPrice*i.Quantity AS total, o.OrderNumber, o.OrderDate,
	o.CustomerId, c.FirstName
FROM orderitems i JOIN orders o ON i.OrderId=o.id JOIN customers c ON c.Id=o.CustomerId
ORDER BY i.OrderId;



