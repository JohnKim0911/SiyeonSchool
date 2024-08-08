
--------------------------------------------------------------------------------
--############### 기존 데이터 삭제  ###############
--------------------------------------------------------------------------------
-- 테이블 삭제: CASCADE CONSTRAINTS를 해줘야 외래키로 엮어있는 데이터들이 잘 지워짐.
DROP TABLE ATTACHMENT CASCADE CONSTRAINTS;
DROP TABLE QUESTION CASCADE CONSTRAINTS;
DROP TABLE USERS CASCADE CONSTRAINTS;
DROP TABLE COMMENTS CASCADE CONSTRAINTS;
DROP TABLE NOTIFICATION CASCADE CONSTRAINTS;
DROP TABLE CONTACTS_CATEGORY CASCADE CONSTRAINTS;
DROP TABLE CONTACTS CASCADE CONSTRAINTS;
DROP TABLE CONTACTS_MEMBER CASCADE CONSTRAINTS;
DROP TABLE CONTACTS_STAR CASCADE CONSTRAINTS;
DROP TABLE MAIL CASCADE CONSTRAINTS;
DROP TABLE MAIL_RECEIVER CASCADE CONSTRAINTS;
DROP TABLE MAILBOX CASCADE CONSTRAINTS;
DROP TABLE MAIL_OWNER CASCADE CONSTRAINTS;
DROP TABLE MAIL_ATTACHMENT CASCADE CONSTRAINTS;
DROP TABLE CLASS_BOARD CASCADE CONSTRAINTS;
DROP TABLE CLASS_POST CASCADE CONSTRAINTS;
DROP TABLE CLASS_COMMENT CASCADE CONSTRAINTS;
DROP TABLE CLASS_ATTACHMENT CASCADE CONSTRAINTS;
DROP TABLE SURVEY_POST CASCADE CONSTRAINTS;
DROP TABLE SURVEY_MEMBER CASCADE CONSTRAINTS;
DROP TABLE SURVEY_QUESTION CASCADE CONSTRAINTS;
DROP TABLE SURVEY_CHOICE CASCADE CONSTRAINTS;
DROP TABLE SURVEY_ANSWER CASCADE CONSTRAINTS;


-- 시퀀스 삭제
DROP SEQUENCE SEQ_FILENO;           -- <첨부파일> 테이블 PK시퀀스
DROP SEQUENCE SEQ_USERNO;           -- <유저> 테이블 PK시퀀스
DROP SEQUENCE SEQ_QUESTIONNO;       -- <질문> 테이블 PK시퀀스
DROP SEQUENCE SEQ_COMMENTNO;        -- <댓글> 테이블 PK시퀀스
DROP SEQUENCE SEQ_NOTINO;           -- <알림> 테이블 PK시퀀스
DROP SEQUENCE SEQ_CONTACTS_CATENO;  -- <주소록_카테고리> 테이블 PK시퀀스
DROP SEQUENCE SEQ_CONTACTSNO;       -- <주소록> 테이블 PK시퀀스
DROP SEQUENCE SEQ_CONTACTS_STARNO;  -- <주소록_중요표시> 테이블 PK시퀀스
DROP SEQUENCE SEQ_MAILNO;           -- <메일> 테이블 PK시퀀스
DROP SEQUENCE SEQ_MAILBOXNO;        -- <메일함> 테이블 PK시퀀스
DROP SEQUENCE SEQ_BOARDNO;        -- <수업_게시판> 테이블 PK시퀀스
DROP SEQUENCE SEQ_POSTNO;        -- <수업_게시글> 테이블 PK시퀀스
DROP SEQUENCE SEQ_SURVEYPOSTNO;        -- <설문조사_게시글> 테이블 PK시퀀스
DROP SEQUENCE SEQ_SURVEYQNO;        -- <설문조사_질문> 테이블 PK시퀀스
DROP SEQUENCE SEQ_SURVEY_CHOICENO;        -- <설문조사_선택지> 테이블 PK시퀀스

