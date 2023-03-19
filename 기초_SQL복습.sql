DROP TABLE BOOK;
DROP TABLE CUSTOMER;
DROP TABLE ORDERS;

----------------------- CREATE -----------------------

-- 책
CREATE TABLE BOOK(
    BOOK_ID     NUMBER  PRIMARY KEY,
    BOOK_NAME   VARCHAR2(40),
    PUBLISHER   VARCHAR2(40),
    PRICE       NUMBER 
);

CREATE TABLE IMPORT_BOOK(
    BOOK_ID     NUMBER  PRIMARY KEY,
    BOOK_NAME   VARCHAR2(40),
    PUBLISHER   VARCHAR2(40),
    PRICE       NUMBER 
);

-- 고객
CREATE TABLE CUSTOMER(
    C_ID        NUMBER          PRIMARY KEY,
    C_NAME      VARCHAR2(40),
    ADDRESS     VARCHAR2(40),
    PHONE       VARCHAR2(20)
);

-- 주문
CREATE TABLE ORDERS(
    ORDER_ID    NUMBER      PRIMARY KEY,
    C_ID        NUMBER CONSTRAINT ORDERS_C_ID_FK REFERENCES CUSTOMER(C_ID),
    BOOK_ID     NUMBER CONSTRAINT ORDERS_BOOK_ID_FK REFERENCES BOOK(BOOK_ID),
    SALE_PRICE  NUMBER,
    ORDER_DATE  DATE DEFAULT SYSDATE
);

------------------------ INSERT ----------------------
insert into book
values (1, '축구의 역사', '굿스포츠', 7000);
insert into book
values (2, '아이즈원', '장원영', 13000);
insert into book
values (3, 'STAYC', '박시은', 22000);
insert into book
values (4, '별의 조각', '윤하', 35000);
insert into book
values (5, 'TRULY', '윤하', 8000);
insert into book
values (6, '그 때 헤어지면 돼', '로이킴', 6000);
insert into book
values (7, '마음의 주인', '이기주', 20000);
insert into book
values (8, '언어의 온도', '이기주', 13000);
insert into book
values (9, '나랑 사귈래', '다이아', 7500);
insert into book
values (10, '지금 널 찾아가고 있어', '세븐틴', 13000);
commit;

insert into CUSTOMER
values (1, '이민지', '대한민국 서울', '000-1000-0001');
insert into CUSTOMER
values (2, '이지은', '대한민국 서울', '000-2000-0001');
insert into CUSTOMER
values (3, '김해은', '대한민국 경기', '000-3000-0001');
insert into CUSTOMER
values (4, '정해인', '대한민국 인천', '000-4000-0001');
insert into CUSTOMER
values (5, '정원지', '대한민국 경기', NULL);

ROLLBACK;
COMMIT;

insert into ORDERS
values (1,1,1,6000,'2014-07-01');
insert into ORDERS
values (2,1,3,21000,'2014-07-03');
insert into ORDERS
values (3,2,5,8000,'2014-07-03');
insert into ORDERS
values (4,3,7,6000,'2014-07-04');
insert into ORDERS
values (5,4,2,20000,'2014-07-05');
insert into ORDERS
values (6,1,8,12000,'2014-07-07');
insert into ORDERS
values (7,4,6,13000,'2014-07-07');
insert into ORDERS
values (8,3,10,12000,'2014-07-08');
insert into ORDERS
values (9,2,10,7000,'2014-07-09');
insert into ORDERS
values (10,3,8,13000,'2014-07-10');

INSERT INTO IMPORT_BOOK VALUES(21, 'Zen Golf', 'Person', 12000);
INSERT INTO IMPORT_BOOK VALUES(22, 'Soccer Skills', 'Human Kinetics', 15000);
COMMIT;

SELECT * FROM BOOK;
SELECT * FROM IMPORT_BOOK;
SELECT * FROM CUSTOMER;
SELECT * FROM ORDERS;

-- 이지은 고객의 전화번호를 찾으시오
select c_name, phone
from customer
where c_name = '이지은';

-- 모든 도서의 이름과 가격을 검색하시오
select book_name, price from book;

-- 모든 도서의 가격과 이름을 검색하시오
select price, book_name from book;

-- 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
select * from book;

-- 도서테이블에 있는 모든 출판사를 검색하시오
select publisher from book;

-- 가격이 20000원 미만인 도서를 검색하시오
select * from book where price < 20000 order by price;

-- 가격이 10000원 이상 20000원 이하인 도서를 검색하시오.
select * from book where price between 10000 and 20000 order by price;

-- 출판사가 '굿스포츠' 혹은 '장원영'인 도서를 검색하시오.
select * from book where publisher in ('굿스포츠', '장원영');

-- '축구의 역사'를 출간한 출판사를 검색하시오.
select book_name, publisher from book where book_name = '축구의 역사';

-- 도서이름에 '축구'가 포함된 출판사를 검색하시오.
select book_name, publisher from book where book_name like '%축구%';

-- 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서를 검색하시오.
select * from book where book_name like '_구%';

-- 축구에 관한 도서 중 가격이 20000원 이상인 도서를 검색하시오.
select * from book where price >= 20000 and book_name like '%축구%';

-- 출판사가 '굿스포츠' 혹은 '장원영'인 도서를 검색하시오.
select *  from book where book_name like '%축구%';

-- 도서를 이름순으로 검색하시오
select * from book order by book_name;

-- 도서를 가격순으로 검색하고 가격이 같으면 이름순으로 검색하시오.
select * from book order by price, book_name;

