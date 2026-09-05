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
insert into bs_board values  (bs_num.nextval,'pretty', '김이박', '배송 언제 오나요?', '주문한지 일주일이 지났는데 아직 배송이 안되었어요.ㅠㅠ', 1, '128.120.0.02', sysdate, sysdate); --seq_num.currval


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