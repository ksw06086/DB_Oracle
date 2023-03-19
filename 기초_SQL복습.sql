DROP TABLE BOOK;
DROP TABLE CUSTOMER;
DROP TABLE ORDERS;

----------------------- CREATE -----------------------

-- å
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

-- ��
CREATE TABLE CUSTOMER(
    C_ID        NUMBER          PRIMARY KEY,
    C_NAME      VARCHAR2(40),
    ADDRESS     VARCHAR2(40),
    PHONE       VARCHAR2(20)
);

-- �ֹ�
CREATE TABLE ORDERS(
    ORDER_ID    NUMBER      PRIMARY KEY,
    C_ID        NUMBER CONSTRAINT ORDERS_C_ID_FK REFERENCES CUSTOMER(C_ID),
    BOOK_ID     NUMBER CONSTRAINT ORDERS_BOOK_ID_FK REFERENCES BOOK(BOOK_ID),
    SALE_PRICE  NUMBER,
    ORDER_DATE  DATE DEFAULT SYSDATE
);

------------------------ INSERT ----------------------
insert into book
values (1, '�౸�� ����', '�½�����', 7000);
insert into book
values (2, '�������', '�����', 13000);
insert into book
values (3, 'STAYC', '�ڽ���', 22000);
insert into book
values (4, '���� ����', '����', 35000);
insert into book
values (5, 'TRULY', '����', 8000);
insert into book
values (6, '�� �� ������� ��', '����Ŵ', 6000);
insert into book
values (7, '������ ����', '�̱���', 20000);
insert into book
values (8, '����� �µ�', '�̱���', 13000);
insert into book
values (9, '���� ��з�', '���̾�', 7500);
insert into book
values (10, '���� �� ã�ư��� �־�', '����ƾ', 13000);
commit;

insert into CUSTOMER
values (1, '�̹���', '���ѹα� ����', '000-1000-0001');
insert into CUSTOMER
values (2, '������', '���ѹα� ����', '000-2000-0001');
insert into CUSTOMER
values (3, '������', '���ѹα� ���', '000-3000-0001');
insert into CUSTOMER
values (4, '������', '���ѹα� ��õ', '000-4000-0001');
insert into CUSTOMER
values (5, '������', '���ѹα� ���', NULL);

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

-- ������ ���� ��ȭ��ȣ�� ã���ÿ�
select c_name, phone
from customer
where c_name = '������';

-- ��� ������ �̸��� ������ �˻��Ͻÿ�
select book_name, price from book;

-- ��� ������ ���ݰ� �̸��� �˻��Ͻÿ�
select price, book_name from book;

-- ��� ������ ������ȣ, �����̸�, ���ǻ�, ������ �˻��Ͻÿ�.
select * from book;

-- �������̺� �ִ� ��� ���ǻ縦 �˻��Ͻÿ�
select publisher from book;

-- ������ 20000�� �̸��� ������ �˻��Ͻÿ�
select * from book where price < 20000 order by price;

-- ������ 10000�� �̻� 20000�� ������ ������ �˻��Ͻÿ�.
select * from book where price between 10000 and 20000 order by price;

-- ���ǻ簡 '�½�����' Ȥ�� '�����'�� ������ �˻��Ͻÿ�.
select * from book where publisher in ('�½�����', '�����');

-- '�౸�� ����'�� �Ⱓ�� ���ǻ縦 �˻��Ͻÿ�.
select book_name, publisher from book where book_name = '�౸�� ����';

-- �����̸��� '�౸'�� ���Ե� ���ǻ縦 �˻��Ͻÿ�.
select book_name, publisher from book where book_name like '%�౸%';

-- �����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ������ �˻��Ͻÿ�.
select * from book where book_name like '_��%';

-- �౸�� ���� ���� �� ������ 20000�� �̻��� ������ �˻��Ͻÿ�.
select * from book where price >= 20000 and book_name like '%�౸%';

-- ���ǻ簡 '�½�����' Ȥ�� '�����'�� ������ �˻��Ͻÿ�.
select *  from book where book_name like '%�౸%';

-- ������ �̸������� �˻��Ͻÿ�
select * from book order by book_name;

-- ������ ���ݼ����� �˻��ϰ� ������ ������ �̸������� �˻��Ͻÿ�.
select * from book order by price, book_name;

-- ������ ������ ������������ �˻��Ͻÿ�. ���� ������ ���ٸ� ���ǻ��� ������������ �˻��Ѵ�.
select * from book order by price desc, publisher;

-- ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�
select sum(sale_price) "�� �Ǹž�" from orders;

-- 2�� ������ ���� �ֹ��� ������ �� �Ǹž��� ���Ͻÿ�
select sum(sale_price) from orders where c_id = 2;

-- ���� �ֹ��� ������ �� �Ǹž�, ��հ�, ������, �ְ��� ���Ͻÿ�.
select sum(sale_price), avg(sale_price), min(sale_price), max(sale_price) from orders;

-- ���缭���� ���� �Ǹ� �Ǽ��� ���Ͻÿ�.
select count(*) from orders;

