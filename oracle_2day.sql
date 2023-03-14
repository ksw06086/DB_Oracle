/*
    WHERE ���� �̿��� ���� �˻�
    - SELECT *
        FROM table��
      WHERE ����;
      -- ���ǹ��� �÷���, ������ ����� �� �� �ִ�.
      -- ���ڿ� ��¥ Ÿ���� ������� �ݵ�� ��������ǥ('')�� ���´�.
      -- '����', '������' ��ҹ��� ����
*/
-- LAST_NAME�� KING�� ����� ���, LAST NAME ��ȸ
SELECT EMPLOYEE_ID, LAST_NAME
FROM employees
WHERE LAST_NAME = 'King';

-- SALARY�� 11000�̻��� ����� ���, LAST_NAME, SALARY
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM employees
WHERE SALARY >= 11000
ORDER BY 3;

-- ������̺��� JOB_ID�� SA_MAN�̰ų� FI_ACCOUNT�� ����� ���, JOB_ID
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES
WHERE JOB_ID IN ('SA_MAN', 'FI_ACCOUNT');

-- �Ի���(HIRE_DATE)�� 2002�⵵ �̸鼭, �޿��� 10000�̻��� ����� ���, �Ի���, �޿� ��ȸ
SELECT EMPLOYEE_ID, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '2002%'
AND SALARY >= 10000;

/*
    �÷��� BETWEEN A AND B : �÷��� ���� A�� B����
    �÷��� NOT BETWEEN A AND B : �÷��� ���� A�� B���̰� �ƴ� ���
*/
-- �Ի���(HIRE_DATE)�� 2002�⵵�̸鼭, �޿��� 10000�̻��� ����� ���, �Ի���, �޿� ��ȸ
SELECT 
    EMPLOYEE_ID, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE hire_date BETWEEN '2002/01/01' and '2002/12/31'
AND SALARY >= 10000;

-- SALARY�� 10000~15000������ ����� ���, SALARY
SELECT
    EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 15000
ORDER BY 2;

-- SALARY�� 10000~15000 ���̸� ������ ����� ���, SALARY
SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 10000 AND 15000
ORDER BY 2;

-- ������̺��� �μ� ID�� 10,20,30,40,50�� ����� �μ� ID(�� �ߺ�����)
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES
WHERE department_id IN (10,20,30,40,50);

/*
    LIKE �����ڿ� ���ϵ� ī��
    -- �÷��� LIKE PATTER
    -- PATTER : 2���� �͟�� ī��
    -- ���ϵ�ī�� : % => �ϳ� �̻��� ���ڰ� � ���� �͵� �������.
                   _ => �ϳ��� ���ڰ� � ���� �͵� �������.
*/
-- LAST_NAME�� 3��°, 4��° �ܾ 'TT'�� ����� LAST_NAME
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '__tt%';

-- OR SUBSTR(LAST_NAME, 3, 4) = 'tt';

-- ������̺��� JONES�� ���Ե� EMAIL
SELECT EMAIL
FROM EMPLOYEES
WHERE INSTR(EMAIL, 'JONES') != 0;
-- OR EMAIL LIKE '%JONES%';

-- JOB ���̺��� REP ���Ե� JOB_ID
SELECT JOB_ID
FROM JOBS
WHERE JOB_ID LIKE '%REP%';
-- OR WHERE INSTR(JOB_ID, 'REP');

/*
    ������ ���� ORDER BY ��
    -- SELECT���� WHERE�� �ڿ� �´�.
    -- ORDER BY �÷��� SORTING
        ASC(��������),                  DESC(��������)
    -  ���� : �� -> ū                  ū -> ��
    -  ���� : ��������(�� -> ��)        ��������(��->��)
    -  ��¥ : ������¥ -> �ֱ�����       
*/
-- Salary �������� ��������, ���, salary ��ȸ, �� salary�� 15000�̻��� ���
select employee_id, salary
FROM employees
WHERE SALARY >= 15000
ORDER BY SALARY;

-- SALARY �������� ��������, ���, SALARY ��ȸ
-- �� SALARY�� 5000�̸�, ��� 140~160
SELECT
    EMPLOYEE_ID, SALARY
FROM employees
WHERE SALARY < 5000
AND EMPLOYEE_ID BETWEEN 140 AND 160
ORDER BY SALARY desc;

