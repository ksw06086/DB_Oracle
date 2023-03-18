/*  �߿�!!  
    �� �������� �ε���
    -- PRIMARY KEY�� ������ Į���� �Ϸù�ȣ�� �ڵ����� �ο��ޱ� ���� �������� ���
    -- ���̺� ���� ������ ���ڸ� �ڵ����� �������ְ�, �ַ� �⺻Ű�� �����
    [ ���� ] 
    CREATE SEQUENCE sequence_name
    [START WITH N] -- �� 
    [INCREMENT BY N] -- ��
    [(MAXVALUE N | NOMAXVALUE)] -- ��
    [(MINVALUE N | NOMINVALUE)] -- ��
    [(CYCLE | NOCYCLE)] -- ��
    [(CACHE N | NOCACHE)] -- ��
    
    �� START WITH
    -- ������ ��ȣ�� ���� ���� ������ �� ���
    �� INCREMENT BY
    -- �������� ������ ��ȣ�� ����ġ�� ������ �� ���
    �� MAXVALUE N
    -- �������� ���� �� �ִ� �ִ밪�� ����
    �� MINVALUE N
    -- �������� ���� �� �ִ� �ּҰ��� ����
    �� CYCLE | NOCYCLE
    -- ������ ������ ���� �ִ밪���� ������ �Ϸ�ǰ� �Ǹ� �ٽ� START WITH �ɼǿ� ������
       ���� ������ �ٽ� �������� ������
    -- NOCYCLE�� ���¿��� �ִ밪�� �����ٸ� ������ �߻���
    �� CACHE | NOCACHE
    -- �޸𸮿� �̸� ���� �Ҵ��� ���Ƽ� �ӵ��� ����
    
    -- NEXTVAL : ���� ���� �˾Ƴ� || CURRVAL : ���� ���� �˾Ƴ�
    -- ��, NEXTVAL�� ���ο� ���� ������ ���� �� ���� CURRVAL�� ������
       ���� ���θ��� �������� NEXTVAL�� ������� �ʰ� �ٷ� CURRVAL�� �ϸ� ������
       
    < NEXTVAL, CURRVAL�� ����� �� �ִ� ��� >
    �� ���������� �ƴ� SELECT ��
    �� INSERT ���� SELECT ��
    �� INSERT ���� VALUE ��
    �� UPDATE ���� SET ��
    
    < NEXTVAL, CURRVAL�� ����� �� ���� ��� >
    �� VIEW�� SELECT ��
    �� DISTINCT Ű���尡 �ִ� SELECT ��
    �� GROUP BY, HAVING, ORDER BY ���� �ִ� SELECT ��
    �� SELECT, DELETE, UPDATE�� ��������
    �� CREATE TABLE, ALTER TABLE ����� DEFAULT ��
    
    -- ���� : DROP SEQUENCE ��������;
    -- ���� : ALTER SEQUENCE �������� ... ;
*/
DROP SEQUENCE EMP_SEQ;
CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 999
CYCLE;

DROP SEQUENCE DEPT_SEQ;
CREATE SEQUENCE DEPT_SEQ
START WITH 10
INCREMENT BY 10
MAXVALUE 999
CYCLE;

SELECT EMP_SEQ.NEXTVAL
FROM DUAL;

SELECT EMP_SEQ.CURRVAL
FROM DUAL;

SELECT DEPT_SEQ.NEXTVAL
FROM DUAL;

SELECT DEPT_SEQ.CURRVAL
FROM DUAL;

-- ������ �����ͻ������� ������ ��ȸ
SELECT * FROM user_sequences;

DROP SEQUENCE EMP_SEQ;
DROP SEQUENCE DEPT_SEQ;

SELECT * FROM user_sequences;

SELECT * FROM DEPT;

-- �μ� ���̺� ����
-- �ڽ� ���̺���� DROP�ϰ�, CREATE�� �θ����
DROP TABLE EMP;
CREATE TABLE DEPT(
    DEPTNO      NUMBER(3),
    DEPT_NAME   VARCHAR2(50) CONSTRAINT DEPT_DEPT_NAME_NN NOT NULL,
    LOC         VARCHAR2(50),
    CONSTRAINT DEPT_DEPT_NO_PK PRIMARY KEY(DEPTNO)
);

-- ��� ���̺� ����
CREATE TABLE EMP(
    EMPNO   NUMBER,
    ENAME   VARCHAR2(20) NOT NULL,
    HIRE_DATE   DATE    DEFAULT SYSDATE,
    SALARY  NUMBER CHECK(SALARY>0),
    DEPTNO NUMBER,
    EMAIL VARCHAR2(60),
    PRIMARY KEY(EMPNO),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO) ON DELETE CASCADE,
    UNIQUE(EMAIL)
);

