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
    mem_num number primary key,
    logtime date,
    updatetime date
);

create sequence bs_seq_num nocycle nocache;

CREATE TABLE bs_product(
    p_id VARCHAR2(500) NOT NULL,
    p_name VARCHAR2(500),
    p_unitPrice number,
    p_description VARCHAR2(500),
    p_category VARCHAR2(500),
    p_manufacturer VARCHAR2(500),
    p_unitsInStock number,
    p_condition VARCHAR2(500),
    p_fileName VARCHAR2(500),   
    p_quantity number default 0,
    PRIMARY KEY (p_id)
);

create table bs_board(
    num number primary key,
    id varchar2(20) not null,
    name varchar2(30) not null,
    subject varchar2(100) not null,
    content varchar2(1000) not null,
    hit number,
    ip varchar2(20),
    regist_day date default sysdate,
    update_day date default sysdate
);

create sequence bs_num nocycle nocache;

create table bs_purchase_history(
    num number primary key,
    id varchar2(20) not null,
    p_id varchar2(500) not null,
    quantity number not null,
    purchase_price number not null,
    purchase_day date default sysdate
);

create sequence bs_purchase_num nocycle nocache;