-- �޿��� ���� ������� ����ϵ�, ���Ͻ� commission_pct�� ���� ������� ���
-- �� �޿��� 10000�̻�, commission_pct�� null�� �ƴ� ���
select salary, commission_pct
from employees
where salary >= 10000
and commission_pct is not null
order by salary desc, commission_pct asc;

/*
    01. �����Լ�
    -- lower : �ҹ��� ��ȯ
    -- upper : �빮�� ��ȯ
    -- initcap : ù���ڸ� �빮�ڷ� ������ ���ڴ� �ҹ��ڷ� ��ȯ
*/
select last_name
from employees
where last_name = initcap('king');

select email
from employees
where email = upper('kgee');

select 'welcome TO oracle',
upper('welcome TO oracle'),
lower('welcome TO oracle'),
initcap('welcome TO oracle')
from dual;

-- last_name�� King, Lee�� ����� last_name, job_id��ȸ
-- �� job_id�� ù���ڸ� �빮�ڷ�
select last_name, initcap(job_id)
from employees
where last_name in ('King', 'Lee');

/*
    -- length ���ڱ��� ��ȯ(�ѱ�, ���� ��� 1���ڴ� 1)
    -- lengthb ���ڱ��̸� byte�� ���� ��ȯ(�ѱ� -> 3byte)
*/

select
    length('Oracle'),
    length('����Ŭ'),
    lengthb('Oracle'),
    lengthb('����Ŭ')
from dual;

/*
    * ���� ó�� �Լ�(���� ���� �Լ�)
    concat      : ������ ���� �����Ѵ�.
    substr      : ���ڸ� �߶� �����Ѵ�.(�ѱ� 1byte)
    substrb     : ���ڸ� �߶� �����Ѵ�.(�ѱ� 2byte)
    instr       : Ư�������� ��ġ ���� ��ȯ�Ѵ�.(�ѱ� 1byte)
    instrb      : Ư�������� ��ġ ���� ��ȯ�Ѵ�.(�ѱ� 2byte)
    lpad, rpad  : �Է¹��� ���ڿ��� ��ȣ�� �����Ͽ� Ư�������� ���ڿ��� ��ȯ
    trim        : �߶󳻰� ���� ���ڸ� ǥ��
*/
/*
    concat - ���ڿ� ���� �Լ� / ||�� ����
*/

-- '01/01/13'�� �Ի��� ����� ���, �Ի���, �̸�
-- �Ի��� : '2001/01/13', �̸� : firstname + lastname
select employee_id ���, hire_date �Ի���, first_name || ' ' || last_name �̸�
from employees
where hire_date = '2001/01/13';

/*
    substr - ���� ���ڿ����� �Ϻ� ��������
    ���� - substr(���, ������ġ, ���ⰳ��)
    �� ������ġ�� ����� ��� ���� 1���� �����ϰ�, ������ ��� ���ʺ��� �����Ѵ�.
*/
select
    substr('welcome to korea', 4, 4)
from dual;

select
    substr('welcome to korea', -8, 2)
from dual;

select
    substr('����Ŭ�ŴϾ�', 3, 4)
from dual;

select
    substr('����Ŭ�ŴϾ�', 4, 6)
from dual;

-- �Ի�⵵�� 04�⵵�̰ų� 06�⵵�� ����� ���, �Ի��� (----�� --�� --��)
select
    employee_id ���,
    substr(hire_date, 1, 4) || '��',
    substr(hire_date, 6, 2) || '��',
    substr(hire_date, 9, 2) || '��'
from employees
where substr(hire_date, 1, 4) in (2004, 2006)
order by 2;

/*
    INSTR : ���ڿ� ���� �ش繮�ڰ� ��� ��ġ�� �����ϴ����� �˷���
    ���� : INSTR(���, ã������, ������ġ, ���° �߰�)
    ������ġ�� ���° �߰��� ������ ��� 1�� �����Ѵ�.
*/

-- 'Oracle mania'���� a�� 1��° ���� ����, 1��° �߰ߵ� ��ġ
select
    instr('Oracle mania', 'a', 1, 1)
FROM dual;

-- 'Oracle mania'���� a�� 1��° ���� ����, 2��° �߰ߵ� ��ġ
select
    instr('Oracle mania', 'a', 1, 2)
FROM dual;

-- 'Oracle mania'���� a�� 1��° ���� ����, 3��° �߰ߵ� ��ġ
select
    instr('Oracle mania', 'a', 1, 3)
FROM dual;

