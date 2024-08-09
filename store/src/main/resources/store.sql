

/* Create Tables */

-- 혜택테이블
CREATE TABLE STORE_BENEFITS
(
	-- 혜택번호
	BENEFIT_NO number(2,0) NOT NULL,
	-- 혜택이름
	BENEFIT_NAME varchar2(255) NOT NULL,
	CONSTRAINT STORE_BENEFITNO_PK PRIMARY KEY (BENEFIT_NO)
);


-- 상품테이블
CREATE TABLE STORE_PRODUCTS
(
	-- 상품번호
	PRODUCT_NO number(4,0) NOT NULL,
	-- 상품명
	PRODUCT_NAME varchar2(255) NOT NULL,
	-- 가격
	PRODUCT_PRICE number(10,0) NOT NULL,
	-- 할인가격
	PRODUCT_DISCOUNT_PRICE number(10,0) NOT NULL,
	-- 재고수량
	PRODUCT_STOCK number(5,0) NOT NULL,
	-- 설명
	PRODUCT_DESCRIPTION varchar2(2000) NOT NULL,
	-- 등록일
	PRODUCT_CREATED_DATE date DEFAULT SYSDATE,
	-- 수정일
	PRODUCT_UPDATED_DATE date,
	-- 상품카테고리번호
	PRODUCT_CATEGORY_NO number(4,0) NOT NULL,
	-- 상품제조회사번호
	PRODUCT_COMPANY_NO number(4,0) NOT NULL,
	-- 상품상태번호
	PRODUCT_STATUS_NO number(2,0) NOT NULL,
	CONSTRAINT STORE_PRODUCTNO_PK PRIMARY KEY (PRODUCT_NO)
);


-- 상품추가혜택테이블
CREATE TABLE STORE_PRODUCT_BENEFITS
(
	-- 상품번호
	PRODUCT_NO number(4,0) NOT NULL,
	-- 혜택번호
	BENEFIT_NO number(2,0) NOT NULL,
	UNIQUE (PRODUCT_NO, BENEFIT_NO)
);


-- 상품카테고리
CREATE TABLE STORE_PRODUCT_CATEGORIES
(
	-- 상품카테고리번호
	PRODUCT_CATEGORY_NO number(4,0) NOT NULL,
	-- 상품카테고리이름
	PRODUCT_CATEGORY_NAME varchar2(255) NOT NULL,
	CONSTRAINT STORE_PRODUCT_CATNO_PK PRIMARY KEY (PRODUCT_CATEGORY_NO)
);


-- 상품제조회사
CREATE TABLE STORE_PRODUCT_COMPANIES
(
	-- 상품제조회사번호
	PRODUCT_COMPANY_NO number(4,0) NOT NULL,
	-- 상품제조회사이름
	PRODUCT_COMPANY_NAME varchar2(255) NOT NULL,
	-- 상품제조회사연락처
	PRODUCT_COMPANY_TEL varchar2(20) NOT NULL,
	CONSTRAINT STORE_PRODUCT_COMPANYNO_PK PRIMARY KEY (PRODUCT_COMPANY_NO)
);


-- 상품상태테이블
CREATE TABLE STORE_PRODUCT_STATUS
(
	-- 상품상태번호
	PRODUCT_STATUS_NO number(2,0) NOT NULL,
	-- 상품상태이름
	PRODUCT_STATUS_NAME varchar2(255) NOT NULL,
	CONSTRAINT STORE_PRODUCT_STATUSNO_PK PRIMARY KEY (PRODUCT_STATUS_NO)
);



/* Create Foreign Keys */

ALTER TABLE STORE_PRODUCT_BENEFITS
	ADD FOREIGN KEY (BENEFIT_NO)
	REFERENCES STORE_BENEFITS (BENEFIT_NO)
;


ALTER TABLE STORE_PRODUCT_BENEFITS
	ADD FOREIGN KEY (PRODUCT_NO)
	REFERENCES STORE_PRODUCTS (PRODUCT_NO)
