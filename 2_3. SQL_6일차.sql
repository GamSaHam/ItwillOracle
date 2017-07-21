
-- FOREIGN KEY : 다른 테이블에 저장된 컬럼값을 참조하여 잘못된 데이터 저장을 방지하기
--              위한 기능을 가지고 있는 제약조건 => 테이블들의 잘못된 JOIN을 방지하기 위해 사용
--  => FOREIGN KEY 제약조건의 컬럼이 참조할 수 있는 다른 테이블의 컬럼은 반드시 PK 제약
--                  조건이 부여 되어 있어야 된다.

-- SUBJECT 테이블 생성 => 과목코드(PK), 과목명을 저장하기 위한 테이블
-- 숫자형 문자형이랑 비교했을때 숫자형이 계산값이 빠르다.
CREATE TABLE SUBJECT(SNO NUMBER(2),SNAME VARCHAR2(20)
        ,CONSTRAINT SUBJECT_SNO_PK PRIMARY KEY(SNO));

DESC SUBJECT;

SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SUBJECT';

-- 과목 코드 과목 이름 저장
INSERT INTO SUBJECT VALUES(10,'JAVA');
INSERT INTO SUBJECT VALUES(20,'ORACLE');
INSERT INTO SUBJECT VALUES(30,'LINUX');
COMMIT;

SELECT * FROM SUBJECT;

-- TRAINEE1 테이블 생성 => 수강생 코드(PK), 수강생 이름, 수강 과목 코드를 저장
--                          하기 위한 테이블

CREATE TABLE TRAINEE1(TNO NUMBER(4), TNAME VARCHAR2(20),SCODE NUMBER(2)
                        ,CONSTRAINT TRAINEE1_TNO_PK PRIMARY KEY(TNO));

DESC TRAINEE1;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TRAINEE1';

INSERT INTO TRAINEE1 VALUES(1000, '홍길동',10);
INSERT INTO TRAINEE1 VALUES(2000, '임꺽정',20);
INSERT INTO TRAINEE1 VALUES(3000, '전우치',30);
INSERT INTO TRAINEE1 VALUES(4000, '일지매',40);
COMMIT;

SELECT * FROM TRAINEE1; -- 일지매는 없는 부서를 듣고 있다.

-- 수강생코드, 수강생이름, 수강과목이름 검색
--  => TRAINEE1 테이블과 SUBJECT 테이블을 JOIN 하여 검색
--  => JOIN 조건에 맞지 않는 수강생 정보는 검색되지 않는다.
DESC TRAINEE1;
DESC SUBJECT;

-- JOIN 조건에 맞지 않는 수강생 정보를 검색하고자 할 경우 OUTER JOIN 사용
--  => 수강생은 존재 하지만 수강과목은 없다. - 데이터 무결성 위반
SELECT TNO,TNAME,SNAME FROM TRAINEE1 T JOIN SUBJECT S ON T.SCODE = S.SNO; 


CREATE TABLE TRAINEE2(TNO NUMBER(4), TNAME VARCHAR2(20),SCODE NUMBER(2)
                        ,CONSTRAINT TRAINEE2_TNO_PK PRIMARY KEY(TNO)
                        ,CONSTRAINT TRAINEE2_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT(SNO));

DESC TRAINEE2;

-- 여기서 CONSTRAINTS [제약조건 명] 제약조건 에 제약조건 명이 나온다.
-- CONSTRAINT_TYPE : R - FOREGIN KEY
-- R_CONSTRAINT_NAME : 참조하는 컬럼의 제약조건 이름
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME ='TRAINEE2';

INSERT INTO TRAINEE2 VALUES(1000, '홍길동',10);
INSERT INTO TRAINEE2 VALUES(2000, '임꺽정',20);
INSERT INTO TRAINEE2 VALUES(3000, '전우치',30);

