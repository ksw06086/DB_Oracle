/* ���̺� ����/����/���� DDL
    * CREATE TABLE ��
    -- ����
    CREATE TABLE [schema. ] table (
        column datatype[DEFAULT expression]
        [column_constraintclause] [,...]);
    - schema                    : �������� �̸�(����� ����)
    - column                    : ���̺� ���ԵǴ� Į����
    - datatype                  : Į���� ���� ������ Ÿ�԰� ����
    - DEFAULT expression        : ������ �Է� ���� ������ ��� �ԷµǴ� �⺻ ��
    - column_constraint_clause  : Į���� ���ǵǴ� ���Ἲ ���� ����
    <char�� varchar2�� ����>
    - varchar2                  : address(50)�̾ ���� ���� �����ϴ� ��ŭ��
                                  ���� �ְڴ�. 20�� ����ϸ� 20���� ������(���� ����X)
    - char                      : ���̰� ������ �� ���
*/

-- food ���̺� ����
drop table food;

-- food ���̺� ����
create table food(
    food_code           varchar2(10)        primary key,
    restaurant_name     varchar2(50),
    kind                char(1),    -- �ѽ�(k), �߽�(c), ���(u), �Ͻ�(j)
    food_name           varchar2(50),
    price               number              default 0,
    starpoint           char(1)             default 0
);

desc food;

-- 1. insert ��
/*
    INSERT INTO TABLE_NAME (COLUMN_NAME, ...)
    VALUES (COLUMN_VALUE, ...);
*/
DELETE FOOD;
COMMIT;

-- DML ���� �Ͻ������� �߰�/����/������ �Ǿ��� �ݿ��� �ȵǾ�����
INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('1', '���õ��', 'K', '�Ұ�ⵤ��', 8500, '1');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('2', '���õ��', 'K', '��ġ�', 7500, '2');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('3', '���õ��', 'C', '¥���', 7000, '3');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('4', '���õ��', 'U', '������', 10000, '5');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('5', '���õ��', 'J', '��мҹ�', 8000, '5');

COMMIT; -- INSERT ���ϰ� ������ָ� ���������

SELECT
    *
FROM FOOD;

/* ���̺� ����(������)
[ ���� ]
CREATE TABLE table [column, ...]
as subquery
where 0 = 1;

- ���̺� ������ ����ǰ�, �����ʹ� ���� �ȵ�
- ���Ἲ ���� ������ not null ���Ǹ� ����ǰ�, �⺻Ű/�ܷ�Ű ���Ἲ ���������� ���� �ȵ�
  ����Ʈ �ɼǿ��� ������ ���� ���簡 �ȵ�
*/

create table food_copy
as
select * from food
where 0 = 1; -- ���� �Ȱ������� ������

select * from food_copy;

desc food_copy;
drop table food_copy;

-- ���̺� ��� ��ȸ
select * from tab;

/*  ALTER TABLE ��
1) �÷� �߰�
[ ���� ]
ALTER TABLE table_name
ADD ([COLUMN_NAME DATA_TYPE DEFAULT EXPR]
        [, COLUMN_NAME DATA_TYPE] ..);
*/
ALTER TABLE FOOD_COPY
ADD (START_DATE DATE DEFAULT SYSDATE);   -- ������ �߰�, �⺻�� ���ó�¥

ALTER TABLE FOOD_COPY
ADD (LOCATION_NAME VARCHAR2(50));

/*  
2) �÷� ����
[ ���� ]
ALTER TABLE table_name
MODIFY ([COLUMN_NAME DATA_TYPE DEFAULT EXPR]
        [, COLUMN_NAME DATA_TYPE] ..);
-- ���� �÷��� �����Ͱ� ���� ��� : �÷�Ÿ���̳� ũ�� ������ ����������,
-- �����Ͱ� �����ϴ� ��� Ÿ�� ���� : CHAR, VARCHAR2�� ����
-- ������ �÷��� ũ�� : ����� �������� ũ��� ���ų� Ŭ ��쿡�� ���氡��
-- ���� Ÿ�� : �� Ȥ�� ��ü �ڸ����� �ø� �� ���� 
*/

-- �÷�����
ALTER TABLE FOOD_COPY
MODIFY PRICE NUMBER(10);

ALTER TABLE FOOD_COPY
MODIFY PRICE NUMBER(5);

DESC FOOD_COPY;

