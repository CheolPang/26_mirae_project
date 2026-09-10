-- =====================================================================
-- 회원(bs_member) 개발/테스트용 쿼리 모음
-- ※ DB 세팅할 때 실행하는 파일 아님. 필요한 줄만 골라서 실행
-- =====================================================================

--데이터 읽기
select * from bs_member;

--로그인 확인 (processLoginMember.jsp 와 같은 조건)
select * from bs_member where id='CheolPang' and password='1004';

--회원 정보 수정 (processUpdateMember.jsp 와 같은 형태)
UPDATE bs_member
SET password = '1004',
    name = '철팽',
    gender = '남',
    birth = ('1000-01-22'),
    mail = 'cheolpang@proton.me',
    phone = '010-0000-0000',
    address = '서울특별시 서초구'
WHERE id = 'CheolPang';

--회원 삭제
delete bs_member where id='test';

commit;