-- SUBJECT 테이블의 SNO 컬럼의 컬럼값으로 존재하지 않는 SCODE 컬럼값을 저장할 경우 에러 발생
INSERT INTO TRAINEE2 VALUES(4000, '일지매',40); -- 일지매 에러 - PARANT KEY NOT FOUND
COMMIT;

SELECT * FROM TRAINEE2;

-- FK 제약조건에 의해 JOIN 조건에 맞지 않는 수강생은 존재하지 않는다.
SELECT TNO,TNAME,SNAME FROM TRAINEE2 T JOIN SUBJECT S ON T.SCODE = S.SNO;

-- SUBJECT 테이블에서 과목코드 10인 과목정보 삭제
-- FOREGIN KEY 에 의해서 데이터가 보호 받는다.
--  => TRAINEE2 테이블의 SCODE 컬럼값으로 저장되어 참조되는 SUBJECT 테이블의 
--      SNO 컬럼값을 가진 데이터는 삭제 되지 않는다. => 데이터 무결성 유지
--      개발자는 좋아하지 않는다. 속도가 느리다.
--      테이블이 키가 존재하는지 여부를 확인 하는 비용이 드므로
DELETE FROM SUBJECT WHERE SNO = 10; -- 에러 발생

-- CHECK : 제공한 조건에 만족할 경우에만 데이터 조작이 가능하도록 설정하는 제약조건

-- SAWON1 테이블 생성 => 사원번호(PK), 사원이름, 급여를 저장하기 위한 테이블
CREATE TABLE SAWON1(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER(8)
                    ,CONSTRAINT SAWON1_NO_PK PRIMARY KEY(NO));


-- SAWON1 테이블에 사원정보 저장 => 사원의 최소 급여 300만원 설정
INSERT INTO SAWON1 VALUES(1000,'홍길동',5000000);
INSERT INTO SAWON1 VALUES(2000,'임꺽정',3000000);
-- 전우치의 급여는 : 1000만원 - 입력 오류 발생 : 100만원 => 저장 가능(무결성 위반)
INSERT INTO SAWON1 VALUES(3000,'전우치',1000000);
COMMIT;

SELECT NO,NAME,TO_CHAR(PAY,'L999,999,990') PAY FROM SAWON1;


-- SAWON2 테이블 생성 => 사원번호(PK), 사원이름, 급여를 저장하기 위한 테이블
--  => 사원의 급여는 300만원 이상만 입력 되도록 CHECK 제약조건 부여

CREATE TABLE SAWON2(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER(8)
                    ,CONSTRAINT SAWON2_NO_PK PRIMARY KEY(NO)
                    ,CONSTRAINT SAWON2_PAY_CHECK CHECK(PAY >= 3000000));

-- CONSTRAINT_TYPE : C - CHECK
-- SEARCH_CONDITION : CHECK 제약조건의 조건식
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION
        FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SAWON2';

INSERT INTO SAWON2 VALUES(1000,'홍길동',5000000);
INSERT INTO SAWON2 VALUES(2000,'임꺽정',3000000);

-- 전우치의 급여 : 1000만원 - 입력 오류 : 100만원 => CHECK 제약조건에 의해 저장 불가능
INSERT INTO SAWON2 VALUES(3000,'전우치',1000000);  -- 에러 발생
INSERT INTO SAWON2 VALUES(3000,'전우치',10000000);
COMMIT;

SELECT NO,NAME,TO_CHAR(PAY,'L999,999,990') PAY FROM SAWON2;

-- 테이블 삭제 => 테이블에 저장된 모든 데이터도 같이 삭제
-- 형식) DROP TABLE 테이블명;
-- USER_TABES 유저 딕션너리에서 현재 로그인 사용자가 사용 가능한 테이블 목록 확인
SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- USER1 테이블 삭제
DROP TABLE USER1;

SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- 오라클에서는 삭제된 테이블을 복구 할수 있다.
-- 테이블 목록 확인
--  => BIN... : 오라클 휴지통에 존재하는 객체
SELECT * FROM TAB; -- TAB VIEW에서 확인 => 삭제된 테이블 목록 확인