-- ������̺��� last_name�� 3��° ���ڰ� 'a'�� ��쿡 last_name, ��ġ��
select
    last_name, instr(last_name, 'a', 3, 1) 
from employees
where last_name like '__a%';

/*
    lpad : Į���̳� ��� ���ڿ��� ��õ� �ڸ������� �����ʿ� ��Ÿ����, ���� ���� �ڸ��� Ư�� ��ȣ�� ä��
    rpad : ��� ���ڿ��� ��õ� �ڸ������� ���ʿ� ��Ÿ����, ���� ������ �ڸ��� Ư�� ��ȣ�� ä��
*/
-- �޿�(15)�� ������ *, �̸�(20)�� �������� ^�� ä���.
select employee_id, lpad(salary, 15, '*') �޿�, rpad(last_name, 20, '^') �̸�
from employees;

/*
    TRIM : Ư�� ���ڸ� �߶󳽴�.. �ַ� ������ ����
            Į���̳� ��� ���ڿ����� �߶󳻰� ���� ���ڿ��� ��ȯ
    -- LTRIM : ���ڿ��� ������ ���� ���ڵ��� �����Ѵ�.
    -- RTRIM : ���ڿ��� �������� ���� ���ڵ��� �����Ѵ�.
    -- TRIM  : ���ڿ��� �յ��� ���� ���ڵ��� �����Ѵ�.
*/
SELECT '        ORACLE 11G        ',
LTRIM('        ORACLE 11G        '),
RTRIM('        ORACLE 11G        '),
TRIM('        ORACLE 11G        ')
FROM DUAL;

/*
    * ���� �Լ�
    ROUND : Ư���ڸ������� �ݿø��Ѵ�.
    TRUNC : Ư���ڸ������� �߶󳽴�(����).
    MOD   : �Է¹��� ���� ���� ������ ���� ��ȯ�Ѵ�.
*/
-- ROUND �Լ�
SELECT ROUND(98.7654, 2), -- 98.77 
    ROUND(98.7654, 0),    -- 99
    ROUND(98.7654, -1)    -- 100
FROM DUAL;

-- MOD �Լ�
SELECT MOD(27,2), MOD(27,5)
FROM DUAL;

-- ABS �Լ� : ���밪
SELECT ABS(-10), -10
FROM DUAL;

-- FLOOR �Լ� : �Ҽ��� �Ʒ� ����
SELECT FLOOR(34.5678), 34.5678
FROM DUAL;

/*
    * ��¥ �Լ�
    SYSDATE         : �ý��� ����� ���� ��¥�� ��ȯ�Ѵ�.
    MONTHS_BETWEEN  : �� ��¥ ���̰� ������� ��ȯ
    ADD_MONTHS      : Ư�� ��¥�� �������� ���Ѵ�.
    NEXT_DAY        : Ư�� ��¥���� ���ʷ� �����ϴ� ���ڷ� ���� ������ ��¥�� ��ȯ
    LAST_DAY        : �ش� ���� ������ ��¥�� ��ȯ�Ѵ�.
    ROUND           : ���ڷ� ���� ��¥�� Ư�� �������� �ݿø��Ѵ�. ROUND(DATE, FORMAT)
    TRUNC           : ���ڷ� ���� ��¥�� Ư�� �������� ������.
*/
-- SYSDATE
SELECT
    SYSDATE ����,
    SYSDATE-1 ����,
    SYSDATE+1 ����,
    SYSDATE+2 ��
FROM DUAL;

-- ROUND : FORMAT�� 'MONTH'�� ��� : ���� �������� 16���� ������ �̹��� 1��, 16�̻��̸� ������ 1��
SELECT
    EMPLOYEE_ID
    , HIRE_DATE �Ի���
    , ROUND(HIRE_DATE, 'month') T_�Ի���
FROM employees;

-- �ٹ��ϼ�
SELECT
    EMPLOYEE_ID, ROUND(SYSDATE-HIRE_DATE, 0) �ٹ��ϼ�
FROM employees;

-- TRUNC : FORMAT�� 'MONTH'�� ��� : ���� �������� �ڸ�. �� ���� 1��
SELECT
    EMPLOYEE_ID
    , HIRE_DATE �Ի���
    , TRUNC(HIRE_DATE, 'month') T_�Ի���
FROM employees;

