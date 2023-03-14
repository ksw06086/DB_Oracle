/*
    WHERE 절을 이용한 조건 검색
    - SELECT *
        FROM table명
      WHERE 조건;
      -- 조건문은 컬럼명, 연산자 상수가 올 수 있다.
      -- 문자와 날짜 타입의 상수값은 반드시 작은따옴표('')로 묶는다.
      -- '문자', '영문자' 대소문자 구별
*/
-- LAST_NAME이 KING인 사원의 사번, LAST NAME 조회
SELECT EMPLOYEE_ID, LAST_NAME
FROM employees
WHERE LAST_NAME = 'King';

-- SALARY가 11000이상인 사원의 사번, LAST_NAME, SALARY
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM employees
WHERE SALARY >= 11000
ORDER BY 3;

-- 사번테이블에서 JOB_ID가 SA_MAN이거나 FI_ACCOUNT인 사원의 사번, JOB_ID
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES
WHERE JOB_ID IN ('SA_MAN', 'FI_ACCOUNT');

-- 입사일(HIRE_DATE)이 2002년도 이면서, 급여가 10000이상인 사원의 사번, 입사일, 급여 조회
SELECT EMPLOYEE_ID, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE HIRE_DATE LIKE '2002%'
AND SALARY >= 10000;

/*
    컬럼명 BETWEEN A AND B : 컬럼의 값이 A와 B사이
    컬럼명 NOT BETWEEN A AND B : 컬럼의 값이 A와 B사이가 아닌 경우
*/
-- 입사일(HIRE_DATE)이 2002년도이면서, 급여가 10000이상인 사원의 사번, 입사일, 급여 조회
SELECT 
    EMPLOYEE_ID, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE hire_date BETWEEN '2002/01/01' and '2002/12/31'
AND SALARY >= 10000;

-- SALARY가 10000~15000사이인 사원의 사번, SALARY
SELECT
    EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE SALARY BETWEEN 10000 AND 15000
ORDER BY 2;

-- SALARY가 10000~15000 사이를 제외한 사원의 사번, SALARY
SELECT EMPLOYEE_ID, SALARY
FROM EMPLOYEES
WHERE SALARY NOT BETWEEN 10000 AND 15000
ORDER BY 2;

-- 사원테이블에서 부서 ID가 10,20,30,40,50인 사원의 부서 ID(단 중복제거)
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES
WHERE department_id IN (10,20,30,40,50);

/*
    LIKE 연산자와 와일드 카드
    -- 컬럼명 LIKE PATTER
    -- PATTER : 2가지 와잍드 카드
    -- 와일드카드 : % => 하나 이상의 문자가 어떤 값이 와도 상관없다.
                   _ => 하나의 문자가 어떤 값이 와도 상관없다.
*/
-- LAST_NAME의 3번째, 4번째 단어가 'TT'인 사원의 LAST_NAME
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '__tt%';

-- OR SUBSTR(LAST_NAME, 3, 4) = 'tt';

-- 사원테이블에서 JONES가 포함된 EMAIL
SELECT EMAIL
FROM EMPLOYEES
WHERE INSTR(EMAIL, 'JONES') != 0;
-- OR EMAIL LIKE '%JONES%';

-- JOB 테이블에서 REP 포함된 JOB_ID
SELECT JOB_ID
FROM JOBS
WHERE JOB_ID LIKE '%REP%';
-- OR WHERE INSTR(JOB_ID, 'REP');

/*
    정렬을 위한 ORDER BY 절
    -- SELECT절의 WHERE절 뒤에 온다.
    -- ORDER BY 컬럼명 SORTING
        ASC(오름차순),                  DESC(내림차순)
    -  숫자 : 작 -> 큰                  큰 -> 작
    -  문자 : 사전순서(가 -> 하)        사전순서(하->가)
    -  날짜 : 빠른날짜 -> 최근일자       
*/
-- Salary 기준으로 오름차순, 사번, salary 조회, 단 salary가 15000이상인 경우
select employee_id, salary
FROM employees
WHERE SALARY >= 15000
ORDER BY SALARY;

