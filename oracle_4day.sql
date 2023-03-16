/*  *** DML�� Ʈ����� ***
�� DML : ���̺� ���ο� �����͸� ����, ���� �����͸� ����/�����ϱ� ���� ��ɾ��� ����
-- INSERT ������ ������ Į���� ������ Ÿ���� ����(CHAR, VARCHAR2)�� ��¥(DATE)�� ���,
   �ݵ�� ���� ����ǥ(' ')�� �Բ� ����ؾ��մϴ�.

<> COMMIT    - ��� �۾����� ���������� ó���ϰڴٰ� Ȯ���ϴ� ��ɾ�� Ʈ�������
               ó�������� �����ͺ��̽��� ��� �ݿ��ϱ� ���ؼ�, ����� ������ ��� ����������
             - INSERT, UPDATE, DELETE �� (�� DML) COMMIT;�� �ؾ���
<> ROLLBACK  - ������� ��� .. �ݵ�� COMMIT ���� �ؾ��Ѵ�.
               Ʈ��������� ���� �ϳ��� ���� ó����, ���۵Ǳ� ������ ���·� �ǵ�����.
<> SAVEPOINT - ������ Ʈ������� �۰� ������. 
               ����� SAVEPOINT�� ROLLBACK TO SAVEPOINT���� ����Ͽ� ǥ���� ������ �ѹ��� �� �մ�.
               1) SAVEPOINT SAVEPOINT��; 2) ROLLBACK TO SAVEPOINT��;

�� Ʈ����� : ������ ó������ ������ �ϳ��� �۾�����
-- 1. COMMIT Ȥ�� ROLLBACK���� ����Ǵ� ���
-- 2. DDL, DCL���� ����Ǵ� ���
-- 3. Ʈ������� ����������Ǵ� ���(�۾� �߰��� �����, COMMIT �� ��ó������ ������ ��)
-- <�ڵ� COMMIT, ROLLBACK>
-- DDL, DCL ���� ����Ǵ� ��쿡�� �ڵ����� COMMIT �ǰ�,
-- Ʈ������� ������ ����Ǵ� ��쿡�� �ڵ����� ROLLBACK�ȴ�.
*/

/* 1. INSERT ��
[ ���� ]
INSERT INTO TABLE_NAME (�÷���1, �÷���2, ...)
VALUES (�÷� ��1, �÷� ��2, ...);
*/
CREATE TABLE MOVIE(
    code        number(3)       primary key,
    movie_name  varchar2(50),
    place       varchar2(50),
    price       number(7)       default 0,
    person      number(3)       default 0
);

insert into movie(code, movie_name, place, price, person)
values (1, '��Ľ�', 'IMAX', 24000, 3);

insert into movie(code, movie_name, place, price, person)
values (2, '�峭���� Ű��', 'CGV', 14000, 2);

insert into movie(code, movie_name, place, price, person)
values (3, '����', 'ALL', 9900, 4);

insert into movie(code, movie_name, place, price, person)
values (4, '��������', 'CGV', 14000, 1);

insert into movie(code, movie_name, place, price, person)
values (5, '������� ���ܼ�', '�Ե��ó׸�', 12000, 1);

SELECT
    *
FROM MOVIE;

ROLLBACK;
COMMIT;

-- START_DATE �÷� �߰�
ALTER TABLE MOVIE
ADD START_DATE DATE DEFAULT SYSDATE;

DROP TABLE MOVIE;

/* ���̺� ����
    1) ������ ���� �� ������ ����
    2) ������ ������ ��� ����
*/
-- 1)
CREATE TABLE MOVIE_COPY
AS SELECT * FROM MOVIE
WHERE 0 = 1;  -- ���� ����

INSERT INTO MOVIE_COPY
SELECT * FROM MOVIE;  -- ������ ����

DROP TABLE MOVIE_COPY;

-- 2)
CREATE TABLE MOVIE_COPY
AS SELECT * FROM MOVIE;

/* 2. UPDATE ��
[ ���� ]
UPDATE table_name
SET column_name1 = value1, column_name2 = value2
where conditions ;
*/
update movie
set place = 'MEGA', PRICE = 10000, PERSON = 6, START_DATE = '2023-05-03'
WHERE CODE = 5;
COMMIT;
ROLLBACK;
SELECT * FROM MOVIE;

select * from food;

update food set food.restaurant_name = '����¡', food_name = '������',
            PRICE = 15000, STARPOINT = 5
WHERE FOOD_CODE = 3;

update food set food.restaurant_name = '�����Ĵ�', food_name = '��ä��',
            PRICE = 10000, STARPOINT = 3
WHERE FOOD_CODE = 1;

COMMIT;

