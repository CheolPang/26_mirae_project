-- =====================================================================
-- 99_drop_all.sql : 프로젝트 테이블/시퀀스 전부 삭제 (초기화)
--
-- ※ C##dbexam 계정으로 접속해서 실행
-- ※ 데이터가 모두 사라짐! 처음부터 다시 세팅하고 싶을 때만 사용
-- ※ 테이블/시퀀스가 없어도 에러 없이 넘어감
-- =====================================================================

BEGIN
    FOR t IN (SELECT table_name FROM user_tables
              WHERE table_name IN ('BS_BOARD', 'BS_MEMBER', 'BS_PRODUCT')) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' PURGE';  -- PURGE: 휴지통에 남기지 않음
    END LOOP;

    FOR s IN (SELECT sequence_name FROM user_sequences
              WHERE sequence_name IN ('BS_NUM', 'BS_SEQ_NUM')) LOOP
        EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
    END LOOP;
END;
/
