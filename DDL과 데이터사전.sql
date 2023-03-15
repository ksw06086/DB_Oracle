/* 테이블 생성/수정/삭제 DDL
    * CREATE TABLE 문
    -- 형식
    CREATE TABLE [schema. ] table (
        column datatype[DEFAULT expression]
        [column_constraintclause] [,...]);
    - schema                    : 소유자의 이름(사용자 계정)
    - column                    : 테이블에 포함되는 칼럼명
    - datatype                  : 칼럼에 대한 데이터 타입과 길이
    - DEFAULT expression        : 데이터 입력 값이 생략된 경우 입력되는 기본 값
    - column_constraint_clause  : 칼럼에 정의되는 무결성 제약 조건
    <char와 varchar2의 차이>
    - varchar2                  : address(50)이어도 내가 실제 차지하는 만큼만
                                  공간 주겠다. 20개 사용하면 20개만 설정됨(길이 일정X)
    - char                      : 길이가 일정할 때 사용
*/

-- food 테이블 삭제
drop table food;

-- food 테이블 생성
create table food(
    food_code           varchar2(10)        primary key,
    restaurant_name     varchar2(50),
    kind                char(1),    -- 한식(k), 중식(c), 양식(u), 일식(j)
    food_name           varchar2(50),
    price               number              default 0,
    starpoint           char(1)             default 0
);

desc food;

-- 1. insert 문
/*
    INSERT INTO TABLE_NAME (COLUMN_NAME, ...)
    VALUES (COLUMN_VALUE, ...);
*/
DELETE FOOD;
COMMIT;

-- DML 언어는 일시적으로 추가/수정/삭제가 되었고 반영은 안되어있음
INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('1', '김밥천국', 'K', '불고기덮밥', 8500, '1');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('2', '김밥천국', 'K', '김치찌개', 7500, '2');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('3', '김밥천국', 'C', '짜장밥', 7000, '3');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('4', '김밥천국', 'U', '돈가스', 10000, '5');

INSERT INTO FOOD(FOOD_CODE, restaurant_name, kind, food_name, price, starpoint)
VALUES('5', '김밥천국', 'J', '모밀소바', 8000, '5');

COMMIT; -- INSERT 다하고 명령해주면 영구저장됨

SELECT
    *
FROM FOOD;

/* 테이블 복사(구조만)
[ 형식 ]
CREATE TABLE table [column, ...]
as subquery
where 0 = 1;

- 테이블 구조만 복사되고, 데이터는 복사 안됨
- 무결성 제약 조건은 not null 조건만 복사되고, 기본키/외래키 무결성 제약조건은 복사 안됨
  디폴트 옵션에서 정의한 값도 복사가 안됨
*/

create table food_copy
as
select * from food
where 0 = 1; -- 값은 안가져오고 구조만

select * from food_copy;

desc food_copy;
drop table food_copy;

-- 테이블 목록 조회
select * from tab;

/*  ALTER TABLE 문
1) 컬럼 추가
[ 형식 ]
ALTER TABLE table_name
ADD ([COLUMN_NAME DATA_TYPE DEFAULT EXPR]
        [, COLUMN_NAME DATA_TYPE] ..);
*/
ALTER TABLE FOOD_COPY
ADD (START_DATE DATE DEFAULT SYSDATE);   -- 영업일 추가, 기본은 오늘날짜

ALTER TABLE FOOD_COPY
ADD (LOCATION_NAME VARCHAR2(50));

/*  
2) 컬럼 변경
[ 형식 ]
ALTER TABLE table_name
MODIFY ([COLUMN_NAME DATA_TYPE DEFAULT EXPR]
        [, COLUMN_NAME DATA_TYPE] ..);
-- 기존 컬럼에 데이터가 없는 경우 : 컬럼타입이나 크기 변경이 자유롭지만,
-- 데이터가 존재하는 경우 타입 변경 : CHAR, VARCHAR2만 허용됨
-- 변경한 컬럼의 크기 : 저장된 데이터의 크기와 같거나 클 경우에만 변경가능
-- 숫자 타입 : 폭 혹은 전체 자릿수를 늘릴 수 있음 
*/

-- 컬럼변경
ALTER TABLE FOOD_COPY
MODIFY PRICE NUMBER(10);

ALTER TABLE FOOD_COPY
MODIFY PRICE NUMBER(5);