--------------------------------------------------------------------------------
-- 주의! <첨부파일>, <QUESTION> 테이블이 <USERS>테이블 보다 위에서 선언되야함. 이렇게 안하면 에러남.
-- 이유: <USERS>테이블에서 <ATTACHMENT>, <QUESTION> 테이블을 외래키로 사용하고 있는데,
--        다른 두 테이블이 생성되지 않은 상태에서 <USERS>테이블이 먼저 읽히면, 해당 테이블들을 인식못하게됨. 결국 에러로 <USERS>테이블이 생성안되게됨.
--------------------------------------------------------------------------------
--###############  첨부파일  ###############
--------------------------------------------------------------------------------
CREATE TABLE ATTACHMENT(
    FILE_NO NUMBER PRIMARY KEY,
    ORIGIN_NAME VARCHAR2(255) NOT NULL,
    CHANGE_NAME VARCHAR2(255) NOT NULL UNIQUE,
    FILE_PATH VARCHAR2(1000) NOT NULL,
    UPLOAD_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN ATTACHMENT.FILE_NO IS '파일번호';
COMMENT ON COLUMN ATTACHMENT.ORIGIN_NAME IS '파일원본명';
COMMENT ON COLUMN ATTACHMENT.CHANGE_NAME IS '파일수정명';
COMMENT ON COLUMN ATTACHMENT.FILE_PATH IS '저장경로';
COMMENT ON COLUMN ATTACHMENT.UPLOAD_DATE IS '업로드일';
COMMENT ON COLUMN ATTACHMENT.STATUS IS '상태(미삭제:Y/삭제:N)';

CREATE SEQUENCE SEQ_FILENO
NOCACHE;

INSERT INTO ATTACHMENT VALUES(SEQ_FILENO.NEXTVAL, 'apple.jpg', 'apple1.jpg', '/SiyeonSchool/upfiles/', SYSDATE, DEFAULT);
INSERT INTO ATTACHMENT VALUES(SEQ_FILENO.NEXTVAL, 'apple.jpg', 'apple2.jpg', '/SiyeonSchool/upfiles/', SYSDATE, DEFAULT);
INSERT INTO ATTACHMENT VALUES(SEQ_FILENO.NEXTVAL, 'apple.jpg', 'apple3.jpg', '/SiyeonSchool/upfiles/', SYSDATE, DEFAULT);
INSERT INTO ATTACHMENT VALUES(SEQ_FILENO.NEXTVAL, 'apple.jpg', 'apple4.jpg', '/SiyeonSchool/upfiles/', SYSDATE, DEFAULT);
INSERT INTO ATTACHMENT VALUES(SEQ_FILENO.NEXTVAL, 'apple.jpg', 'apple5.jpg', '/SiyeonSchool/upfiles/', SYSDATE, DEFAULT);

--------------------------------------------------------------------------------
--###############  질문  ############### (아이디/비밀번호 찾기용)
--------------------------------------------------------------------------------
CREATE TABLE QUESTION(
    QUESTION_NO NUMBER PRIMARY KEY,
    QUESTION_CONTENT VARCHAR2(100) NOT NULL
);

COMMENT ON COLUMN QUESTION.QUESTION_NO IS '질문번호';
COMMENT ON COLUMN QUESTION.QUESTION_CONTENT IS '질문내용';

CREATE SEQUENCE SEQ_QUESTIONNO
NOCACHE;

INSERT INTO QUESTION VALUES(SEQ_QUESTIONNO.NEXTVAL, '기억에 남는 추억의 장소는?');
INSERT INTO QUESTION VALUES(SEQ_QUESTIONNO.NEXTVAL, '자신의 인생 좌우명은?');
INSERT INTO QUESTION VALUES(SEQ_QUESTIONNO.NEXTVAL, '자신의 보물 제1호는?');
INSERT INTO QUESTION VALUES(SEQ_QUESTIONNO.NEXTVAL, '가장 기억에 남는 선생님 성함은?');
INSERT INTO QUESTION VALUES(SEQ_QUESTIONNO.NEXTVAL, '추억하고 싶은 날짜가 있다면?');

--------------------------------------------------------------------------------
--###############  유저  ###############
--------------------------------------------------------------------------------
CREATE TABLE USERS( -- USER는 예약어라 테이블명에 사용 못함. 대신 뒤에 S를 붙여 사용.
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) NOT NULL UNIQUE,
    USER_PWD VARCHAR2(20) NOT NULL,
    USER_NAME VARCHAR2(20) NOT NULL,
    PHONE VARCHAR2(13) NOT NULL UNIQUE,
    BIRTHDAY DATE NOT NULL,
    EMAIL VARCHAR2(30),
    ADDRESS VARCHAR2(100),
    ENROLL_DATE DATE DEFAULT SYSDATE NOT NULL,
    MODIFY_DATE DATE DEFAULT SYSDATE NOT NULL,
    PROFILE_FILE_NO NUMBER,
    QUESTION_NO NUMBER NOT NULL,
    QUESTION_ANSWER VARCHAR2(50)  NOT NULL, 
    USER_AUTH CHAR(1) DEFAULT 'U' NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    GITHUB_URL VARCHAR2(100),
    NOTION_URL VARCHAR2(100),
    FOREIGN KEY(PROFILE_FILE_NO) REFERENCES ATTACHMENT(FILE_NO),
    FOREIGN KEY(QUESTION_NO) REFERENCES QUESTION(QUESTION_NO),
    CHECK(USER_AUTH IN ('U', 'A')),
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN USERS.USER_NO IS '유저번호'; 
COMMENT ON COLUMN USERS.USER_ID IS '유저아이디'; 
COMMENT ON COLUMN USERS.USER_PWD IS '유저비밀번호';
COMMENT ON COLUMN USERS.USER_NAME IS '유저이름'; 
COMMENT ON COLUMN USERS.PHONE IS '전화번호'; 
COMMENT ON COLUMN USERS.BIRTHDAY IS '생일';
COMMENT ON COLUMN USERS.EMAIL IS '이메일'; 
COMMENT ON COLUMN USERS.ADDRESS IS '주소'; 
COMMENT ON COLUMN USERS.ENROLL_DATE IS '회원가입일'; 
COMMENT ON COLUMN USERS.MODIFY_DATE IS '정보수정일'; 
COMMENT ON COLUMN USERS.PROFILE_FILE_NO IS '프로필사진';
COMMENT ON COLUMN USERS.QUESTION_NO IS '질문번호(아이디/비밀번호 찾기용)'; 
COMMENT ON COLUMN USERS.QUESTION_ANSWER IS '질문답변(아이디/비밀번호 찾기용)'; 
COMMENT ON COLUMN USERS.USER_AUTH IS '유저권한(일반유저:U/관리자:A)';
COMMENT ON COLUMN USERS.STATUS IS '상태(미탈퇴:Y/탈퇴:N)';
COMMENT ON COLUMN USERS.GITHUB_URL IS '깃허브주소';
COMMENT ON COLUMN USERS.NOTION_URL IS '노션주소';

CREATE SEQUENCE SEQ_USERNO
NOCACHE;

INSERT INTO USERS VALUES(SEQ_USERNO.NEXTVAL, 'admin', '1234', '나관리', '010-1111-2222', TO_DATE(19950101), 'admin@kh.or.kr', '서울시 강남구 역삼동', SYSDATE, SYSDATE, NULL, 1, '방과후 옥상', 'A', DEFAULT, NULL, NULL);
INSERT INTO USERS VALUES(SEQ_USERNO.NEXTVAL, 'user01', 'pass01', '차은우', '010-3333-4444', TO_DATE(19980820), 'user01@kh.or.kr', '서울시 양천구 목동', SYSDATE, SYSDATE, NULL, 2, '내가제일잘나가', DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO USERS VALUES(SEQ_USERNO.NEXTVAL, 'user02', 'pass02', '주지훈', '010-5555-6666', TO_DATE(19941123), 'user02@kh.or.kr', '서울시 강서구', SYSDATE, SYSDATE, NULL, 3, '내얼굴', DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO USERS VALUES(SEQ_USERNO.NEXTVAL, 'user03', 'pass03', '장원영', '010-7777-8888', TO_DATE(20000227), 'user03@kh.or.kr', '인천', SYSDATE, SYSDATE, NULL, 4, '우리의그분', DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO USERS VALUES(SEQ_USERNO.NEXTVAL, 'user04', 'pass04', '손흥민', '010-7777-7777', TO_DATE(19920603), 'user04@kh.or.kr', '경기도', SYSDATE, SYSDATE, NULL, 5, '2022-02-22', DEFAULT, DEFAULT, NULL, NULL);

--------------------------------------------------------------------------------
--###############  댓글  ###############
--------------------------------------------------------------------------------
CREATE TABLE COMMENTS( -- COMMENT는 예약어라 테이블명에 사용 못함. 대신 뒤에 S를 붙여 사용.
    COMMENT_NO NUMBER PRIMARY KEY,
    COMMENT_TYPE CHAR(1) DEFAULT 'P' NOT NULL,
    P_COMMENT_NO NUMBER,
    WRITER_NO NUMBER NOT NULL,
    COMMENT_CONTENT VARCHAR2(400) NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    FOREIGN KEY(P_COMMENT_NO) REFERENCES COMMENTS(COMMENT_NO),
    FOREIGN KEY(WRITER_NO) REFERENCES USERS(USER_NO),
    CHECK(COMMENT_TYPE IN ('P', 'C')),
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN COMMENTS.COMMENT_NO IS '댓글번호';
COMMENT ON COLUMN COMMENTS.COMMENT_TYPE IS '댓글구분(부모:P/자식:C)';
COMMENT ON COLUMN COMMENTS.P_COMMENT_NO IS '부모댓글번호';
COMMENT ON COLUMN COMMENTS.WRITER_NO IS '작성자번호';
COMMENT ON COLUMN COMMENTS.COMMENT_CONTENT IS '댓글내용';
COMMENT ON COLUMN COMMENTS.CREATE_DATE IS '작성일';
COMMENT ON COLUMN COMMENTS.STATUS IS '상태(미삭제:Y/삭제:N)';

CREATE SEQUENCE SEQ_COMMENTNO
NOCACHE;

INSERT INTO COMMENTS VALUES(SEQ_COMMENTNO.NEXTVAL, 'P', NULL, 3, '댓글 테스트 중입니다~~~', SYSDATE, DEFAULT);
INSERT INTO COMMENTS VALUES(SEQ_COMMENTNO.NEXTVAL, 'P', NULL, 1, '잘 되려나~~~', SYSDATE, DEFAULT);
INSERT INTO COMMENTS VALUES(SEQ_COMMENTNO.NEXTVAL, 'P', NULL, 2, '괜찮아 잘될거야', SYSDATE, DEFAULT);
INSERT INTO COMMENTS VALUES(SEQ_COMMENTNO.NEXTVAL, 'C', 1, 5, '답글테스트~~~', SYSDATE, DEFAULT);
INSERT INTO COMMENTS VALUES(SEQ_COMMENTNO.NEXTVAL, 'C', 1, 4, '오호~~ 아무말대잔치', SYSDATE, DEFAULT);


--------------------------------------------------------------------------------
--###############  알림  ############### (공통 헤더에 사용될 알림)
--------------------------------------------------------------------------------
CREATE TABLE NOTIFICATION(
    NOTI_NO NUMBER PRIMARY KEY,
    SENDER_NO NUMBER NOT NULL,
    RECEIVER_NO NUMBER NOT NULL,
    CONTENT VARCHAR2(255) NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    READ CHAR(1) DEFAULT'N' NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    REFER_DB VARCHAR2(20),
    REFER_NO NUMBER,
    FOREIGN KEY(SENDER_NO) REFERENCES USERS(USER_NO),
    FOREIGN KEY(RECEIVER_NO) REFERENCES USERS(USER_NO),
    CHECK(READ IN ('Y', 'N')),
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN NOTIFICATION.NOTI_NO IS '알림번호';
COMMENT ON COLUMN NOTIFICATION.SENDER_NO IS '발신인번호';
COMMENT ON COLUMN NOTIFICATION.RECEIVER_NO IS '수신인번호';
COMMENT ON COLUMN NOTIFICATION.CONTENT IS '알림내용';
COMMENT ON COLUMN NOTIFICATION.CREATE_DATE IS '생성일';
COMMENT ON COLUMN NOTIFICATION.READ IS '읽기여부(읽음:Y/안읽음:N)';
COMMENT ON COLUMN NOTIFICATION.STATUS IS '상태(미삭제:Y/삭제:N)';
COMMENT ON COLUMN NOTIFICATION.REFER_DB IS '참조DB테이블명';
COMMENT ON COLUMN NOTIFICATION.REFER_NO IS '참조글번호';

CREATE SEQUENCE SEQ_NOTINO
NOCACHE;

INSERT INTO NOTIFICATION VALUES(SEQ_NOTINO.NEXTVAL, 3, 5, '주지훈(user02)님이 댓글을 남겼습니다.', SYSDATE, DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO NOTIFICATION VALUES(SEQ_NOTINO.NEXTVAL, 1, 2, '나관리(admin)님이 설문조사를 요청하였습니다.', SYSDATE, DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO NOTIFICATION VALUES(SEQ_NOTINO.NEXTVAL, 4, 2, '장원영(user03)님이 댓글을 남겼습니다.', SYSDATE, DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO NOTIFICATION VALUES(SEQ_NOTINO.NEXTVAL, 5, 1, '손흥민(user04)님이 댓글을 남겼습니다.', SYSDATE, DEFAULT, DEFAULT, NULL, NULL);
INSERT INTO NOTIFICATION VALUES(SEQ_NOTINO.NEXTVAL, 2, 3, '차은우(user01)님이 댓글을 남겼습니다.', SYSDATE, DEFAULT, DEFAULT, NULL, NULL);

--------------------------------------------------------------------------------
--###############  주소록_카테고리  ###############
--------------------------------------------------------------------------------
CREATE TABLE CONTACTS_CATEGORY(
    CATEGORY_NO NUMBER PRIMARY KEY,
    CATEGORY_NAME VARCHAR2(50) NOT NULL UNIQUE 
);

COMMENT ON COLUMN CONTACTS_CATEGORY.CATEGORY_NO IS '카테고리번호';
COMMENT ON COLUMN CONTACTS_CATEGORY.CATEGORY_NAME IS '카테고리이름(ex) 세미프로젝트)';

CREATE SEQUENCE SEQ_CONTACTS_CATENO
NOCACHE;

INSERT INTO CONTACTS_CATEGORY VALUES(SEQ_CONTACTS_CATENO.NEXTVAL, '자바 미니 팀프로젝트');
INSERT INTO CONTACTS_CATEGORY VALUES(SEQ_CONTACTS_CATENO.NEXTVAL, '웹 클론 프로젝트');
INSERT INTO CONTACTS_CATEGORY VALUES(SEQ_CONTACTS_CATENO.NEXTVAL, '세미 프로젝트');
INSERT INTO CONTACTS_CATEGORY VALUES(SEQ_CONTACTS_CATENO.NEXTVAL, '파이널 프로젝트');
INSERT INTO CONTACTS_CATEGORY VALUES(SEQ_CONTACTS_CATENO.NEXTVAL, '자격증 스터디');

--------------------------------------------------------------------------------
--###############  주소록  ###############
--------------------------------------------------------------------------------
CREATE TABLE CONTACTS(
    CONTACTS_NO NUMBER PRIMARY KEY,
    CONTACTS_NAME VARCHAR2(50) NOT NULL,
    CONTACTS_TYPE CHAR(1) DEFAULT 'P' NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CATEGORY_NO NUMBER,
    FOREIGN KEY(CATEGORY_NO) REFERENCES CONTACTS_CATEGORY(CATEGORY_NO),
    CHECK(CONTACTS_TYPE IN ('P', 'S')),
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN CONTACTS.CONTACTS_NO IS '주소록번호';
COMMENT ON COLUMN CONTACTS.CONTACTS_NAME IS '주소록이름(ex) 세미프로젝트 2조)';
COMMENT ON COLUMN CONTACTS.CONTACTS_TYPE IS '주소록구분(개인:P/공유:S)';
COMMENT ON COLUMN CONTACTS.STATUS IS '상태(미삭제:Y/삭제:N)';
COMMENT ON COLUMN CONTACTS.CATEGORY_NO IS '카테고리번호';

CREATE SEQUENCE SEQ_CONTACTSNO
NOCACHE;

INSERT INTO CONTACTS VALUES(SEQ_CONTACTSNO.NEXTVAL, '세미프로젝트 1조', 'S', DEFAULT, 3);
INSERT INTO CONTACTS VALUES(SEQ_CONTACTSNO.NEXTVAL, '세미프로젝트 2조', 'S', DEFAULT, 3);
INSERT INTO CONTACTS VALUES(SEQ_CONTACTSNO.NEXTVAL, '세미프로젝트 3조', 'S', DEFAULT, 3);
INSERT INTO CONTACTS VALUES(SEQ_CONTACTSNO.NEXTVAL, '세미프로젝트 4조', 'S', DEFAULT, 3);
INSERT INTO CONTACTS VALUES(SEQ_CONTACTSNO.NEXTVAL, '세미프로젝트 5조', 'S', DEFAULT, 3);

--------------------------------------------------------------------------------
--###############  주소록_구성원  ###############
--------------------------------------------------------------------------------
CREATE TABLE CONTACTS_MEMBER(
    USER_NO NUMBER,
    CONTACTS_NO NUMBER,
    ROLE CHAR(1) CHECK (ROLE IN ('T', 'S', 'L', 'F')), 
    PRIMARY KEY(USER_NO, CONTACTS_NO),
    FOREIGN KEY(USER_NO) REFERENCES USERS(USER_NO),
    FOREIGN KEY(CONTACTS_NO) REFERENCES CONTACTS(CONTACTS_NO)
);

COMMENT ON COLUMN CONTACTS_MEMBER.USER_NO IS '유저번호';
COMMENT ON COLUMN CONTACTS_MEMBER.CONTACTS_NO IS '주소록번호';
COMMENT ON COLUMN CONTACTS_MEMBER.ROLE IS '역할(선생님:T/학생:S, 팀장:L/팀원:F)';

INSERT INTO CONTACTS_MEMBER VALUES(1, 1, 'L');
INSERT INTO CONTACTS_MEMBER VALUES(2, 1, 'F');
INSERT INTO CONTACTS_MEMBER VALUES(3, 2, 'L');
INSERT INTO CONTACTS_MEMBER VALUES(4, 2, 'F');
INSERT INTO CONTACTS_MEMBER VALUES(5, 3, 'L');

--------------------------------------------------------------------------------
--###############  주소록_중요표시  ###############
--------------------------------------------------------------------------------
CREATE TABLE CONTACTS_STAR(
    STAR_NO NUMBER PRIMARY KEY,
    CURRENT_USER_NO NUMBER NOT NULL,
    OTHER_USER_NO NUMBER NOT NULL,
    STAR CHAR(1) DEFAULT 'Y' NOT NULL,
    FOREIGN KEY(CURRENT_USER_NO) REFERENCES USERS(USER_NO),
    FOREIGN KEY(OTHER_USER_NO) REFERENCES USERS(USER_NO),
    CHECK(STAR IN ('Y', 'N'))
);

COMMENT ON COLUMN CONTACTS_STAR.STAR_NO IS '중요표시번호';
COMMENT ON COLUMN CONTACTS_STAR.CURRENT_USER_NO IS '현유저번호';
COMMENT ON COLUMN CONTACTS_STAR.OTHER_USER_NO IS '타유저번호';
COMMENT ON COLUMN CONTACTS_STAR.STAR IS '중요표시(중요:Y/안중요:N)';

CREATE SEQUENCE SEQ_CONTACTS_STARNO
NOCACHE;

INSERT INTO CONTACTS_STAR VALUES(SEQ_CONTACTS_STARNO.NEXTVAL, 1, 2, DEFAULT);
INSERT INTO CONTACTS_STAR VALUES(SEQ_CONTACTS_STARNO.NEXTVAL, 1, 3, DEFAULT);
INSERT INTO CONTACTS_STAR VALUES(SEQ_CONTACTS_STARNO.NEXTVAL, 2, 1, DEFAULT);
INSERT INTO CONTACTS_STAR VALUES(SEQ_CONTACTS_STARNO.NEXTVAL, 2, 4, DEFAULT);
INSERT INTO CONTACTS_STAR VALUES(SEQ_CONTACTS_STARNO.NEXTVAL, 3, 5, DEFAULT);

--------------------------------------------------------------------------------
--###############  메일  ###############
--------------------------------------------------------------------------------
CREATE TABLE MAIL (
    MAIL_NO NUMBER PRIMARY KEY,
    SENDER NUMBER NOT NULL,
    MAIL_TITLE VARCHAR2(100) NOT NULL,
    MAIL_CONTENT VARCHAR2(4000),
    SEND_DATE DATE DEFAULT SYSDATE NOT NULL,
    SEND_CANCEL CHAR(1) DEFAULT 'N' NOT NULL,
    FOREIGN KEY (SENDER) REFERENCES USERS(USER_NO),
    CHECK (SEND_CANCEL IN ('Y', 'N'))
);

COMMENT ON COLUMN MAIL.MAIL_NO IS '메일번호';
COMMENT ON COLUMN MAIL.SENDER IS '발신인';
COMMENT ON COLUMN MAIL.MAIL_TITLE IS '메일제목';
COMMENT ON COLUMN MAIL.MAIL_CONTENT IS '메일내용';
COMMENT ON COLUMN MAIL.SEND_DATE IS '발신일시';
COMMENT ON COLUMN MAIL.SEND_CANCEL IS '발신취소여부(발신취소:Y/발신:N)';

CREATE SEQUENCE SEQ_MAILNO
NOCACHE;

INSERT INTO MAIL VALUES(SEQ_MAILNO.NEXTVAL, 3, '이곳은 메일 제목 자리입니다!!!', '여기는 메일의 내용 자리입니다.', SYSDATE, DEFAULT);
INSERT INTO MAIL VALUES(SEQ_MAILNO.NEXTVAL, 5, '가나다라마바사아자차카타파하', '여기는 메일의 내용 자리입니다.11111', SYSDATE, DEFAULT);
INSERT INTO MAIL VALUES(SEQ_MAILNO.NEXTVAL, 1, '샘플데이터 넣는중~~~~', '여기는 메일의 내용 자리입니다.22222', SYSDATE, DEFAULT);
INSERT INTO MAIL VALUES(SEQ_MAILNO.NEXTVAL, 4, '2222이곳은 메일 제목 자리입니다!!!', '여기는 메일의 내용 자리입니다.33333', SYSDATE, DEFAULT);
INSERT INTO MAIL VALUES(SEQ_MAILNO.NEXTVAL, 2, '3333이곳은 메일 제목 자리입니다!!!', '여기는 메일의 내용 자리입니다.4444', SYSDATE, DEFAULT);

--------------------------------------------------------------------------------
--###############  메일_수신인  ###############
--------------------------------------------------------------------------------
CREATE TABLE MAIL_RECEIVER (
    MAIL_NO NUMBER,
    RECEIVER_NO NUMBER,
    RECEIVER_TYPE CHAR(1) DEFAULT 'R' NOT NULL,
    READ CHAR(1) DEFAULT 'N' NOT NULL,
    PRIMARY KEY(MAIL_NO, RECEIVER_NO),
    FOREIGN KEY(MAIL_NO) REFERENCES MAIL(MAIL_NO),
    FOREIGN KEY(RECEIVER_NO) REFERENCES USERS(USER_NO),
    CHECK(RECEIVER_TYPE IN ('R', 'C', 'S')),
    CHECK(READ IN ('Y', 'N'))
);

COMMENT ON COLUMN MAIL_RECEIVER.MAIL_NO IS '메일번호';
COMMENT ON COLUMN MAIL_RECEIVER.RECEIVER_NO IS '수신인번호';
COMMENT ON COLUMN MAIL_RECEIVER.RECEIVER_TYPE IS '수신인구분(수신:R/참조:C/비밀:S)';
COMMENT ON COLUMN MAIL_RECEIVER.READ IS '읽음여부(읽음:Y/않읽음:N)';

INSERT INTO MAIL_RECEIVER VALUES(1, 2, DEFAULT, DEFAULT);
INSERT INTO MAIL_RECEIVER VALUES(1, 3, 'C', 'Y');
INSERT INTO MAIL_RECEIVER VALUES(1, 4, 'S', DEFAULT);
INSERT INTO MAIL_RECEIVER VALUES(1, 5, DEFAULT, DEFAULT);
INSERT INTO MAIL_RECEIVER VALUES(2, 1, DEFAULT, DEFAULT);

--------------------------------------------------------------------------------
--###############  메일함  ###############
--------------------------------------------------------------------------------
CREATE TABLE MAILBOX(
    MAILBOX_NO NUMBER PRIMARY KEY,
    MAILBOX_NAME VARCHAR2(50) NOT NULL,
    MAILBOX_TYPE CHAR(1) DEFAULT 'B' NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CHECK(MAILBOX_TYPE IN('B', 'P')),
    CHECK(STATUS IN('Y', 'N'))
);

COMMENT ON COLUMN MAILBOX.MAILBOX_NO IS '메일함번호';
COMMENT ON COLUMN MAILBOX.MAILBOX_NAME IS '메일함이름';
COMMENT ON COLUMN MAILBOX.MAILBOX_TYPE IS '메일함구분(기본:B/개인:P)';
COMMENT ON COLUMN MAILBOX.STATUS IS '상태(미삭제:Y/삭제:N)';

CREATE SEQUENCE SEQ_MAILBOXNO
NOCACHE;

INSERT INTO MAILBOX VALUES(SEQ_MAILBOXNO.NEXTVAL, '받은메일함', DEFAULT, DEFAULT);
INSERT INTO MAILBOX VALUES(SEQ_MAILBOXNO.NEXTVAL, '보낸메일함', DEFAULT, DEFAULT);
INSERT INTO MAILBOX VALUES(SEQ_MAILBOXNO.NEXTVAL, '임시보관함', DEFAULT, DEFAULT);
INSERT INTO MAILBOX VALUES(SEQ_MAILBOXNO.NEXTVAL, '휴지통', DEFAULT, DEFAULT);
INSERT INTO MAILBOX VALUES(SEQ_MAILBOXNO.NEXTVAL, '개인보관함1', 'P', DEFAULT);

--------------------------------------------------------------------------------
--###############  메일_소유자  ###############
--------------------------------------------------------------------------------
CREATE TABLE MAIL_OWNER(
    OWNER_NO NUMBER,
    MAIL_NO NUMBER,
    MAILBOX_NO NUMBER NOT NULL,
    MAIL_STAR CHAR(1) DEFAULT 'N' NOT NULL,
    MAIL_STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    PRIMARY KEY(OWNER_NO, MAIL_NO),
    FOREIGN KEY(MAILBOX_NO) REFERENCES MAILBOX(MAILBOX_NO),
    CHECK(MAIL_STAR IN ('Y', 'N')),
    CHECK(MAIL_STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN MAIL_OWNER.OWNER_NO IS '메일소유자';
COMMENT ON COLUMN MAIL_OWNER.MAIL_NO IS '메일번호';
COMMENT ON COLUMN MAIL_OWNER.MAILBOX_NO IS '메일함번호';
COMMENT ON COLUMN MAIL_OWNER.MAIL_STAR IS '메일중요여부(중요:Y/안중요:N)';
COMMENT ON COLUMN MAIL_OWNER.MAIL_STATUS IS '메일상태(미삭제:Y/삭제:N)';

INSERT INTO MAIL_OWNER VALUES(2, 5, 1, DEFAULT, DEFAULT);
INSERT INTO MAIL_OWNER VALUES(2, 4, 1, 'Y', DEFAULT);
INSERT INTO MAIL_OWNER VALUES(2, 3, 2, DEFAULT, DEFAULT);
INSERT INTO MAIL_OWNER VALUES(1, 2, 2, DEFAULT, DEFAULT);
INSERT INTO MAIL_OWNER VALUES(1, 1, 1, DEFAULT, DEFAULT);

--------------------------------------------------------------------------------
--###############  메일_첨부파일  ###############
--------------------------------------------------------------------------------
CREATE TABLE MAIL_ATTACHMENT(
    MAIL_NO NUMBER,
    FILE_NO NUMBER,
    PRIMARY KEY(MAIL_NO, FILE_NO),
    FOREIGN KEY(MAIL_NO) REFERENCES MAIL(MAIL_NO),
    FOREIGN KEY(FILE_NO) REFERENCES ATTACHMENT(FILE_NO)
);

COMMENT ON COLUMN MAIL_ATTACHMENT.MAIL_NO IS '메일번호';
COMMENT ON COLUMN MAIL_ATTACHMENT.FILE_NO IS '파일번호';

INSERT INTO MAIL_ATTACHMENT VALUES(1, 1);
INSERT INTO MAIL_ATTACHMENT VALUES(1, 2);
INSERT INTO MAIL_ATTACHMENT VALUES(1, 3);
INSERT INTO MAIL_ATTACHMENT VALUES(2, 4);
INSERT INTO MAIL_ATTACHMENT VALUES(3, 5);

--------------------------------------------------------------------------------
--###############  수업_게시판  ###############
--------------------------------------------------------------------------------
CREATE TABLE CLASS_BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_NAME VARCHAR2(50) NOT NULL UNIQUE,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN CLASS_BOARD.BOARD_NO IS '게시판번호';
COMMENT ON COLUMN CLASS_BOARD.BOARD_NAME IS '게시판이름';
COMMENT ON COLUMN CLASS_BOARD.STATUS IS '상태(미삭제:Y/삭제:N)';

CREATE SEQUENCE SEQ_BOARDNO
NOCACHE;

INSERT INTO CLASS_BOARD VALUES(SEQ_BOARDNO.NEXTVAL, 'Java', DEFAULT);
INSERT INTO CLASS_BOARD VALUES(SEQ_BOARDNO.NEXTVAL, 'Oracle', DEFAULT);
INSERT INTO CLASS_BOARD VALUES(SEQ_BOARDNO.NEXTVAL, 'JDBC', DEFAULT);
INSERT INTO CLASS_BOARD VALUES(SEQ_BOARDNO.NEXTVAL, 'Front-End', DEFAULT);
INSERT INTO CLASS_BOARD VALUES(SEQ_BOARDNO.NEXTVAL, 'Server', DEFAULT);

--------------------------------------------------------------------------------
--###############  수업_게시글  ###############
--------------------------------------------------------------------------------
CREATE TABLE CLASS_POST(
    POST_NO NUMBER PRIMARY KEY,
    BOARD_NO NUMBER NOT NULL,
    USER_NO NUMBER NOT NULL,
    POST_TITLE VARCHAR2(100) NOT NULL,
    POST_CONTENT VARCHAR2(4000),
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    FOREIGN KEY(BOARD_NO) REFERENCES CLASS_BOARD(BOARD_NO),
    FOREIGN KEY(USER_NO) REFERENCES USERS(USER_NO),
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN CLASS_POST.POST_NO IS '게시글번호';
COMMENT ON COLUMN CLASS_POST.BOARD_NO IS '게시판번호';
COMMENT ON COLUMN CLASS_POST.USER_NO IS '작성자번호';
COMMENT ON COLUMN CLASS_POST.POST_TITLE IS '게시글제목';
COMMENT ON COLUMN CLASS_POST.POST_CONTENT IS '게시글내용';
COMMENT ON COLUMN CLASS_POST.CREATE_DATE IS '작성일';
COMMENT ON COLUMN CLASS_POST.STATUS IS '상태(미삭제:Y/삭제:N)';

CREATE SEQUENCE SEQ_POSTNO
NOCACHE;

INSERT INTO CLASS_POST VALUES(SEQ_POSTNO.NEXTVAL, 1, 1, '이클립스 설치 및 세팅', '이클립스 설치는 이렇게, 세팅은 요렇게 하면됩니다. 잘 아시겠쥬?', SYSDATE, DEFAULT);
INSERT INTO CLASS_POST VALUES(SEQ_POSTNO.NEXTVAL, 1, 1, '배열', '배열은 배열입니다. 그렇습니다.', SYSDATE, DEFAULT);
INSERT INTO CLASS_POST VALUES(SEQ_POSTNO.NEXTVAL, 1, 1, '컬렉션', '컬렉션에는 이런이런게 있습니다. 이건 컬렉션이 아닙니다.', SYSDATE, DEFAULT);
INSERT INTO CLASS_POST VALUES(SEQ_POSTNO.NEXTVAL, 2, 1, 'SELECT', '원하는 데이터를 가져오려면 쿼리를 이렇게 짜면 됩니다. 조인바리를 이렇게 이렇게, 참 쉽죠?', SYSDATE, DEFAULT);
INSERT INTO CLASS_POST VALUES(SEQ_POSTNO.NEXTVAL, 3, 1, 'JDBC 개요', '자바랑 DB랑 연결해봅시다.', SYSDATE, DEFAULT);

--------------------------------------------------------------------------------
--###############  수업_댓글  ###############
--------------------------------------------------------------------------------
CREATE TABLE CLASS_COMMENT(
    POST_NO NUMBER,
    COMMENT_NO NUMBER UNIQUE,
    PRIMARY KEY(POST_NO, COMMENT_NO),
    FOREIGN KEY(POST_NO) REFERENCES CLASS_POST(POST_NO),
    FOREIGN KEY(COMMENT_NO) REFERENCES COMMENTS(COMMENT_NO)
);

COMMENT ON COLUMN CLASS_COMMENT.POST_NO IS '게시글번호';
COMMENT ON COLUMN CLASS_COMMENT.COMMENT_NO IS '댓글번호';

INSERT INTO CLASS_COMMENT VALUES(1, 1);
INSERT INTO CLASS_COMMENT VALUES(1, 2);
INSERT INTO CLASS_COMMENT VALUES(2, 3);
INSERT INTO CLASS_COMMENT VALUES(3, 4);
INSERT INTO CLASS_COMMENT VALUES(3, 5);

--------------------------------------------------------------------------------
--###############  수업_첨부파일  ###############
--------------------------------------------------------------------------------
CREATE TABLE CLASS_ATTACHMENT(
    POST_NO NUMBER,
    FILE_NO NUMBER,
    PRIMARY KEY (POST_NO, FILE_NO),
    FOREIGN KEY(POST_NO) REFERENCES CLASS_POST(POST_NO),
    FOREIGN KEY(FILE_NO) REFERENCES ATTACHMENT(FILE_NO)
);

COMMENT ON COLUMN CLASS_ATTACHMENT.POST_NO IS '게시글번호';
COMMENT ON COLUMN CLASS_ATTACHMENT.FILE_NO IS '파일번호';

INSERT INTO CLASS_ATTACHMENT VALUES(1, 5);
INSERT INTO CLASS_ATTACHMENT VALUES(1, 4);
INSERT INTO CLASS_ATTACHMENT VALUES(2, 1);
INSERT INTO CLASS_ATTACHMENT VALUES(3, 2);
INSERT INTO CLASS_ATTACHMENT VALUES(4, 3);

--------------------------------------------------------------------------------
--###############  설문조사_게시글  ###############
--------------------------------------------------------------------------------
CREATE TABLE SURVEY_POST(
    POST_NO NUMBER PRIMARY KEY,
    POST_TITLE VARCHAR2(100) NOT NULL,
    WRITER_NO NUMBER NOT NULL,
    CREATE_DATE DATE DEFAULT SYSDATE NOT NULL,
    ON_GOING CHAR(1) DEFAULT 'Y' NOT NULL,
    TEMP_SAVE CHAR(1) DEFAULT 'N' NOT NULL,
    STATUS CHAR(1) DEFAULT 'Y' NOT NULL,
    FOREIGN KEY(WRITER_NO) REFERENCES USERS(USER_NO),
    CHECK(ON_GOING IN ('Y', 'N')),
    CHECK(TEMP_SAVE IN ('Y', 'N')),
    CHECK(STATUS IN ('Y', 'N'))
);

COMMENT ON COLUMN SURVEY_POST.POST_NO IS '게시글번호';
COMMENT ON COLUMN SURVEY_POST.POST_TITLE IS '게시글제목';
COMMENT ON COLUMN SURVEY_POST.WRITER_NO IS '작성자번호';
COMMENT ON COLUMN SURVEY_POST.CREATE_DATE IS '작성일';
COMMENT ON COLUMN SURVEY_POST.ON_GOING IS '진행여부(진행중:Y/종료:N)';
COMMENT ON COLUMN SURVEY_POST.TEMP_SAVE IS '임시보관여부(임시보관:Y/게시:N)';
COMMENT ON COLUMN SURVEY_POST.STATUS IS '상태(미삭제:Y/삭제:N)';

CREATE SEQUENCE SEQ_SURVEYPOSTNO
NOCACHE;

INSERT INTO SURVEY_POST VALUES(SEQ_SURVEYPOSTNO.NEXTVAL, '평가제출현황_240607', 1, SYSDATE, 'N', DEFAULT, DEFAULT);
INSERT INTO SURVEY_POST VALUES(SEQ_SURVEYPOSTNO.NEXTVAL, '평가제출현황_240620', 1, SYSDATE, 'N', DEFAULT, DEFAULT);
INSERT INTO SURVEY_POST VALUES(SEQ_SURVEYPOSTNO.NEXTVAL, '평가제출현황_240703', 1, SYSDATE, 'N', DEFAULT, DEFAULT);
INSERT INTO SURVEY_POST VALUES(SEQ_SURVEYPOSTNO.NEXTVAL, '평가제출현황_240715', 1, SYSDATE, 'N', DEFAULT, DEFAULT);
INSERT INTO SURVEY_POST VALUES(SEQ_SURVEYPOSTNO.NEXTVAL, '평가제출현황_240801', 1, SYSDATE, 'Y', DEFAULT, DEFAULT);

--------------------------------------------------------------------------------
--###############  설문조사_대상자  ###############
--------------------------------------------------------------------------------
CREATE TABLE SURVEY_MEMBER(
    POST_NO NUMBER,
    USER_NO NUMBER,
    COMPLETE CHAR(1) DEFAULT 'N' NOT NULL,
    PRIMARY KEY(POST_NO, USER_NO),
    FOREIGN KEY(POST_NO) REFERENCES SURVEY_POST(POST_NO),
    FOREIGN KEY(USER_NO) REFERENCES USERS(USER_NO),
    CHECK(COMPLETE IN ('Y', 'N'))
);

COMMENT ON COLUMN SURVEY_MEMBER.POST_NO IS '게시글번호';
COMMENT ON COLUMN SURVEY_MEMBER.USER_NO IS '조사대상자번호';
COMMENT ON COLUMN SURVEY_MEMBER.COMPLETE IS '완료여부(참여완료:Y/미완료:N)';

INSERT INTO SURVEY_MEMBER VALUES(1, 2, 'N');
INSERT INTO SURVEY_MEMBER VALUES(1, 3, 'Y');
INSERT INTO SURVEY_MEMBER VALUES(1, 4, 'Y');
INSERT INTO SURVEY_MEMBER VALUES(1, 5, 'N');
INSERT INTO SURVEY_MEMBER VALUES(2, 2, 'N');

--------------------------------------------------------------------------------
--###############  설문조사_질문  ###############
--------------------------------------------------------------------------------
CREATE TABLE SURVEY_QUESTION(
    QUESTION_NO NUMBER PRIMARY KEY,
    POST_NO NUMBER NOT NULL,
    QUESTION_CONTENT VARCHAR2(300) NOT NULL,
    ANSWER_TYPE CHAR(1) DEFAULT 'S' NOT NULL,
    REQUIRED CHAR(1) DEFAULT 'N' NOT NULL,
    FOREIGN KEY(POST_NO) REFERENCES SURVEY_POST(POST_NO),
    CHECK(ANSWER_TYPE IN ('S', 'M', 'D')),
    CHECK(REQUIRED IN ('Y', 'N'))
);

COMMENT ON COLUMN SURVEY_QUESTION.QUESTION_NO IS '질문번호';
COMMENT ON COLUMN SURVEY_QUESTION.POST_NO IS '게시글번호';
COMMENT ON COLUMN SURVEY_QUESTION.QUESTION_CONTENT IS '질문내용';
COMMENT ON COLUMN SURVEY_QUESTION.ANSWER_TYPE IS '답변타입(단일선택:S/다중선택:M/서술형:D)';
COMMENT ON COLUMN SURVEY_QUESTION.REQUIRED IS '필수입력여부(필수입력:Y/선택입력:N)';

CREATE SEQUENCE SEQ_SURVEYQNO
NOCACHE;

INSERT INTO SURVEY_QUESTION VALUES(SEQ_SURVEYQNO.NEXTVAL, 5, '이번 시험 난이도 어땠나요?', 'S', 'Y');
INSERT INTO SURVEY_QUESTION VALUES(SEQ_SURVEYQNO.NEXTVAL, 5, '가장 어려웠던 문제는?', 'S', 'N');
INSERT INTO SURVEY_QUESTION VALUES(SEQ_SURVEYQNO.NEXTVAL, 5, '가장 쉬웠던 문제는?', 'S', 'N');
INSERT INTO SURVEY_QUESTION VALUES(SEQ_SURVEYQNO.NEXTVAL, 4, '좋아하는 가수는?', 'D', 'N');
INSERT INTO SURVEY_QUESTION VALUES(SEQ_SURVEYQNO.NEXTVAL, 4, '취미?', 'M', 'Y');

--------------------------------------------------------------------------------
--###############  설문조사_선택지  ###############
--------------------------------------------------------------------------------
CREATE TABLE SURVEY_CHOICE(
    CHOICE_NO NUMBER PRIMARY KEY,
    QUESTION_NO NUMBER NOT NULL,
    CHOICE_CONTENT VARCHAR2(100) NOT NULL,
    FOREIGN KEY(QUESTION_NO) REFERENCES SURVEY_QUESTION(QUESTION_NO)
);

COMMENT ON COLUMN SURVEY_CHOICE.CHOICE_NO IS '선택지번호';
COMMENT ON COLUMN SURVEY_CHOICE.QUESTION_NO IS '질문번호';
COMMENT ON COLUMN SURVEY_CHOICE.CHOICE_CONTENT IS '선택지내용';

CREATE SEQUENCE SEQ_SURVEY_CHOICENO
NOCACHE;

INSERT INTO SURVEY_CHOICE VALUES(SEQ_SURVEY_CHOICENO.NEXTVAL, 1, '매우 쉬움');
INSERT INTO SURVEY_CHOICE VALUES(SEQ_SURVEY_CHOICENO.NEXTVAL, 1, '쉬움');
INSERT INTO SURVEY_CHOICE VALUES(SEQ_SURVEY_CHOICENO.NEXTVAL, 1, '보통');
INSERT INTO SURVEY_CHOICE VALUES(SEQ_SURVEY_CHOICENO.NEXTVAL, 1, '어려움');
INSERT INTO SURVEY_CHOICE VALUES(SEQ_SURVEY_CHOICENO.NEXTVAL, 1, '매우 어려움');

--------------------------------------------------------------------------------
--###############  설문조사_답변  ###############
--------------------------------------------------------------------------------
CREATE TABLE SURVEY_ANSWER(
    QUESTION_NO NUMBER,
    USER_NO NUMBER,
    USER_ANSWER VARCHAR2(300),
    PRIMARY KEY(QUESTION_NO, USER_NO),
    FOREIGN KEY(QUESTION_NO) REFERENCES SURVEY_QUESTION(QUESTION_NO),
    FOREIGN KEY(USER_NO) REFERENCES USERS(USER_NO)
);

COMMENT ON COLUMN SURVEY_ANSWER.QUESTION_NO IS '질문번호';
COMMENT ON COLUMN SURVEY_ANSWER.USER_NO IS '유저번호';
COMMENT ON COLUMN SURVEY_ANSWER.USER_ANSWER IS '유저답변(ex)1,2,3,..., 일반텍스트도 가능)';

INSERT INTO SURVEY_ANSWER VALUES(1, 2, '3');
INSERT INTO SURVEY_ANSWER VALUES(1, 3, '2');
INSERT INTO SURVEY_ANSWER VALUES(1, 4, '4');
INSERT INTO SURVEY_ANSWER VALUES(1, 5, '3');
INSERT INTO SURVEY_ANSWER VALUES(5, 2, '영화보기, 등산, 요리');


--------------------------------------------------------------------------------
--###############  테이블명  ###############
--------------------------------------------------------------------------------


-- 커밋!!
COMMIT;