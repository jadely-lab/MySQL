CREATE TABLE 고객 (
  고객아이디  VARCHAR(20) NOT NULL,
  고객이름  VARCHAR(10),
  나이  INT,
  등급  VARCHAR(10),
  직업  VARCHAR(20),
  적립금  INT, 
  PRIMARY KEY(고객아이디)
);

DESCRIBE 고객;

CREATE TABLE 판매자(
  판매자번호  CHAR(3) NOT NULL,
  이름  VARCHAR(20),
  수수료 INT,
  PRIMARY KEY(판매자번호)
);

DESCRIBE 판매자;

CREATE TABLE 제품(
  제품번호  CHAR(3) NOT NULL,
  제품명  VARCHAR(20),
  재고량  INT,
  단가  INT,
  판매자  CHAR(3),
  PRIMARY KEY(제품번호),
  FOREIGN KEY(판매자) REFERENCES 판매자(판매자번호) ON DELETE NO ACTION
);

DESCRIBE 제품;

CREATE TABLE 주문(
  주문번호  CHAR(3) NOT NULL,
  주문고객  VARCHAR(20),
  주문제품  CHAR(3),
  수량  INT,
  배송지  VARCHAR(30),
  주문일자  DATE,
  PRIMARY KEY(주문번호),
  FOREIGN KEY(주문고객) REFERENCES 고객(고객아이디) ON DELETE NO ACTION,
  FOREIGN KEY(주문제품) REFERENCES 제품(제품번호) ON DELETE NO ACTION
);

DESCRIBE 주문;



INSERT INTO 고객 VALUES ('apple' , '정소화' , 20 , 'gold' , '학생' , 1000);
INSERT INTO 고객 VALUES ('banana' , '김선우' , 25 , 'vip' , '간호사' , 2500);
INSERT INTO 고객 VALUES ('carrot' , '고명석' , 28 , 'gold' , '교사' , 4500);
INSERT INTO 고객 VALUES ('orange' , '김용욱' , 22 , 'silver' , '학생' , 0);
INSERT INTO 고객 VALUES ('melon' , '성원용' , 35 , 'gold' , '회사원' , 5000);
INSERT INTO 고객 VALUES ('peach' , '오형준' , NULL , 'silver' , '의사' , 300);
INSERT INTO 고객 VALUES ('pear' , '채광주' , 31 , 'silver' , '회사원' , 500);

SELECT * FROM 고객;

INSERT INTO 판매자 VALUES ('S01' , '대한통운' , 100);
INSERT INTO 판매자 VALUES ('S02' , '한국푸드' ,1000);
INSERT INTO 판매자 VALUES ('S03' , '한빛제과' , 0);
INSERT INTO 판매자 VALUES ('S04' , '민국푸드' , 100);

SELECT * FROM 판매자;

INSERT INTO 제품 VALUES ('P01', '그냥만두', 5000, 4500, 'S01');
INSERT INTO 제품 VALUES ('P02', '매운쫄면', 2500, 5500, 'S04');
INSERT INTO 제품 VALUES ('P03', '쿵떡파이', 3600, 2600, 'S03');
INSERT INTO 제품 VALUES ('P04', '맛난초콜릿', 1250, 2500, 'S03');
INSERT INTO 제품 VALUES ('P05', '얼큰라면', 2200, 1200, 'S01');
INSERT INTO 제품 VALUES ('P06', '통통우동', 1000, 1550, 'S04');
INSERT INTO 제품 VALUES ('P07', '달콤비스킷', 1650, 1500, 'S03');
INSERT INTO 제품 VALUES ('P08', '맛있어젤리',1000, 1000, 'S02');

SELECT * FROM 제품;

INSERT INTO 주문 VALUES ('O01', 'apple', 'P03', 10, '서울시', '21/01/01');
INSERT INTO 주문 VALUES ('O02', 'melon', 'P01', 5, '인천시', '21/01/10');
INSERT INTO 주문 VALUES ('O03', 'banana', 'P06', 45, '경기도', '21/01/11');
INSERT INTO 주문 VALUES ('O04', 'carrot', 'P02', 8, '부산시', '21/02/01');
INSERT INTO 주문 VALUES ('O05', 'melon', 'P06', 36, '경기도', '21/02/20');
INSERT INTO 주문 VALUES ('O06', 'banana', 'P01', 19, '충청북도', '21/03/02');
INSERT INTO 주문 VALUES ('O07', 'apple', 'P03', 22, '서울시', '21/03/15');
INSERT INTO 주문 VALUES ('O08', 'pear', 'P02', 50, '강원도', '21/04/10');
INSERT INTO 주문 VALUES ('O09', 'banana', 'P04', 15, '전라남도', '21/04/11');
INSERT INTO 주문 VALUES ('O10', 'carrot', 'P03', 20, '경기도', '21/05/22');

SELECT * FROM 주문;



SELECT DISTINCT 제품명
FROM 제품
WHERE 단가 = (SELECT MIN(단가) FROM 제품);



SELECT  주문고객, COUNT(주문번호) AS 주문횟수, SUM(수량) AS '주문수량의 총계'
FROM  주문
GROUP BY 주문고객 HAVING SUM(수량) >= 50;



SELECT 판매자.이름 AS '판매자 이름', SUM(제품.재고량) AS '전체 재고량'
FROM 제품, 판매자
WHERE 판매자.판매자번호 = 제품.판매자
GROUP BY 제품.판매자
ORDER BY SUM(제품.재고량) DESC;



SELECT 고객.고객이름
FROM 고객, 주문, 제품
WHERE 제품.제품명 LIKE '%초콜릿%' 
AND 고객.고객아이디 = 주문.주문고객 
AND 제품.제품번호 = 주문.주문제품;



SELECT  고객.고객이름
FROM  고객 left outer join 주문 ON 주문.주문고객 = 고객.고객아이디
WHERE 주문번호 IS NULL;



SELECT * FROM 주문;

UPDATE 주문
SET 수량 = 수량 * 1.2
WHERE 주문고객 = (SELECT 고객아이디
FROM 고객
WHERE 고객이름 = '김선우');

SELECT * FROM 주문;



SELECT * FROM 주문;
SELECT * FROM 고객;

DELETE
FROM 주문
WHERE 주문고객 = 'apple';

DELETE
FROM 고객
WHERE 고객아이디 = 'apple';

SELECT * FROM 주문;
SELECT * FROM 고객;



SELECT * FROM 제품;

ALTER TABLE 제품 ADD 제조국 VARCHAR(30) DEFAULT 'Korea';

SELECT * FROM 제품;