-- SALARY 기준으로 내림차순, 사번, SALARY 조회
-- 단 SALARY가 5000미만, 사번 140~160
SELECT
    EMPLOYEE_ID, SALARY
FROM employees
WHERE SALARY < 5000
AND EMPLOYEE_ID BETWEEN 140 AND 160
ORDER BY SALARY desc;

-- 급여가 높은 사람부터 출력하되, 동일시 commission_pct가 낮은 사람부터 출력
-- 단 급여는 10000이상, commission_pct가 null이 아닌 경우
select salary, commission_pct
from employees
where salary >= 10000
and commission_pct is not null
order by salary desc, commission_pct asc;

/*
    01. 문자함수
    -- lower : 소문자 변환
    -- upper : 대문자 변환
    -- initcap : 첫글자만 대문자로 나머지 글자는 소문자로 변환
*/
select last_name
from employees
where last_name = initcap('king');

select email
from employees
where email = upper('kgee');

select 'welcome TO oracle',
upper('welcome TO oracle'),
lower('welcome TO oracle'),
initcap('welcome TO oracle')
from dual;

-- last_name이 King, Lee인 사원의 last_name, job_id조회
-- 단 job_id는 첫문자만 대문자로
select last_name, initcap(job_id)
from employees
where last_name in ('King', 'Lee');

/*
    -- length 문자길이 반환(한글, 영문 모두 1문자당 1)
    -- lengthb 문자길이를 byte에 따라 반환(한글 -> 3byte)
*/

select
    length('Oracle'),
    length('오라클'),
    lengthb('Oracle'),
    lengthb('오라클')
from dual;

/*
    * 문자 처리 함수(문자 조작 함수)
    concat      : 문자의 값을 연결한다.
    substr      : 문자를 잘라 추출한다.(한글 1byte)
    substrb     : 문자를 잘라 추출한다.(한글 2byte)
    instr       : 특정문자의 위치 값을 반환한다.(한글 1byte)
    instrb      : 특정문자의 위치 값을 반환한다.(한글 2byte)
    lpad, rpad  : 입력받은 문자열과 기호를 정렬하여 특정길이의 문자열로 반환
    trim        : 잘라내고 남은 문자를 표시
*/
/*
    concat - 문자열 결합 함수 / ||와 동일
*/

-- '01/01/13'에 입사한 사원의 사번, 입사일, 이름
-- 입사일 : '2001/01/13', 이름 : firstname + lastname
select employee_id 사번, hire_date 입사일, first_name || ' ' || last_name 이름
from employees
where hire_date = '2001/01/13';

/*
    substr - 기존 문자열에서 일부 가져오기
    형식 - substr(대상, 시작위치, 추출개수)
    ㄴ 시작위치가 양수인 경우 앞쪽 1부터 시작하고, 음수인 경우 뒤쪽부터 시작한다.
*/
select
    substr('welcome to korea', 4, 4)
from dual;

select
    substr('welcome to korea', -8, 2)
from dual;

select
    substr('오라클매니아', 3, 4)
from dual;

select
    substr('오라클매니아', 4, 6)
from dual;

-- 입사년도가 04년도이거나 06년도인 사원의 사번, 입사일 (----년 --월 --일)
select
    employee_id 사번,
    substr(hire_date, 1, 4) || '년',
    substr(hire_date, 6, 2) || '월',
    substr(hire_date, 9, 2) || '일'
from employees
where substr(hire_date, 1, 4) in (2004, 2006)
order by 2;

/*
    INSTR : 문자열 내에 해당문자가 어느 위치에 존재하는지를 알려줌
    형식 : INSTR(대상, 찾을글자, 시작위치, 몇번째 발견)
    시작위치와 몇번째 발견이 생략시 모두 1로 간주한다.
*/

-- 'Oracle mania'에서 a가 1번째 부터 시작, 1번째 발견된 위치
select
    instr('Oracle mania', 'a', 1, 1)
FROM dual;

-- 'Oracle mania'에서 a가 1번째 부터 시작, 2번째 발견된 위치
select
    instr('Oracle mania', 'a', 1, 2)
FROM dual;

-- 'Oracle mania'에서 a가 1번째 부터 시작, 3번째 발견된 위치
select
    instr('Oracle mania', 'a', 1, 3)