-- 오라클 휴지통(RECYCLEBIN)에 존재하는 객체 목록 확인
SHOW RECYCLEBIN;

-- 오라클 휴지통에 존재하는 객체 복구
FLASHBACK TABLE USER1 TO BEFORE DROP;

SELECT TABLE_NAME FROM TABS;

-- USER1 테이블과 USER2 테이블 삭제
DROP TABLE USER1;
DROP TABLE USER2;

-- 유니크를 부여하면 INDEX라는 객체가 만들어 진다.
SHOW RECYCLEBIN;

-- 오라클 휴지통에서 특정 객체만 제거할수 있드록 (복구 불가)
PURGE TABLE USER2; -- 테이블에 종속된 INDEX 객체 제거
SHOW RECYCLEBIN;

-- 테이블 삭제 (USER3,USER4,USER5)
DROP TABLE USER3;
DROP TABLE USER4;
DROP TABLE USER5;
SHOW RECYCLEBIN;

-- 오라클 휴지통에서 모든 객체 제거
PURGE RECYCLEBIN;
SHOW RECYCLEBIN;

-- USER6 테이블 삭제시 오라클 휴지통으로 이동하지 않고 완전히 삭제
DROP TABLE USER6 PURGE; -- 휴지통으로 이동하지 말고 바로 제거
SHOW RECYCLEBIN;
SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- 테이블 초기화 => 테이블에 존재하는 모든 데이터를 제거하여 테이블 생성 했을 
--                  때와 동일하게 만드는 명령
--                  형식) TRUNCATE TABLE 테이블명

-- BONUS 테이블의 모든 데이터 삭제
SELECT * FROM BONUS;

-- 현제 세션의 트렌젝션에서만 삭제 => 실제 테이블에서는 그대로 존재 한다.
DELETE FROM BONUS;

SELECT * FROM BONUS;

-- 실제 테이블에 DML 명령의 결과를 적용하지 않고 취소
ROLLBACK;

-- 테이블 초기화 => DDL 명령이므로 초기화 후 트렌젝션이 바로 적용(AUTO COMMIT)
TRUNCATE TABLE BONUS;
ROLLBACK;

SELECT* FROM BONUS;

-- 테이블 이름 변경
-- 형식) RENAME 원본 테이블명 TO 변경 테이블명

-- BONUS 테이블의 이름을 COMMISSION으로 변경
SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

RENAME BONUS TO COMMISSION;

SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- 테이블 구조 변경 => 컬럼 추가, 컬럼 삭제, 컬럼의 자료형 또는 저장 크기 변경
-- 형식) ALTER TABLE 테이블명 변경옵션;

-- EMPLOYEE 테이블 생성 => 사원번호, 사원이름, 전화번호를 저장하는 테이블
CREATE TABLE EMPLOYEE(ENO NUMBER(4), ENAME VARCHAR2(10), PHONE VARCHAR2(15));

DESC EMPLOYEE;

-- EMPLOYEE 테이블에 주소를 저장하는 컬럼 추가
-- 테이블을 중간에 바꾸는것을 권장하지 않는다.
ALTER TABLE EMPLOYEE ADD(ADDRESS VARCHAR2(50));
DESC EMPLOYEE;

-- EMPLOYEE 테이블 ENO 커럼의 자료형을 NUMBER(4)에서 VARCHAR2(4)로 변경
ALTER TABLE EMPLOYEE MODIFY (ENO VARCHAR2(4));

DESC EMPLOYEE;

-- EMPLOYEE 테이블에 사원정보 저장
INSERT INTO EMPLOYEE VALUES(1000,'홍길동','111-1111','서울시 강남구 역삼동');
COMMIT;

SELECT * FROM EMPLOYEE;

