-- vi du ve giao tac (transaction)
/*
- ACID
- transaction la mot don vi cong viec (work unit)
- thuc hien mot cong viec bao gom nhieu buoc (nhieu lenh)
- cong viec goi la thanh cong khi tat ca cac buoc thanh cong
- neu nhu co it nhat 1 buoc that bai --> cong viec that bai
- cai dat transaction:
	- neu nhu cac lenh (trong transaction) thanh cong --> commit (save)
    - neu co it nhat 1 lenh that bai (trong transaction) --> rollback (undo)
*/
-- bang thu nghiem transaction
CREATE TABLE test_tran
SELECT * FROM employees;

ALTER TABLE test_tran ENGINE=INNODB;

SELECT TABLE_NAME,
       ENGINE
FROM   information_schema.TABLES
WHERE  TABLE_SCHEMA = 'humanresources';

START TRANSACTION; -- Explicit Transaction <> Implicit Transaction
SELECT COUNT(*) AS 'Before delete' FROM test_tran;
DELETE FROM test_tran;
SELECT COUNT(*) AS 'After delete' FROM test_tran;
ROLLBACK;
SELECT COUNT(*) AS 'After rollback' FROM test_tran;

START TRANSACTION;
SELECT COUNT(*) AS 'Before delete' FROM test_tran;
DELETE FROM test_tran;
SELECT COUNT(*) AS 'After delete' FROM test_tran;
COMMIT;
SELECT COUNT(*) AS 'After commit' FROM test_tran;

DROP TABLE test_tran;
