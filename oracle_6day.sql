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