-- DEPT ������ ����
INSERT into dept
values(dept_seq.nextval, 'IT1', '�ÿ�Ʋ');
INSERT into dept
values(dept_seq.nextval, 'IT2', '�ɶ���');
INSERT into dept
values(dept_seq.nextval, 'IT3', '����');
INSERT into dept
values(dept_seq.nextval, 'IT4', '������');
INSERT into dept
values(dept_seq.nextval, 'IT5', '�ĸ�');
INSERT into dept
values(dept_seq.nextval, 'IT6', '����');
INSERT into dept
values(dept_seq.nextval, 'IT7', 'ȫ��');
INSERT into dept
values(dept_seq.nextval, 'IT8', '������ī');
INSERT into dept
values(dept_seq.nextval, 'IT9', '�߱�');
INSERT into dept
values(dept_seq.nextval, 'IT10', '����Ȧ��');

-- EMP ������ ����
insert into emp
values(emp_seq.nextval, 'ȫ�浿1', '19/01/01', 10000, dept_seq.nextval, 'hong1@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿2', '19/02/01', 20000, dept_seq.nextval, 'hong2@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿3', '19/03/01', 30000, dept_seq.nextval, 'hong3@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿4', '19/04/01', 40000, dept_seq.nextval, 'hong4@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿5', '19/05/01', 50000, dept_seq.nextval, 'hong5@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿6', '19/06/01', 60000, dept_seq.nextval, 'hong6@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿7', '19/07/01', 70000, dept_seq.nextval, 'hong7@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿8', '19/08/01', 80000, dept_seq.nextval, 'hong8@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿9', '19/09/01', 90000, dept_seq.nextval, 'hong9@naver.com');
insert into emp
values(emp_seq.nextval, 'ȫ�浿10', '19/10/01', 100000, dept_seq.nextval, 'hong10@naver.com');
SELECT
    *
FROM dept;
SELECT
    *
FROM emp;
commit;

/*  �� ��ȸ�� ���� ����� ���� �ε���
    -- �ε����� �˻� �ӵ��� ����Ű�� ���ؼ� ���
    -- �ε��� ��ü�� ���� ������ USER_COLUMNS�� USER_IND_COLUMNS ������ ������ ���ؼ� ���캼 �� ����
    -- �⺻Ű�� ����Ű�� �ε����� �ڵ����� ������
    [ ���� ] 
    -- ����
    CREATE INDEX index_name
    ON table_name[column_name];
    -- USER_IND_COLUMNS ������ �������� �ε��� ���� Ȯ���ϱ�
    SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
    FROM USER_IND_COLUMNS
    WHERE TABLE_NAME IN ('�빮�� ���̺��');
    -- ����
    DROP INDEX index_name;
    
    < �ε��� ���� >
    -- �����ε��� / �� ���� �ε��� / ���� �ε��� / ���� �ε��� / �Լ���� �ε���
*/

create TABLE DEPT_IDX
AS 
SELECT * FROM DEPT;

CREATE TABLE EMP_IDX
AS
SELECT * FROM EMP;

-- 1) ���� �ε��� : �⺻Ű�� ����Űó�� ������ ���� ���� �÷��� �����ϴ� �ε���
--                 UNIQUE INDEX�� ����Ѵ�.
CREATE UNIQUE INDEX IDX_DEPT_DEPTNO
ON DEPT_IDX(DEPTNO);

-- 2) �� ���� �ε��� : �ߺ��� �����͸� ���� �÷��� ���ؼ� �����ϴ� �ε���(UNIQUE ���̸� ������)
CREATE INDEX IDX_EMP_ENAME
ON EMP_IDX(ENAME);

-- 3) ���� �ε��� : �ΰ� �̻��� �÷����� �ε����� �����Ѵ�.
CREATE INDEX IDX_DEPT_COM
ON DEPT_IDX(DEPT_NAME, LOC);

--- 1,2,3�� �� ����ϴ� ����

SELECT
 *
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP_IDX');

-- 4) �Լ���� �ε���
CREATE INDEX IDX_EMP_SALARY
ON EMP_IDX(SALARY * 12);

/*  �� �ε��� ��뿩�θ� �����ϱ� ���� ����
    
    < �ε����� ����ؾ� �ϴ� ��� >
    �� ���̺� ���� ���� ���� ��
    �� WHERE ���� �ش� �÷��� ���� ���� ��
    �� �˻������ ��ü �������� 2%~4% ���� �� ��
    �� JOIN�� ���� ���Ǵ� �÷��̳� NULL�� �����ϴ� �÷��� ���� ���
    
    < �ε����� ������� ���ƾ� �ϴ� ��� >
    �� ���̺� ���� ���� ���� ��
    �� WHERE ���� �ش� �÷��� ���� ������ ���� ��
    �� �˻������ ��ü �������� 10~15% �̻��� ��
    �� ���̺� DML �۾��� ���� ��� ��, �Է� ���� ���� ���� ���� �Ͼ ��
*/