-- EMPLOYEE 테이블의 ENO 컬럼의 자료형을 VARCHAR2(4) 에서 NUMBER(4)로 변경
--  => 변경하고자 하는 컬럼에 컬럼값이 저장되어 있는 경우 자료형 변경 불가
ALTER TABLE EMPLOYEE MODIFY (ENO NUMBER(4)); -- 에러 발생

-- EMPLOYEE 테이블에 사원정보 저장
--  => 커럶의 저장크기보다 큰 컬럼값을 저장 할 경우 에러 발생
--  => ENAME : 10 BYTE ~ 입력 컬럼값 : 15BYTE
INSERT INTO EMPLOYEE VALUES('2000','임꺽정형님','222-222','서울시 관악구 봉천동'); -- 에러 발생

-- EMPLOYEE 테이블의 ENAME 컬럼의 저장 크기를 20바이트로 변경
--  => 변경하고자 하는 컬럼의 저장 크기는 저장된 컬럼값의 크기보다 크면 변경 가능
ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(20));

SELECT * FROM EMPLOYEE;

ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(10));

-- EMPLOYEE 테이블의 PHONE 컬럼 삭제 => 컬럼값도 같이 삭제
ALTER TABLE EMPLOYEE DROP COLUMN PHONE;
DESC EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- 테이블의 컬럼은 무족건 삭제하는 것보다 먼저 사용을 제한하고 나중에
-- 삭제하는 것을 권장한다.
-- EMPLOYEE 테이블의 ADDRESS 컬럼 사용 제한
-- 컬럼이 삭제 된것은 아니고 눈에만 안보이도록 한 것이다.
ALTER TABLE EMPLOYEE SET UNUSED(ADDRESS);


DESC EMPLOYEE; -- 어드레스 없다

SELECT * FROM EMPLOYEE;

-- 테이블에서 사용 제한된 컬럼의 갯수 확인
SELECT * FROM USER_UNUSED_COL_TABS;

-- 제한 컬럼 삭제
ALTER TABLE EMPLOYEE DROP UNUSED COLUMNS;

-- 테이블의 컬럼에 제약조건을 추가하거나 삭제
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';

DESC EMPLOYEE;

-- EMPLOYEE 테이블의 ENO 컬럼에 PK 제약조건 추가 => 테이블 수준의 제약조건
ALTER TABLE EMPLOYEE ADD(CONSTRAINT EMPLOYEE_ENO_PK PRIMARY KEY(ENO));

-- EMPLOYEE 테이블의 ENAME 컬럼에 NOT NULL 제약조건 추가 => 컬럼 수준의 제약조건
--  => 컬럼 수준의 제약조건(컬럼 구조 변경 옵션 이용)
ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(20) CONSTRAINT EMPLOYEE_ENAME_NN NOT NULL);

DESC EMPLOYEE;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';

-- EMPLOYEE 테이블의 ENO 컬럼의 부여된 PK 제약조건을 삭제
ALTER TABLE EMPLOYEE DROP PRIMARY KEY; -- 프라이머리 키는 하나 이기때문에

-- 이런다고 제거가 되지 않는다.
ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(20));

-- 제약조건 명을 DROP 시켜준다.
-- => 제약조건에 부여된 이름을 이용하여 제거(권장)
ALTER TABLE EMPLOYEE DROP CONSTRAINT EMPLOYEE_ENAME_NN;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';

-- DEPT1 테이블 생성 => 부서코드(PK), 부서 이름, 부서 위치를 저장하기 위한 테이블
CREATE TABLE DEPT01 (DNO NUMBER(2),DNAME VARCHAR2(20), LOC VARCHAR2(20), CONSTRAINT DEPT01_DNO_PK PRIMARY KEY(DNO));


-- DEPT01 테이블에 부서 정보 저장
INSERT INTO DEPT01 VALUES(10,'총무부','서울');
INSERT INTO DEPT01 VALUES(20,'영업부','수원');
COMMIT;

SELECT * FROM DEPT01;


