-------------------------------------------------------------------------
-- < 좋은 프로그램을 의미하는 것 >
-- 예전에는 똑같은 기능일 때 코드와 용량이 더 작은게 좋은 프로그램이었음
-- 지금은 3R로 봄
-- ㄴ readability<읽기쉬운>, reuseability<재사용>, reliability<신뢰성>
-------------------------------------------------------------------------

/*  ㅁ PL/SQL(ORACLE'S PROCEDURAL LANGUAGE EXTENSION TO SQL)
    -- 오라클에서 지원하는 프로그래밍 언어의 특성을 수용하여 SQL에서는 사용할 수 없는 
       절차적 프로그래밍 기능을 가지고 있어 SQL의 단점을 보완한다.
*/
-- 오라클에서 화면 출력 : 패키지명.PUT_LINE 프로시저를 사용
-- 환경변수 serveroutput는 디폴트 값이 OFF이므로 화면 출력하기 위해 ON으로 변경
SET SERVEROUTPUT ON -- PL/SQL을 사용하기 위한 환경변수
BEGIN
    DBMS_OUTPUT.put_line('WELCOM TO ORACLE');   -- 하나의 프로시저
END;
/

/*  ㅁ 변수선언
    1) 스칼라
    -- PL/SQL에서 변수를 선언할 때 사용되는 데이터 타입은 SQL에서
       사용하던 데이터 타입과 유사함. 숫자, 문자, 날짜, BOOLEAN 4가지로 나뉨
    2) 레퍼런스
    -- 변수의 데이터 타입을 데이터베이스 기존컬럼에 맞추어 선언하기 위해서 
       %TYPE ATTRIBUTE를 이용함. 변수 선언시 필요할 데이터 타입을 명시적으로 
       언급하는 대신 'TABLE이름.COLUMN이름%TYPE'으로 지정함
    -- %TYPE은 컬럼 단위로 데이터 타입을 참조함.
    -- ROW(행) 전체에 대한 데이터 타입을 참조하려면 %ROWTYPE을 사용함
       %ROWTYPE : 테이블의 컬럼 순서대로, 데이터 타입까지 동일하게 사용하겠다는 의미
*/
-- 사원번호와 사원이름 출력하기
SET SERVEROUTPUT ON
DECLARE
    V_EMPID     EMPLOYEES.EMPLOYEE_ID%TYPE;
    V_EMPNAME   EMPLOYEES.LAST_NAME%TYPE;
    V_SALARY    EMPLOYEES.SALARY%TYPE;
    V_JOBID     EMPLOYEES.JOB_ID%TYPE;
BEGIN
    DBMS_OUTPUT.put_line('사원번호  사원이름  급여  직무');
    DBMS_OUTPUT.put_line('---------------------------');
    
    SELECT EMPLOYEE_ID, LAST_NAME, SALARY, JOB_ID
    INTO V_EMPID, V_EMPNAME, V_SALARY, V_JOBID
    FROM EMPLOYEES
    WHERE LAST_NAME = 'Chen';
    DBMS_OUTPUT.put_line(V_EMPID || '  ' || v_empname || ' ' || v_salary || '  ' || v_jobid);
END;
/

/*  ㅁ IF문
    [ 형식 ]
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
    DBMS_OUTPUT.put_line('사번     이름      부서ID    부서명');
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

/*  ㅁ 커서 : CURSOR, OPEN, FETCH, CLOSE 4단계 명령에 의해 사용됨
    -- SELECT문의 수행 결과가 여러 개의 로우로 구해지는 경우 모든 로우에 대한 
       처리를 하려면 커서를 사용해야 함
    -- FETCH 문 : 결과 셋에서 로우 단위로 데이터를 읽어들임.
    -- 현재 행에 대한 정보를 얻어 INTO 뒤에 기술한 변수에 저장한 후 다음 행으로 이동함, 
    -- 얻어진 여러개의 로우에 대한 결과 값을 모두 처리하려면 반복문에 FETCH문을 기술해야 함
    CURSOR : 행에 대한 정보를 가짐
    FETCH  : 꺼내서 INTO 뒤에 변수에게 넣어줌
[ 형식 ]
DECLARE
    CURSOR cursor_name
IS statement(SELECT절);
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
    DBMS_OUTPUT.PUT_LINE('부서번호 부서명 매니저 지역명');
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

/*  ㅁ 저장 프로시저
    -- 프로시저 : PL/SQL은 프로그램 로직을 프로시저로 구현하여 객체 형태로 사용한다.
                 프로시저는 일반프로그래밍 언어에서 상요한느 함수와 비슷한 개념으로,
                 작업순서가 정해진 독립된 프로그램의 수행단위를 말한다.
                 프로시저는 정의된 다음, 오라클에 저장되므로 저장프로시저라고도 함
    
    -- CallableStatement : DB에 생성된 저장프로시저를 EXECUTE()로 호출해서 사용
    -- 오라클에서 함수는 반드시 RETURN문을 사용하여 결과를 반환하지만,
       프로시저는 결과를 반환할수도, 반환하지 않을 수도 있다.
       
    -- PL/SQL 블록 구조는 선언부, 실행부, 예외처리부
    -- 생성 : 
       CREATE OR REPLACE PROCEDURE 프로시저명(매개변수1 DATE_TYPE, 매개변수2 DATA_TYPE, ...)
       IS
            로컬변수;
       BEGIN
            수행문1;
            수행문2;
       END;
       /
    -- 실행 : EXECUTE 프로시저명;
    -- 삭제 : DROP PROCEDURE 프로시저명;
    -- 프로시저 확인 데이터 사전 : USER_SOURCE
*/

-- 프로시저 생성하기
-- SET~/까지 실행후 EXECUTE
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE EMP_SALARY
IS
    V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT SALARY INTO V_SALARY
    FROM EMPLOYEES
    WHERE LAST_NAME = 'Chen';
    DBMS_OUTPUT.put_line('CHEN의 급여는 ' || V_SALARY || '입니다.');
END;
/

EXECUTE EMP_SALARY;

-- 프로시저 확인
SELECT NAME, TEXT
FROM USER_SOURCE
WHERE NAME LIKE '%EMP_SALARY%';

-- IN 매개변수 사용하기
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
    
    DBMS_OUTPUT.PUT_LINE(V_LASTNAME || '의 급여는 ' || V_SALARY || '원입니다.');
END;
/

EXECUTE SP_SALARY_ENAME('Chen');
EXECUTE SP_SALARY_ENAME('Seo');

/*
    [MODE]는 IN과 OUT, INOUT 세 가지를 기술할 수 있는데
    IN 데이터를 전달받을 때 쓰고 OUT은 수행된 결과를 받아갈 때 사용합니다.
    INOUT은 두가지 목적에 모두 사용됩니다.
*/

-- OUT 매개변수 사용
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

VARIABLE V_SALARY VARCHAR2(14);     -- 위에처럼 %타입은 못함
EXECUTE SP_SALARY_ENAME2('Chen', :V_SALARY);
PRINT V_SALARY;