-- 'IT' ���Ե� �μ����� ���� �μ��� ���, �̸�(last_name, first_name)
-- �Ի���, �μ��ڵ�, �μ��� ���
select e.employee_id, e.first_name || ' ' || e.last_name as �̸�
    , e.hire_date, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.department_name like '%IT%';

-- country_id�� 'US'�� ������ country_id, �����, ����ID, ������
select
    c.country_id,
    c.country_name,
    r.region_id,
    r.region_name
from countries c, regions r
where c.region_id = r.region_id
and c.country_id like '%US%';

select
    c.country_id,
    c.country_name,
    r.region_id,
    r.region_name
from countries c join regions r
on c.region_id = r.region_id
where c.country_id like '%US%';

-- 'Seattle'�̶�� city���� �׹��ϴ� ����� ���, last_name, �μ���, salary, city ���
select
    e.employee_id
    , e.last_name
    , d.department_name
    , e.salary
    , l.city
from locations l, departments d, employees e
where e.department_id = d.department_id
and d.location_id = l.location_id
and l.city like '%Seattle%';

-- ���� ���̺� join�� join on join on join on �̷��� �ؾ��Ѵ�.
select
    e.employee_id
    , e.last_name
    , d.department_name
    , e.salary
    , l.city
from departments d join employees e
on e.department_id = d.department_id
join locations l
on d.location_id = l.location_id
where l.city like '%Seattle%';

-- �μ��ڵ尡 100���� ����� ���, last_name, �μ��ڵ�, �μ���, job_title, min, max
select
    e.employee_id ���
    , e.last_name �̸�
    , d.department_id �μ��ڵ�
    , d.department_name �μ���
    , j.job_title �����̸�
    , j.min_salary �ּұ޿�
    , j.max_salary �ִ�޿�
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and d.department_id = 100;


-- ����� 101��, job_history�� start_date�� '97/09/21'�� ����� ���, last_name,
-- �μ�����, ��ġ����, ��������, ��������, �������� ��������
select e.employee_id, e.last_name
    , d.*
    , l.*
    , c.*
    , r.*
    , j.*
    , h.*
from employees e join departments d
on e.department_id = d.department_id
join jobs j
on e.job_id = j.job_id
join locations l
on l.location_id = d.location_id
join countries c
on c.country_id = l.country_id
join regions r
on r.region_id = c.region_id
join job_history h
on h.employee_id = e.employee_id
where e.employee_id = 101
and h.start_date = to_date('19970921','yyyy-mm-dd');
    
/*
    SELF JOIN
    - �ϳ��� ���̺� �ִ� Į������ �����ؾ� �ϴ� ������ �ʿ��� ��� ���
    - ���� ���̺��� �ϳ� �� �����ϴ� ��ó�� ������ �� �ֵ��� ���̺� ��Ī�� �����
    - ������̺��� MANAGER_ID�÷��� �ִµ� ��� �Ŵ�ó�� ����Ű�� ������ �Ѵ�.
    - ���� ���̺������� �Ŵ����� ����̹Ƿ� E.MANAGER_ID = M.EMPLOYEE_ID�� ������ ����
*/
-- 156�� �̶�� ����� ���, LAST_NAME, �Ŵ��� id, �Ŵ��� LAST_NAME
SELECT
    E.EMPLOYEE_ID ���
    , E.LAST_NAME �̸�
    , M.EMPLOYEE_ID "�Ŵ��� ��ȣ"
    , M.LAST_NAME "�Ŵ��� �̸�"
FROM employees E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
ORDER BY 1;

/*
    OUTER JOIN : EQUAL JOIN���� ���� Į�� �� ���� �ϳ��� NULL������ ���� �����
                 ����� �ʿ䰡 �ִ� ��� ���
    - NULL ���� ���� ���� ���� ����� ������� ����. NULL�� ���ؼ� � ������
      �����ϴ��� ����� NULL�̱� ����
    - ���� OUTER JOIN�� �̿��ϸ� NULL ���̱⿡ ������ ���� ����� ������ �� �ְ�,
      (+) ��ȣ�� ���� ���ǿ��� ������ ������ �÷��� �̸� �ڿ� ����
    - ������ RIGHT, LEFT, FULL�� �ִ�.
    
    - RIGHT OUTER JOIN : �� ����� ������ �����̸�, �������� �����Ͱ� ���� ��쿡 �ش��Ѵ�.
                         �ݵ�� ������ �Ǵ� ���� �����Ͱ� ��� ��µǾ�� �Ѵ�.
                         ���� ���̺� �÷� �ڿ�(+)�� �߰��Ѵ�.
    - LEFT OUTER JOIN  : �� ����� ���� �����̸�, ������ �����Ͱ� ���� ��쿡 �ش��Ѵ�.
                         �ݵ�� ������ �Ǵ� ���� �����Ͱ� ��� ��µǾ�� �Ѵ�.
                         ������ ���̺� �÷� �ڿ�(+)�� �߰��Ѵ�.                     
*/
-- 120~270�� �μ��� �ż��μ�
-- �μ����� ��� ���, LEFT OUTER JOIN, ��� ���̺��� �μ��� NULL�̾ �μ����̺��� �μ� ���
SELECT DISTINCT
    D.DEPARTMENT_ID "�μ��� �μ�" -- �μ���ȣ 10~270
    , E.DEPARTMENT_ID "����� �μ�" -- �μ���ȣ 10~110
    , D.DEPARTMENT_NAME "�μ���"
