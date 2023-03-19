/*  ㅁ 집합연산자
    1. intersect 연산자(교집합) ..
    현재 직책이 이전 직책과 동일한 사원
    ㄴ 직무가 변경된 적이 있지만, 현재는 이전 직무로 복귀한 사원.. 파견
    ㄴ 현재 근무 emplotees, 이전 직무 경력 job_history
    ㄴ 따라서 두 테이블의 교집합 즉 중복값
*/
select
    employee_id, job_id
from employees
intersect
select
    employee_id, job_id
from job_history;

-- 2. minus (차집합)
--교집합 아닌거 찾기(사원테이블의 200과 176제외)
select
    employee_id, job_id
from employees
minus
select
    employee_id, job_id
from job_history;

-- 3. union 연산자(합집합) : 중복행 X or 중복행 O 중복행을 제거해 두 쿼리의 행을 반환
-- 모든 사원의 현재 및 이전 직무 세부사항을 조회하되, 각 사원의 정보는 한번만 조회
select
    employee_id, job_id
from employees
union
select
    employee_id, job_id
from job_history;
-- 117건 -> 2건의 중복행 제거 -> 115건

-- 3. union all 연산자(합집합) : 중복행 제거 안함
-- 모든 사원의 현재 및 이전 직무 세부사항을 조회
select
    employee_id, job_id
from employees
union all
select
    employee_id, job_id
from job_history;

-- union 연산자 이용해 위치 id, 부서이름, 해당부서의 위치를 표시
select
    location_id, department_name, to_char(null)
from departments    -- 27
union
select
    location_id, to_char(null), locations.city
from locations;     -- 23
-- 합집합의 예시 A,B a에는 없는데 b에는 있으면 null을 주어서 수를 맞춰준다.
-- order by 시에는 맨 아래에 한다.

-- 뷰를 활용해서 TOM-N 구하기
-- 입사일이 빠른 순서로 5명 출력(인라인 뷰)
SELECT 
    ROWNUM,
    EMPLOYEE_ID,
    LAST_NAME,
    HIRE_DATE,
    SALARY
FROM (SELECT * FROM EMPLOYEES ORDER BY HIRE_DATE)
WHERE ROWNUM <= 5
AND HIRE_DATE IS NOT NULL;
-- EX) 1P 1~10 2P 11~20 3P 21~30 (START_NUM과 END_NUM 사용)

-- 급여를 적은 사람부터 순서대로 10명 출력(인라인 뷰)
SELECT ROWNUM, EMPLOYEE_ID, LAST_NAME, HIRE_DATE, SALARY
FROM (SELECT * FROM EMPLOYEES ORDER BY SALARY)
WHERE ROWNUM <= 10
AND SALARY IS NOT NULL;

/*  ㅁ 분석함수 !!!!!
    정의 : 그룹별로가 아닌 결과SET의 각 행마다 집계결과를 보여준다.
           즉 그룹별 계산결과를 각 행마다 보여주는 것
    -- OVER : 분석함수임을 나타내는 키워드
    -- PARTITION BY : 계산 대상 그룹을 정함
*/
-- 각각의 동일부서의 급여합꼐.. HR계정에서 실행
SELECT
    DEPARTMENT_ID, EMPLOYEE_ID, SALARY, SUM(SALARY) 
    OVER(PARTITION BY DEPARTMENT_ID) S_SAL
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID;

/*  ㅁ 순위함수
    -- RANK 함수 : 순위를 부여하는 함수, 동일순위 처리가 가능
    (중복순위 다음 순서는 건너뜀 - 1, 2, 2, 4, 5)
    -- DENSE_RANK 함수 : 동일 등수가 순위에 영향을 주지 않음
    (중복순위 다음 순서는 연속 - 1, 2, 2, 3, 4)
    -- ROW_NUMBER 함수 : 특정 순위로 일련번호를 제공하는 함수, 동일순위 처리 불가
    (중복순위 없이 유일값 - 1,2,3,4)
    ** 순위함수 사용시 ORDER BY절은 필수로 입력
    
    -- NTILE(분류) : 쿼리의 결과를 N개의 그룹으로 분류하는 기능을 제공, 지정숫자만큼 분류함
    -- [ 형식 ] NTILE(분류숫자)    
*/

-- 급여가 높은 순서대로 순위 구하기
SELECT
    DEPARTMENT_ID,
    EMPLOYEE_ID,
    SALARY,
    RANK() OVER(ORDER BY SALARY DESC) "RANK"
FROM EMPLOYEES;

-- 순위함수 비교
select
    DEPARTMENT_ID,
    EMPLOYEE_ID,
    SALARY,
    RANK() OVER(ORDER BY SALARY DESC),
    DENSE_RANK() OVER(ORDER BY SALARY DESC),
    ROW_NUMBER() OVER(ORDER BY SALARY DESC)
FROM EMPLOYEES;

-- 순위함수 -- NTILE(분류)
select
    EMPLOYEE_ID,
    NTILE(2) OVER(ORDER BY EMPLOYEE_ID) GRP2, -- 전체를 2등분으로 나누어 1, 2 표현
    NTILE(3) OVER(ORDER BY EMPLOYEE_ID) GRP2, -- 전체를 3등분으로 나누어 1,2,3 표현
    NTILE(5) OVER(ORDER BY EMPLOYEE_ID) GRP2 -- 전체를 5등분으로 나누어 1,2,3,4,5 표현
