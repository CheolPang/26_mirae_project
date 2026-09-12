
insert into bs_member values('admin','admin1234','관리자',null,null,null,null,null, to_char(sysdate,'YYYY-MM-DD'), bs_seq_num.nextval, sysdate, sysdate);


insert into bs_member values('CheolPang','1004','철팽','남','2000-01-22','cheolpang@proton.me','010-0000-0000','서울특별시 서초구', '2026-09-05', bs_seq_num.nextval, sysdate, sysdate);

insert into bs_product values('P1234','시디즈 베이직 오피스 체어',155550,
'컴퓨터,사무용의자 / 메쉬등판 / 패브릭좌판 / [조절] 틸팅 : 가능 , 강도 , 고정 / 좌판 : 높낮이 / 목받침 : 높낮이 , 각도 / 요추받침 : 높낮이 , 깊이 / [크기] 좌판가로 : 51cm / 좌판깊이 : 48cm / 좌판높이 : 42~48cm / 총높이 : 115~121cm / 색상: 다크그레이, 베이지',
'chair','SIDIZ',1000,'new','P1234.jpg',0);

insert into bs_product values('P1235','동서가구 시에라 천연가죽 소파',478670,
'소파 / 4인용 / [소재] 천연가죽 / 소가죽 종류 : 면피 / 콤비사용 / 내장재 : 스펀지(폼) , 라텍스 , 솜 , 스프링 / [크기/색상] 좌방석깊이 : 55cm / 크기(가로x세로x높이): 270x92x85cm / 색상: 라이트그레이, 그레이, 베이지, 초코브라운, 화이트그레이, 카멜',
'sofa','DongSeo',5000,'new','P1235.jpg',0);

insert into bs_product values('P1236','데스커 컴퓨터 책상 2.0',175000,
'컴퓨터 책상 / 일자형 / 상판두께 : 28mm / E0등급 / [특징] 철제다리 / 기본포함 : 배선선반 / [크기/색상] 크기(가로x세로x높이): 1600x800x720mm / 색상: 화이트, 메이플, 모던아카시아, 빈티지블랙 라이트그레이, 그레이, 베이지, 초코브라운, 화이트그레이',
'desk','Desker',8000,'new','P1236.jpg',0);

insert into bs_board values (bs_num.nextval,'kimtest', '김테스트', '내일 배송 오나요', '언제와요', 1, '128.120.0.02', sysdate, sysdate);
insert into bs_board values (bs_num.nextval,'kimtest', '김테스트', '추석 때 배송 일정이 어떻게 되나요', '추석때 늦나요', 1, '128.120.0.02', sysdate, sysdate);
insert into bs_board values (bs_num.nextval,'kimtest', '김테스트', '언제 오나요', '언제까지 기다려요. 언제와요', 1, '128.120.0.02', sysdate, sysdate);
insert into bs_board values (bs_num.nextval,'kimtest', '김테스트', '반품하고싶어요', '상품 다 깨졌어요', 1, '128.120.0.02', sysdate, sysdate);
insert into bs_board values (bs_num.nextval,'tests', '테스트인가', '교환 규정은 어떻게 되죠?', '저희 집이랑 안 맞는 사이즈가 와서 교환해야하는데 규정이 어떻게 되죠', 1, '128.120.0.02', sysdate, sysdate);
insert into bs_board values (bs_num.nextval,'tests', '태스트인가', '여기 하루만에 온다면서요', '왜 안와요', 1, '128.120.0.02', sysdate, sysdate);


commit;