;


ALTER TABLE STORE_PRODUCTS
	ADD CONSTRAINT STORE_PRODUCT_CATNO_FK FOREIGN KEY (PRODUCT_CATEGORY_NO)
	REFERENCES STORE_PRODUCT_CATEGORIES (PRODUCT_CATEGORY_NO)
;


ALTER TABLE STORE_PRODUCTS
	ADD CONSTRAINT STORE_PRODUCT_COMNO_FK FOREIGN KEY (PRODUCT_COMPANY_NO)
	REFERENCES STORE_PRODUCT_COMPANIES (PRODUCT_COMPANY_NO)
;


ALTER TABLE STORE_PRODUCTS
	ADD CONSTRAINT STORE_PRODUCT_STATUSNO_FK FOREIGN KEY (PRODUCT_STATUS_NO)
	REFERENCES STORE_PRODUCT_STATUS (PRODUCT_STATUS_NO)
;



/* Comments */

COMMENT ON TABLE STORE_BENEFITS IS '혜택테이블';
COMMENT ON COLUMN STORE_BENEFITS.BENEFIT_NO IS '혜택번호';
COMMENT ON COLUMN STORE_BENEFITS.BENEFIT_NAME IS '혜택이름';
COMMENT ON TABLE STORE_PRODUCTS IS '상품테이블';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_NAME IS '상품명';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_PRICE IS '가격';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_DISCOUNT_PRICE IS '할인가격';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_STOCK IS '재고수량';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_DESCRIPTION IS '설명';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_CREATED_DATE IS '등록일';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_UPDATED_DATE IS '수정일';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_CATEGORY_NO IS '상품카테고리번호';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_COMPANY_NO IS '상품제조회사번호';
COMMENT ON COLUMN STORE_PRODUCTS.PRODUCT_STATUS_NO IS '상품상태번호';
COMMENT ON TABLE STORE_PRODUCT_BENEFITS IS '상품추가혜택테이블';
COMMENT ON COLUMN STORE_PRODUCT_BENEFITS.PRODUCT_NO IS '상품번호';
COMMENT ON COLUMN STORE_PRODUCT_BENEFITS.BENEFIT_NO IS '혜택번호';
COMMENT ON TABLE STORE_PRODUCT_CATEGORIES IS '상품카테고리';
COMMENT ON COLUMN STORE_PRODUCT_CATEGORIES.PRODUCT_CATEGORY_NO IS '상품카테고리번호';
COMMENT ON COLUMN STORE_PRODUCT_CATEGORIES.PRODUCT_CATEGORY_NAME IS '상품카테고리이름';
COMMENT ON TABLE STORE_PRODUCT_COMPANIES IS '상품제조회사';
COMMENT ON COLUMN STORE_PRODUCT_COMPANIES.PRODUCT_COMPANY_NO IS '상품제조회사번호';
COMMENT ON COLUMN STORE_PRODUCT_COMPANIES.PRODUCT_COMPANY_NAME IS '상품제조회사이름';
COMMENT ON COLUMN STORE_PRODUCT_COMPANIES.PRODUCT_COMPANY_TEL IS '상품제조회사연락처';
COMMENT ON TABLE STORE_PRODUCT_STATUS IS '상품상태테이블';
COMMENT ON COLUMN STORE_PRODUCT_STATUS.PRODUCT_STATUS_NO IS '상품상태번호';
COMMENT ON COLUMN STORE_PRODUCT_STATUS.PRODUCT_STATUS_NAME IS '상품상태이름';


CREATE SEQUENCE STORE_CATEGORIES_SEQ START WITH 1000 NOCACHE;
CREATE SEQUENCE STORE_COMPANIES_SEQ START WITH 1000 NOCACHE;
CREATE SEQUENCE STORE_STATUS_SEQ START WITH 10 NOCACHE;
CREATE SEQUENCE STORE_BENEFITS_SEQ START WITH 10 NOCACHE;