/* UPDATE���� �������� Ȱ���ϱ� */
UPDATE FOOD SET FOOD_NAME = (SELECT FOOD_NAME FROM FOOD WHERE FOOD_CODE = 3),
        KIND = (SELECT KIND FROM FOOD WHERE FOOD_CODE = 3)
WHERE FOOD_CODE = 1;

UPDATE FOOD SET (FOOD_NAME, KIND, PRICE) = 
            (SELECT FOOD_NAME, KIND, PRICE FROM FOOD WHERE FOOD_CODE = 4) 
WHERE FOOD_CODE = 1;

/* 3. DELETE ��
[ ���� ]
DELETE [FROM] TABLE_NAME
WHERE CONDITIONS;
*/
SELECT * FROM FOOD_TEST;

-- FOOD_CODE 3�� ������ ����
DELETE FROM FOOD_TEST
WHERE FOOD_CODE = 3;

COMMIT;

-- FOOD_NAME�� ����� �����ϴ� ������ ����
DELETE FOOD_TEST
WHERE FOOD_NAME LIKE '%���%';

-- 5���� PRICE���� ū PRICE�� ��� ����
DELETE FOOD
WHERE PRICE > (SELECT PRICE FROM FOOD WHERE FOOD_CODE = 5);

SELECT * FROM FOOD;
SELECT * FROM MOVIE;

-- START_DATE �� ȭ�鿡�� 2023-05-03�� �Էµ� START_DATE ����
DELETE FROM MOVIE
WHERE START_DATE = '2023-05-03';
ROLLBACK;

CREATE TABLE DEPT_TR(
    deptno      number          primary key,
    deptname    varchar2(40)    not null,
    loc         varchar2(50));
    
insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (10, 'IT', '����');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (20, '��ȹ', '����');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (30, '����', '����');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (40, '������', '����');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (50, '����', '����');

COMMIT;

SELECT * FROM DEPT_TR;
-- Ʈ�����
-- 1) 40�� �μ� ���� �� COMMIT
DELETE DEPT_TR
WHERE DEPTNO = 40;

COMMIT;
ROLLBACK;

-- 2) 30�� �μ� ���� �� ���̺� C1 ����
DELETE DEPT_TR
WHERE DEPTNO = 30;
SAVEPOINT C1;      -- SAVEPOINT�� �����Ǿ����ϴ�.

-- 3) 20�� �μ� ���� �� ���̺� C2 ����
DELETE DEPT_TR
WHERE DEPTNO = 20;
SAVEPOINT C2;      -- SAVEPOINT�� �����Ǿ����ϴ�.

-- 4) 10�� �μ� ���� �� ��ȸ
DELETE DEPT_TR
WHERE DEPTNO = 10;
SELECT * FROM DEPT_TR;

-- 5) 10�� �μ� ���� ���
rollback to c2;
-- 6) 20�� �μ� ���� ���
rollback to c1;
-- 7) 30�� �μ� ���� ���
rollback;
-- 8) 40�� �μ� ���� ���
rollback;

/*  * ������ ���Ἲ�� ���� ����
    1. ���� ���� : ���̺� ��ȿ���� ���� �����Ͱ� �ԷµǴ� ���� �����ϱ� ���ؼ�
                  ���̺� ���� �� �� �÷��� ���� �����ϴ� ��Ģ
    <ORACLE �������� ����>
    NOT NULL        - Į���� NULL ���� �������� ���ϵ��� �����Ѵ�.
    UNIQUE          - ���̺��� ��� �ο쿡 ���ؼ� ������ ���� ������ �Ѵ�.
    PRIMARY KEY     - ���̺��� �� ���� �ĺ��ϱ� ���� ������ NULL�� �ߺ��� ���� ��� ����
                      ��, NOT NULL ���ǰ� UNIQUE ������ ������ �����̴�.
    FOREIGN KEY     - �����Ǵ� ���̺� �÷� ���� �׻� �����ؾ� �Ѵ�.
    CHECK           - ���� ������ ������ ���� ������ ������ �����Ͽ� ������ ������ ����Ѵ�.
    
    -- �������� �� : ���̺��_�÷���_Ű
    -- �������ǿ� ���� INSERT, DELETE.. �߿�!
       1. �θ����̺��� PK �÷��� �����Ͱ� �����ؾ�
          �ڽ����̺��� FK �÷��� ������ INSERT�� �����ϴ�.
       2. �ڽ����̺��� FK �÷����� ���Ǵ� ���� �����ϸ�, �μ����̺��� PK �÷���
          ������ ����, �ڽ� FK �����͸� ���� ���� ��, �θ� �����͸� �����Ѵ�.
*/

-- �������� ���� ��������
SELECT
    CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM SYS.USER_CONSTRAINTS;

