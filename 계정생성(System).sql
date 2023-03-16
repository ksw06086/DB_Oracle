/*
cmd 상태
교육용 hr 계정 사용하려면

1. sqlplus system/oracle로 접속

2. 락해제
   alter user hr account unlock;  

3. 패스워드 변경
   --alter user <계정이름> identified by <패스워드>;
   alter user hr identified by tiger;

----------------------------------------
- [ 새로운 계정 생성 ]
- System 계정에서 아래 명령어 작성

4-1. 계정생성(oracle 12c 이전버전)
   -- create user <계정이름> identified by <계정암호> default tablespace users;
      create user scott identified by tiger default tablespace users(테이블 공간은 유저에게 주겠다.);
4-2. 계정생성(oracle 12c 이후버전)
   -- create user "C##계정이름" identified by "계정암호" default tablespace users;
      create user "C##scott" identified by "tiger" default tablespace users(테이블 공간은 유저에게 주겠다.);
   -- 미리 alter session set "_ORACLE_SCRIPT"=TRUE;로 해주면 이전버전으로 가능
5. 사용자 권한 부여
   -- grant connect, resource to scott;

6. 락 해제
   -- alter user <계정이름> account unlock;
   alter user madang account unlock;  ( 락을 풀겠다. )

7.  계정 잘못만든 경우 계정 삭제하기(잘못된 경우) 
  --  drop user <계정이름> cascade;
   drop user scott cascade (삭제);
   
8. sql developer에서 계정생성
*/
-- 사용자 계정 생성
-- CREATE user "C##madang" identified by 1234 DEFAULT tablespace users;
ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;
CREATE user adang identified by 1234 DEFAULT tablespace users;

-- 사용자 권한 부여
-- GRANT CONNECT, RESOURCE to "C##madang";
GRANT CONNECT, RESOURCE to adang;

-- view 생성권한 부여
-- grant create view to "C##madang";
grant create view to adang;  
grant unlimited tablespace to "C##madang";  -- 모든 테이블스페이스를 제한없이 사용할 수 있음

-- 계정해제
-- ALTER USER "C##madang" ACCOUNT UNLOCK;
ALTER USER adang ACCOUNT UNLOCK;

-- 계정삭제
drop USER ADANG CASCADE;