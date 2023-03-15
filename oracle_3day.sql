-- 'IT' 포함된 부서명을 가진 부서의 사번, 이름(last_name, first_name)
-- 입사일, 부서코드, 부서명 출력
select e.employee_id, e.first_name || ' ' || e.last_name as 이름
    , e.hire_date, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id
and d.department_name like '%IT%';

-- country_id가 'US'인 나라의 country_id, 나라명, 지역ID, 지역명
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

-- 'Seattle'이라는 city에서 그무하는 사원의 사번, last_name, 부서명, salary, city 출력
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

-- 여러 테이블 join시 join on join on join on 이렇게 해야한다.
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

-- 부서코드가 100번인 사원의 사번, last_name, 부서코드, 부서명, job_title, min, max
select
    e.employee_id 사번
    , e.last_name 이름
    , d.department_id 부서코드
    , d.department_name 부서명
    , j.job_title 직무이름
    , j.min_salary 최소급여
    , j.max_salary 최대급여
from employees e, departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id
and d.department_id = 100;


-- 사번이 101번, job_history의 start_date가 '97/09/21'인 사원의 사번, last_name,
-- 부서정보, 위치정보, 국가정보, 지역정보, 직무정보 가져오기
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
    - 하나의 테이블에 있는 칼럼끼리 연결해야 하는 조인이 필요한 경우 사용
    - 같은 테이블이 하나 더 존재하는 것처럼 생각할 수 있도록 테이블 별칭을 사용함
    - 사원테이블에는 MANAGER_ID컬럼이 있는데 담당 매니처를 가리키는 역할을 한다.
    - 같은 테이블이지만 매니저도 사원이므로 E.MANAGER_ID = M.EMPLOYEE_ID로 연결이 가능
*/
-- 156번 이라는 사원의 사번, LAST_NAME, 매니저 id, 매니저 LAST_NAME
SELECT
    E.EMPLOYEE_ID 사번
    , E.LAST_NAME 이름
    , M.EMPLOYEE_ID "매니저 번호"
    , M.LAST_NAME "매니저 이름"
FROM employees E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
ORDER BY 1;

/*
    OUTER JOIN : EQUAL JOIN에서 양측 칼럼 값 중의 하나가 NULL이지만 조인 결과로
                 출력할 필요가 있는 경우 사용
    - NULL 값을 가진 행은 조인 결과로 얻어지지 않음. NULL에 대해서 어떤 연산을
      적용하더라도 결과는 NULL이기 때문
    - 따라서 OUTER JOIN을 이용하면 NULL 값이기에 배제된 행을 결과에 포함할 수 있고,
      (+) 기호를 조인 조건에서 정보가 부족한 컬럼의 이름 뒤에 붙임
    - 종류는 RIGHT, LEFT, FULL이 있다.
    
    - RIGHT OUTER JOIN : 값 출력은 오른쪽 기준이며, 오른쪽의 데이터가 많은 경우에 해당한다.
                         반드시 기준이 되는 쪽은 데이터가 모두 출력되어야 한다.
                         왼쪽 테이블 컬럼 뒤에(+)를 추가한다.
    - LEFT OUTER JOIN  : 값 출력은 왼쪽 기준이며, 왼쪽의 데이터가 많은 경우에 해당한다.
                         반드시 기준이 되는 쪽은 데이터가 모두 출력되어야 한다.
                         오른쪽 테이블 컬럼 뒤에(+)를 추가한다.                     
*/
-- 120~270번 부서가 신설부서
-- 부서정보 모두 출력, LEFT OUTER JOIN, 사원 테이블의 부서가 NULL이어도 부서테이블의 부서 출력
SELECT DISTINCT
    D.DEPARTMENT_ID "부서의 부서" -- 부서번호 10~270
    , E.DEPARTMENT_ID "사원의 부서" -- 부서번호 10~110
    , D.DEPARTMENT_NAME "부서명"
FROM employees E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID
ORDER BY 1;

-- OUTER JOIN, SELF JOIN을 이용하여 매니저가 없는 사원을 포함하여 사번, 사원명,
-- 매니저 ID, 매니저 이름 출력
SELECT
    E.EMPLOYEE_ID 사번,
    E.LAST_NAME 사원명,
    M.EMPLOYEE_ID 매니저번,
    M.LAST_NAME 매니저명
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID(+)
ORDER BY 1;