-- �μ� ���̺� ����
CREATE TABLE DEPT2(
    DEPTNO          NUMBER,
    DEPTNAME        VARCHAR2(50) CONSTRAINT DEPT_DEPTNAME_NN NOT NULL,
    LOC             VARCHAR2(50),
    CONSTRAINT  DEPT_DEPTNO_PK PRIMARY KEY(DEPTNO)
);

CREATE TABLE EMP2(
    EMPNO           NUMBER,
    ENAME           VARCHAR2(20) NOT NULL,
    HIRE_DATE       DATE        DEFAULT SYSDATE,
    SALARY          NUMBER  CONSTRAINT EMP2_SALARY_MIN CHECK(SALARY > 0),
    DEPTNO          NUMBER,
    EMAIL           VARCHAR2(60),
    CONSTRAINT EMP2_EMPNO_PK PRIMARY KEY(EMPNO),
    CONSTRAINT EMP2_DEPTNO_FK   FOREIGN KEY(DEPTNO) REFERENCES DEPT2(DEPTNO)
                ON DELETE CASCADE,  -- �ڽ� ���̺� �����ϸ� �θ����̺� ������ �ڽĵ� ����
    CONSTRAINT EMP2_EMAIL_UK     UNIQUE(EMAIL)
);

INSERT INTO DEPT2
VALUES (101, 'IT', '����');
INSERT INTO DEPT2
VALUES (102, 'SALES', '����');
INSERT INTO DEPT2
VALUES (103, 'ACCOUNT', '����');
INSERT INTO DEPT2
VALUES (104, 'HR', '�ĸ�');
INSERT INTO DEPT2
VALUES (105, 'CLERK', '�ι���');
INSERT INTO DEPT2
VALUES (106, 'TT', '���ε�');

INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1001, '������', '2023-03-20', 2500000, 101, 'so@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1002, '������', '2023-03-21', 3000000, 102, 'jun@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1003, '������', '2023-03-22', 2000000, 103, 'kim@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1004, '������', '2023-04-20', 2100000, 104, 'yoon@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1005, '������', '2023-05-01', 2000000, 105, 'osan@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1006, '�����', '2023-05-03', 1900000, 106, 'kimsw@naver.com');
select * from dept2;
select * from emp2;
commit;

insert into dept2
values (107, 'SERVICE', '����');

INSERT INTO EMP2
VALUES (1007, '�����', '2023-05-03', 1900000, 106, 'kims@naver.com');

UPDATE EMP2
SET DEPTNO = 107
WHERE EMPNO = 1007;

-- �޿��� ������ ��
INSERT INTO EMP2
VALUES (1008, '�����2', '2023-05-03', -400000, 106, 'kims@naver.com'); -- ����

----------------------------------------------------------------------
------------------ ���̺� ���� �÷� ���� ------------------
----------------------------------------------------------------------
-- �μ� ���̺� ����
CREATE TABLE DEPT_RE2(
    DEPTNO          NUMBER  CONSTRAINT DEPT_RE2_DEPTNO_PK PRIMARY KEY,
    DEPTNAME        VARCHAR2(50) CONSTRAINT DEPT_RE2_DEPTNAME_NN NOT NULL,
    LOC             VARCHAR2(50)
);

-- ��� ���̺� ����
CREATE TABLE EMP_RE2(
    EMPNO           NUMBER CONSTRAINT EMP_RE2_EMPNO_PK PRIMARY KEY,
    ENAME           VARCHAR2(20) CONSTRAINT EMP_RE2_ENAME NOT NULL,
    HIRE_DATE       DATE DEFAULT SYSDATE,
    SALARY          NUMBER  CONSTRAINT EMP_RE2_SALARY_CHK CHECK(SALARY > 0),
    DEPTNO          NUMBER  CONSTRAINT EMP_RE2_DEPTNO_FK REFERENCES DEPT_RE2(DEPTNO),
    EMAIL           VARCHAR2(60)  CONSTRAINT EMP_RE2_EMAIL_UQ UNIQUE
);

