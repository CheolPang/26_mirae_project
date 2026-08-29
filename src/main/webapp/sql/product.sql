CREATE TABLE bs_product(
p_id VARCHAR2(10) NOT NULL,
p_name VARCHAR2(100),
p_unitPrice number,
p_description VARCHAR2(500),
p_category VARCHAR2(20),
p_manufacturer VARCHAR2(20),
p_unitsInStock number,
p_condition VARCHAR2(20),
p_fileName VARCHAR2(20),
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