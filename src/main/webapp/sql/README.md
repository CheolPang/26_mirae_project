# DB 세팅 (Oracle XE)

## 파일 구성

| 파일 | 접속 계정 | 설명 |
|---|---|---|
| `00_create_user.sql` | **SYSTEM** | 프로젝트용 계정 `C##dbexam` 생성 (새 컴퓨터에서 처음 한 번만) |
| `01_create_tables.sql` | C##dbexam | 테이블 4개 + 시퀀스 3개 생성 |
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

## Eclipse 서버 설정 (상품 이미지 업로드)

관리자가 올린 상품 이미지는 `application.getRealPath("/upload")` 폴더에 저장된다.
기본 설정에서는 이 경로가 Eclipse 배포 복사본(`.metadata/.../wtpwebapps/byeongsu_freshman/upload`)이라
서버를 Clean/재배포하거나 다른 컴퓨터로 옮기면 이미지가 사라진다.
아래 설정을 켜면 서버가 프로젝트 폴더를 직접 실행하므로 이미지가 **프로젝트의 `src/main/webapp/upload`** 에 저장된다.
(프로젝트가 어느 위치에 있든 Eclipse가 경로를 알아서 잡는다)

1. Servers 탭에서 `Tomcat v9.0 Server at localhost` 더블클릭
2. Overview → **Server Options** → **Serve modules without publishing** 체크
3. `Ctrl+S` 로 저장 → 서버 재시작

새 컴퓨터에서 서버를 새로 만들었다면 이 설정을 다시 한 번 켜야 한다.
(이 설정이면 JSP/CSS 수정도 publish 없이 바로 반영된다)

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
| `bs_purchase_history` | `bs_purchase_num` (num) | `thanksCustomer.jsp` (로그인 회원의 주문 완료 시 적재, AI 추천 기능용) |

## 주의

- **한글 깨짐**: 파일은 UTF-8이다.
  - SQL Developer: 도구 → 환경설정 → 환경 → 인코딩을 `UTF-8`로 설정한 뒤 파일 열기
  - SQL*Plus: 실행 전에 `set NLS_LANG=KOREAN_KOREA.AL32UTF8`
- 접속 정보(`C##dbexam` / `m1234`)를 바꾸려면 `dbconn.jsp`, `mvc/database/DBConnection.java` 두 곳을 같이 고쳐야 한다.
- 상품 이미지 파일(`P1234~P1236.jpg`)은 `webapp/upload/` 폴더에 있어야 한다.
  관리자가 새로 올린 이미지도 이 폴더에 쌓이므로(위 Eclipse 서버 설정 필요) 다른 컴퓨터로 옮길 때 같이 커밋한다.

## AI 상품 추천 챗봇 설정 (WEB-INF/ollama.properties)

우하단 AI 버튼(모든 페이지에 `footer.jsp` → `aiChatWidget.jsp`로 포함됨)은
`AiChatController`(`/AiChatAction.do`)를 거쳐 Ollama에게 물어본다.
Ollama 서버 주소/모델명은 코드에 하드코딩하지 않고 아래 파일에서 읽는다.

파일 위치: `src/main/webapp/WEB-INF/ollama.properties`

```properties
ollama.baseUrl=http://localhost:11434
ollama.model=llama3
```

- `ollama.baseUrl` : Ollama HTTP API 베이스 주소 (끝에 `/api/...` 붙이지 않음)
- `ollama.model` : 사용할 모델 이름 (`ollama pull`로 미리 받아둔 모델)

실제 Ollama가 떠 있는 주소/모델로 값만 바꿔서 저장하면 된다. `AiChatController`가
채팅 요청마다 이 파일을 다시 읽으므로 재배포/재시작 없이 바로 반영된다.
Ollama에 연결할 수 없거나(주소에 아무것도 안 떠 있음) 15~20초 안에 응답이 없으면
채팅창에는 "지금은 추천을 받을 수 없어요."라는 안내만 뜨고 500 에러 페이지로는 가지 않는다.