FROM dual;

-- 사원테이블에서 last_name의 3번째 문자가 'a'인 경우에 last_name, 위치값
select
    last_name, instr(last_name, 'a', 3, 1) 
from employees
where last_name like '__a%';

/*
    lpad : 칼럼이나 대상 문자열을 명시된 자릿수에서 오른쪽에 나타내고, 남은 왼쪽 자리를 특정 기호로 채움
    rpad : 대상 문자열을 명시된 자릿수에서 왼쪽에 나타내고, 남은 오른쪽 자리를 특정 기호로 채움
*/
-- 급여(15)는 왼쪽을 *, 이름(20)은 오른쪽을 ^로 채운다.
select employee_id, lpad(salary, 15, '*') 급여, rpad(last_name, 20, '^') 이름
from employees;

/*
    TRIM : 특정 문자를 잘라낸다.. 주로 공백을 제거
            칼럼이나 대상 문자열에서 잘라내고 남은 문자열만 반환
    -- LTRIM : 문자열의 왼쪽의 공백 문자들을 삭제한다.
    -- RTRIM : 문자열의 오른쪽의 공백 문자들을 삭제한다.
    -- TRIM  : 문자열의 앞뒤의 공백 문자들을 삭제한다.
*/
SELECT '        ORACLE 11G        ',
LTRIM('        ORACLE 11G        '),
RTRIM('        ORACLE 11G        '),
TRIM('        ORACLE 11G        ')
FROM DUAL;

/*
    * 숫자 함수
    ROUND : 특정자릿수에서 반올림한다.
    TRUNC : 특정자릿수에서 잘라낸다(버림).
    MOD   : 입력받은 수를 나눈 나머지 값을 반환한다.
*/
-- ROUND 함수
SELECT ROUND(98.7654, 2), -- 98.77 
    ROUND(98.7654, 0),    -- 99
    ROUND(98.7654, -1)    -- 100
FROM DUAL;

-- MOD 함수
SELECT MOD(27,2), MOD(27,5)
FROM DUAL;

-- ABS 함수 : 절대값
SELECT ABS(-10), -10
FROM DUAL;

-- FLOOR 함수 : 소수점 아래 버림
SELECT FLOOR(34.5678), 34.5678
FROM DUAL;

/*
    * 날짜 함수
    SYSDATE         : 시스템 저장된 현재 날짜를 반환한다.
    MONTHS_BETWEEN  : 두 날짜 사이가 몇개월인지 반환
    ADD_MONTHS      : 특정 날짜에 개월수를 더한다.
    NEXT_DAY        : 특정 날짜에서 최초로 도래하는 인자로 받은 요일의 날짜를 반환
    LAST_DAY        : 해당 달의 마지막 날짜를 반환한다.
    ROUND           : 인자로 받은 날짜를 특정 기준으로 반올림한다. ROUND(DATE, FORMAT)
    TRUNC           : 인자로 받은 날짜를 특정 기준으로 버린다.
*/
-- SYSDATE
SELECT
    SYSDATE 오늘,
    SYSDATE-1 어제,
    SYSDATE+1 내일,
    SYSDATE+2 모레
FROM DUAL;

-- ROUND : FORMAT이 'MONTH'인 경우 : 일을 기준으로 16보다 적으면 이번달 1일, 16이상이면 다음달 1일
SELECT
    EMPLOYEE_ID
    , HIRE_DATE 입사일
    , ROUND(HIRE_DATE, 'month') T_입사일
FROM employees;

-- 근무일수
SELECT
    EMPLOYEE_ID, ROUND(SYSDATE-HIRE_DATE, 0) 근무일수
FROM employees;

-- TRUNC : FORMAT이 'MONTH'인 경우 : 달을 기준으로 자름. 그 달의 1일
SELECT
    EMPLOYEE_ID
    , HIRE_DATE 입사일
    , TRUNC(HIRE_DATE, 'month') T_입사일
FROM employees;

