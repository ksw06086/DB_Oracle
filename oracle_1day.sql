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



