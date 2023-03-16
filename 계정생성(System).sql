/*
cmd ����
������ hr ���� ����Ϸ���

1. sqlplus system/oracle�� ����

2. ������
   alter user hr account unlock;  

3. �н����� ����
   --alter user <�����̸�> identified by <�н�����>;
   alter user hr identified by tiger;

----------------------------------------
- [ ���ο� ���� ���� ]
- System �������� �Ʒ� ��ɾ� �ۼ�

4-1. ��������(oracle 12c ��������)
   -- create user <�����̸�> identified by <������ȣ> default tablespace users;
      create user scott identified by tiger default tablespace users(���̺� ������ �������� �ְڴ�.);
4-2. ��������(oracle 12c ���Ĺ���)
   -- create user "C##�����̸�" identified by "������ȣ" default tablespace users;
      create user "C##scott" identified by "tiger" default tablespace users(���̺� ������ �������� �ְڴ�.);
   -- �̸� alter session set "_ORACLE_SCRIPT"=TRUE;�� ���ָ� ������������ ����
5. ����� ���� �ο�
   -- grant connect, resource to scott;

6. �� ����
   -- alter user <�����̸�> account unlock;
   alter user madang account unlock;  ( ���� Ǯ�ڴ�. )

7.  ���� �߸����� ��� ���� �����ϱ�(�߸��� ���) 
  --  drop user <�����̸�> cascade;
   drop user scott cascade (����);
   
8. sql developer���� ��������
*/
-- ����� ���� ����
-- CREATE user "C##madang" identified by 1234 DEFAULT tablespace users;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE user adang identified by 1234 DEFAULT tablespace users;

-- ����� ���� �ο�
-- GRANT CONNECT, RESOURCE to "C##madang";
GRANT CONNECT, RESOURCE to adang;

-- view �������� �ο�
-- grant create view to "C##madang";
grant create view to adang;  
grant unlimited tablespace to "C##madang";  -- ��� ���̺����̽��� ���Ѿ��� ����� �� ����

-- ��������
-- ALTER USER "C##madang" ACCOUNT UNLOCK;
ALTER USER adang ACCOUNT UNLOCK;

-- ��������
drop USER ADANG CASCADE;