/*
3) �÷� ����
-- 2�� �̻��� �÷��� �����ϴ� ���̺����� ����
-- �� ���� �ϳ��� �÷��� ������ �� ����, ������ �÷��� ���� �Ұ���
[ ���� ]
ALTER TABLE table_name
DROP COLUMN column_name;
*/
ALTER TABLE FOOD_COPY
DROP COLUMN LOCATION_NAME;

DESC FOOD_COPY;

/*
4) SET UNUSED
-- �ý����� �䱸�� ���� �� ������ ���ϰ� ���ϴ� �÷��� ��� ���� �� ���
-- DROP ��ɺ��� ����
-- ������ ��ó�� ó���ؼ� SELECT�� DESCRIBE(DESC)�� ����� �� ����
[ ���� ]
ALTER TABLE table_name
SET UNUSED (column_name);
*/

ALTER TABLE FOOD_COPY
SET UNUSED (START_DATE);

DESC FOOD_COPY;

/*
    * RENAME : ���̺� �̸� ����
    [ ���� ] RENAME �� ���̺� �� TO �� ���̺� ��
*/

CREATE TABLE FOOD_TEST
AS
SELECT * FROM FOOD
WHERE 0 = 1;

RENAME FOOD_TEST TO FOOD_NEW;

SELECT * FROM TAB;

/*
    * DROP TABLE ��
    -- ������ ���̺�� ������ ��� ����
    -- ������ ���̺��� �⺻Ű�� ����Ű�� �ٸ� ���̺��� �����ϰ� �ִ� ��� 
       ������ �Ұ����� �׷��� ���� ���� �ڽ� ���̺��� ���� �����ؾ���
    -- ������ �θ� ����, ������ �ڽ� ����        
*/
DROP TABLE FOOD_NEW;

/*  * TRUNCATE ��
    -- ������ ���̺��� ��� ������ ����(DELETE�� ����)
*/
-- 1) ���̺� ����, ������ ����
CREATE TABLE FOOD_TEST
AS
SELECT * FROM FOOD;   -- �����ͱ��� ����

-- INSERT�� ������ ����
INSERT INTO FOOD_TEST
SELECT * FROM FOOD;
COMMIT;     -- ����

ROLLBACK;    -- INSERT �� COMMIT���� �ʰ� ROLLBACK�ϸ� �������� ���ư�

SELECT * FROM FOOD_TEST;

-- 2) TRUNCATE
TRUNCATE TABLE FOOD_TEST;

/*
    * ������ ���� : �پ��� ������ �����ϴ� �ý��� ���̺��� ����
    -- ����ڰ� ���̺��� �����ϰų� ����ڸ� �����ϴ� ���� �۾��� �� �� 
       �����ͺ��̽� ������ ���� �ڵ����� ���ŵǴ� ���̺�
    -- ����ڴ� ������ ������ ������ ���� �����ϰų� ������ �� ���� �б����� 
       �� ���·� ����ڿ��� ������
    [ ���� ]
    -- USER_    : �ڽ��� ������ ������ ��ü � ���� ������ȸ
    -- ALL_     : �ڽ��� ���� �����߰ų� ������ �ο����� ��ü � ���� ������ȸ
    -- DBA_     : �����ͺ��̽� �����ڸ� ���ٰ����� ��ü���� ������ȸ
*/
-- 1) USER_
--    USER_TABLE        : ����ڰ� ������ ���̺��� ����
--    USER_SEQUENCES    : ����ڰ� ������ �������� ����
--    USER_INDEXES      : ����ڰ� ������ �ε��� ������ ��ȸ
--    USER_VIEW         : ����ڰ� ������ �� ������ ��ȸ�� �� �ִ� ������ ����
SELECT
    TABLE_NAME
FROM USER_TABLES;       -- ���� ������ �ִ� ���̺� ������

-- 2) ALL_
--    ALL_TABLE         : ��� ���̺� ��ȸ
SELECT
    OWNER, TABLE_NAME
FROM ALL_TABLES;

-- 3) DBA_
--    - DBA�� �ý��� ������ ���� ����ڸ� ���� ����
--    - ���� ����ڰ� HR�̶�� DBA_�� �����ϴ� ������ ������ ��ȸ�� ������ ����
SELECT
    OWNER, TABLE_NAME
FROM DBA_TABLES;

--------------------------------------------------------------------------------