-- MONTHS_BETWEEN : 날짜와 날짜 사이의 개월 수를 구하는 함수
-- MONTHS_BETWEEN(DATE1, DATE2)
-- 근무개월수 구하기
SELECT
    EMPLOYEE_ID,
    HIRE_DATE 입사일,
    MONTHS_BETWEEN(SYSDATE, HIRE_DATE) 근무개월수
    , ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) R_근무개월수
    , TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) T_근무개월수
FROM employees;

-- ADD_MONTHS : 특정 개월수를 더한 날짜를 구하는 함수
-- ADD_MONTHS(DATE, NUMBER)
-- 입사 3개월
SELECT EMPLOYEE_ID,
    HIRE_DATE 입사일,
    ADD_MONTHS(HIRE_DATE, 3) "입사 3개월 후"
FROM employees;

-- NEXT_DAY : 해당 날짜를 기준으로 최초로 도래하는 파일에 해당하는 날짜를 반환하는 함수
-- NEXT_DAY(DATE, 요일) / EX) 1:일요일, 2:월요일, ... 7:토요일
SELECT 
    SYSDATE,
    NEXT_DAY(SYSDATE, '금요일'),
    NEXT_DAY(SYSDATE, '일요일'),
    NEXT_DAY(SYSDATE, 6),
    NEXT_DAY(SYSDATE, 1)
FROM DUAL;

-- LAST_DAY : 해당 날짜가 속한 달의 마지막 날짜를 반환하는 함수
SELECT
    EMPLOYEE_ID 사번,
    HIRE_DATE 입사일,
    LAST_DAY(HIRE_DATE) "입사한 달의 마지막 날"
FROM employees;

/*
    * 형 변환 함수
    - 오라클에서 데이터형으로 변환해야하는 경우에는 TO_NUMBER, TO_CHAR, TO_DATE를 사용
    -- TO_CHAR      : 날짜형 혹은 숫자형을 문자형으로 변환
    -- TO_DATE      : 문자형을 날짜형으로 변환
    -- TO_NUMBER    : 문자형을 숫자형으로 변환
*/

/*
    * TO_CHAR : 날짜 -> 문자
    - TO_CHAR(날짜 데이터, '출력형식')
    - 종류 : 의미
    + YYYY  : 년도표현(4자리)
    + YY    : 년도표현(2자리)
    + MM    : 월을 숫자로 표현
    + MON   : 월을 알파벳으로 표현
    + DAY   : 요일 표현
    + DY    : 요일을 약어로 표현
*/
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DAY)'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD DY'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DY)')
FROM DUAL;

-- 시간표현
-- 오전 -> AM | 오후 -> PM
-- 12시간 -> HH:MI:SS | 24시간 -> HH24:MI:SS
SELECT
    SYSDATE,
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DY) HH:MI:SS'),
    TO_CHAR(SYSDATE, 'YYYY-MM-DD (DY) HH24:MI:SS')
FROM DUAL;

/*
    * TO_CHAR : 숫자 -> 문자
    -- L : 각 지역별 통화기호를 앞에 표시 예) 한국 : \
    -- , : 천 단위 자리 구분을 표시
    -- . : 소수점 표시
    -- 9 : 자리수를 나타냄(자릿수 안맞아도 0으로 안채워짐)
    -- 0 : 자리수를 나타냄(자릿수 안맞으면 0으로 채워짐
*/
SELECT
    EMPLOYEE_ID, SALARY,
    TO_CHAR(SALARY, 'L9,999,999'),
    TO_CHAR(SALARY, 'L0,000,000')
FROM employees;

-- TO_DATE
-- TO_DATE('문자', 'FORMAT')

-- 입사일이 03/06/17 YYYY-MM-DD(요일)인 사원의 사번, 입사일
SELECT EMPLOYEE_ID 사번, TO_CHAR(HIRE_DATE, 'YYYY-MM-DD (DY)')
FROM employees
WHERE HIRE_DATE = TO_DATE('20030617', 'YYYY-MM-DD');

-- 수강일수
SELECT TRUNC(SYSDATE - TO_DATE('20190617','YYYY-MM-DD')) 수강일수
FROM DUAL;

-- TO NUMBER : 문자형 -> 숫자형 변환
SELECT 
    '1,000,000' - '5,000'
FROM DUAL;