-- MONTHS_BETWEEN : ��¥�� ��¥ ������ ���� ���� ���ϴ� �Լ�
-- MONTHS_BETWEEN(DATE1, DATE2)
-- �ٹ������� ���ϱ�
SELECT
    EMPLOYEE_ID,
    HIRE_DATE �Ի���,
    MONTHS_BETWEEN(SYSDATE, HIRE_DATE) �ٹ�������
    , ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) R_�ٹ�������
    , TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) T_�ٹ�������
FROM employees;

-- ADD_MONTHS : Ư�� �������� ���� ��¥�� ���ϴ� �Լ�
-- ADD_MONTHS(DATE, NUMBER)
-- �Ի� 3����
SELECT EMPLOYEE_ID,
    HIRE_DATE �Ի���,
    ADD_MONTHS(HIRE_DATE, 3) "�Ի� 3���� ��"
FROM employees;

-- NEXT_DAY : �ش� ��¥�� �������� ���ʷ� �����ϴ� ���Ͽ� �ش��ϴ� ��¥�� ��ȯ�ϴ� �Լ�
-- NEXT_DAY(DATE, ����) / EX) 1:�Ͽ���, 2:������, ... 7:�����
SELECT 
    SYSDATE,
    NEXT_DAY(SYSDATE, '�ݿ���'),
    NEXT_DAY(SYSDATE, '�Ͽ���'),
    NEXT_DAY(SYSDATE, 6),
    NEXT_DAY(SYSDATE, 1)
FROM DUAL;

-- LAST_DAY : �ش� ��¥�� ���� ���� ������ ��¥�� ��ȯ�ϴ� �Լ�
SELECT
    EMPLOYEE_ID ���,
    HIRE_DATE �Ի���,
    LAST_DAY(HIRE_DATE) "�Ի��� ���� ������ ��"
FROM employees;

/*
    * �� ��ȯ �Լ�
    - ����Ŭ���� ������������ ��ȯ�ؾ��ϴ� ��쿡�� TO_NUMBER, TO_CHAR, TO_DATE�� ���
    -- TO_CHAR      : ��¥�� Ȥ�� �������� ���������� ��ȯ
    -- TO_DATE      : �������� ��¥������ ��ȯ
    -- TO_NUMBER    : �������� ���������� ��ȯ
*/

/*
    * TO_CHAR : ��¥ -> ����
    - TO_CHAR(��¥ ������, '�������')
    - ���� : �ǹ�
    + YYYY  : �⵵ǥ��(4�ڸ�)
    + YY    : �⵵ǥ��(2�ڸ�)
    + MM    : ���� ���ڷ� ǥ��
    + MON   : ���� ���ĺ����� ǥ��
    + DAY   : ���� ǥ��
    + DY    : ������ ���� ǥ��
*/
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DAY)'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD DY'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DY)')
FROM DUAL;

-- �ð�ǥ��
-- ���� -> AM | ���� -> PM
-- 12�ð� -> HH:MI:SS | 24�ð� -> HH24:MI:SS
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DY) HH:MI:SS'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DY) HH24:MI:SS')
FROM DUAL;

/*
    * TO_CHAR : ���� -> ����
    -- L : �� ������ ��ȭ��ȣ�� �տ� ǥ�� ��) �ѱ� : \
    -- , : õ ���� �ڸ� ������ ǥ��
    -- . : �Ҽ��� ǥ��
    -- 9 : �ڸ����� ��Ÿ��(�ڸ��� �ȸ¾Ƶ� 0���� ��ä����)
    -- 0 : �ڸ����� ��Ÿ��(�ڸ��� �ȸ����� 0���� ä����
*/
SELECT
    EMPLOYEE_ID, SALARY,
    TO_CHAR(SALARY, 'L9,999,999'),
    TO_CHAR(SALARY, 'L0,000,000')
FROM employees;

-- TO_DATE
-- TO_DATE('����', 'FORMAT')

-- �Ի����� 03/06/17 YYYY-MM-DD(����)�� ����� ���, �Ի���
SELECT EMPLOYEE_ID ���, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD (DY)')
FROM employees
WHERE HIRE_DATE = TO_DATE('20030617', 'YYYY-MM-DD');

-- �����ϼ�
SELECT TRUNC(SYSDATE - TO_DATE('20190617','YYYY-MM-DD')) �����ϼ�
FROM DUAL;

-- TO NUMBER : ������ -> ������ ��ȯ
SELECT 
    '1,000,000' - '5,000'
FROM DUAL;

SELECT
    TO_NUMBER('1,000,000', '999999999999999') - TO_NUMBER('5,000' , '99999')
FROM DUAL;