DESC FOOD_COPY;

/*
3) 컬럼 제거
-- 2개 이상의 컬럼이 존재하는 테이블에서만 가능
-- 한 번에 하나의 컬럼만 삭제할 수 잇음, 삭제된 컬럼은 복구 불가능
[ 형식 ]
ALTER TABLE table_name
DROP COLUMN column_name;
*/
ALTER TABLE FOOD_COPY
DROP COLUMN LOCATION_NAME;

DESC FOOD_COPY;

/*
4) SET UNUSED
-- 시스템의 요구가 적을 때 삭제는 안하고 원하는 컬럼을 사용 안할 때 사용
-- DROP 명령보다 빠름
-- 삭제된 것처럼 처리해서 SELECT나 DESCRIBE(DESC)를 사용할 수 없음
[ 형식 ]
ALTER TABLE table_name
SET UNUSED (column_name);
*/

ALTER TABLE FOOD_COPY
SET UNUSED (START_DATE);

DESC FOOD_COPY;

/*
    * RENAME : 테이블 이름 변경
    [ 형식 ] RENAME 전 테이블 명 TO 새 테이블 명
*/

CREATE TABLE FOOD_TEST
AS
SELECT * FROM FOOD
WHERE 0 = 1;

RENAME FOOD_TEST TO FOOD_NEW;

SELECT * FROM TAB;

/*
    * DROP TABLE 문
    -- 기존의 테이블과 데이터 모두 제거
    -- 삭제할 테이블의 기본키나 고유키를 다른 테이블에서 참조하고 있는 경우 
       삭제가 불가능함 그래서 참조 중인 자식 테이블을 먼저 제거해야함
    -- 삽입은 부모 먼저, 삭제는 자식 먼저        
*/
DROP TABLE FOOD_NEW;

/*  * TRUNCATE 문
    -- 기존의 테이블의 모든 데이터 제거(DELETE와 같음)
*/
-- 1) 테이블 생성, 데이터 복사
CREATE TABLE FOOD_TEST
AS
SELECT * FROM FOOD;   -- 데이터까지 복사

-- INSERT로 데이터 복사
INSERT INTO FOOD_TEST
SELECT * FROM FOOD;
COMMIT;     -- 저장

ROLLBACK;    -- INSERT 후 COMMIT하지 않고 ROLLBACK하면 이전으로 돌아감

SELECT * FROM FOOD_TEST;

-- 2) TRUNCATE
TRUNCATE TABLE FOOD_TEST;

/*
    * 데이터 사전 : 다양한 정보를 저장하는 시스템 테이블의 집합
    -- 사용자가 테이블을 생성하거나 사용자를 변경하는 등의 작업을 할 때 
       데이터베이스 서버에 의해 자동으로 갱신되는 테이블
    -- 사용자는 데이터 사전의 내용을 직접 수정하거나 삭제할 수 없고 읽기전용 
       뷰 형태로 사용자에게 제공됨
    [ 종류 ]
    -- USER_    : 자신의 계정이 소유한 객체 등에 과한 정보조회
    -- ALL_     : 자신의 계정 소유했거나 권한을 부여받은 객체 등에 관한 정보조회
    -- DBA_     : 데이터베이스 관리자만 접근가능한 객체등의 정보조회
*/
-- 1) USER_
--    USER_TABLE        : 사용자가 소유한 테이블의 정보
--    USER_SEQUENCES    : 사용자가 소유한 시퀀스의 정보
--    USER_INDEXES      : 사용자가 소유한 인덱스 정보를 조회
--    USER_VIEW         : 사용자가 소유한 뷰 정보를 조회할 수 있는 데이터 사전
SELECT
    TABLE_NAME
FROM USER_TABLES;       -- 내가 가지고 있는 테이블 보여줌

-- 2) ALL_
--    ALL_TABLE         : 모든 테이블 조회
SELECT
    OWNER, TABLE_NAME
FROM ALL_TABLES;

-- 3) DBA_
--    - DBA나 시스템 권한을 가진 사용자만 접근 가능
--    - 현재 사용자가 HR이라면 DBA_로 시작하는 데이터 사전을 조회할 권한이 없음
SELECT
    OWNER, TABLE_NAME
FROM DBA_TABLES;

--------------------------------------------------------------------------------
