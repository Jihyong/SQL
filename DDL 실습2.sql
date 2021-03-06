--1번
CREATE TABLE CUSTOMERS(
    CNO     NUMBER(5) PRIMARY KEY,
    CNAME   VARCHAR2(10) NOT NULL,
    ADDRESS VARCHAR2(50) NOT NULL,
    EAIL    VARCHAR2(20) NOT NULL,
    PHONE   VARCHAR2(20) NOT NULL
);
SELECT  *
FROM    CUSTOMERS

CREATE TABLE ORDERS(
    ORDERNO     NUMBER(10) PRIMARY KEY,
    ORDERDATE   DATE DEFAULT SYSDATE       NOT NULL,
    ADDRESS     VARCHAR2(50) NOT NULL,
    PHONE       VARCHAR2(20) NOT NULL,
    STATUS      VARCHAR2(20) NOT NULL,
    CNO NUMBER(5)   NOT NULL,
    FOREIGN KEY(CNO) REFERENCES CUSTOMERS(CNO)
);

CREATE TABLE PRODUCTS(
    PNO     NUMBER(5)   PRIMARY KEY,
    PNAME   VARCHAR2(20) NOT NULL,
    COST    NUMBER(8)   DEFAULT 0   NOT NULL,
    STOCK   NUMBER(5)   DEFAULT 0   NOT NULL
)

CREATE TABLE ORDERDETAIL(
    ORDERNO NUMBER(10),
    PNO     NUMBER(5) ,
    QTY     NUMBER(5),
    COST    NUMBER(8),
    FOREIGN KEY(ORDERNO) REFERENCES ORDERS(ORDERNO),
    FOREIGN KEY(PNO) REFERENCES PRODUCTS(PNO),
    PRIMARY KEY(ORDERNO,PNO)
);

--2번
INSERT INTO PRODUCTS VALUES(1001,'삼양라면',1000,200)
INSERT INTO PRODUCTS VALUES(1002,'새우깡',1500,500)
INSERT INTO PRODUCTS VALUES(1003,'월드콘',2000,350)
INSERT INTO PRODUCTS VALUES(1004,'빼빼로',2000,700)
INSERT INTO PRODUCTS VALUES(1005,'코카콜라',1800,550)
INSERT INTO PRODUCTS VALUES(1006,'환타',1600,300)
SELECT  *
FROM    PRODUCTS

--3번
INSERT INTO CUSTOMERS VALUES(101,'김철수','서울 강남구','cskim@naver.com','899-6666')
INSERT INTO CUSTOMERS VALUES(102,'이영희','부산 서면','yhlee@naver.com','355-8882')
INSERT INTO CUSTOMERS VALUES(103,'최진국','제주 동광양','jkchoi@naver.com','852-5764')
INSERT INTO CUSTOMERS VALUES(104,'강준호','강릉 홍제동','jhkang@naver.com','559-7777')
INSERT INTO CUSTOMERS VALUES(105,'민병국','대전 전민동','bgmin@naver.com','559-8741')
INSERT INTO CUSTOMERS VALUES(106,'오민수','광주 북구','msoh@naver.com','542-9988')
SELECT  *
FROM    CUSTOMERS

--4번
SELECT  *
FROM    ORDERS
SELECT  *
FROM    ORDERDETAIL

INSERT INTO ORDERS(ORDERNO,ORDERDATE,ADDRESS,PHONE,STATUS,CNO) 
VALUES(1,SYSDATE-3,'서울 강남구','899-6666','결제완료',101);
INSERT INTO ORDERDETAIL(ORDERNO,PNO,COST,QTY) VALUES(1,1001,1000,50);

--5번
UPDATE  PRODUCTS
SET     STOCK = '150'
WHERE   PNO = '1001'

--6번
INSERT INTO ORDERS(ORDERNO,ORDERDATE,ADDRESS,PHONE,STATUS,CNO)
VALUES(2,SYSDATE-2,'부산 수영구','337-5000','결제완료',102);
INSERT INTO ORDERDETAIL(ORDERNO,PNO,COST,QTY) VALUES(2,1002,1500,100);
INSERT INTO ORDERDETAIL(ORDERNO,PNO,COST,QTY) VALUES(2,1003,2000,150);