-- 1. NVL �Լ�
-- ������̺��� ���, �޿�, Ŀ�̼�, �󿩱�(�޿� * Ŀ�̼�) ���ϱ�
SELECT
    EMPLOYEE_ID, SALARY, COMMISSION_PCT �󿩺���, 
    NVL(COMMISSION_PCT, 0) * SALARY �ǻ󿩱�,
    SALARY*12 ����, SALARY*12 + SALARY*NVL(COMMISSION_PCT, 0) "���� �Ѿ�"
FROM employees
ORDER BY 4 DESC;

-- 2. NVL2 : EXPR1�� �˻��Ͽ� �� ����� ���̸� EXPR3�� ��ȯ�ϰ� ���� �ƴϸ� EXPR2�� ��ȯ
--    NVL2(EXPR1, EXPR2, EXPR3)
SELECT 
    EMPLOYEE_ID
    , SALARY
    , COMMISSION_PCT
    , NVL2(COMMISSION_PCT, SALARY*12 + SALARY*COMMISSION_PCT, SALARY*12) "���� �Ѿ�"
FROM employees;

-- 3. NULLIF : �� ǥ������ ���Ͽ� ������ ��쿡�� ��, �������� ������ ù��° ǥ���� ��ȯ
--    NULLIF(EXPR1, EXPR2)
SELECT
    NULLIF('A', 'A'),
    NULLIF('A', 'B')
FROM DUAL;

/* COALESCE
   - �μ��߿��� NULL�� �ƴ� ù ��° �μ��� ��ȯ
   - EXPR1�� NULL�� �ƴϸ� EXPR1 ��ȯ, 
     EXPR1�� NULL�̰� EXPR2�� NULL�� �ƴϸ� EXPR2 ��ȯ
   - COALESCE(EXPR1, EXPR2, ..., EXPRn)
*/
-- Ŀ�̼��� NULL�̰� �޿��� NULL�� �ƴϸ� SALARY�� ��ȯ�ϰ�, �Ѵ� NULL�̸� 0�� ���
SELECT 
    COMMISSION_PCT,
    SALARY,
    COALESCE(COMMISSION_PCT, SALARY, 0)
FROM employees;

------------------------------------------------------------------------------------

/*
    DECODE : ���ǿ� ���� �پ��� ���� ����
    - DECODE(ǥ����, ����1, ���1,
                    ����2, ���2,
                    ����3, ���3,
                    �⺻���N)
-- �ڹ��� SWITCH CASE ���� ����
*/
-- ��� ���̺��� �μ� ID�� 10~100������ ����� �μ����� ���
-- �� �ܴ� "�μ� ����"
-- �� �μ��ڵ尡 �ߺ����� �ʵ��� �ϸ�, �μ� ��ȣ�� �����Ѵ�. �μ���ȣ�� ������ ������� �ʴ´�.
/*
10	Administration
20	Marketing
30	Purchasing
40	Human Resources
50	Shipping
60	IT
70	Public Relations
80	Sales
90	Executive
100	Finance
110	Accounting
*/
select DISTINCT employee_id,
        decode(department_id, 10, 'Administration',
                                    20, 'Marketing',
                                    30, 'Purchasing',
                                    40, 'Human Resources',
                                    50, 'Shipping',
                                    60, 'IT',
                                    70, 'Public Relations',
                                    80, 'Sales',
                                    90, 'Executive',
                                    100, 'Finance',
                                    '�μ� ����') �μ���
from employees
where department_id is not null
order by 1;

/*
case : ���α׷� ����� if else if else�� ������ ������ ����
case ǥ���� when ����1 then ���1
            when ����2 then ���2
            when ����3 then ���3
            else ���n
end
*/
select distinct
    case department_id when 10 then '�����'
                        when 20 then '������'
                        when 30 then '�����'
                        when 40 then '������'
                        when 50 then '�ֿ���'
                        when 60 then '��ä��'
                        when 70 then '�����'
                        when 80 then '��ä��'
                        when 90 then '�����'
                        when 100 then '����'
                        else '������'
    end �������
from employees
where department_id is not null;