/*   ���� ����� ����ϱ�
    �� ���� : ������ ���̺��� �ٰ��� ������ ���� ���̺� ��ũ ��������� �Ҵ���� ����.
             ��, ���������� �����͸� �������� �ʰ�, ������ ������, �並 ������ ��
             ����� �������� ����Ǿ� ����. ������ ������� ���̺��� �Ļ��� ��ü 
             ���̺�� �����ϱ� ������ '���� ���̺�'�̶� �Ѵ�.
             ���� ���Ǵ� user_views ������ ������ ���� ��ȸ �����ϴ�.
    
    �� ���ۿ���
    -- ��� �����͸� �����ϰ� ���� ���� ���� ���̺��̹Ƿ� ��ü�� ����
    -- ��� ���̺�ó�� ���� �� �մ� ������ �並 ������ �� create view ��ɾ� ������
       as ���� ����� ���� ���� ��ü�� �����ϰ� �ִٰ� �̸� �����ϱ� ����
    -- select���� from������ v_emp�� ����Ͽ� �����ϸ�,
       ����Ŭ������ user_views���� v_emp(key)�� ã�´�.
    -- ����ߴ� �������������� ����� text���� view �� v_emp ��ġ�� �����ͼ� �����Ѵ�.
    
    �� �並 ����ϴ� ����
    -- ���Ȱ� ����� ���Ǽ� ����
    -- ���� ����ϴ� �����ϰ� �� �������� ��� �����ϸ�, ������ �ܼ�ȭ �� �� �հ�, 
       ���ȿ� ������
    -- ���Ѻ��� ������ ���ѵǾ, ������ ���̺� �����ϴ� ����鸶�� �ٸ� �信 
       �����ϵ��� �� �� �ִ�.
    
    �� view �������� �ο�, system �������� ����
    -- grant create view to scott;
*/
CREATE VIEW V_EMP_DEPT2
AS
-- USER_VIEW�� TEXT �κ�
SELECT E.EMPNO, E.ENAME, E.EMAIL, E.HIRE_DATE, E.DEPTNO, D.DEPTNAME, D.LOC
FROM EMP2 E, DEPT2 D
WHERE D.DEPTNO = E.DEPTNO;

SELECT * FROM V_EMP_DEPT2;

-- ������ �������� �� ��ȸ
SELECT 
    VIEW_NAME, TEXT
FROM USER_VIEWS;

/*  �� �����ϱ�
[ ���� ] DROP VIEW (VIEW) [, .. N]
-- ��� ��ü�� ���� �������̺��̱� ������ �並 �����Ѵٴ� ���� USER_VIEWS ������
   ��ųʸ��� ����Ǿ� �ִ� ���� ���Ǹ� �����ϴ� ���� �ǹ��Ѵ�.
-- �並 ������ �⺻���̺��� ������ �����Ϳ��� ������ ����.
*/
DROP VIEW V_EMP_DEPT2;
SELECT
 *
FROM USER_VIEWS;

/*
    �� CREATE OR REPLACE VIEW
    -- �̹� �����ϴ� �信 ���ؼ� �� ������ ���Ӱ� �����Ͽ� �����
    �� WITH READ ONLY : �ش� �並 ���ؼ��� SELECT�� ������
    -- �̰� ������ ���� ���̺��� ��� ������ �߰�/����/���� ����
    �� WITH CHECK OPTION
    -- �ش� �並 ���ؼ� �� �� �ִ� ���� �������� UPDATE �Ǵ� INSERT�� ������
    -- ��, �並 ������ �� ���� ���ÿ� ���� �÷����� �ƴ� ���� ���� ���ϵ��� �ϴ� ��� ����
    -- ��, ���� ���õ� ���� INSERT, UPDATE ����
    
    * �߿�!!! WITH READ ONLY�� ���� �ʰ� VIEW�� ���� ���¿��� DML �� ����ϸ�
      VIEW���� �ƴ� ���̺��� ������ ��  
*/
-- �� WITH READ ONLY
CREATE OR REPLACE VIEW V_EMP_READONLY
AS
SELECT EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO
FROM EMP2
WITH READ ONLY;

-- ERROR : cannot perform a DML operation on a read-only view
INSERT INTO V_EMP_READONLY(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(2001, '����', 'BOA@NAVER.COM', SYSDATE, 105);

-- �� WITH CHECK OPTION
CREATE OR REPLACE VIEW V_EMP_OPTION
AS
SELECT EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO
FROM EMP2
WHERE EMPNO IN(3001,3002)   -- INSERT, UPDATE ������
WITH CHECK OPTION;

INSERT INTO V_EMP_OPTION(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(3001, '�̼���', 'LEE@NAVER.COM', SYSDATE, 105); -- INSERT

INSERT INTO V_EMP_OPTION(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(3002, '������', 'JMLEE@NAVER.COM', SYSDATE, 105); -- INSERT

INSERT INTO V_EMP_OPTION(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(3003, '�����', 'KIM@NAVER.COM', SYSDATE, 105); -- ERROR

COMMIT;

UPDATE V_EMP_OPTION
SET EMAIL = 'LEE@GMAIL.COM'
WHERE EMPNO = 3001;

UPDATE V_EMP_OPTION
SET EMAIL = 'JMLEE@GMAIL.COM'
WHERE EMPNO = 3002;

UPDATE V_EMP_OPTION
SET EMAIL = 'KIM@GMAIL.COM'
WHERE EMPNO = 3003;

SELECT
    *
FROM V_EMP_READONLY;    -- �Է°� ���� ��� ������ ��쿡��

-- ���� ���̺�, VIEW ���̺� ��� ������Ʈ �Ǿ��� INSERT �Ǿ���(�߿�!)
SELECT * FROM EMP2;