FROM EMPLOYEES;
-- 등급나눌때 대 중 소분류로 나눌 때

/*  ㅁ 윈도우 함수
    -- 분석함수 중에서 윈도우절을 사용하는 함수를 윈도우 함수라고 함
    -- 윈도우절을 사용하게 되면 PARTITION BY 절에 명시된 그룹을 좀 더 세부적으로 그룹핑 할 수 잇따.
    -- 윈도우절 분석함수 중에서 일부(AVG, COUNT, SUM, MAX, MIN)만 사용할 수 있다.
    -- ROWS  : 물리적인 ROW 단위로 행 집합을 지정한다.
    -- RANGE : 논리적인 상대번지로 행 집합을 지정한다.
*/
-- ROWS 사용예제
-- 부서별(PARTITION BY DEPARTMENT_ID)로 이전 ROW(ROW 1 PRECEDING)의 급여와
-- 현재 ROW의 급여합계를 출력
-- ROWS 2 PRECEDING -> 현재 + 이전 + 그 이전
SELECT
    EMPLOYEE_ID,
    LAST_NAME,
    DEPARTMENT_ID,
    SALARY,
    SUM(SALARY) OVER(PARTITION BY DEPARTMENT_ID ORDER BY EMPLOYEE_ID
                        ROWS 2 PRECEDING) PRE_SUM
FROM EMPLOYEES;

/*  ㅁ RANGE 사용예제 .. 주로 날짜로 함
    -- 영업정보시스템에서 분석화면에 전월비교, 전년비교, 분기별 합계, ...
    -- WITH AS : 프로시저 사용
    -- 7월에 데이터가 없으므로 직전 3개월 합계는 8개월의 경우 5,6월 두달치만 누적
    -- 201801인 경우 AMT_PRE3이 NULL인 이유는 이전 3개월이 없기 때문
    -- 201812인 경우 AMT_PRE3이 NULL인 이유는 이후 3개월이 없기 때문
*/
WITH TEST AS
(
    SELECT '201801' YYYYMM, 100 AMT FROM DUAL
    UNION ALL SELECT '201802' YYYYMM, 200 AMT FROM DUAL
    UNION ALL SELECT '201803' YYYYMM, 300 AMT FROM DUAL
    UNION ALL SELECT '201804' YYYYMM, 400 AMT FROM DUAL
    UNION ALL SELECT '201805' YYYYMM, 500 AMT FROM DUAL
    UNION ALL SELECT '201806' YYYYMM, 600 AMT FROM DUAL
    UNION ALL SELECT '201807' YYYYMM, 700 AMT FROM DUAL
    UNION ALL SELECT '201808' YYYYMM, 800 AMT FROM DUAL
    UNION ALL SELECT '201809' YYYYMM, 900 AMT FROM DUAL
    UNION ALL SELECT '201810' YYYYMM, 100 AMT FROM DUAL
    UNION ALL SELECT '201811' YYYYMM, 200 AMT FROM DUAL
    UNION ALL SELECT '201812' YYYYMM, 300 AMT FROM DUAL
)
select yyyymm, amt,
    sum(amt) over(order by to_date(yyyymm,'yyyymm')
            range BETWEEN interval '3' month preceding
                    and   interval '1' month preceding) amt_pre2 -- 이전 3개월 (현재는 미포함)
,   sum(amt) over(order by to_date(yyyymm,'yyyymm')
            range BETWEEN interval '1' month following
                    and   interval '3' month following) amt_pre3 -- 이후 3개월(현재는 미포함)
from test;
-- interval '숫자' <구하고싶은 거(일/월/년)> => 해당 일/월/년도 구하기
-- 2개 동시에 쓰려면 hour to minute / minute to second 같이 하면 됨

/*  ㅁ ROLLUP / CUBE  - 중요 -
    -- GROUP BY 구문의 결과에 소계 및 합계정보를 추가로 나타내주는 함수
    -- ROLLUP   : 단계별 소계(많이 씀)
    -- CUBE     : 모든 경우의 수에 대한 소계(잘 안씀)
*/

-- ROLLUP 예제1
-- 부서별 급여 합계와 전체 합계를 조회
-- 방법1. 롤업 사용
SELECT
    DEPARTMENT_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID);

-- 방법2. 유니온 올 사용
SELECT
    DEPARTMENT_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
UNION ALL
SELECT
    NULL DEPARTMENT_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
ORDER BY DEPARTMENT_ID;

-- ROLLUP 예제2
-- 부서별 사원의 급여와 소계(작은 합계), 전체합계(총계)를 조회
SELECT 
    DEPARTMENT_ID,
    EMPLOYEE_ID,
    SUM(SALARY) S_SAL
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY ROLLUP(DEPARTMENT_ID, EMPLOYEE_ID);
-- ROLLUP 순서에 따라 앞에 오는게 소계 기준이 됨

-- ROLLUP 예제3, 중요!
-- 부서명, JOB_ID별 급여와 직원 수 합계
-- 부서 소계 급여 합계 직원수 합계
SELECT
    D.DEPARTMENT_NAME,
    JOB_ID,
    SUM(SALARY),
    COUNT(E.EMPLOYEE_ID)
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
AND E.DEPARTMENT_ID IS NOT NULL
GROUP BY ROLLUP(D.DEPARTMENT_NAME, JOB_ID);



 