-- �� ���� �ֹ��� ������ �� ������ �� �Ǹž��� ���Ͻÿ�.
select c_id, count(*), sum(sale_price)
from orders
group by c_id;

-- ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ������ ���Ͻÿ�.
-- ��, �α� �̻� ������ ���� ���Ѵ�.
select c_id, count(*) from orders
group by c_id
having count(*) >= 2
and max(sale_price) >= 8000;

-- ���� ���� �ֹ��� ���� �����͸� ����ȣ ������ �����Ͽ� ���̽ÿ�.
select c.*, o.* from customer c, orders o
where c.c_id = o.c_id
order by c.c_id;

-- ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻��Ͻÿ�.
select c.c_name, o.sale_price from customer c, orders o
where c.c_id = o.c_id;

-- ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ�, ������ �����Ͻÿ�.
select c.c_name, sum(o.sale_price) from customer c, orders o
where c.c_id = o.c_id
group by c.c_name
order by c.c_name;

-- ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�.
select c.c_name, b.book_name from customer c, orders o, book b
where c.c_id = o.c_id
and o.book_id = b.book_id
order by c.c_name;

-- ������ 20000���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�.
select c.c_name, b.book_name from customer c, orders o, book b
where c.c_id = o.c_id
and o.book_id = b.book_id
and b.price = 20000;

-- ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� ���Ͻÿ�.
select c.c_name, o.sale_price from customer c, orders o
where c.c_id = o.c_id(+);

-- ���� ��� ������ �̸��� ���̽ÿ�
select book_name from book
where price = (select max(price) from book);

-- ������ ������ ���� �մ� ���� �̸��� �˻��Ͻÿ�.
select c_name from customer
where c_id in (select distinct c_id from orders); 

-- ��������� ������ ������ ������ ���� �̸��� ���̽ÿ�.
select c.c_name from customer c, orders o
where c.c_id = o.c_id
and o.book_id in (select book_id from book where publisher = '�����');

-- ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ������ ���Ͻÿ�.
select
    *
from book b
where price > (select avg(price)
                from book p
               where p.publisher = b.publisher);
select publisher, avg(price)
from book p
group by publisher;

-- ������ �ֹ����� ���� ���� �̸��� ���̽ÿ�.
select c_name
from customer
where c_id not in (select distinct c_id from orders);

-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ���̽ÿ�.
select c_name, address
from customer
where c_id in (select distinct c_id from orders);

-- ������ ���� �Ӽ��� ���� NEWBOOK ���̺��� �����Ͻÿ�, �������� NUMBER��
-- �������� ������ ����Ÿ���� VARCHAR2�� ����Ѵ�.
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

-- ������ ���� �Ӽ��� ���� NEWCUSTOMER ���̺��� �����Ͻÿ�.
-- C_ID - NUMBER �⺻Ű
-- C_NAME - VARCHAR2 40
-- ADDRESS - VARCHAR2 40
-- PHONE - VARCHAR2 30
CREATE TABLE NEWCUSTOMER(
    C_ID NUMBER PRIMARY KEY,
    C_NAME VARCHAR2(40),
    ADDRESS VARCHAR2(40),
    PHONE VARCHAR2(30)
);    

-- ������ ���� �Ӽ��� ���� NEWORDER ���̺��� �����Ͻÿ�.
-- ORDER_ID - NUMBER �⺻Ű
-- C_ID - NUMBER , NOT NULL, �ַ�Ű
-- BOOK_ID - NUMBER, NOT NULL, �ַ�Ű
-- SALE_PRICE - NUMBER
-- ORDER_DATE - DATE
CREATE TABLE NEWORDER(
    ORDER_ID NUMBER PRIMARY KEY,
    C_ID NUMBER NOT NULL REFERENCES CUSTOMER(C_ID) ON DELETE CASCADE,
    BOOK_ID NUMBER(2) NOT NULL REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
    SALE_PRICE NUMBER,
    ORDER_DATE DATE
);

-- NEWBOOK ���̺� VARCHAR2 13�� �ڷ����� ���� ISBN �Ӽ��� �߰��Ͻÿ�.
ALTER TABLE NEWBOOK
ADD ISBN VARCHAR2(13);
-- NEWBOOK ���̺� ISVN �Ӽ��� ������Ÿ���� �ѹ������� �����Ͻÿ�.
ALTER TABLE NEWBOOK
MODIFY ISBN NUMBER;
-- NEWBOOK ���̺� ISBN �Ӽ��� �����Ͻÿ�
ALTER TABLE NEWBOOK
DROP COLUMN ISBN;
-- NEWBOOK ���̺� BOOK_ID �Ӽ��� NOT NULL ���������� �����Ͻÿ�.
ALTER TABLE NEWBOOK
MODIFY BOOK_ID NUMBER NOT NULL;
-- NEWBOOK ���̺� BOOK_ID �Ӽ��� �⺻Ű�� �����Ͻÿ�.
ALTER TABLE NEWBOOK
MODIFY BOOK_ID NUMBER PRIMARY KEY;
-- NEWBOOK ���̺��� �����Ͻÿ�.
DROP TABLE NEWBOOK;

