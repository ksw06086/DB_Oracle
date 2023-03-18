/*  중요!!  
    ㅁ 시퀀스와 인덱스
    -- PRIMARY KEY로 지정한 칼럼에 일련번호를 자동으로 부여받기 위해 시퀀스를 사용
    -- 테이블 내의 유일한 숫자를 자동으로 생성해주고, 주로 기본키로 사용함
    [ 형식 ] 
    CREATE SEQUENCE sequence_name
    [START WITH N] -- ① 
    [INCREMENT BY N] -- ②
    [(MAXVALUE N | NOMAXVALUE)] -- ③
    [(MINVALUE N | NOMINVALUE)] -- ④
    [(CYCLE | NOCYCLE)] -- ⑤
    [(CACHE N | NOCACHE)] -- ⑥
    
    ① START WITH
    -- 시퀀스 번호의 시작 값을 지정할 때 사용
    ② INCREMENT BY
    -- 연속적인 시퀀스 번호의 증가치를 지정할 때 사용
    ③ MAXVALUE N
    -- 시퀀스가 가질 수 있는 최대값을 지정
    ④ MINVALUE N
    -- 시퀀스가 가질 수 있는 최소값을 지정
    ⑤ CYCLE | NOCYCLE
    -- 지정된 시퀀스 값이 최대값까지 증가가 완료되게 되면 다시 START WITH 옵션에 지정한
       시작 값에서 다시 시퀀스를 시작함
    -- NOCYCLE인 상태에서 최대값을 지났다면 에러를 발생함
    ⑥ CACHE | NOCACHE
    -- 메모리에 미리 값을 할당해 놓아서 속도가 빠름
    
    -- NEXTVAL : 다음 값을 알아냄 || CURRVAL : 현재 값을 알아냄
    -- 즉, NEXTVAL로 새로운 값을 생성한 다음 이 값을 CURRVAL로 가져옴
       만일 새로만든 시퀀스에 NEXTVAL을 상요하지 않고 바로 CURRVAL을 하면 오류남
       
    < NEXTVAL, CURRVAL을 사용할 수 있는 경우 >
    ㅁ 서브쿼리가 아닌 SELECT 문
    ㅁ INSERT 문의 SELECT 절
    ㅁ INSERT 문의 VALUE 절
    ㅁ UPDATE 문의 SET 절
    
    < NEXTVAL, CURRVAL을 사용할 수 없는 경우 >
    ㅁ VIEW의 SELECT 절
    ㅁ DISTINCT 키워드가 있는 SELECT 문
    ㅁ GROUP BY, HAVING, ORDER BY 절이 있는 SELECT 문
    ㅁ SELECT, DELETE, UPDATE의 서브쿼리
    ㅁ CREATE TABLE, ALTER TABLE 명령의 DEFAULT 값
    
    -- 삭제 : DROP SEQUENCE 시퀀스명;
    -- 수정 : ALTER SEQUENCE 시컨스명 ... ;
*/
DROP SEQUENCE EMP_SEQ;
CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 999
CYCLE;

DROP SEQUENCE DEPT_SEQ;
CREATE SEQUENCE DEPT_SEQ
START WITH 10
INCREMENT BY 10
MAXVALUE 999
CYCLE;

SELECT EMP_SEQ.NEXTVAL
FROM DUAL;

SELECT EMP_SEQ.CURRVAL
FROM DUAL;

SELECT DEPT_SEQ.NEXTVAL
FROM DUAL;

SELECT DEPT_SEQ.CURRVAL
FROM DUAL;

-- 시퀀스 데이터사전에서 시퀀스 조회
SELECT * FROM user_sequences;

DROP SEQUENCE EMP_SEQ;
DROP SEQUENCE DEPT_SEQ;

SELECT * FROM user_sequences;

SELECT * FROM DEPT;

-- 부서 테이블 생성
-- 자식 테이블부터 DROP하고, CREATE는 부모부터
DROP TABLE EMP;
CREATE TABLE DEPT(
    DEPTNO      NUMBER(3),
    DEPT_NAME   VARCHAR2(50) CONSTRAINT DEPT_DEPT_NAME_NN NOT NULL,
    LOC         VARCHAR2(50),
    CONSTRAINT DEPT_DEPT_NO_PK PRIMARY KEY(DEPTNO)
);

-- 사원 테이블 생성
CREATE TABLE EMP(
    EMPNO   NUMBER,
    ENAME   VARCHAR2(20) NOT NULL,
    HIRE_DATE   DATE    DEFAULT SYSDATE,
    SALARY  NUMBER CHECK(SALARY>0),
    DEPTNO NUMBER,
    EMAIL VARCHAR2(60),
    PRIMARY KEY(EMPNO),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT(DEPTNO) ON DELETE CASCADE,
    UNIQUE(EMAIL)
);

