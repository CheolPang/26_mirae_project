-- =====================================================================
-- 00_create_user.sql : 프로젝트용 DB 계정 생성
--
-- ※ SYSTEM(관리자) 계정으로 접속해서 실행할 것
-- ※ 새 컴퓨터에서 처음 한 번만 실행 (이미 계정이 있으면 건너뛰기)
--
-- 아래 접속 정보는 소스코드에 하드코딩된 값과 같아야 한다.
--   - src/main/webapp/dbconn.jsp
--   - src/main/java/mvc/database/DBConnection.java
--   url  : jdbc:oracle:thin:@localhost:1521:xe
--   user : C##dbexam
--   pw   : m1234
-- =====================================================================

CREATE USER C##dbexam IDENTIFIED BY m1234;

-- 접속 + 테이블/시퀀스 생성 권한
GRANT CONNECT, RESOURCE TO C##dbexam;

-- 테이블스페이스 사용량 (없으면 INSERT 시 ORA-01950 에러)
ALTER USER C##dbexam QUOTA UNLIMITED ON USERS;
