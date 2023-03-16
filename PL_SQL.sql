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
    
    

*/







