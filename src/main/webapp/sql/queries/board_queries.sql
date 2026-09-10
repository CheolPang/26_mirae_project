-- =====================================================================
-- 게시판(bs_board) 개발/테스트용 쿼리 모음
-- ※ DB 세팅할 때 실행하는 파일 아님. 필요한 줄만 골라서 실행
-- =====================================================================

--데이터 읽기
select * from bs_board;
select * from bs_board ORDER BY num DESC;
select count(*) from bs_board;
desc bs_board;

--데이터 검색기능 (BoardDAO 검색 컬럼: subject, content, name)
select count(*) from bs_board where content like '%배%';
select count(*) from bs_board where content like '%배송%';
select * from bs_board where content like '%배송%';
SELECT count(*) FROM bs_board where content like '%테스%';
SELECT count(*) FROM bs_board where subject like '%게시%';
SELECT count(*) FROM bs_board where name like '%관리자%';
select count(*) from bs_board where name like '%김%';
SELECT * FROM bs_board where name like '%큐%' ORDER BY num DESC;

--데이터 수정
update bs_board set subject='수정', update_day=sysdate where num=3;

--조건에 맞는 데이터 삭제
delete bs_board where id='cuty';

rollback;
commit;
