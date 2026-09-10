# DB 세팅 (Oracle XE)

## 파일 구성

| 파일 | 접속 계정 | 설명 |
|---|---|---|
| `00_create_user.sql` | **SYSTEM** | 프로젝트용 계정 `C##dbexam` 생성 (새 컴퓨터에서 처음 한 번만) |
| `01_create_tables.sql` | C##dbexam | 테이블 3개 + 시퀀스 2개 생성 |
| `02_insert_data.sql` | C##dbexam | 초기 데이터 (관리자/회원, 상품 3개, 게시글 1개) |
| `99_drop_all.sql` | C##dbexam | 테이블/시퀀스 전부 삭제 (초기화) |
| `setup_all.sql` | C##dbexam | `99` → `01` → `02` 한 번에 실행 |
| `queries/` | - | 개발 중 쓰던 테스트 쿼리 모음 (세팅할 때 실행 X) |

## 새 컴퓨터 세팅 순서

1. Oracle XE 설치 (SID `xe`, 포트 `1521`)
2. **SYSTEM** 계정으로 접속 → `00_create_user.sql` 실행
3. **C##dbexam / m1234** 로 접속 → `setup_all.sql` 스크립트 실행
   - SQL Developer: 파일 열고 **스크립트 실행(F5)** (Ctrl+Enter 는 한 줄만 실행되므로 X)
   - SQL*Plus: 이 폴더에서 `sqlplus C##dbexam/m1234@localhost:1521/xe` → `@setup_all.sql`

다시 처음 상태로 돌리고 싶을 때도 3번만 다시 실행하면 된다.

## 초기 계정

| id | pw | 비고 |
|---|---|---|
| `admin` | `admin1234` | 관리자 (상품 등록/수정/삭제 메뉴는 id가 `admin`일 때만 보임) |
| `CheolPang` | `1004` | 일반 회원 |

## 테이블

| 테이블 | 시퀀스 | 사용하는 곳 |
|---|---|---|
| `bs_member` | `bs_seq_num` (mem_num) | `member/*.jsp` |
| `bs_product` | - | `products.jsp`, `product.jsp`, `addCart.jsp`, 상품 관리 JSP |
| `bs_board` | `bs_num` (num) | `BoardController` → `BoardDAO` |

## 주의

- **한글 깨짐**: 파일은 UTF-8이다.
  - SQL Developer: 도구 → 환경설정 → 환경 → 인코딩을 `UTF-8`로 설정한 뒤 파일 열기
  - SQL*Plus: 실행 전에 `set NLS_LANG=KOREAN_KOREA.AL32UTF8`
- 접속 정보(`C##dbexam` / `m1234`)를 바꾸려면 `dbconn.jsp`, `mvc/database/DBConnection.java` 두 곳을 같이 고쳐야 한다.
- 상품 이미지 파일(`P1234~P1236.jpg`)은 `webapp/upload/` 폴더에 있어야 한다.
