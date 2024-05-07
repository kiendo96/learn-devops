-- xem cong viec va phong hien tai cua nhan vien 101
select employee_id, first_name, job_id, department_id from employees where employee_id=101;
-- xem cong viec va phong trong qua khu cua nhan vien 101
select employee_id, job_id, department_id from job_history where employee_id=101;

select employee_id, first_name, job_id, department_id, 'hien tai' as note from employees where employee_id=101
union
select employee_id, '', job_id, department_id, 'qua khu' from job_history where employee_id=101;

select employee_id, first_name, job_id, department_id, 'hien tai' as note from employees where employee_id=101
union
select employee_id, '', job_id, department_id, 'qua khu' from job_history where employee_id=101;
/*
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.JOB_ID, e.DEPARTMENT_ID, 'Current' as Note 
FROM employees e
WHERE e.EMPLOYEE_ID = 101
UNION
-- xem cong viec va phong trong qua khu cua nhan vien 101
SELECT h.EMPLOYEE_ID, e.FIRST_NAME, h.JOB_ID, h.DEPARTMENT_ID, 'Past'
FROM job_history h, employees e
WHERE h.EMPLOYEE_ID = e.EMPLOYEE_ID AND h.EMPLOYEE_ID = 101;
*/
* truy van co ban:
- select from where order by limit
- cac ham trong mysql

* truy van nang cao:
- truy van nhieu bang
- truy van con + truy van con ket hop
- truy van co nhom
- ...
- bieu thuc dieu kien case
- ham xep hang, ham danh so thu tu

-- truy van co nhom
-- nhom theo phong va dem so nhan vien cua moi phong
SELECT department_id, COUNT(*) AS count_emp
FROM employees
where department_id is not null
GROUP BY department_id
order by count_emp desc;

-- cho biet them ten phong va tong luong
SELECT e.Department_id, d.DEPARTMENT_NAME, COUNT(*) AS Total_emp, SUM(e.SALARY) as Total_Sal
FROM employees e JOIN departments d on e.DEPARTMENT_ID = d.DEPARTMENT_ID 
GROUP BY e.department_id
ORDER BY Total_emp DESC;

-- PIVOT: xoay cac dong thanh cac cot
/*
SELECT YEAR(HIRE_DATE) AS year_hd, COUNT(*) AS count_emp
FROM employees
GROUP BY YEAR(HIRE_DATE);
*/
-- xoay cac dong thanh cac cot
SELECT 
	SUM(CASE WHEN YEAR(HIRE_DATE)=2004 THEN 1 ELSE 0 END) AS nam_2004,
    SUM(CASE WHEN YEAR(HIRE_DATE)=2005 THEN 1 ELSE 0 END) AS nam_2005,
    SUM(CASE WHEN YEAR(HIRE_DATE)=2006 THEN 1 ELSE 0 END) AS nam_2006,
    SUM(CASE WHEN YEAR(HIRE_DATE)=2007 THEN 1 ELSE 0 END) AS nam_2007,
    SUM(CASE WHEN YEAR(HIRE_DATE)=2008 THEN 1 ELSE 0 END) AS nam_2008
FROM employees
WHERE YEAR(HIRE_DATE) BETWEEN 2004 AND 2008;

SELECT 
	SUM(IF(YEAR(HIRE_DATE)=2004,1,0)) AS nam_2004,
    SUM(IF(YEAR(HIRE_DATE)=2005,1,0)) AS nam_2005,
    SUM(IF(YEAR(HIRE_DATE)=2006,1,0)) AS nam_2006,
    SUM(IF(YEAR(HIRE_DATE)=2007,1,0)) AS nam_2007,
    SUM(IF(YEAR(HIRE_DATE)=2008,1,0)) AS nam_2008,
    COUNT(*) AS tong_cong
FROM employees
WHERE YEAR(HIRE_DATE) BETWEEN 2004 AND 2008;

SELECT 
	JOB_ID,
	SUM(IF(YEAR(HIRE_DATE)=2004,1,0)) AS nam_2004,
    SUM(IF(YEAR(HIRE_DATE)=2005,1,0)) AS nam_2005,
    SUM(IF(YEAR(HIRE_DATE)=2006,1,0)) AS nam_2006,
    SUM(IF(YEAR(HIRE_DATE)=2007,1,0)) AS nam_2007,
    SUM(IF(YEAR(HIRE_DATE)=2008,1,0)) AS nam_2008,
    COUNT(*) AS tong_cong
FROM employees
WHERE YEAR(HIRE_DATE) BETWEEN 2004 AND 2008
GROUP BY JOB_ID;

-- VIEW: bang ao
CREATE VIEW myview
AS
	SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, JOB_ID, HIRE_DATE, DEPARTMENT_ID
    FROM employees;

SELECT d.productid, d.productname, MAX(d.dem) as dem
FROM
(SELECT o.productid, p.productname, COUNT(*) as dem 
FROM orderdetails o JOIN products p ON o.productid = p.productid
GROUP BY o.productid, p.productname
ORDER BY dem DESC) d;

SELECT *
FROM 
(
	SELECT 
		p.productid,
		p.productname,
		RANK() over(order by count(o.orderid) desc) as hang
	FROM products p 
	JOIN orderdetails o
		on p.productid = o.productid
	GROUP BY
		p.productid,
		p.productname
	) t
WHERE t.hang = 1

/*
SELECT 
  d.productid, p.productname,
  COUNT(*) AS Dem
FROM orderdetails d JOIN products p ON d.productid = p.productid
GROUP BY d.productid, p.productname
ORDER BY dem DESC
LIMIT 1;
*/
/*
SELECT d.productid, d.productname, MAX(d.dem) as dem
FROM
(SELECT o.productid, p.productname, COUNT(*) as dem 
FROM orderdetails o JOIN products p ON o.productid = p.productid
GROUP BY o.productid, p.productname) d
GROUP BY d.productid, d.productname
*/
SELECT *
FROM 
(
	SELECT 
		p.productid,
		p.productname,
		RANK() over(order by count(o.orderid) desc) as hang,
    	COUNT(*) AS dem
	FROM products p 
	JOIN orderdetails o
		on p.productid = o.productid
	GROUP BY
		p.productid,
		p.productname
	) t
WHERE t.hang = 1