-- EMP01 테이블 생성 = 사원번호(PK), 사원이름, 부서 코드(FK: DEPT01 테이블의 DNO 컬럼 참조)를 저장하기 위한 테이블
CREATE TABLE EMP01(ENO NUMBER(4), ENAME VARCHAR(20), DNO NUMBER(2)
                        ,CONSTRAINT EMP01_ENO_PK PRIMARY KEY(ENO)
                        ,CONSTRAINT EMP01_DNO_FK FOREIGN KEY(DNO) REFERENCES DEPT01(DNO));
                        
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP01';

-- EMP01 테이블에 사원정보 저장 => EMP01 테이블의 DNO 컬럼은 DEPT 테이블의 DNO 컬럼값 참조하여 저장
INSERT INTO EMP01 VALUES(1000,'홍길동',10); -- 
INSERT INTO EMP01 VALUES(2000,'임꺽정',20); -- 
INSERT INTO EMP01 VALUES(3000,'전우치',30); -- FK 제약조건에 의해서 parant key not found 에러 발생
COMMIT;

SELECT * FROM EMP01;

-- DEPT01 테이블에 저장된 10번 부서 삭제
DELETE FROM DEPT01 WHERE DNO = 10; -- FK 제약조건에 의해서 child record found 에러 발생

-- 제약조건 - 무결성을 유지하기 위해서 에러 발생

-- FK 제약조건을 무시하고 삭제 하고 싶다.

-- FK 제약조건 비활성화 처리
-- 형식) ALTER TABLE 테이블명 DISABLE CONSTRAINT 제약조건명
-- => FK 제약조건에 의해 에러가 발생되지 않는다.
ALTER TABLE EMP01 DISABLE CONSTRAINT EMP01_DNO_FK;

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP01';

INSERT INTO EMP01 VALUES(3000,'전우치',30);
COMMIT;

SELECT * FROM EMP01;

DELETE  FROM DEPT01 WHERE DNO = 10;

SELECT * FROM DEPT01;

-- 비활성화 조건의 활성화 처리
-- 형식) ALTER TABLE 테이블명 ENABLE CONSTRAINT 제약조건 이름;

ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DNO_FK; -- 에러 발생 데이터 무결성이 무너짐
                                                -- FOREIGN 키를 줄수가 없다.
                                                -- 10번, 30번 부서 때문에 FK 제약조건이 활성화
                                                -- 되지 않는다.

-- 10번 또는 30번 부서를 생성하거나 10번 또는 30부서의 사원정보를 삭제
--  => 데이터 무결성이 유지되도록 삽입, 삭제, 변경
INSERT INTO DEPT01 VALUES(10,'총무부','서울');
DELETE FROM EMP01 WHERE ENO = 3000;

COMMIT;

SELECT * FROM EMP01;
SELECT * FROM DEPT01;

-- 비활성화된 제약조건 활성화
ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DNO_FK; -- 제약조건에 맞음으로 성공

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP01';

-- FK 제약조건에 의해 부모테이블(DEPT01)과 자식테이블(EMP01) 간에 참조 설정이 되어 있는 경우
-- 부모테이블의 PK 제약조건을 비활성화 하거나 제거할 수 없다.
--  => 자식 테이블에 부여된 FK 제약조건을 모두 제거 후 비활성화 또는 제거 가능
ALTER TABLE DEPT01 DISABLE PRIMARY KEY;
ALTER TABLE DEPT01 DROP PRIMARY KEY;

-- CASCADE 키워드를 사용하면 부모테이블에 PK 제약조건을 비활성화 하거나 제거
-- 할경우 자식 테이블의 FK 제약조건도 비활성화 또는 제거 할수 있다.
-- DEPT01 테이블에 DNO 컬럼에 부여된 PK 제약조건 비활성화
--

-- DEPT01 테이블에 DNO 컬럼에 부여된 PK 제약조건을 CASCADE 비활성화
ALTER TABLE DEPT01 DISABLE PRIMARY KEY CASCADE;

