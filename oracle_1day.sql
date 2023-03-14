-- 테이블 구조 조회
-- DESC[RiBE] 테이블명;
desc employees;

-- 테이블 목록 조회
select * from tab;

-- 데이터 조회
/* select 컬럼명1, 컬럼명2, ...
    from 테이블명
    where 조건식
    order by 컬럼명 또는 검색할 컬럼 중의 정렬할 순서번호(ASC<오름>/desc<내림>)
*/
select * from employees
where employee_id = 206;

-- 오라클 문자는 ' '이다.
-- job_id가 IT_PROG인 경우 사번, 이름, 이메일 조회, 사번 내림차순 정렬
select employee_id, last_name, email from employees
where job_id = 'IT_PROG'
order by employee_id desc;

-- 사원테이블에서 사번, last_name, salary 조회(단, 사번이 100번)
-- 컬럼에 별칭 지정 : 1. 공백추가 2. AS추가 3. ""로 별칭 감싸기
select employee_id, last_name, salary from employees
where employee_id = 100;

-- 사원테이블에서 사번, 이메일, 급여 조회
-- (단 급여가 10000 이상, 사번 149) / salary 오름, employee_id 오름
select employee_id, email, salary
from employees
where salary >= 10000
and employee_id > 149
order by 3,1;

-- 부서테이블에서 부서id, 부서명 조회(단 부서명이 IT인 경우)
select department_id, department_name
from departments
-- WHERE department_name = 'IT'
-- or department_name = 'Finance'
-- or department_name = 'Marketing'
where department_name in('IT', 'Finance', 'Marketing');

-- 직무테이블에서 job_id가 ST로 시작하거나 최소급여가 10000이상일 때의 모든 정보
select
*
from jobs
where job_id like 'ST%'
or min_salary >= 10000
order by min_salary;

-- 중복된 데이터를 한번씩만 출력하게 하는 DISTINCT
-- 부서정보를 전체 출력하되 부서번호로 정렬
-- 하나만 출력하게 해서 조건하거나 안하면 중복값 안나오는데 다른 걸 같이 조회하면 나옴
-- 왜냐하면 뒤에 자료들이 중복이 아니기 때문에 모두 다 나옴
-- AND 형식으로 알고 있으면 됨. 하나의 행이 전체 다 중복일 때에만 됨
select distinct
    manager_id, department_id
from departments;

-- DUAL 테이블 : (한 행으로 결과를 출력)하기 위해서 제공되는 테이블
-- DUMMY(VARCHAR2(1))라는 하나의 컬럼으로 구성되어 있다.
select
    *
from dual;
select
sysdate
from dual; -- 현재날짜
/*
    Null 연산자를 이용한 조건 검색
    Null은 미확정, 알수 없는 값을 의미하며, 연산, 할당, 비교가 불가능함.
    IS NULL : 컬럼값 중에서 NULL을 포함하는 ROW를 검색하기 위한 연산자
    IS NOT NULL : 컬럼값 중에서 NULL을 포함하지 않는 ROW를 검색하기 위한 연산자.
*/
-- WHERE 컬럼명 IS [NOT] NULL;
-- 커미션을 받는 사원의 사번, SALARY, 커미션
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL;

-- 부서 ID가 NULL인 사원의 사번, 부서ID
SELECT EMPLOYEE_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NULL;

-- NVL : NULL인 경우 비교, 연산, 할당이 불가능하므로, NULL인 경우 NVL을 이용해 대체
/*
    NVL 함수 : NULL을 0 또는 다른 값으로 변환한다.
    NVL(컬럼명 | 표현식, 대체값);
    NULL : 정해지지 않는 값, 연산/할당/비교가 불가능
            연산시 관계 컬럼도 NULL으로 바뀐다.
            두개의 값은 반드시 데이터 타입이 일치해야한다.
*/
-- 사원테이블의 사번, 급여, 커미션, 상여금(급여*커미션) 구하기
SELECT EMPLOYEE_ID, SALARY, COMMISSION_PCT, 
(NVL(COMMISSION_PCT, 0)*SALARY) AS 상여금,
SALARY * 12 연봉, SALARY*12 + SALARY*NVL(COMMISSION_PCT,0) "연봉 총액"
FROM employees;

-- 사원테이블의 사번, 커미션 조회(단 커미션 오름차순 정렬)
SELECT EMPLOYEE_ID, NVL(COMMISSION_PCT,0)
FROM EMPLOYEES
ORDER BY COMMISSION_PCT;

