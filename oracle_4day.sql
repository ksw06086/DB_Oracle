/*  *** DML과 트랜잭션 ***
● DML : 테이블에 새로운 데이터를 삽입, 기존 데이터를 수정/삭제하기 위한 명령어의 집합
-- INSERT 문에서 삽입할 칼럼의 데이터 타입이 문자(CHAR, VARCHAR2)나 날짜(DATE)일 경우,
   반드시 작은 따옴표(' ')를 함께 사용해야합니다.

<> COMMIT    - 모든 작업들을 정상적으로 처리하겠다고 확정하는 명령어로 트랜잭션의
               처리과정을 데이터베이스에 모두 반영하기 위해서, 변경된 내용을 모두 영구저장함
             - INSERT, UPDATE, DELETE 후 (즉 DML) COMMIT;을 해야함
<> ROLLBACK  - 변경사항 취소 .. 반드시 COMMIT 전에 해야한다.
               트랜잭션으로 인한 하나의 묶음 처리가, 시작되기 이전의 상태로 되돌린다.
<> SAVEPOINT - 현재의 트랜잭션을 작게 분할함. 
               저장된 SAVEPOINT는 ROLLBACK TO SAVEPOINT문을 사용하여 표시한 곳까지 롤백할 수 잇다.
               1) SAVEPOINT SAVEPOINT명; 2) ROLLBACK TO SAVEPOINT명;

● 트랜잭션 : 데이터 처리에서 논리적인 하나의 작업단위
-- 1. COMMIT 혹은 ROLLBACK문이 실행되는 경우
-- 2. DDL, DCL문이 실행되는 경우
-- 3. 트랜잭션이 비정상종료되는 경우(작업 중간에 종료됨, COMMIT 후 일처리에서 에러남 등)
-- <자동 COMMIT, ROLLBACK>
-- DDL, DCL 문이 실행되는 경우에는 자동으로 COMMIT 되고,
-- 트랜잭션이 비정상 종료되는 경우에는 자동으로 ROLLBACK된다.
*/

/* 1. INSERT 문
[ 형식 ]
INSERT INTO TABLE_NAME (컬럼명1, 컬럼명2, ...)
VALUES (컬럼 값1, 컬럼 값2, ...);
*/
CREATE TABLE MOVIE(
    code        number(3)       primary key,
    movie_name  varchar2(50),
    place       varchar2(50),
    price       number(7)       default 0,
    person      number(3)       default 0
);

insert into movie(code, movie_name, place, price, person)
values (1, '어벤쳐스', 'IMAX', 24000, 3);

insert into movie(code, movie_name, place, price, person)
values (2, '장난스런 키스', 'CGV', 14000, 2);

insert into movie(code, movie_name, place, price, person)
values (3, '생일', 'ALL', 9900, 4);

insert into movie(code, movie_name, place, price, person)
values (4, '극한직업', 'CGV', 14000, 1);

insert into movie(code, movie_name, place, price, person)
values (5, '스즈메의 문단속', '롯데시네마', 12000, 1);

SELECT
    *
FROM MOVIE;

ROLLBACK;
COMMIT;

-- START_DATE 컬럼 추가
ALTER TABLE MOVIE
ADD START_DATE DATE DEFAULT SYSDATE;

DROP TABLE MOVIE;

/* 테이블 복사
    1) 구조만 복사 후 데이터 복사
    2) 구조와 데이터 모두 복사
*/
-- 1)
CREATE TABLE MOVIE_COPY
AS SELECT * FROM MOVIE
WHERE 0 = 1;  -- 구조 복사

INSERT INTO MOVIE_COPY
SELECT * FROM MOVIE;  -- 데이터 복사

DROP TABLE MOVIE_COPY;

-- 2)
CREATE TABLE MOVIE_COPY
AS SELECT * FROM MOVIE;

/* 2. UPDATE 문
[ 형식 ]
UPDATE table_name
SET column_name1 = value1, column_name2 = value2
where conditions ;
*/
update movie
set place = 'MEGA', PRICE = 10000, PERSON = 6, START_DATE = '2023-05-03'
WHERE CODE = 5;
COMMIT;
ROLLBACK;
SELECT * FROM MOVIE;

select * from food;

update food set food.restaurant_name = '베이징', food_name = '탕수육',
            PRICE = 15000, STARPOINT = 5
WHERE FOOD_CODE = 3;

update food set food.restaurant_name = '구내식당', food_name = '잡채밥',
            PRICE = 10000, STARPOINT = 3
WHERE FOOD_CODE = 1;

COMMIT;

/* UPDATE에서 서브쿼리 활용하기 */
UPDATE FOOD SET FOOD_NAME = (SELECT FOOD_NAME FROM FOOD WHERE FOOD_CODE = 3),
        KIND = (SELECT KIND FROM FOOD WHERE FOOD_CODE = 3)