-- CASCADE 동시에 제거해 달라
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN('EMP01','DEPT01');

-- DEPT01 테이블에 DNO 컬럼에 부여된 PK 제약조건을 CASCADE 제거
--  => EMP01 테이블의 DNO 컬럼에 부여된 FK 제약조건도 제거

CREATE TABLE DEPT02 (DNO NUMBER(2),DNAME VARCHAR2(20), LOC VARCHAR2(20), CONSTRAINT DEPT02_DNO_PK PRIMARY KEY(DNO));


-- DEPT02 테이블에 부서 정보 저장
INSERT INTO DEPT02 VALUES(10,'총무부','서울');
INSERT INTO DEPT02 VALUES(20,'영업부','수원');
COMMIT;

-- EMP02 테이블 생성 = 사원번호(PK), 사원이름, 부서 코드(FK: DEPT01 테이블의 DNO 컬럼 참조)를 저장하기 위한 테이블
-- => ON DELETE CASCADE : 부모 테이블의 데이터를 삭제하면 자식테이블의 참조하는 컬럼값의 데이터도
--                      같이 삭제 한다. - ON DELETE SET NULL(컬럼값을 NULL로 변경)
CREATE TABLE EMP02(ENO NUMBER(4), ENAME VARCHAR(15), DNO NUMBER(2)
                        ,CONSTRAINT EMP02_ENO_PK PRIMARY KEY(ENO)
                        ,CONSTRAINT EMP02_DNO_FK FOREIGN KEY(DNO) REFERENCES DEPT02(DNO) ON DELETE CASCADE);


-- EMP02 테이블에 사원을 추가
--  => EMP02 테이블의 DNO 컬럼값
INSERT INTO EMP02 VALUES(1000,'홍길동',10); -- 
INSERT INTO EMP02 VALUES(2000,'임꺽정',20); -- 
COMMIT;

SELECT * FROM EMP02;

-- DEPT02 테이블의 저장된 10번 부서정보 삭제
--  => 10번 부서에 근무하는 모든 사원정보를 EMP02 테이블에서 삭제
DELETE FROM DEPT02 WHERE DNO = 10;
COMMIT;

SELECT * FROM DEPT02; -- 영업부도 삭제
SELECT * FROM EMP02; -- 홍길동도 삭제

-- VIEW : 실제 테이블을 이용하여 만들어진 가상의 테이블
--  => 실제 테이블을 검색하는 하나의 SELECT 명령으로 생성되는 객체

-- SELECT 명령을 이용한 테이블 생성 및 데이터 복사
CREATE TABLE EMP_COPY AS SELECT * FROM EMP; -- SELECT * FROM EMP; 구문이 VIEW 이다.
SELECT * FROM EMP_COPY;

-- 제약조건은 복사 되지 않는다.

-- 단순뷰 : 하나의 테이블을 이용하여 생성된 VIEW 
--  => 데이터 검색뿐만 아니라 DML 명령을 사용하여 실제 테이블에 적용 가능
--  => 그룹함수 및 DISTINCT 사용 불가능

-- 복합뷰 : 두 개이상의 테이블을 JOIN 하여 생성된 뷰
--  => 데이터 검색만 가능하며 DML 명령 사용 불가능
--  => 그룹함수 및 DISTINCT 키워드 사용 가능

-- VIEW 생성
-- 형식) CREATE [OR REPLACE] [{FORCE|NOFORCE}] VIEW 뷰이름[(컬럼명,...)]
--      AS SELECT 검색대상,... FROM 테이블명
--      [WITH CHECK OPTION] [WITH READ ONLY]
--  => 기존에 존재하는 뷰의 구조는 변경 불가능 - 기존 뷰 삭제 후 다시 생성
--  => OR REPLACE를 사용하면 뷰가 존재하지 않으면 생성 
--  있으면 기존 뷰 삭제 후 다시 생성(변경)
--  => FORCE : 실제 테이블이 존재하지 않아도 VIEW를 생성하기 위한 키워드
--  => WITH CHECK OPTION : 해당 뷰를 통해 검색되는 범위에서만 INSERT 또는 UPDATE
--                          명령이 사용되도록 설정하는 옵션
--  => WITH READ ONLY : VIEW를 이용하여 검색만 가능하도록 설정하는 옵션 - 선언
--                      하지 않으면 DML 명령 사용 가능

