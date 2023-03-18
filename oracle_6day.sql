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