WHERE FOOD_CODE = 1;

UPDATE FOOD SET (FOOD_NAME, KIND, PRICE) = 
            (SELECT FOOD_NAME, KIND, PRICE FROM FOOD WHERE FOOD_CODE = 4) 
WHERE FOOD_CODE = 1;

/* 3. DELETE 문
[ 형식 ]
DELETE [FROM] TABLE_NAME
WHERE CONDITIONS;
*/
SELECT * FROM FOOD_TEST;

-- FOOD_CODE 3인 데이터 삭제
DELETE FROM FOOD_TEST
WHERE FOOD_CODE = 3;

COMMIT;

-- FOOD_NAME이 모밀을 포함하는 데이터 삭제
DELETE FOOD_TEST
WHERE FOOD_NAME LIKE '%모밀%';

-- 5번의 PRICE보다 큰 PRICE를 모두 삭제
DELETE FOOD
WHERE PRICE > (SELECT PRICE FROM FOOD WHERE FOOD_CODE = 5);

SELECT * FROM FOOD;
SELECT * FROM MOVIE;

-- START_DATE 가 화면에서 2023-05-03로 입력된 START_DATE 삭제
DELETE FROM MOVIE
WHERE START_DATE = '2023-05-03';
ROLLBACK;

CREATE TABLE DEPT_TR(
    deptno      number          primary key,
    deptname    varchar2(40)    not null,
    loc         varchar2(50));
    
insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (10, 'IT', '서울');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (20, '기획', '서울');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (30, '영업', '서울');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (40, '마케팅', '서울');

insert INTO DEPT_TR(DEPTNO, DEPTNAME, LOC)
VALUES (50, '개발', '서울');

COMMIT;

SELECT * FROM DEPT_TR;
-- 트랜잭션
-- 1) 40번 부서 삭제 후 COMMIT
DELETE DEPT_TR
WHERE DEPTNO = 40;

COMMIT;
ROLLBACK;

-- 2) 30번 부서 삭제 후 세이브 C1 설정
DELETE DEPT_TR
WHERE DEPTNO = 30;
SAVEPOINT C1;      -- SAVEPOINT가 생성되었습니다.

-- 3) 20번 부서 삭제 후 세이브 C2 설정
DELETE DEPT_TR
WHERE DEPTNO = 20;
SAVEPOINT C2;      -- SAVEPOINT가 생성되었습니다.

-- 4) 10번 부서 삭제 후 조회
DELETE DEPT_TR
WHERE DEPTNO = 10;
SELECT * FROM DEPT_TR;

-- 5) 10번 부서 삭제 취소
rollback to c2;
-- 6) 20번 부서 삭제 취소
rollback to c1;
-- 7) 30번 부서 삭제 취소
rollback;
-- 8) 40번 부서 삭제 취소
rollback;

/*  * 데이터 무결성과 제약 조건
    1. 제약 조건 : 테이블에 유효하지 않은 데이터가 입력되는 것을 방지하기 위해서
                  테이블 생성 시 각 컬럼에 대해 정의하는 규칙
    <ORACLE 제약조건 종류>
    NOT NULL        - 칼럼에 NULL 값을 포함하지 못하도록 지정한다.
    UNIQUE          - 테이블의 모든 로우에 대해서 유일한 값을 갖도록 한다.
    PRIMARY KEY     - 테이블의 각 행을 식별하기 위한 것으로 NULL과 중복된 값을 허용 안함
                      즉, NOT NULL 조건과 UNIQUE 조건을 결합한 형태이다.
    FOREIGN KEY     - 참조되는 테이블에 컬럼 값이 항상 존재해야 한다.
    CHECK           - 저장 가능한 데이터 값의 범위나 조건을 지정하여 설정한 값만을 허용한다.
    
    -- 제약조건 명 : 테이블명_컬럼명_키
    -- 제약조건에 따른 INSERT, DELETE.. 중요!
       1. 부모테이블의 PK 컬럼에 데이터가 존재해야
          자식테이블의 FK 컬럼에 데이터 INSERT가 가능하다.
       2. 자식테이블의 FK 컬럼으로 사용되는 행이 존재하면, 부서테이블의 PK 컬럼을
          포함한 행은, 자식 FK 데이터를 먼저 삭제 후, 부모 데이터를 삭제한다.
*/

-- 제약조건 정보 가저오기
SELECT
    CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM SYS.USER_CONSTRAINTS;

-- 부서 테이블 생성
CREATE TABLE DEPT2(
    DEPTNO          NUMBER,
    DEPTNAME        VARCHAR2(50) CONSTRAINT DEPT_DEPTNAME_NN NOT NULL,
    LOC             VARCHAR2(50),
    CONSTRAINT  DEPT_DEPTNO_PK PRIMARY KEY(DEPTNO)
);

