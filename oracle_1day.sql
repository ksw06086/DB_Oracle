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