/*
    서브쿼리
    -- 하나의 SELECT 문장이 절 안에 포함된 또 하나의 SELECT 문장이다.
       서브쿼리는 메인쿼리에 사용할 값을 반환함
    - 메인쿼리 : 서브쿼리를 포함하고 있는 쿼리문
    - 서브쿼리 : 포함된 또 하나의 쿼리문, 비교연산자의 오른쪽에 기술해야하고,
                반드시 괄호 안에 넣어야한다. 메인쿼리가 실행되기 전에 한번만 실행됨
    - 종류 : 단일행 서브쿼리, 다중행 서브쿼리
    + 단일행 서브쿼리 : 수행결과가 오직 하나의 ROW(행, RECODE, TUPPLE)만을 반환
            - 연산자 : >, <, >=, <=, =, <>
    + 다중행 서브쿼리 : 수행결과가 하나 이상의 ROW를 반환
            - 연산자 : IN, ANY, SOME, ALL, EXISTS
    - 형식
    SELECT SELECT_LIST
     FROM TABLE
    WHERE EXPR OPERATOR (SELECT SELECT_LIST FROM TABLE WHERE .....);
*/
-- 'Jones' 보다 급여를 많이 받는 사원의 사번, 이름, 급여
SELECT EMPLOYEE_ID
    , LAST_NAME
    , SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE LAST_NAME = 'Jones')
ORDER BY SALARY;

-- 'Chen'과 같은 부서에서 일하는 사원의 사번, 이름, 부서번호, 부서명
SELECT E.EMPLOYEE_ID
        , E.LAST_NAME
        , D.DEPARTMENT_ID
        , D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE LAST_NAME = 'Chen')
ORDER BY EMPLOYEE_ID;

-- JOB_TITLE이 'Programmer'인 사원과 같은 직무에서 일하는 사원명, job_id, 급여 출력
select 
    last_name
    , job_id
    , salary
from employees
where job_id = (select job_id from jobs where job_title like '%Programmer%')
order by 1;

-- 2) 다중 행 서브쿼리
-- (1) IN 활용
-- 부서별 최소급여들 중의 하나와 일치하는 사원의 사번, 이름, 급여
SELECT 
    EMPLOYEE_ID
    , LAST_NAME
    , SALARY
FROM EMPLOYEES
WHERE SALARY IN (
    SELECT MIN(SALARY) FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID)
ORDER BY SALARY;
    
-- (2) ANY 연산자 : 메인쿼리의 비교조건이 서브쿼리의 출력결과와 비교해서 하나 이상이 일치하면 참
-- [ < ANI(여러 값들) : 여러 값들 중 최대값 보다 작냐? ]
-- [ > ANI(여러 값들) : 여러 값들 중 최소값 보다 크냐? ]

-- 직급이 'ST_CLERK'이 아니면서, 급여가 'ST_CLERK'의 최대값보다 낮은 사원 출력
-- 출력은 사번, 이름, JOB_ID, SALARY
SELECT
    EMPLOYEE_ID
    , LAST_NAME
    , JOB_ID
    , SALARY
FROM EMPLOYEES
WHERE JOB_ID <> 'ST_CLERK'
AND SALARY < ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'ST_CLERK')
ORDER BY SALARY;

-- (3) ALL 연산자 : 메인쿼리의 비교조건이 서브쿼리의 검색결과와 비교해서 모든 값이 일치하면 참
-- [ < ALL(여러 값들) : 여러 값들 보다 작은가? ]
-- [ > ALL(여러 값들) : 여러 값들 보다 큰가? ]

-- 직급이 'PU_CLERK'이 아니면서, 급여가 'PU_CLERK'의 최소값보다 낮은 사원 출력
-- 출력은 사번, 이름, JOB_ID, SALARY
SELECT
    EMPLOYEE_ID
    , LAST_NAME
    , JOB_ID
    , SALARY
FROM EMPLOYEES
WHERE JOB_ID <> 'PU_CLERK'
AND SALARY < ALL (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID = 'PU_CLERK')
ORDER BY SALARY;

-- (4) EXISTS : IN과 동일 <--> NOT EXISTS(값이 없으면 조회)
-- DML이랑 같이 쓸 때 활용하기 좋음(EX> 사원이 존재하면 부서를 신설)

-- 구매할 사람들이 있으면 판매할 품목을 가져옴 / 없으면 가져올 필요가 없음
-- 고객 : CUSTOMER
-- 영업 : SALE
select
    totalSale
from order o
where exists (select customer_id
                from customers
               where customers.cus_id = o.cus_id);

-- 부서가 100번 이상이거나 급여가 10000원 이상인 사원들의 사번, 부서번호, 급여를 출력
select 
    employee_id
    , department_id
    , salary
from employees
where (department_id, salary) in (select department_id, salary
                                    from employees
                                    where department_id > 100
                                    or salary > 10000);
                                    