CREATE TABLE EMP2(
    EMPNO           NUMBER,
    ENAME           VARCHAR2(20) NOT NULL,
    HIRE_DATE       DATE        DEFAULT SYSDATE,
    SALARY          NUMBER  CONSTRAINT EMP2_SALARY_MIN CHECK(SALARY > 0),
    DEPTNO          NUMBER,
    EMAIL           VARCHAR2(60),
    CONSTRAINT EMP2_EMPNO_PK PRIMARY KEY(EMPNO),
    CONSTRAINT EMP2_DEPTNO_FK   FOREIGN KEY(DEPTNO) REFERENCES DEPT2(DEPTNO)
                ON DELETE CASCADE,  -- 자식 테이블에 설정하면 부모테이블 삭제시 자식도 삭제
    CONSTRAINT EMP2_EMAIL_UK     UNIQUE(EMAIL)
);

INSERT INTO DEPT2
VALUES (101, 'IT', '서울');
INSERT INTO DEPT2
VALUES (102, 'SALES', '뉴욕');
INSERT INTO DEPT2
VALUES (103, 'ACCOUNT', '도쿄');
INSERT INTO DEPT2
VALUES (104, 'HR', '파리');
INSERT INTO DEPT2
VALUES (105, 'CLERK', '두바이');
INSERT INTO DEPT2
VALUES (106, 'TT', '무인도');

INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1001, '소지섭', '2023-03-20', 2500000, 101, 'so@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1002, '정승훈', '2023-03-21', 3000000, 102, 'jun@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1003, '김진태', '2023-03-22', 2000000, 103, 'kim@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1004, '윤수빈', '2023-04-20', 2100000, 104, 'yoon@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1005, '정병권', '2023-05-01', 2000000, 105, 'osan@naver.com');
INSERT INTO EMP2(EMPNO, ENAME, HIRE_DATE, SALARY, DEPTNO, EMAIL)
VALUES(1006, '장원영', '2023-05-03', 1900000, 106, 'kimsw@naver.com');
select * from dept2;
select * from emp2;
commit;

insert into dept2
values (107, 'SERVICE', '강남');

INSERT INTO EMP2
VALUES (1007, '장원영', '2023-05-03', 1900000, 106, 'kims@naver.com');

UPDATE EMP2
SET DEPTNO = 107
WHERE EMPNO = 1007;

-- 급여가 음수일 때
INSERT INTO EMP2
VALUES (1008, '장원영2', '2023-05-03', -400000, 106, 'kims@naver.com'); -- 에러

----------------------------------------------------------------------
------------------ 테이블 생성 컬럼 레벨 ------------------
----------------------------------------------------------------------
-- 부서 테이블 생성
CREATE TABLE DEPT_RE2(
    DEPTNO          NUMBER  CONSTRAINT DEPT_RE2_DEPTNO_PK PRIMARY KEY,
    DEPTNAME        VARCHAR2(50) CONSTRAINT DEPT_RE2_DEPTNAME_NN NOT NULL,
    LOC             VARCHAR2(50)
);

-- 사원 테이블 생성
CREATE TABLE EMP_RE2(
    EMPNO           NUMBER CONSTRAINT EMP_RE2_EMPNO_PK PRIMARY KEY,
    ENAME           VARCHAR2(20) CONSTRAINT EMP_RE2_ENAME NOT NULL,
    HIRE_DATE       DATE DEFAULT SYSDATE,
    SALARY          NUMBER  CONSTRAINT EMP_RE2_SALARY_CHK CHECK(SALARY > 0),
    DEPTNO          NUMBER  CONSTRAINT EMP_RE2_DEPTNO_FK REFERENCES DEPT_RE2(DEPTNO),
    EMAIL           VARCHAR2(60)  CONSTRAINT EMP_RE2_EMAIL_UQ UNIQUE
);

