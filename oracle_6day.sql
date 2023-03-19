/*  �� ���տ�����
    1. intersect ������(������) ..
    ���� ��å�� ���� ��å�� ������ ���
    �� ������ ����� ���� ������, ����� ���� ������ ������ ���.. �İ�
    �� ���� �ٹ� emplotees, ���� ���� ��� job_history
    �� ���� �� ���̺��� ������ �� �ߺ���
*/
select
    employee_id, job_id
from employees
intersect
select
    employee_id, job_id
from job_history;

-- 2. minus (������)
--������ �ƴѰ� ã��(������̺��� 200�� 176����)
select
    employee_id, job_id
from employees
minus
select
    employee_id, job_id
from job_history;

-- 3. union ������(������) : �ߺ��� X or �ߺ��� O �ߺ����� ������ �� ������ ���� ��ȯ
-- ��� ����� ���� �� ���� ���� ���λ����� ��ȸ�ϵ�, �� ����� ������ �ѹ��� ��ȸ
select
    employee_id, job_id
from employees
union
select
    employee_id, job_id
from job_history;
-- 117�� -> 2���� �ߺ��� ���� -> 115��

-- 3. union all ������(������) : �ߺ��� ���� ����
-- ��� ����� ���� �� ���� ���� ���λ����� ��ȸ
select
    employee_id, job_id
from employees
union all
select
    employee_id, job_id
from job_history;

-- union ������ �̿��� ��ġ id, �μ��̸�, �ش�μ��� ��ġ�� ǥ��
select
    location_id, department_name, to_char(null)
from departments    -- 27
union
select
    location_id, to_char(null), locations.city
from locations;     -- 23
-- �������� ���� A,B a���� ���µ� b���� ������ null�� �־ ���� �����ش�.
-- order by �ÿ��� �� �Ʒ��� �Ѵ�.

-- �並 Ȱ���ؼ� TOM-N ���ϱ�
-- �Ի����� ���� ������ 5�� ���(�ζ��� ��)
SELECT 
    ROWNUM,
    EMPLOYEE_ID,
    LAST_NAME,
    HIRE_DATE,
    SALARY
FROM (SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE)
WHERE ROWNUM <= 5
AND HIRE_DATE IS NOT NULL;
-- EX) 1P 1~10 2P 11~20 3P 21~30 (START_NUM�� END_NUM ���)

-- �޿��� ���� ������� ������� 10�� ���(�ζ��� ��)
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM (SELECT * FROM EMPLOYEES ORDER BY SALARY)
WHERE ROWNUM <= 10
AND SALARY IS NOT NULL;

/*  �� �м��Լ� !!!!!
    ���� : �׷캰�ΰ� �ƴ� ���SET�� �� �ึ�� �������� �����ش�.
           �� �׷캰 ������� �� �ึ�� �����ִ� ��
    -- OVER : �м��Լ����� ��Ÿ���� Ű����
    -- PARTITION BY : ��� ��� �׷��� ����
*/
-- ������ ���Ϻμ��� �޿��ղ�.. HR�������� ����
SELECT
    DEPARTMENT_ID, EMPLOYEE_ID, SALARY, SUM(SALARY) 
    OVER(PARTITION BY DEPARTMENT_ID) S_SAL
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID;

/*  �� �����Լ�
    -- RANK �Լ� : ������ �ο��ϴ� �Լ�, ���ϼ��� ó���� ����
    (�ߺ����� ���� ������ �ǳʶ� - 1, 2, 2, 4, 5)
    -- DENSE_RANK �Լ� : ���� ����� ������ ������ ���� ����
    (�ߺ����� ���� ������ ���� - 1, 2, 2, 3, 4)
    -- ROW_NUMBER �Լ� : Ư�� ������ �Ϸù�ȣ�� �����ϴ� �Լ�, ���ϼ��� ó�� �Ұ�
    (�ߺ����� ���� ���ϰ� - 1,2,3,4)
    ** �����Լ� ���� ORDER BY���� �ʼ��� �Է�
    
    -- NTILE(�з�) : ������ ����� N���� �׷����� �з��ϴ� ����� ����, �������ڸ�ŭ �з���
    -- [ ���� ] NTILE(�з�����)    
*/

-- �޿��� ���� ������� ���� ���ϱ�
SELECT
    DEPARTMENT_ID,
    EMPLOYEE_ID,
    SALARY,
    RANK() OVER(ORDER BY SALARY DESC) "RANK"
FROM EMPLOYEES;

-- �����Լ� ��
select
    DEPARTMENT_ID,
    EMPLOYEE_ID,
    SALARY,
    RANK() OVER(ORDER BY SALARY DESC),
    DENSE_RANK() OVER(ORDER BY SALARY DESC),
    ROW_NUMBER() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEES;

-- �����Լ� -- NTILE(�з�)
select
    EMPLOYEE_ID,
    NTILE(2) OVER(ORDER BY EMPLOYEE_ID) GRP2, -- ��ü�� 2������� ������ 1, 2 ǥ��
    NTILE(3) OVER(ORDER BY EMPLOYEE_ID) GRP2, -- ��ü�� 3������� ������ 1,2,3 ǥ��
    NTILE(5) OVER(ORDER BY EMPLOYEE_ID) GRP2 -- ��ü�� 5������� ������ 1,2,3,4,5 ǥ��
