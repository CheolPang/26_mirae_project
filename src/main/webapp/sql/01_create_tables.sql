-- =====================================================================
-- 01_create_tables.sql : 테이블 + 시퀀스 생성
--
-- ※ C##dbexam 계정으로 접속해서 실행
-- ※ 이미 테이블이 있으면 에러 → 99_drop_all.sql 먼저 실행
-- =====================================================================


-- ---------------------------------------------------------------------
-- 회원 (member/*.jsp, BoardDAO.getLoginNameById)
-- ---------------------------------------------------------------------
create table bs_member(
    id varchar2(20) not null unique,
    password varchar2(20) not null,
    name varchar2(30) not null,
    gender varchar2(10),
    birth varchar2(20),
    mail varchar2(30),
    phone varchar2(30),
    address varchar2(100),
    regist_day varchar2(30),
    mem_num number primary key,  -- bs_seq_num 시퀀스
    logtime date,
    updatetime date
);

create sequence bs_seq_num nocycle nocache;


-- ---------------------------------------------------------------------
-- 상품 (products.jsp, product.jsp, addCart.jsp, 상품 관리 JSP)
-- ---------------------------------------------------------------------
CREATE TABLE bs_product(
    p_id VARCHAR2(500) NOT NULL,
    p_name VARCHAR2(500),
    p_unitPrice number,
    p_description VARCHAR2(500),
    p_category VARCHAR2(500),
    p_manufacturer VARCHAR2(500),
    p_unitsInStock number,
    p_condition VARCHAR2(500),
    p_fileName VARCHAR2(500),    -- webapp/upload/ 폴더의 이미지 파일명
    p_quantity number default 0,
    PRIMARY KEY (p_id)
);


-- ---------------------------------------------------------------------
-- 게시판 (BoardController → BoardDAO)
-- ---------------------------------------------------------------------
create table bs_board(
    num number primary key,        -- 게시글 순번 (bs_num 시퀀스)
    id varchar2(20) not null,      -- 회원 아이디
    name varchar2(30) not null,    -- 회원 이름 (bs_member.name 과 같은 크기여야 긴 이름도 글을 쓸 수 있다)
    subject varchar2(100) not null, -- 게시글 제목
    content varchar2(1000) not null, -- 게시글 내용
    hit number,                    -- 게시글 조회 수
    ip varchar2(20),               -- 게시글 등록 ip
    regist_day date default sysdate,
    update_day date default sysdate
);

create sequence bs_num nocycle nocache;


-- ---------------------------------------------------------------------
-- 구매 이력 (thanksCustomer.jsp에서 로그인 회원의 주문 완료 시 적재)
-- AI 상품 추천 기능이 회원별로 실제 구매한 상품을 조회할 때 사용 (추천 기능 자체는 별도 작업)
-- ---------------------------------------------------------------------
create table bs_purchase_history(
    num number primary key,          -- 구매 내역 순번 (bs_purchase_num 시퀀스)
    id varchar2(20) not null,        -- 회원 아이디 (bs_member.id)
    p_id varchar2(500) not null,     -- 상품 코드 (bs_product.p_id)
    quantity number not null,        -- 구매 수량
    purchase_price number not null,  -- 구매 당시 단가 (p_unitPrice)
    purchase_day date default sysdate  -- 구매(주문완료) 일시
);

create sequence bs_purchase_num nocycle nocache;
