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