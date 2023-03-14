-- ���̺� ���� ��ȸ
-- DESC[RiBE] ���̺��;
desc employees;

-- ���̺� ��� ��ȸ
select * from tab;

-- ������ ��ȸ
/* select �÷���1, �÷���2, ...
    from ���̺��
    where ���ǽ�
    order by �÷��� �Ǵ� �˻��� �÷� ���� ������ ������ȣ(ASC<����>/desc<����>)
*/
select * from employees
where employee_id = 206;

-- ����Ŭ ���ڴ� ' '�̴�.
-- job_id�� IT_PROG�� ��� ���, �̸�, �̸��� ��ȸ, ��� �������� ����
select employee_id, last_name, email from employees
where job_id = 'IT_PROG'
order by employee_id desc;

-- ������̺��� ���, last_name, salary ��ȸ(��, ����� 100��)
-- �÷��� ��Ī ���� : 1. �����߰� 2. AS�߰� 3. ""�� ��Ī ���α�
select employee_id, last_name, salary from employees
where employee_id = 100;

-- ������̺��� ���, �̸���, �޿� ��ȸ
-- (�� �޿��� 10000 �̻�, ��� 149) / salary ����, employee_id ����
select employee_id, email, salary
from employees
where salary >= 10000
and employee_id > 149
order by 3,1;

-- �μ����̺��� �μ�id, �μ��� ��ȸ(�� �μ����� IT�� ���)
select department_id, department_name
from departments
-- WHERE department_name = 'IT'
-- or department_name = 'Finance'
-- or department_name = 'Marketing'
where department_name in('IT', 'Finance', 'Marketing');

-- �������̺��� job_id�� ST�� �����ϰų� �ּұ޿��� 10000�̻��� ���� ��� ����
select
*
from jobs
where job_id like 'ST%'
or min_salary >= 10000
order by min_salary;

-- �ߺ��� �����͸� �ѹ����� ����ϰ� �ϴ� DISTINCT
-- �μ������� ��ü ����ϵ� �μ���ȣ�� ����
-- �ϳ��� ����ϰ� �ؼ� �����ϰų� ���ϸ� �ߺ��� �ȳ����µ� �ٸ� �� ���� ��ȸ�ϸ� ����
-- �ֳ��ϸ� �ڿ� �ڷ���� �ߺ��� �ƴϱ� ������ ��� �� ����
-- AND �������� �˰� ������ ��. �ϳ��� ���� ��ü �� �ߺ��� ������ ��
select distinct
    manager_id, department_id
from departments;

-- DUAL ���̺� : (�� ������ ����� ���)�ϱ� ���ؼ� �����Ǵ� ���̺�
-- DUMMY(VARCHAR2(1))��� �ϳ��� �÷����� �����Ǿ� �ִ�.
select
    *
from dual;
select
sysdate
from dual; -- ���糯¥
/*
    Null �����ڸ� �̿��� ���� �˻�
    Null�� ��Ȯ��, �˼� ���� ���� �ǹ��ϸ�, ����, �Ҵ�, �񱳰� �Ұ�����.
    IS NULL : �÷��� �߿��� NULL�� �����ϴ� ROW�� �˻��ϱ� ���� ������
    IS NOT NULL : �÷��� �߿��� NULL�� �������� �ʴ� ROW�� �˻��ϱ� ���� ������.
*/
-- WHERE �÷��� IS [NOT] NULL;
-- Ŀ�̼��� �޴� ����� ���, SALARY, Ŀ�̼�
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- �μ� ID�� NULL�� ����� ���, �μ�ID
SELECT EMPLOYEE_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- NVL : NULL�� ��� ��, ����, �Ҵ��� �Ұ����ϹǷ�, NULL�� ��� NVL�� �̿��� ��ü
/*
    NVL �Լ� : NULL�� 0 �Ǵ� �ٸ� ������ ��ȯ�Ѵ�.
    NVL(�÷��� | ǥ����, ��ü��);
    NULL : �������� �ʴ� ��, ����/�Ҵ�/�񱳰� �Ұ���
            ����� ���� �÷��� NULL���� �ٲ��.
            �ΰ��� ���� �ݵ�� ������ Ÿ���� ��ġ�ؾ��Ѵ�.
*/
-- ������̺��� ���, �޿�, Ŀ�̼�, �󿩱�(�޿�*Ŀ�̼�) ���ϱ�
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT, 
(NVL(COMMISSION_PCT, 0)*SALARY) AS �󿩱�,
SALARY * 12 ����, SALARY*12 + SALARY*NVL(COMMISSION_PCT,0) "���� �Ѿ�"
FROM employees;

-- ������̺��� ���, Ŀ�̼� ��ȸ(�� Ŀ�̼� �������� ����)
SELECT EMPLOYEE_ID, NVL(COMMISSION_PCT,0)
FROM EMPLOYEES
ORDER BY COMMISSION_PCT;

