create table bs_board(
    num number primary key,--게시글 순번은 시퀀스로 만들예정
    id varchar2(20) not null,--회원 아이디
    name varchar2(20) not null, --회원 이름
    subject varchar2(100) not null, --게시글 제목
    content varchar2(1000) not null, --게시글 내용
    hit number,--게시글 조회 수
    ip varchar2(20),--게시글 등록 ip
    regist_day  date default sysdate,
    update_day date default sysdate
);


--시퀀스 생성
create sequence bs_num nocycle nocache;
-- 시퀀스 삭제
drop sequence bs_num;


--데이터 저장 : paging 만들것이므로 데이터 26개 추가할 것!
insert into bs_board values  (bs_num.nextval,'김테스트', '김테스트', '내일 배송 오나요?', '언제와요', 1, '128.120.0.02', sysdate, sysdate); --seq_num.currval

--검색기능
select count(*) from bs_board where content like '%배%';
select count(*) from bs_board where content like '%배송%';

select * from bs_board order by num desc;
select * from bs_board where content like '%배송%'


--데이터 검색기능
SELECT  count(*) FROM bs_board where content like '%테스%';
SELECT  count(*) FROM bs_board where subject like '%게시%';
SELECT  count(*) FROM bs_board where name like '%관리자%';



--데이터 수정
update board set subject='수정', update_day=sysdate where num='3';


--데이터 읽기
select * from bs_board;
select count(*) from bs_board;
select count(*) from bs_board where name like '%김%';
select * from bs_board ORDER BY num DESC;
select * from bs_board ORDER BY board_seq DESC;
SELECT  * FROM bs_board where name like '%큐%' ORDER BY board_seq DESC;
desc board;


--조건에 맞는 데이터 삭제
delete bs_board where id='cuty';


--테이블 삭제
drop table bs_board;
select * from bs_board;
rollback;
commit;

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

--시퀀스 생성
create sequence bs_seq_num nocycle nocache;

--데이터 삽입 (bs_member)
insert into bs_member values('CheolPang','1004','철팽','남','2000-01-22','cheolpang@proton.me','010-0000-0000','서울특별시 서초구', '2026-09-05', bs_seq_num.nextval, sysdate, sysdate);

select * from bs_member;


select * from bs_member where id='CheolPang' and password='1004';
  UPDATE bs_member
  SET password = '1004',
      name = '철팽',
      gender = '남',
      birth = ('1000-01-22'),
      mail = 'cheolpang@proton.me',
      phone = '010-0000-0000',
      address = '서울특별시 서초구'
  WHERE id = 'CheolPang';

delete bs_member where id='test';

commit;

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
--데이터 삽입
insert into bs_product values('P1234','시디즈 베이직 오피스 체어',155550,
'컴퓨터,사무용의자 / 메쉬등판 / 패브릭좌판 / [조절] 틸팅 : 가능 , 강도 , 고정 / 좌판 : 높낮이 / 목받침 : 높낮이 , 각도 / 요추받침 : 높낮이 , 깊이 / [크기] 좌판가로 : 51cm / 좌판깊이 : 48cm / 좌판높이 : 42~48cm / 총높이 : 115~121cm / 색상: 다크그레이, 베이지',
'chair','SIDIZ',1000,'new','P1234.jpg',0);
insert into bs_product values('P1235','동서가구 시에라 천연가죽 소파',478670,
'소파 / 4인용 / [소재] 천연가죽 / 소가죽 종류 : 면피 / 콤비사용 / 내장재 : 스펀지(폼) , 라텍스 , 솜 , 스프링 / [크기/색상] 좌방석깊이 : 55cm / 크기(가로x세로x높이): 270x92x85cm / 색상: 라이트그레이, 그레이, 베이지, 초코브라운, 화이트그레이, 카멜',
'sofa','DongSeo',5000,'new','P1235.jpg',0);
insert into bs_product values('P1236','데스커 컴퓨터 책상 2.0',175000,
'컴퓨터 책상 / 일자형 / 상판두께 : 28mm / E0등급 / [특징] 철제다리 / 기본포함 : 배선선반 / [크기/색상] 크기(가로x세로x높이): 1600x800x720mm / 색상: 화이트, 메이플, 모던아카시아, 빈티지블랙 라이트그레이, 그레이, 베이지, 초코브라운, 화이트그레이',
'desk','Desker',8000,'new','P1236.jpg',0);
-- 테이블 구조 확인
desc bs_product;
-- 테이블 삭제
drop table bs_product;
--휴지통 비우기
purge recyclebin;
-- 테이블 목록
select * from tab;
--테이블 데이터 확인
select * from bs_product;

-- ALTER TABLE bs_product MODIFY p_filename VARCHAR2(200);
SELECT * from bs_product WHERE p_id='P1252';




commit;