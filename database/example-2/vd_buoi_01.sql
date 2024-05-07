CREATE TABLE country
(
  id int PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  code CHAR(3) NOT NULL  
);    
INSERT INTO country VALUES(1,'Viet Nam','VNA');
DROP TABLE country;

CREATE TABLE country
(
  id int PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(50) NOT NULL,
  code CHAR(3) NOT NULL  
);    

INSERT INTO country(name,code) VALUES('Viet Nam','VNA');
INSERT INTO country(name,code) VALUES('Canada','CAN');

SELECT * 
FROM `medals` 
WHERE year=2012  AND Medal='Gold' AND Gender='Men' AND CountryCode='USA'
ORDER BY `Athlete`;