FROM employees E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID
ORDER BY 1;

-- OUTER JOIN, SELF JOIN�� �̿��Ͽ� �Ŵ����� ���� ����� �����Ͽ� ���, �����,
-- �Ŵ��� ID, �Ŵ��� �̸� ���
SELECT
    E.EMPLOYEE_ID ���,
    E.LAST_NAME �����,
    M.EMPLOYEE_ID �Ŵ�����,
    M.LAST_NAME �Ŵ�����
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID(+)
ORDER BY 1;

/*
    ��������
    -- �ϳ��� SELECT ������ �� �ȿ� ���Ե� �� �ϳ��� SELECT �����̴�.
       ���������� ���������� ����� ���� ��ȯ��
    - �������� : ���������� �����ϰ� �ִ� ������
    - �������� : ���Ե� �� �ϳ��� ������, �񱳿������� �����ʿ� ����ؾ��ϰ�,
                �ݵ�� ��ȣ �ȿ� �־���Ѵ�. ���������� ����Ǳ� ���� �ѹ��� �����
    - ���� : ������ ��������, ������ ��������
    + ������ �������� : �������� ���� �ϳ��� ROW(��, RECODE, TUPPLE)���� ��ȯ
            - ������ : >, <, >=, <=, =, <>
    + ������ �������� : �������� �ϳ� �̻��� ROW�� ��ȯ
            - ������ : IN, ANY, SOME, ALL, EXISTS
    - ����
    SELECT SELECT_LIST
     FROM TABLE
    WHERE EXPR OPERATOR (SELECT SELECT_LIST FROM TABLE WHERE .....);
*/
-- 'Jones' ���� �޿��� ���� �޴� ����� ���, �̸�, �޿�
SELECT EMPLOYEE_ID
    , LAST_NAME
    , SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME = 'Jones')
ORDER BY SALARY;

-- 'Chen'�� ���� �μ����� ���ϴ� ����� ���, �̸�, �μ���ȣ, �μ���
SELECT E.EMPLOYEE_ID
        , E.LAST_NAME
        , D.DEPARTMENT_ID
        , D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Chen')
ORDER BY EMPLOYEE_ID;

-- JOB_TITLE�� 'Programmer'�� ����� ���� �������� ���ϴ� �����, job_id, �޿� ���
select 
    last_name
    , job_id
    , salary
from employees
where job_id = (select job_id from jobs where job_title like '%Programmer%')
order by 1;

-- 2) ���� �� ��������
-- (1) IN Ȱ��
-- �μ��� �ּұ޿��� ���� �ϳ��� ��ġ�ϴ� ����� ���, �̸�, �޿�
SELECT 
    EMPLOYEE_ID
    , LAST_NAME
    , SALARY
FROM EMPLOYEES
WHERE SALARY IN (
    SELECT MIN(SALARY) FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID)
ORDER BY SALARY;
    
-- (2) ANY ������ : ���������� �������� ���������� ��°���� ���ؼ� �ϳ� �̻��� ��ġ�ϸ� ��
-- [ < ANI(���� ����) : ���� ���� �� �ִ밪 ���� �۳�? ]
-- [ > ANI(���� ����) : ���� ���� �� �ּҰ� ���� ũ��? ]

-- ������ 'ST_CLERK'�� �ƴϸ鼭, �޿��� 'ST_CLERK'�� �ִ밪���� ���� ��� ���
-- ����� ���, �̸�, JOB_ID, SALARY
SELECT
    EMPLOYEE_ID
    , LAST_NAME
    , JOB_ID
    , SALARY
FROM EMPLOYEES
WHERE JOB_ID <> 'ST_CLERK'
AND SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'ST_CLERK')
ORDER BY SALARY;

-- (3) ALL ������ : ���������� �������� ���������� �˻������ ���ؼ� ��� ���� ��ġ�ϸ� ��
-- [ < ALL(���� ����) : ���� ���� ���� ������? ]
-- [ > ALL(���� ����) : ���� ���� ���� ū��? ]

-- ������ 'PU_CLERK'�� �ƴϸ鼭, �޿��� 'PU_CLERK'�� �ּҰ����� ���� ��� ���
-- ����� ���, �̸�, JOB_ID, SALARY
SELECT
    EMPLOYEE_ID
    , LAST_NAME
    , JOB_ID
    , SALARY
FROM EMPLOYEES
WHERE JOB_ID <> 'PU_CLERK'
AND SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'PU_CLERK')
ORDER BY SALARY;

-- (4) EXISTS : IN�� ���� <--> NOT EXISTS(���� ������ ��ȸ)
-- DML�̶� ���� �� �� Ȱ���ϱ� ����(EX> ����� �����ϸ� �μ��� �ż�)

-- ������ ������� ������ �Ǹ��� ǰ���� ������ / ������ ������ �ʿ䰡 ����
-- �� : CUSTOMER
-- ���� : SALE
select
    totalSale
from order o
where exists (select customer_id
                from customers
               where customers.cus_id = o.cus_id);

-- �μ��� 100�� �̻��̰ų� �޿��� 10000�� �̻��� ������� ���, �μ���ȣ, �޿��� ���
select 
    employee_id
    , department_id
    , salary
from employees
where (department_id, salary) in (select department_id, salary
                                    from employees
                                    where department_id > 100
                                    or salary > 10000);
                                    