-- EMP_COPY 테이블에 저장된 사원 중 30번 부서에 근무하는 사원의 사원번호, 사원이름
--  부서코드를 검색하여 EMP_VIEW30이라는 뷰 생성 => 단순뷰
-- VIEW에 관련된 명령 권한이 없어서 명령시 에러 발생 => 관리자에게 VIEW에 관련된
-- 권한 부여 조치


-- 관리자로 접속하여 SCOTT 사용자에게 VIEW 관련 시스템 권한 부여
-- DOS > SQLPLUS /NOLOG
-- SQL > CONN SYS/SYS AS SYSDBA
-- SQL > GRANT CREATE VIEW TO scott;

-- 권한 부여후 명령 실행하면 뷰가 생성이 된다. 뷰는 DBA에서 권한을 받아야 한다.
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO = 30;

SELECT * FROM EMP_VIEW30; -- 물리적으로 존재하지 않는다. 논리적으로만 존재한다.

-- 뷰 목록 확인 => USER_VIEWS 유저 딕션너리 이용
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

-- VIEW에 데이터 저장
INSERT INTO EMP_VIEW30 VALUES(1111,'홍길동',30);

COMMIT;

SELECT * FROM EMP_VIEW30;

-- 뷰에 데이터가 삽입되는 것이 아니라 뷰를 생성한 테이블에 데이터 삽입
--  => EMP_VIEW30 뷰가 아닌 EMP_COPY 테이블에 데이터 삽입
--  => 뷰에 의해 저장되지 않은 컬럼에는 DEFAULT 설정값 저장

SELECT * FROM EMP_COPY;

-- 뷰를 사용하는 이유
-- 1) 자주 사용하는 복잡한 SELECT 명령을 뷰로 선언하면 보다 쉽게 원하는 데이타 검색
SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO = 30;
SELECT * FROM EMP_VIEW30;

-- 2) 뷰를 이용하여 보다 쉬운 보안 설정이 가능하다.

-- 영업부 : 사원번호,사원이름,급여,보너스 검색 가능
CREATE VIEW EMP_VIEW01 AS SELECT EMPNO,ENAME,SAL,COMM FROM EMP_COPY;

-- 영업부는 EMP_COPY 를 접근하지 못하도록 설정한다.

SELECT * FROM EMP_VIEW01;


-- 인사부 : 사원번호,사원이름,업무,급여,입사일 검색 가능 => EMP_VIEW02
CREATE VIEW EMP_VIEW02 AS SELECT EMPNO,ENAME,JOB,HIREDATE,SAL FROM EMP_COPY;

SELECT * FROM EMP_VIEW02;

--EMP 테이블과 DEPT 테이블을 JOIN 하여 사원번호,사원이름,급여,부서명 검색
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO;



-- 조인 검색 결과를 EMP_VIEW 뷰 생성 => 복합뷰 
CREATE VIEW EMP_VIEW AS SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

SELECT * FROM EMP_VIEW;

SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

-- EMP_VIEW30 뷰 검색 => EMP_COPY 테이블 검색하여 VIEW 생성
SELECT * FROM EMP_VIEW30;


-- OR REPLACE 명령을 이용하여 기존 뷰 대신 새로운 뷰를 생성한다.
CREATE OR REPLACE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,SAL,DEPTNO 
        FROM EMP_COPY WHERE DEPTNO = 30;    -- 에러 발생
    
-- TEXT 변경 확인
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;