SELECT
    TO_NUMBER('1,000,000', '999999999999999') - TO_NUMBER('5,000' , '99999')
FROM DUAL;

-- 1. NVL 함수
-- 사원테이블의 사번, 급여, 커미션, 상여금(급여 * 커미션) 구하기
SELECT
    EMPLOYEE_ID, SALARY, COMMISSION_PCT 상여비율, 
    NVL(COMMISSION_PCT, 0) * SALARY 실상여금,
    SALARY*12 연봉, SALARY*12 + SALARY*NVL(COMMISSION_PCT, 0) "연봉 총액"
FROM employees
ORDER BY 4 DESC;

-- 2. NVL2 : EXPR1을 검사하여 그 결과가 널이면 EXPR3를 반환하고 널이 아니면 EXPR2를 반환
--    NVL2(EXPR1, EXPR2, EXPR3)
SELECT 
    EMPLOYEE_ID
    , SALARY
    , COMMISSION_PCT
    , NVL2(COMMISSION_PCT, SALARY*12 + SALARY*COMMISSION_PCT, SALARY*12) "연봉 총액"
FROM employees;

-- 3. NULLIF : 두 표현식을 비교하여 동일한 경우에는 널, 동일하지 않으면 첫번째 표현식 반환
--    NULLIF(EXPR1, EXPR2)
SELECT
    NULLIF('A', 'A'),
    NULLIF('A', 'B')
FROM DUAL;

/* COALESCE
   - 인수중에서 NULL이 아닌 첫 번째 인수를 반환
   - EXPR1이 NULL이 아니면 EXPR1 반환, 
     EXPR1이 NULL이고 EXPR2가 NULL이 아니면 EXPR2 반환
   - COALESCE(EXPR1, EXPR2, ..., EXPRn)
*/
-- 커미션이 NULL이고 급여가 NULL이 아니면 SALARY를 반환하고, 둘다 NULL이면 0을 출력
SELECT 
    COMMISSION_PCT,
    SALARY,
    COALESCE(COMMISSION_PCT, SALARY, 0)
FROM employees;

------------------------------------------------------------------------------------

/*
    DECODE : 조건에 따라 다양한 선택 가능
    - DECODE(표현식, 조건1, 결과1,
                    조건2, 결과2,
                    조건3, 결과3,
                    기본결과N)
-- 자바의 SWITCH CASE 문과 동일
*/
-- 사원 테이블의 부서 ID가 10~100사이인 경우의 부서명을 출력
-- 그 외는 "부서 미정"
-- 단 부서코드가 중복되지 않도록 하며, 부서 번호로 정렬한다. 부서번호가 없으면 출력하지 않는다.
/*
10	Administration
20	Marketing
30	Purchasing
40	Human Resources
50	Shipping
60	IT
70	Public Relations
80	Sales
90	Executive
100	Finance
110	Accounting
*/
select DISTINCT employee_id,
        decode(department_id, 10, 'Administration',
                                    20, 'Marketing',
                                    30, 'Purchasing',
                                    40, 'Human Resources',
                                    50, 'Shipping',
                                    60, 'IT',
                                    70, 'Public Relations',
                                    80, 'Sales',
                                    90, 'Executive',
                                    100, 'Finance',
                                    '부서 미정') 부서명
from employees
where department_id is not null
order by 1;

/*
case : 프로그램 언어의 if else if else와 유사한 구조를 가짐
case 표현식 when 조건1 then 결과1
            when 조건2 then 결과2
            when 조건3 then 결과3
            else 결과n
end
*/
select distinct
    case department_id when 10 then '장원영'
                        when 20 then '권은비'
                        when 30 then '사쿠라'
                        when 40 then '강혜원'
                        when 50 then '최예나'
                        when 60 then '이채연'
                        when 70 then '히토미'
                        when 80 then '김채원'
                        when 90 then '김민주'
                        when 100 then '나코'
                        else '안유진'
    end 아이즈원
from employees
where department_id is not null;

