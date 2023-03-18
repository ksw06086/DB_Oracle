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
    -- FETCH �� : ��� �¿��� �ο� ������ �����͸� �о����.
    -- ���� �࿡ ���� ������ ��� INTO �ڿ� ����� ������ ������ �� ���� ������ �̵���, 
    -- ����� �������� �ο쿡 ���� ��� ���� ��� ó���Ϸ��� �ݺ����� FETCH���� ����ؾ� ��
    CURSOR : �࿡ ���� ������ ����
    FETCH  : ������ INTO �ڿ� �������� �־���
[ ���� ]
DECLARE
    CURSOR cursor_name
IS statement(SELECT��);
BEGIN
OPEN cursor_name;
    FETCH cursor_name
        INTO variable_name;
CLOSE cursor_name;
END;
*/
SET SERVEROUTPUT ON
DECLARE
    V_DEPT DEPARTMENTS%ROWTYPE;
    CURSOR C1
    IS SELECT * FROM DEPARTMENTS;
BEGIN
    DBMS_OUTPUT.PUT_LINE('�μ���ȣ �μ��� �Ŵ��� ������');
    DBMS_OUTPUT.PUT_LINE('-------------------------');
    
    OPEN C1;
    LOOP
        FETCH C1 INTO V_DEPT.DEPARTMENT_ID, V_DEPT.DEPARTMENT_NAME,
                      V_DEPT.MANAGER_ID,    V_DEPT.LOCATION_ID;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(V_DEPT.DEPARTMENT_ID || ' ' || V_DEPT.DEPARTMENT_NAME
                                || ' ' || V_DEPT.MANAGER_ID || ' ' || V_DEPT.LOCATION_ID);
    END LOOP;
    CLOSE C1;
END;
/

/*  �� ���� ���ν���
    -- ���ν��� : PL/SQL�� ���α׷� ������ ���ν����� �����Ͽ� ��ü ���·� ����Ѵ�.
                 ���ν����� �Ϲ����α׷��� ���� ����Ѵ� �Լ��� ����� ��������,
                 �۾������� ������ ������ ���α׷��� ��������� ���Ѵ�.
                 ���ν����� ���ǵ� ����, ����Ŭ�� ����ǹǷ� �������ν������ ��
    
    -- CallableStatement : DB�� ������ �������ν����� EXECUTE()�� ȣ���ؼ� ���
    -- ����Ŭ���� �Լ��� �ݵ�� RETURN���� ����Ͽ� ����� ��ȯ������,
       ���ν����� ����� ��ȯ�Ҽ���, ��ȯ���� ���� ���� �ִ�.
       
    -- PL/SQL ��� ������ �����, �����, ����ó����
    -- ���� : 
       CREATE OR REPLACE PROCEDURE ���ν�����(�Ű�����1 DATE_TYPE, �Ű�����2 DATA_TYPE, ...)
       IS
            ���ú���;
       BEGIN
            ���๮1;
            ���๮2;
       END;
       /
    -- ���� : EXECUTE ���ν�����;
    -- ���� : DROP PROCEDURE ���ν�����;
    -- ���ν��� Ȯ�� ������ ���� : USER_SOURCE
*/

-- ���ν��� �����ϱ�
-- SET~/���� ������ EXECUTE
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE EMP_SALARY
IS
    V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEES
    WHERE LAST_NAME = 'Chen';
    DBMS_OUTPUT.put_line('CHEN�� �޿��� ' || V_SALARY || '�Դϴ�.');
END;
/

EXECUTE EMP_SALARY;

-- ���ν��� Ȯ��
SELECT NAME, TEXT
FROM USER_SOURCE
WHERE NAME LIKE '%EMP_SALARY%';

-- IN �Ű����� ����ϱ�
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE SP_SALARY_ENAME(
    V_LASTNAME IN EMPLOYEES.LAST_NAME%TYPE
)
IS
    V_SALARY    EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEES
    WHERE LAST_NAME = V_LASTNAME;
    
    DBMS_OUTPUT.PUT_LINE(V_LASTNAME || '�� �޿��� ' || V_SALARY || '���Դϴ�.');
END;
/

EXECUTE SP_SALARY_ENAME('Chen');
EXECUTE SP_SALARY_ENAME('Seo');

/*
    [MODE]�� IN�� OUT, INOUT �� ������ ����� �� �ִµ�
    IN �����͸� ���޹��� �� ���� OUT�� ����� ����� �޾ư� �� ����մϴ�.
    INOUT�� �ΰ��� ������ ��� ���˴ϴ�.
*/

-- OUT �Ű����� ���
CREATE OR REPLACE PROCEDURE SP_SALARY_ENAME2(
    V_LASTNAME IN EMPLOYEES.LAST_NAME%TYPE,
    V_SALARY  OUT EMPLOYEES.SALARY%TYPE
)
IS
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEES
    WHERE LAST_NAME = V_LASTNAME;
END;
/

VARIABLE V_SALARY VARCHAR2(14);     -- ����ó�� %Ÿ���� ����
EXECUTE SP_SALARY_ENAME2('Chen', :V_SALARY);
PRINT V_SALARY;