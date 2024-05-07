SELECT s.City, s.CompanyName, UCASE(p.ProductName) AS ProductName, p.UnitPrice 
FROM products p JOIN suppliers s ON p.SupplierId=s.Id
WHERE s.Country='Japan'
ORDER BY s.City;
--
SELECT s.Country, CONCAT('$',ROUND(AVG(p.UnitPrice),2)) AS avg_unitprice, 
    COUNT(p.Id) AS count_product, COUNT(DISTINCT s.City) AS count_city
FROM products p JOIN suppliers s ON p.SupplierId=s.Id
WHERE p.IsDiscontinued=0
GROUP BY s.Country
ORDER BY count_product
--
SELECT CONCAT(c.FirstName,' ',c.LastName) AS Customer_name, `OrderNumber`, DATE_FORMAT(OrderDate, '%d/%m/%Y') AS order_date, 		CONCAT('$',FORMAT(TotalAmount,2)) AS total_amount
FROM orders o JOIN customers c ON o.CustomerId=c.Id
WHERE OrderDate BETWEEN '2014-03-01' AND '2014-03-31'
ORDER BY OrderDate DESC, TotalAmount DESC;
--
CREATE OR REPLACE VIEW myview
AS
	SELECT
        YEAR(OrderDate) AS sale_year, p.ProductName AS product_name,
        SUM(i.UnitPrice*i.Quantity) AS sum_amount
    FROM orders o JOIN orderitems i ON o.Id=i.OrderId
        JOIN products p ON i.ProductId=p.Id
    GROUP BY sale_year, product_name;
SELECT sale_year, product_name, sum_amount
FROM
(
    SELECT DENSE_RANK() OVER(PARTITION BY sale_year ORDER BY sum_amount DESC) AS hang,
        sale_year, product_name, sum_amount
    FROM myview
) q
WHERE hang<=5;
--
SELECT *
FROM
(
SELECT DENSE_RANK() OVER(PARTITION BY sale_year ORDER BY sum_amount DESC) AS hang, sale_year, product_name, sum_amount
FROM
(
	SELECT
        YEAR(OrderDate) AS sale_year, p.ProductName AS product_name,
        SUM(i.UnitPrice*i.Quantity) AS sum_amount
    FROM orders o JOIN orderitems i ON o.Id=i.OrderId
        JOIN products p ON i.ProductId=p.Id
    GROUP BY sale_year, product_name
) q
) q_
WHERE hang<=5;

--
SELECT `OrderNumber`, DATE_FORMAT(OrderDate, '%d/%m/%Y') AS `OrderDate`, CONCAT('$',FORMAT(TotalAmount,2)) AS total_amount, 'max total amount' AS note
FROM orders
WHERE `TotalAmount`=(SELECT MAX(`TotalAmount`) FROM orders)
UNION ALL
SELECT `OrderNumber`, DATE_FORMAT(OrderDate, '%d/%m/%Y'), 
CONCAT('$',FORMAT(TotalAmount,2)), 'min total amount'
FROM orders
WHERE `TotalAmount`=(SELECT MIN(`TotalAmount`) FROM orders);
--
SELECT o.OrderNumber, o.OrderDate, CONCAT(FirstName,' ',LastName) AS customer_name, o.TotalAmount
FROM orders o JOIN customers c ON o.CustomerId=c.Id
WHERE DAYOFWEEK(OrderDate)=1 AND YEAR(OrderDate)=2014 AND MONTH(OrderDate)=3
ORDER BY OrderDate DESC;
--
SELECT YEAR(OrderDate) AS year, QUARTER(OrderDate) AS quarter, FORMAT(SUM(TotalAmount),2) AS sum_totalamount
FROM orders
GROUP BY year, quarter
ORDER BY SUM(TotalAmount) DESC
LIMIT 2;
--
SELECT CONCAT(c.FirstName,' ',c.LastName) AS customer_name, COUNT(o.Id) AS count_orders
FROM customers c LEFT JOIN orders o ON c.Id=o.CustomerId
GROUP BY customer_name
ORDER BY count_orders
--
SELECT * 
FROM orders
WHERE id IN
(SELECT orderid FROM orderitems WHERE productid IN 
 (SELECT id FROM products WHERE ProductName ='Chai'))
ORDER BY totalamount DESC
LIMIT 10;
--
SELECT p.ProductName, SUM(i.Quantity) AS sum_quantity
FROM products p LEFT JOIN orderitems i ON p.Id=i.ProductId LEFT JOIN orders o ON o.Id=i.OrderId
WHERE p.IsDiscontinued=0
GROUP BY p.ProductName
ORDER BY sum_quantity;
