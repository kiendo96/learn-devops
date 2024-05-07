CREATE TABLE orders
(
    orderid INT PRIMARY KEY,
    customerid INT,
    ordertotal INT
);

INSERT INTO orders VALUES(1,1,1000);
INSERT INTO orders VALUES(2,1,1000);
INSERT INTO orders VALUES(3,1,1000);
INSERT INTO orders VALUES(4,2,2000);
INSERT INTO orders VALUES(5,2,2000);

SELECT customerid, SUM(ordertotal)
FROM orders
GROUP BY customerid; -- RIGHT

SELECT orderid, customerid, SUM(ordertotal)
FROM orders
GROUP BY customerid; -- WRONG

SET SESSION sql_mode='ONLY_FULL_GROUP_BY';
SELECT orderid, customerid, SUM(ordertotal)
FROM orders
GROUP BY customerid; -- ERROR

SET SESSION sql_mode='';