/*
    * 그룹함수
    데이터 그룹 : GROUP BY
    그룹 결과 제한 : HAVING 절
    --------------------------------------------------------
    01. 그룹함수
    - 테이블의 전체 데이터에서 통계적인 결과를 구하기 위해서 행 집합에 적용하여 하나의 결과를 생산
    - 그룹함수는 다른 연산자와는 달리 해당 컬럼값이 NULL인 것을 제외하고 계산하므로
    - NULL이 포함된 컬럼이 있더라도 결과는 NULL이 아니다.
    구분      설명
    SUM:    그룹의 누적 합계를 반환
    AVG:    그룹의 평균을 반환
    COUNT:  그룹의 총 개수를 반환
    MAX:    그룹의 최대값을 반환
    MIN:    그룹의 최소값을 반환
*/
-- SUM
SELECT
    TO_CHAR(SUM(SALARY), 'L9,999,999') 급여총액
FROM employees;

-- AVG
-- 급여평균 : 소수점 3째 자리에서 반올림
SELECT
    TO_CHAR(ROUND(AVG(SALARY),2), 'L9,999,999') 급여평균
FROM employees;
-- 급여평균 : 정수
SELECT
    TO_CHAR(ROUND(AVG(SALARY)), 'L9,999,999,999') R_급여평균, 
    TO_CHAR(FLOOR(AVG(SALARY)), 'L9,999,999,999') F_급여평균 
FROM employees;

-- MAX, MIN
SELECT MAX(SALARY) 급여MAX, MIN(SALARY) 급여MIN
FROM employees;

-- 최근 입사일, 가장 오래전 입사일
SELECT
    TO_CHAR(MAX(HIRE_DATE)) "최근 입사일",
    TO_CHAR(MIN(HIRE_DATE)) "가장 오래전 입사일"
FROM employees;

-- COUNT(*) : NULL 값으로 된 행, 중복된 행을 비롯하여 선택된 모든 행을 카운트한 갯수
-- 사원 수
SELECT
    COUNT(*) 사원수
FROM employees;

-- COUNT(컬럼명) : NULL이 아닌 행의 갯수
SELECT
    COUNT(COMMISSION_PCT) "커미션을 받는 사원 수"
FROM employees;

SELECT
    COUNT(*) "커미션을 받는 사원 수"
FROM employees
WHERE COMMISSION_PCT IS NOT NULL;

-- 중복 안된 JOB_ID 갯수
SELECT
    COUNT(DISTINCT JOB_ID)
FROM employees;

-- 사번, 최대급여
SELECT
    EMPLOYEE_ID, MAX(SALARY)
FROM employees; -- 에러

/*
    데이터 그룹 : GROUP BY 컬럼명 - 특정 칼럼을 그룹별로 나눔, WHERE 후에 옴
    -- 그룹함수가 아닌 SELECT 리스트의 모든 컬럼은 GROUP BY 절에 반드시 기술해야 한다.
    -- 그러니 반대로 GROUP BY절에 기술된 컬럼이 반드시 SELECT 리스트에 있어야 하는건 아니다.
       단지 결과가 무의미하다.
    -- 그룹함수는 두번까지 중첩해서 사용 가능하다. 예) MAX(AVG(SALARY))
       단 SELECT LIST에 일반 컬럼 사용불가 -> HAVING 조건 절과 SUBQUERY를 활용한다.
*/
SELECT
    DEPARTMENT_ID, MAX(SALARY) "부서별 최대급여"
FROM employees
GROUP BY department_id
ORDER BY 1;

SELECT
    DEPARTMENT_ID, MAX(AVG(SALARY)) "부서별 최대 평균 급여"
FROM employees
GROUP BY department_id
ORDER BY 1; -- 에러, 그룹함수가 2번 연속으로 사용됨

-- 부서별, 직무별 인원수, 최대급여, 최소급여, 급여합계, 급여평균
-- 부서, 직급은 오름차순(단 부서는 NULL이면 허용 안함)
SELECT
    DEPARTMENT_ID 부서, JOB_ID 직무
    , COUNT(JOB_ID) "직무별 인원수", MAX(SALARY) 최대급여
    , MIN(SALARY) 최소급여, SUM(SALARY) 급여합계, AVG(SALARY) 급여평균
FROM employees
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY 1, 2;

/* 그룹 결과 제한 : HAVING 절
    
*/