--7번
UPDATE  PRODUCTS
SET     STOCK = 400
WHERE   PNO = 1002;

UPDATE  PRODUCTS
SET     STOCK = 200
WHERE   PNO = 1003;

--8번
INSERT INTO ORDERS VALUES(3,SYSDATE-1,'광주 북구','652-2277','결제완료',106);
INSERT INTO ORDERDETAIL VALUES(3,1004,100,2000);
INSERT INTO ORDERDETAIL VALUES(3,1005,50,1800);

--9번
UPDATE  PRODUCTS
SET     STOCK = 600
WHERE   PNO = 1004;
UPDATE  PRODUCTS
SET     STOCK = 500
WHERE   PNO = 1005;

-10번
SELECT  O.ORDERDATE,
        C.CNAME,
        C.ADDRESS,
        C.PHONE,
        O.STATUS,
        P.PNAME,
        D.COST,
        D.QTY,
        (D.COST * D.QTY) AS "COST*QTY"
FROM    CUSTOMERS C
JOIN    ORDERS O ON(C.CNO = O.CNO)
JOIN    ORDERDETAIL D ON(O.ORDERNO = D.ORDERNO)
JOIN    PRODUCTS P ON(D.PNO = P.PNO);

--11번
SELECT  ORDERDATE,
        SUM(COST * QTY)
FROM    ORDERS
JOIN    ORDERDETAIL USING(ORDERNO)
GROUP BY    ORDERDATE;

--12번
INSERT INTO PRODUCTS(PNO,PNAME,COST,STOCK) VALUES(1007,'목캔디',3000,500);

--13번
INSERT INTO ORDERS VALUES(4,SYSDATE,'제주 동광양','352-4657','결제완료',103);
INSERT INTO ORDERDETAIL VALUES(4,1007,200,3000);

--비디오 대여점
CREATE TABLE MEMBER(
            MEMBER_ID NUMBER(10) PRIMARY KEY,
            NAME VARCHAR2(25) NOT NULL,
            ADDRESS VARCHAR2(100),
            CITY VARCHAR2(30),
            PHONE VARCHAR2(15),
            JOIN_DATE DATE DEFAULT SYSDATE NOT NULL
            );
            
CREATE TABLE TITLE(
            TITLE_ID    NUMBER(10) PRIMARY KEY,
            TITLE       VARCHAR2(60) NOT NULL,
            DESCRIPTION VARCHAR2(400) NOT NULL,
            RATING      VARCHAR2(20),
            CATEGORY    VARCHAR2(20),
            RELEASE_DATE DATE,
            CHECK(RATING IN ('18가','15가','12가','전체가')),
            CHECK(CATEGORY IN ('드라마','코미디','액션','아동','SF','다큐멘터리'))
);

CREATE TABLE TITLE_COPY(
            COPY_ID NUMBER(10) ,
            TITLE_ID NUMBER(10),
            STATUS   VARCHAR2(20) NOT NULL CHECK(STATUS IN ('대여가능','파손','대여중','예약')),
            FOREIGN KEY(TITLE_ID) REFERENCES TITLE(TITLE_ID),
            PRIMARY KEY(COPY_ID,TITLE_ID)
);