FROM EMPLOYEES;
-- ��޳����� �� �� �Һз��� ���� ��

/*  �� ������ �Լ�
    -- �м��Լ� �߿��� ���������� ����ϴ� �Լ��� ������ �Լ���� ��
    -- ���������� ����ϰ� �Ǹ� PARTITION BY ���� ��õ� �׷��� �� �� ���������� �׷��� �� �� �յ�.
    -- �������� �м��Լ� �߿��� �Ϻ�(AVG, COUNT, SUM, MAX, MIN)�� ����� �� �ִ�.
    -- ROWS  : �������� ROW ������ �� ������ �����Ѵ�.
    -- RANGE : ������ �������� �� ������ �����Ѵ�.
*/
-- ROWS ��뿹��
-- �μ���(PARTITION BY DEPARTMENT_ID)�� ���� ROW(ROW 1 PRECEDING)�� �޿���
-- ���� ROW�� �޿��հ踦 ���
-- ROWS 2 PRECEDING -> ���� + ���� + �� ����
SELECT
    EMPLOYEE_ID,
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY,
    SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY EMPLOYEE_ID
                        ROWS 2 PRECEDING) PRE_SUM
FROM EMPLOYEES;

/*  �� RANGE ��뿹�� .. �ַ� ��¥�� ��
    -- ���������ý��ۿ��� �м�ȭ�鿡 ������, �����, �б⺰ �հ�, ...
    -- WITH AS : ���ν��� ���
    -- 7���� �����Ͱ� �����Ƿ� ���� 3���� �հ�� 8������ ��� 5,6�� �δ�ġ�� ����
    -- 201801�� ��� AMT_PRE3�� NULL�� ������ ���� 3������ ���� ����
    -- 201812�� ��� AMT_PRE3�� NULL�� ������ ���� 3������ ���� ����
*/
WITH TEST AS
(
    SELECT '201801' YYYYMM, 100 AMT FROM DUAL
    UNION ALL SELECT '201802' YYYYMM, 200 AMT FROM DUAL
    UNION ALL SELECT '201803' YYYYMM, 300 AMT FROM DUAL
    UNION ALL SELECT '201804' YYYYMM, 400 AMT FROM DUAL
    UNION ALL SELECT '201805' YYYYMM, 500 AMT FROM DUAL
    UNION ALL SELECT '201806' YYYYMM, 600 AMT FROM DUAL
    UNION ALL SELECT '201807' YYYYMM, 700 AMT FROM DUAL
    UNION ALL SELECT '201808' YYYYMM, 800 AMT FROM DUAL
    UNION ALL SELECT '201809' YYYYMM, 900 AMT FROM DUAL
    UNION ALL SELECT '201810' YYYYMM, 100 AMT FROM DUAL
    UNION ALL SELECT '201811' YYYYMM, 200 AMT FROM DUAL
    UNION ALL SELECT '201812' YYYYMM, 300 AMT FROM DUAL
)
select yyyymm, amt,
    sum(amt) over(order by to_date(yyyymm,'yyyymm')
            range BETWEEN interval '3' month preceding
                    and   interval '1' month preceding) amt_pre2 -- ���� 3���� (����� ������)
,   sum(amt) over(order by to_date(yyyymm,'yyyymm')
            range BETWEEN interval '1' month following
                    and   interval '3' month following) amt_pre3 -- ���� 3����(����� ������)
from test;
-- interval '����' <���ϰ���� ��(��/��/��)> => �ش� ��/��/�⵵ ���ϱ�
-- 2�� ���ÿ� ������ hour to minute / minute to second ���� �ϸ� ��

/*  �� ROLLUP / CUBE  - �߿� -
    -- GROUP BY ������ ����� �Ұ� �� �հ������� �߰��� ��Ÿ���ִ� �Լ�
    -- ROLLUP   : �ܰ躰 �Ұ�(���� ��)
    -- CUBE     : ��� ����� ���� ���� �Ұ�(�� �Ⱦ�)
*/

-- ROLLUP ����1
-- �μ��� �޿� �հ�� ��ü �հ踦 ��ȸ
-- ���1. �Ѿ� ���
SELECT
    DEPARTMENT_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID);

-- ���2. ���Ͽ� �� ���
SELECT
    DEPARTMENT_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
UNION ALL
SELECT
    NULL DEPARTMENT_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID;

-- ROLLUP ����2
-- �μ��� ����� �޿��� �Ұ�(���� �հ�), ��ü�հ�(�Ѱ�)�� ��ȸ
SELECT 
    DEPARTMENT_ID,
    EMPLOYEE_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY ROLLUP(DEPARTMENT_ID, EMPLOYEE_ID);
-- ROLLUP ������ ���� �տ� ���°� �Ұ� ������ ��

-- ROLLUP ����3, �߿�!
-- �μ���, JOB_ID�� �޿��� ���� �� �հ�
-- �μ� �Ұ� �޿� �հ� ������ �հ�
SELECT
    D.DEPARTMENT_NAME,
    JOB_ID,
    SUM(SALARY),
    COUNT(E.EMPLOYEE_ID)
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND E.DEPARTMENT_ID IS NOT NULL
GROUP BY ROLLUP(D.DEPARTMENT_NAME, JOB_ID);



 