/*
    * �׷��Լ�
    ������ �׷� : GROUP BY
    �׷� ��� ���� : HAVING ��
    --------------------------------------------------------
    01. �׷��Լ�
    - ���̺��� ��ü �����Ϳ��� ������� ����� ���ϱ� ���ؼ� �� ���տ� �����Ͽ� �ϳ��� ����� ����
    - �׷��Լ��� �ٸ� �����ڿʹ� �޸� �ش� �÷����� NULL�� ���� �����ϰ� ����ϹǷ�
    - NULL�� ���Ե� �÷��� �ִ��� ����� NULL�� �ƴϴ�.
    ����      ����
    SUM:    �׷��� ���� �հ踦 ��ȯ
    AVG:    �׷��� ����� ��ȯ
    COUNT:  �׷��� �� ������ ��ȯ
    MAX:    �׷��� �ִ밪�� ��ȯ
    MIN:    �׷��� �ּҰ��� ��ȯ
*/
-- SUM
SELECT
    TO_CHAR(SUM(SALARY), 'L9,999,999') �޿��Ѿ�
FROM employees;

-- AVG
-- �޿���� : �Ҽ��� 3° �ڸ����� �ݿø�
SELECT
    TO_CHAR(ROUND(AVG(SALARY),2), 'L9,999,999') �޿����
FROM employees;
-- �޿���� : ����
SELECT
    TO_CHAR(ROUND(AVG(SALARY)), 'L9,999,999,999') R_�޿����, 
    TO_CHAR(FLOOR(AVG(SALARY)), 'L9,999,999,999') F_�޿���� 
FROM employees;

-- MAX, MIN
SELECT MAX(SALARY) �޿�MAX, MIN(SALARY) �޿�MIN
FROM employees;

-- �ֱ� �Ի���, ���� ������ �Ի���
SELECT
    TO_CHAR(MAX(HIRE_DATE)) "�ֱ� �Ի���",
    TO_CHAR(MIN(HIRE_DATE)) "���� ������ �Ի���"
FROM employees;

-- COUNT(*) : NULL ������ �� ��, �ߺ��� ���� ����Ͽ� ���õ� ��� ���� ī��Ʈ�� ����
-- ��� ��
SELECT
    COUNT(*) �����
FROM employees;

-- COUNT(�÷���) : NULL�� �ƴ� ���� ����
SELECT
    COUNT(COMMISSION_PCT) "Ŀ�̼��� �޴� ��� ��"
FROM employees;

SELECT
    COUNT(*) "Ŀ�̼��� �޴� ��� ��"
FROM employees
WHERE COMMISSION_PCT IS NOT NULL;

-- �ߺ� �ȵ� JOB_ID ����
SELECT
    COUNT(DISTINCT JOB_ID)
FROM employees;

-- ���, �ִ�޿�
SELECT
    EMPLOYEE_ID, MAX(SALARY)
FROM employees; -- ����

/*
    ������ �׷� : GROUP BY �÷��� - Ư�� Į���� �׷캰�� ����, WHERE �Ŀ� ��
    -- �׷��Լ��� �ƴ� SELECT ����Ʈ�� ��� �÷��� GROUP BY ���� �ݵ�� ����ؾ� �Ѵ�.
    -- �׷��� �ݴ�� GROUP BY���� ����� �÷��� �ݵ�� SELECT ����Ʈ�� �־�� �ϴ°� �ƴϴ�.
       ���� ����� ���ǹ��ϴ�.
    -- �׷��Լ��� �ι����� ��ø�ؼ� ��� �����ϴ�. ��) MAX(AVG(SALARY))
       �� SELECT LIST�� �Ϲ� �÷� ���Ұ� -> HAVING ���� ���� SUBQUERY�� Ȱ���Ѵ�.
*/
SELECT
    DEPARTMENT_ID, MAX(SALARY) "�μ��� �ִ�޿�"
FROM employees
GROUP BY department_id
ORDER BY 1;

SELECT
    DEPARTMENT_ID, MAX(AVG(SALARY)) "�μ��� �ִ� ��� �޿�"
FROM employees
GROUP BY department_id
ORDER BY 1; -- ����, �׷��Լ��� 2�� �������� ����

-- �μ���, ������ �ο���, �ִ�޿�, �ּұ޿�, �޿��հ�, �޿����
-- �μ�, ������ ��������(�� �μ��� NULL�̸� ��� ����)
SELECT
    DEPARTMENT_ID �μ�, JOB_ID ����
    , COUNT(JOB_ID) "������ �ο���", MAX(SALARY) �ִ�޿�
    , MIN(SALARY) �ּұ޿�, SUM(SALARY) �޿��հ�, AVG(SALARY) �޿����
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY 1, 2;

/* �׷� ��� ���� : HAVING ��
    
*/