CREATE TABLE RENTAL(
            BOOK_DATE DATE DEFAULT SYSDATE,
            MEMBER_ID NUMBER(10), --혹은 여기다 FK제약 REFERENCES MEMBER(MEMBER_ID)
            COPY_ID   NUMBER(10),
            TITLE_ID  NUMBER(10),
            ACT_RET_DATE DATE,
            EXP_RET_DATE DATE DEFAULT SYSDATE+2,
            FOREIGN KEY(MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
            FOREIGN KEY(COPY_ID,TITLE_ID) REFERENCES TITLE_COPY(COPY_ID,TITLE_ID),
            PRIMARY KEY(BOOK_DATE,MEMBER_ID,COPY_ID,TITLE_ID)
);

CREATE TABLE RESERVATION(
            RES_DATE DATE,
            MEMBER_ID NUMBER(10),
            TITLE_ID NUMBER(10),
            PRIMARY KEY(RES_DATE,MEMBER_ID,TITLE_ID),
            FOREIGN KEY (MEMBER_ID) REFERENCES MEMBER(MEMBER_ID),
            FOREIGN KEY (TITLE_ID) REFERENCES TITLE(TITLE_ID)
);

--2번
CREATE SEQUENCE MEMBER_ID_SEQ
START WITH 101
NOCACHE;

CREATE SEQUENCE TITLE_ID_SEQ
START WITH 92
NOCACHE;

--3번
INSERT INTO TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
VALUES(TITLE_ID_SEQ.NEXTVAL,'인어공주','인어공주 설명','전체가','아동','95/10/05');
INSERT INTO TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
VALUES(TITLE_ID_SEQ.NEXTVAL,'매트릭스','매트릭스 설명','15가','SF','95/05/19');
INSERT INTO TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
VALUES(TITLE_ID_SEQ.NEXTVAL,'에이리언','에이리언 설명','18가','SF','95/08/12');
INSERT INTO TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
VALUES(TITLE_ID_SEQ.NEXTVAL,'모던타임즈','모던타임즈 설명','전체가','코미디','95/07/12');
INSERT INTO TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
VALUES(TITLE_ID_SEQ.NEXTVAL,'러브스토리','러브스토리 설명','전체가','드라마','95/09/12');
INSERT INTO TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
VALUES(TITLE_ID_SEQ.NEXTVAL,'람보','람보 설명','18가','액션','95/06/01');
SELECT  *
FROM    RENTAL

--4번
INSERT INTO MEMBER(MEMBER_ID,NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
VALUES(MEMBER_ID_SEQ.NEXTVAL,'김철수','강남구','서울','899-6666','90/03/08');
INSERT INTO MEMBER(MEMBER_ID,NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
VALUES(MEMBER_ID_SEQ.NEXTVAL,'이영희','서면','부산','355-8882','90/03/08');
INSERT INTO MEMBER(MEMBER_ID,NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
VALUES(MEMBER_ID_SEQ.NEXTVAL,'최진국','동광양','제주','852-5764','91/06/17');
INSERT INTO MEMBER(MEMBER_ID,NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
VALUES(MEMBER_ID_SEQ.NEXTVAL,'강준호','홍제동','강릉','559-7777','90/04/07');
INSERT INTO MEMBER(MEMBER_ID,NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
VALUES(MEMBER_ID_SEQ.NEXTVAL,'민병국','전민동','대전','559-8741','91/01/18');
INSERT INTO MEMBER(MEMBER_ID,NAME,ADDRESS,CITY,PHONE,JOIN_DATE)
VALUES(MEMBER_ID_SEQ.NEXTVAL,'오민수','북구','광주','542-9988','91/01/18');

--5번
SELECT  TITLE,TITLE_ID
FROM    TITLE

INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(92,1,'대여가능');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(93,1,'대여가능');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(93,2,'대여중');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(94,1,'대여가능');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(95,1,'대여가능');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(95,2,'대여가능');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(95,3,'대여중');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(96,1,'대여가능');
INSERT INTO TITLE_COPY(TITLE_ID,COPY_ID,STATUS) VALUES(97,1,'대여가능');

--6번

INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(92,1,101,SYSDATE-3,SYSDATE-1,SYSDATE-2);
INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(93,2,103,SYSDATE-1,SYSDATE+1,NULL);
INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(95,3,104,SYSDATE-2,SYSDATE,NULL);
INSERT INTO RENTAL(TITLE_ID,COPY_ID,MEMBER_ID,BOOK_DATE,EXP_RET_DATE,ACT_RET_DATE)
VALUES(97,1,105,SYSDATE-4,SYSDATE-2,SYSDATE-2);
SELECT  *
FROM    RENTAL;
SELECT  *
FROM    MEMBER

--7번
CREATE OR REPLACE VIEW TITLE_AVAIL(TITLE,COPY_ID,STATUS,EXP_RET_DATE)
AS SELECT   TITLE,
            COPY_ID,
            STATUS,
            EXP_RET_DATE
    FROM    TITLE_COPY
    JOIN    TITLE USING (TITLE_ID)
    JOIN    RENTAL USING (COPY_ID);
SELECT  *
FROM    TITLE_AVAIL;

--8번
--A)
SELECT  *
FROM    TITLE_COPY
INSERT INTO TITLE(TITLE_ID,TITLE,DESCRIPTION,RATING,CATEGORY,RELEASE_DATE)
VALUES(98,'스타워즈','스타워즈 설명','전체가','SF','77/07/07');
INSERT INTO TITLE_COPY(COPY_ID,TITLE_ID,STATUS) VALUES(1,98,'대여가능');
INSERT INTO TITLE_COPY(COPY_ID,TITLE_ID,STATUS) VALUES(2,98,'대여가능');

--B)
SELECT  *
FROM    MEMBER
SELECT  *
FROM    RESERVATION;
INSERT INTO RESERVATION(RES_DATE,MEMBER_ID,TITLE_ID) VALUES(SYSDATE,102,98);
INSERT INTO RESERVATION(RES_DATE,MEMBER_ID,TITLE_ID) VALUES(SYSDATE,106,96);

--C)
DELETE
FROM    RESERVATION
WHERE   MEMBER_ID = 102;

SELECT *
FROM   RENTAL;
INSERT INTO RENTAL VALUES(SYSDATE,102,1,98,NULL,DEFAULT);

SELECT  *
FROM    TITLE_COPY
UPDATE TITLE_COPY
SET    STATUS = '대여중'
WHERE  COPY_ID = 1 AND TITLE_ID = 98;

SELECT  *
FROM    TITLE_AVAIL;

--9번
SELECT  *
FROM    TITLE
ALTER TABLE TITLE
ADD PRICE NUMBER(5);

UPDATE  TITLE
SET     PRICE = 3000
WHERE   TITLE_ID = 92;
UPDATE  TITLE
SET     PRICE = 2500
WHERE   TITLE_ID = 93;
UPDATE  TITLE
SET     PRICE = 2000
WHERE   TITLE_ID = 94;
UPDATE  TITLE
SET     PRICE = 3000
WHERE   TITLE_ID = 95;
UPDATE  TITLE
SET     PRICE = 3500
WHERE   TITLE_ID = 96;
UPDATE  TITLE
SET     PRICE = 2000
WHERE   TITLE_ID = 97;
UPDATE  TITLE
SET     PRICE = 1500
WHERE   TITLE_ID = 98;

ALTER TABLE TITLE
MODIFY PRICE NUMBER(5) DEFAULT 0 NOT NULL;

/* PRICE 컬럼에 NOT NULL 제약조건 지정이 안 됨!!
ALTER TABLE TITLE
ADD CONSTRAINTS PRI_CON NOT NULL(PRICE);

ALTER TABLE TITLE
MODIFY PRICE NUMBER(5) DEFAULT 0 NOT NULL;

ALTER TABLE TITLE
ADD PRICE NUMBER(5) DEFAULT '0' NOT NULL;
*/

--10번
CREATE OR REPLACE VIEW REPORT(회원명,제목,대여일,기간)
AS SELECT   NAME,
            TITLE,
            BOOK_DATE,
            SUBSTR(ACT_RET_DATE,7,2) - SUBSTR(BOOK_DATE,7,2)
    FROM    RENTAL
    JOIN    MEMBER USING (MEMBER_ID)
    JOIN    TITLE USING (TITLE_ID)
SELECT  *
FROM    REPORT;

CREATE TABLE T(
        COL1 CHAR(1) NOT NULL,
        COL2 NUMBER
);
INSERT INTO T VALUES('A',NULL);
INSERT INTO T VALUES('B','');
INSERT INTO T VALUES('C',3);
INSERT INTO T VALUES('D',4);
INSERT INTO T VALUES('E',5);

SELECT  COUNT(COL1)
FROM    T
WHERE   COL2 IS NULL; --NULL 비교는 IS NULL IS NOT NULL밖에 안 됨 =, <, > NULL은 불가