-- 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색한다.
select * from book order by price desc, publisher;

-- 고객이 주문한 도서의 총 판매액을 구하시오
select sum(sale_price) "총 판매액" from orders;

-- 2번 이지은 고객이 주문한 도서의 총 판매액을 구하시오
select sum(sale_price) from orders where c_id = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
select sum(sale_price), avg(sale_price), min(sale_price), max(sale_price) from orders;

-- 마당서점의 도서 판매 건수를 구하시오.
select count(*) from orders;

-- 고객 별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
select c_id, count(*), sum(sale_price)
from orders
group by c_id;

-- 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오.
-- 단, 두권 이상 구매한 고객만 구한다.
select c_id, count(*) from orders
group by c_id
having count(*) >= 2
and max(sale_price) >= 8000;

-- 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오.
select c.*, o.* from customer c, orders o
where c.c_id = o.c_id
order by c.c_id;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
select c.c_name, o.sale_price from customer c, orders o
where c.c_id = o.c_id;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
select c.c_name, sum(o.sale_price) from customer c, orders o
where c.c_id = o.c_id
group by c.c_name
order by c.c_name;

-- 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
select c.c_name, b.book_name from customer c, orders o, book b
where c.c_id = o.c_id
and o.book_id = b.book_id
order by c.c_name;

-- 가격이 20000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
select c.c_name, b.book_name from customer c, orders o, book b
where c.c_id = o.c_id
and o.book_id = b.book_id
and b.price = 20000;

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
select c.c_name, o.sale_price from customer c, orders o
where c.c_id = o.c_id(+);

-- 가장 비싼 도서의 이름을 보이시오
select book_name from book
where price = (select max(price) from book);

-- 도서를 구매한 적이 잇는 고객의 이름을 검색하시오.
select c_name from customer
where c_id in (select distinct c_id from orders); 

-- 장원영에서 출판한 도서를 구매한 고객의 이름을 보이시오.
select c.c_name from customer c, orders o
where c.c_id = o.c_id
and o.book_id in (select book_id from book where publisher = '장원영');

-- 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
select
    *
from book b
where price > (select avg(price)
                from book p
               where p.publisher = b.publisher);
select publisher, avg(price)
from book p
group by publisher;

-- 도서를 주문하지 않은 고객의 이름을 보이시오.
select c_name
from customer
where c_id not in (select distinct c_id from orders);

-- 주문이 있는 고객의 이름과 주소를 보이시오.
select c_name, address
from customer
where c_id in (select distinct c_id from orders);

-- 다음과 같은 속성을 가진 NEWBOOK 테이블을 생성하시오, 정수형은 NUMBER를
-- 문자형은 가변형 문자타입인 VARCHAR2를 사용한다.
-- BOOK_ID - NUMBER 2
-- BOOK_NAME - VARCHAR2 20
-- PUBLISHER - VARCHAR2 20
-- PRICE - NUMBER 8
create table NEWBOOK(
    BOOK_ID NUMBER(2),
    BOOK_NAME VARCHAR2(20),
    PUBLISHER VARCHAR2(20),
    PRICE NUMBER
);

-- 다음과 같은 속성을 가진 NEWCUSTOMER 테이블을 생성하시오.
-- C_ID - NUMBER 기본키
-- C_NAME - VARCHAR2 40
-- ADDRESS - VARCHAR2 40
-- PHONE - VARCHAR2 30
CREATE TABLE NEWCUSTOMER(
    C_ID NUMBER PRIMARY KEY,
    C_NAME VARCHAR2(40),
    ADDRESS VARCHAR2(40),
    PHONE VARCHAR2(30)
);    

-- 다음과 같은 속성을 가진 NEWORDER 테이블을 생성하시오.
-- ORDER_ID - NUMBER 기본키
-- C_ID - NUMBER , NOT NULL, 왜래키
-- BOOK_ID - NUMBER, NOT NULL, 왜래키
-- SALE_PRICE - NUMBER
-- ORDER_DATE - DATE
CREATE TABLE NEWORDER(
    ORDER_ID NUMBER PRIMARY KEY,
    C_ID NUMBER NOT NULL REFERENCES CUSTOMER(C_ID) ON DELETE CASCADE,
    BOOK_ID NUMBER(2) NOT NULL REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
    SALE_PRICE NUMBER,
    ORDER_DATE DATE
);

-- NEWBOOK 테이블에 VARCHAR2 13의 자료형을 가진 ISBN 속성을 추가하시오.
ALTER TABLE NEWBOOK
ADD ISBN VARCHAR2(13);
-- NEWBOOK 테이블에 ISVN 속성의 데이터타입을 넘버형으로 변경하시오.
ALTER TABLE NEWBOOK
MODIFY ISBN NUMBER;
-- NEWBOOK 테이블에 ISBN 속성을 삭제하시오
ALTER TABLE NEWBOOK
DROP COLUMN ISBN;
-- NEWBOOK 테이블에 BOOK_ID 속성에 NOT NULL 제약조건을 적용하시오.
ALTER TABLE NEWBOOK
MODIFY BOOK_ID NUMBER NOT NULL;
-- NEWBOOK 테이블에 BOOK_ID 속성을 기본키로 변경하시오.
ALTER TABLE NEWBOOK
MODIFY BOOK_ID NUMBER PRIMARY KEY;
-- NEWBOOK 테이블을 삭제하시오.
DROP TABLE NEWBOOK;