-- DEPT 데이터 삽입
INSERT into dept
values(dept_seq.nextval, 'IT1', '시에틀');
INSERT into dept
values(dept_seq.nextval, 'IT2', '핀란드');
INSERT into dept
values(dept_seq.nextval, 'IT3', '뉴욕');
INSERT into dept
values(dept_seq.nextval, 'IT4', '워싱턴');
INSERT into dept
values(dept_seq.nextval, 'IT5', '파리');
INSERT into dept
values(dept_seq.nextval, 'IT6', '도쿄');
INSERT into dept
values(dept_seq.nextval, 'IT7', '홍콩');
INSERT into dept
values(dept_seq.nextval, 'IT8', '아프리카');
INSERT into dept
values(dept_seq.nextval, 'IT9', '중국');
INSERT into dept
values(dept_seq.nextval, 'IT10', '스톡홀롬');

-- EMP 데이터 삽입
insert into emp
values(emp_seq.nextval, '홍길동1', '19/01/01', 10000, dept_seq.nextval, 'hong1@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동2', '19/02/01', 20000, dept_seq.nextval, 'hong2@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동3', '19/03/01', 30000, dept_seq.nextval, 'hong3@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동4', '19/04/01', 40000, dept_seq.nextval, 'hong4@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동5', '19/05/01', 50000, dept_seq.nextval, 'hong5@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동6', '19/06/01', 60000, dept_seq.nextval, 'hong6@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동7', '19/07/01', 70000, dept_seq.nextval, 'hong7@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동8', '19/08/01', 80000, dept_seq.nextval, 'hong8@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동9', '19/09/01', 90000, dept_seq.nextval, 'hong9@naver.com');
insert into emp
values(emp_seq.nextval, '홍길동10', '19/10/01', 100000, dept_seq.nextval, 'hong10@naver.com');
SELECT
    *
FROM dept;
SELECT
    *
FROM emp;
commit;

/*  ㅁ 조회시 성능 향상을 위한 인덱스
    -- 인덱스는 검색 속도를 향상시키기 위해서 사용
    -- 인덱스 객체에 대한 정보는 USER_COLUMNS와 USER_IND_COLUMNS 데이터 사전을 통해서 살펴볼 수 잇음
    -- 기본키나 유일키는 인덱스가 자동으로 생성됨
    [ 형식 ] 
    -- 생성
    CREATE INDEX index_name
    ON table_name[column_name];
    -- USER_IND_COLUMNS 데이터 사전으로 인덱스 생성 확인하기
    SELECT INDEX_NAME, TABLE_NAME, COLUMN_NAME
    FROM USER_IND_COLUMNS
    WHERE TABLE_NAME IN ('대문자 테이블명');
    -- 제거
    DROP INDEX index_name;
    
    < 인덱스 종류 >
    -- 고유인덱스 / 비 고유 인덱스 / 단일 인덱스 / 결합 인덱스 / 함수기반 인덱스
*/

create TABLE DEPT_IDX
AS 
SELECT * FROM DEPT;

CREATE TABLE EMP_IDX
AS
SELECT * FROM EMP;

-- 1) 고유 인덱스 : 기본키나 유일키처럼 유일한 값을 갖는 컬럼에 생성하는 인덱스
--                 UNIQUE INDEX로 사용한다.
CREATE UNIQUE INDEX IDX_DEPT_DEPTNO
ON DEPT_IDX(DEPTNO);

-- 2) 비 고유 인덱스 : 중복된 데이터를 갖는 컬럼에 대해서 생성하는 인덱스(UNIQUE 붙이면 에러남)
CREATE INDEX IDX_EMP_ENAME
ON EMP_IDX(ENAME);

-- 3) 결합 인덱스 : 두개 이상의 컬럼으로 인덱스를 구성한다.
CREATE INDEX IDX_DEPT_COM
ON DEPT_IDX(DEPT_NAME, LOC);

--- 1,2,3을 잘 사용하는 편임

SELECT
 *
FROM USER_IND_COLUMNS
WHERE TABLE_NAME IN('EMP_IDX');

-- 4) 함수기반 인덱스
CREATE INDEX IDX_EMP_SALARY
ON EMP_IDX(SALARY * 12);

/*  ㅁ 인덱스 사용여부를 결정하기 위한 조건
    
    < 인덱스를 사용해야 하는 경우 >
    ㅁ 테이블에 행의 수가 많을 때
    ㅁ WHERE 문에 해당 컬럼이 많이 사용될 때
    ㅁ 검색결과가 전체 데이터의 2%~4% 정도 일 때
    ㅁ JOIN에 자주 사용되는 컬럼이나 NULL을 포함하는 컬럼이 많은 경우
    
    < 인덱스를 사용하지 말아야 하는 경우 >
    ㅁ 테이블에 행의 수가 적을 때
    ㅁ WHERE 문에 해당 컬럼이 자주 사용되지 않을 때
    ㅁ 검색결과가 전체 데이터의 10~15% 이상일 때
    ㅁ 테이블에 DML 작업이 많은 경우 즉, 입력 수정 삭제 등이 자주 일어날 때
*/