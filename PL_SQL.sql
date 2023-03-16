-------------------------------------------------------------------------
-- < ���� ���α׷��� �ǹ��ϴ� �� >
-- �������� �Ȱ��� ����� �� �ڵ�� �뷮�� �� ������ ���� ���α׷��̾���
-- ������ 3R�� ��
-- �� readability<�б⽬��>, reuseability<����>, reliability<�ŷڼ�>
-------------------------------------------------------------------------

/*  �� PL/SQL(ORACLE'S PROCEDURAL LANGUAGE EXTENSION TO SQL)
    -- ����Ŭ���� �����ϴ� ���α׷��� ����� Ư���� �����Ͽ� SQL������ ����� �� ���� 
       ������ ���α׷��� ����� ������ �־� SQL�� ������ �����Ѵ�.
*/
-- ����Ŭ���� ȭ�� ��� : ��Ű����.PUT_LINE ���ν����� ���
-- ȯ�溯�� serveroutput�� ����Ʈ ���� OFF�̹Ƿ� ȭ�� ����ϱ� ���� ON���� ����
SET SERVEROUTPUT ON -- PL/SQL�� ����ϱ� ���� ȯ�溯��
BEGIN
    DBMS_OUTPUT.put_line('WELCOM TO ORACLE');   -- �ϳ��� ���ν���
END;
/

/*  �� ��������
    1) ��Į��
    -- PL/SQL���� ������ ������ �� ���Ǵ� ������ Ÿ���� SQL����
       ����ϴ� ������ Ÿ�԰� ������. ����, ����, ��¥, BOOLEAN 4������ ����
    2) ���۷���
    -- ������ ������ Ÿ���� �����ͺ��̽� �����÷��� ���߾� �����ϱ� ���ؼ� 
       %TYPE ATTRIBUTE�� �̿���. ���� ����� �ʿ��� ������ Ÿ���� ��������� 
       ����ϴ� ��� 'TABLE�̸�.COLUMN�̸�%TYPE'���� ������
    -- %TYPE�� �÷� ������ ������ Ÿ���� ������.
    -- ROW(��) ��ü�� ���� ������ Ÿ���� �����Ϸ��� %ROWTYPE�� �����
       %ROWTYPE : ���̺��� �÷� �������, ������ Ÿ�Ա��� �����ϰ� ����ϰڴٴ� �ǹ�
*/
-- �����ȣ�� ����̸� ����ϱ�
SET SERVEROUTPUT ON
DECLARE
    V_EMPID     EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_EMPNAME   EMPLOYEES.LAST_NAME%TYPE;
    V_SALARY    EMPLOYEES.SALARY%TYPE;
    V_JOBID     EMPLOYEES.JOB_ID%TYPE;
BEGIN
    DBMS_OUTPUT.put_line('�����ȣ  ����̸�  �޿�  ����');
    DBMS_OUTPUT.put_line('---------------------------');
    
    SELECT EMPLOYEE_ID, LAST_NAME, SALARY, JOB_ID
    INTO V_EMPID, V_EMPNAME, V_SALARY, V_JOBID
    FROM EMPLOYEES
    WHERE LAST_NAME = 'Chen';
    DBMS_OUTPUT.put_line(V_EMPID || '  ' || v_empname || ' ' || v_salary || '  ' || v_jobid);
END;
/

/*  �� IF��
    [ ���� ]
    IF CONDITION THEN
        STATEMENTS;
        ...
    ELSIF CONDITION THEN
        STATEMENTS;
        ...
    ELSE
        STATEMENTS;
        ...
    END IF;
*/
SET SERVEROUTPUT ON
DECLARE
    V_EMPID     EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_EMPNAME   EMPLOYEES.LAST_NAME%TYPE;
    V_DEPTNO    EMPLOYEES.DEPARTMENT_ID%TYPE;
    V_DEPTNAME VARCHAR(50) := NULL;
BEGIN
    DBMS_OUTPUT.put_line('���     �̸�      �μ�ID    �μ���');
    SELECT EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID
    INTO V_EMPID, V_EMPNAME, V_DEPTNO
    FROM EMPLOYEES
    WHERE LAST_NAME = 'Chen';
    
    IF (V_DEPTNO = 100) then
        v_deptname := 'accounting';
    elsif (v_deptno = 20) THEN
        V_DEPTNAME := 'RESEARCH';
    elsif (v_deptno = 30) THEN
        V_DEPTNAME := 'SALES';
    elsif (v_deptno = 40) THEN
        V_DEPTNAME := 'IT_PROGRAMMER';
    ELSE
        V_DEPTNAME := 'SERVICE';
    END IF;
    
    DBMS_OUTPUT.put_line('-------------------------------');
    DBMS_OUTPUT.put_line(V_EMPID || '  ' || v_empname || ' ' || v_DEPTNO|| '  ' || v_DEPTNAME);
END;
/

/*  �� Ŀ�� : CURSOR, OPEN, FETCH, CLOSE 4�ܰ� ��ɿ� ���� ����
    -- SELECT���� ���� ����� ���� ���� �ο�� �������� ��� ��� �ο쿡 ���� 
       ó���� �Ϸ��� Ŀ���� ����ؾ� ��
    
    

*/







