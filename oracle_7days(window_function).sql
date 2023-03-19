/*  ㅁ window function : 꼭 over가 필수로 들어가야함
    [ 형식 ]
    SELECT window_function (arguments) OVER (
    [PARTITION BY 칼럼] [ORDER BY 절] [WINDOWING 절])
    FROM 테이블 명;
    -- window_function : 기존에 사용하던 함수도 있고, 새롭게 window 함수용으로 추가된 것도 있음
    -- arguments(인수)  : 함수에 따라 0~n개의 인수가 지정될 수 있음
    -- PARTITION BY    : 전체 집합을 기준에 의해 소그룹으로 나눌 수 있음
    -- ORDER BY        : 어떤 항목에 대해 순위를 지정할지에 대해 기술
    -- WINDOWING       : 함수의 대상이 되는 행 기준의 범위를 강력하게 지정
                       : SQL SERVER에서는 지원하지 않음
                       : ROWS -> 현재행을 기준으로 몇개의 행을 포함하는지
                       : RANGE -> 현재행을 기준으로 어떤 값의 범위를 포함하는지
    ㅁ WINDOWING 사용 예
    -- BETWEEN 사용타입)
    ROWS | RANGE BETWEEN
    UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING
    AND
    UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING
    -- BETWEEN 미사용타입)
    ROWS | RANGE
    UNBOUNDED PRECEDING | CURRENT ROW | VALUE_EXPR PRECEDING/FOLLOWING
    -- DEFAULT 경우)
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    [] UNBOUNDED : 한계를 두지 않고, 해당 파티션의 끝까지를 의미
    [] PRECEDING : 현재 행에서 앞쪽의 행을 나타냄
                 : <> 3 PRECEDING : 현재행 부터 앞으로 3번째 행을 범위로 함
                 : <> UNBOUNDED PRECEDING : 윈도우의 시작 위치가 첫번째 ROW
    [] FOLLOWING : 현재 행에서 뒤쪽의 행을 나타냄
                 : FOLLOWING을 사용하기 위해서는 BETWEEN~AND~형식을 사용해야함
                 : <> UNBOUNDED FOLLOWING : 윈도우의 마지막 위치가 마지막 ROW
*/
-- 1. 급여순위 내리기 / 2. 직업별로 나누어서 직업 안에서 순위 나누기
-- 지금은 급여를 기준으로 정렬이 되지만 두번째 줄을 없애면 JOB_ID 순으로 정렬이 되고 
SELECT JOB_ID, LAST_NAME, SALARY,
        RANK() OVER(ORDER BY SALARY DESC) S_SAL,
        RANK() OVER(PARTITION BY JOB_ID ORDER BY SALARY DESC) JOB_SAL
FROM EMPLOYEES;