/*   뷰의 개념과 사용하기
    ㅁ 정의 : 쿨리적인 테이블을 근거한 논리적인 가상 테이블 디스크 저장공간이 할당되지 않음.
             즉, 실질적으로 데이터를 저장하지 않고, 데이터 사전에, 뷰를 정의할 때
             기술한 쿼리문만 저장되어 있음. 하지만 사용방법은 테이블에서 파생된 객체 
             테이블과 유사하기 때문에 '가상 테이블'이라 한다.
             뷰의 정의는 user_views 데이터 사전을 통해 조회 가능하다.
    
    ㅁ 동작원리
    -- 뷰는 데이터를 저장하고 있지 않은 가상 테이블이므로 실체가 없음
    -- 뷰는 테이블처럼 사용될 수 잇는 이유는 뷰를 정의할 때 create view 명령어 다음의
       as 절에 기술한 쿼리 문장 자체를 저장하고 있다가 이를 실행하기 때문
    -- select문의 from절에서 v_emp로 기술하여 정의하면,
       오라클서버는 user_views에서 v_emp(key)를 찾는다.
    -- 기술했던 서브쿼리문장이 저장된 text값을 view 즉 v_emp 위치로 가져와서 실행한다.
    
    ㅁ 뷰를 사용하는 이유
    -- 보안과 사용의 편의성 때문
    -- 자주 사용하는 복잡하고 긴 쿼리문을 뷰로 정의하면, 접근을 단순화 할 수 잇고, 
       보안에 유리함
    -- 권한별로 접근이 제한되어서, 동일한 테이블에 접근하는 사람들마다 다른 뷰에 
       접근하도록 할 수 있다.
    
    ㅁ view 생성권한 부여, system 계정에서 실행
    -- grant create view to scott;
*/
CREATE VIEW V_EMP_DEPT2
AS
-- USER_VIEW의 TEXT 부분
SELECT E.EMPNO, E.ENAME, E.EMAIL, E.HIRE_DATE, E.DEPTNO, D.DEPTNAME, D.LOC
FROM EMP2 E, DEPT2 D
WHERE D.DEPTNO = E.DEPTNO;

SELECT * FROM V_EMP_DEPT2;

-- 데이터 사전에서 뷰 조회
SELECT 
    VIEW_NAME, TEXT
FROM USER_VIEWS;

/*  뷰 제거하기
[ 형식 ] DROP VIEW (VIEW) [, .. N]
-- 뷰는 실체가 없는 가상테이블이기 때문에 뷰를 삭제한다는 것은 USER_VIEWS 데이터
   딕셔너리에 저장되어 있는 뷰의 정의를 삭제하는 것을 의미한다.
-- 뷰를 정의한 기본테이블의 구조나 데이터에는 영향이 없다.
*/
DROP VIEW V_EMP_DEPT2;
SELECT
 *
FROM USER_VIEWS;

/*
    ㅁ CREATE OR REPLACE VIEW
    -- 이미 존재하는 뷰에 대해서 그 내용을 새롭게 변경하여 재생성
    ㅁ WITH READ ONLY : 해당 뷰를 통해서는 SELECT만 가능함
    -- 이거 없으면 단일 테이블의 경우 데이터 추가/수정/삭제 가능
    ㅁ WITH CHECK OPTION
    -- 해당 뷰를 통해서 볼 수 있는 범위 내에서만 UPDATE 또는 INSERT가 가능함
    -- 즉, 뷰를 생성할 때 조건 제시에 사용된 컬럼값이 아닌 값을 변경 못하도록 하는 기능 제공
    -- 즉, 조건 제시된 값만 INSERT, UPDATE 가능
    
    * 중요!!! WITH READ ONLY를 하지 않고 VIEW를 만든 상태에서 DML 용어를 사용하면
      VIEW만이 아닌 테이블에도 영향이 감  
*/
-- ㅁ WITH READ ONLY
CREATE OR REPLACE VIEW V_EMP_READONLY
AS
SELECT EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO
FROM EMP2
WITH READ ONLY;

-- ERROR : cannot perform a DML operation on a read-only view
INSERT INTO V_EMP_READONLY(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(2001, '보아', 'BOA@NAVER.COM', SYSDATE, 105);

-- ㅁ WITH CHECK OPTION
CREATE OR REPLACE VIEW V_EMP_OPTION
AS
SELECT EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO
FROM EMP2
WHERE EMPNO IN(3001,3002)   -- INSERT, UPDATE 허용범위
WITH CHECK OPTION;

INSERT INTO V_EMP_OPTION(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(3001, '이순신', 'LEE@NAVER.COM', SYSDATE, 105); -- INSERT

INSERT INTO V_EMP_OPTION(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(3002, '이지민', 'JMLEE@NAVER.COM', SYSDATE, 105); -- INSERT

INSERT INTO V_EMP_OPTION(EMPNO, ENAME, EMAIL, HIRE_DATE, DEPTNO)
VALUES(3003, '김민지', 'KIM@NAVER.COM', SYSDATE, 105); -- ERROR

COMMIT;

UPDATE V_EMP_OPTION
SET EMAIL = 'LEE@GMAIL.COM'
WHERE EMPNO = 3001;

UPDATE V_EMP_OPTION
SET EMAIL = 'JMLEE@GMAIL.COM'
WHERE EMPNO = 3002;

UPDATE V_EMP_OPTION
SET EMAIL = 'KIM@GMAIL.COM'
WHERE EMPNO = 3003;

SELECT
    *
FROM V_EMP_READONLY;    -- 입력과 수정 모두 성공인 경우에만

-- 실제 테이블, VIEW 테이블 모두 업데이트 되었고 INSERT 되었음(중요!)
SELECT * FROM EMP2;

