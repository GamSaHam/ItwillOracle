--TCL(TRANSACTION CONTROL LANGUAGE) : 트렌젝션 제어어
-- => 트렌젝션을 적용하거나 취소하는 명령

--트렌젝션(TRANSACTION) : 현재 세션에서 생성되는 SQL 명령의 작업 단위
-- => 세션(SESSION) : DBMS에 접속하여 명령을 실행할 수 있는 작업 환경

--트렌젝션 생성 : 세션에서 SQL 명령(DML,DDL,DCL)이 실행되면 자동으로 트렌젝션 생성

--트렌젝션 적용 : 현재 세션에서 실행된 SQL 명령의 결과를 실제 테이블에 적용 후 제거
-- => 세션이 정상적으로 종료된 경우 자동으로 트렌젝션 적용
-- => DDL 또는 DCL 명령 실행 후 자동으로 트렌젝션 적용
-- => DML 명령 실행 후 COMMIT 명령을 이용하여 트렌젝션 적용

--트렌젝션 취소 : 현재 세션에서 존재하는 트렌젝션 제거
-- => 세션이 비정상적으로 종료된 경우 자동으로 트렌젝션 취소
-- => DML 명령 실행 후 ROLLBACK 명령을 이용하여 트렌젝션 취소

--세션에 트렌젝션이 존재하지 않는 경우 SELECT 명령은 실제 테이블의 데이타 검색
SELECT * FROM DEPT;

--부서테이블에서 50번 부서 삭제
DELETE FROM DEPT WHERE DEPTNO=50;--트렌젝션 생성

--세션에 트렌젝션이 존재할 경우 SELECT 명령은 트렌젝션에 존재하는 테이블의 데이타 검색
-- => 50번 부서정보가 삭제 되었으나 실제 테이블에서는 삭제되지 않았다.
SELECT * FROM DEPT;

--트렌젝션 취소
ROLLBACK;--트렌젝션 제거

--실제 테이블의 데이타 검색 => 50부서 존재
SELECT * FROM DEPT;

--부서테이블에서 50번 부서 삭제
DELETE FROM DEPT WHERE DEPTNO=50;
SELECT * FROM DEPT;--트렌젝션 검색

--트렌젝션 적용 : 실제 테이블에 DML 명령의 결과가 적용 
-- => 50번 부서정보 실제 테이블에서 삭제
COMMIT;--트렌젝션 제거

SELECT * FROM EMP;--실제 테이블 검색
DELETE FROM EMP;--모든 사원정보 삭제 => 트렌젝션 생성
SELECT * FROM EMP;--트렌젝션 검색
ROLLBACK;--트렌젝션 취소
SELECT * FROM EMP;--실제 테이블 검색

--트렌젝션을 이용하는 이유 : 데이타 일관성 유지
--보너스 테이블에서 사원이름이 LEE인 사원정보를 삭제
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='LEE';--현재 세션의 트렌젝션에서만 삭제
SELECT * FROM BONUS;--LEE 사원 삭제 확인
--다른 세션에서 보너스 테이블을 검색한 경우 LEE 사원 존재 
-- => 데이타 일관성 : 세션의 작업이 종료되기 전까지 기존 데이타 확인
COMMIT;--실제 테이블 적용되어 다른 세션에서도 LEE 사원 삭제 확인

--데이타 LOCK : 현재 세션에서 처리중인 트렌젝션의 데이타에 LOCK를 걸어 다른 세션에서는
--트렌젝션의 데이타를 사용하지 못하도록 하는 기능

--보너스 테이블에서 사원이름이 MARTIN인 사원의 급여를 1400으로 변경
SELECT * FROM BONUS;
UPDATE BONUS SET SAL=1400 WHERE ENAME='MARTIN';

--다른 세션에서 MARTIN 사원의 보너스를 급여의 50%으로 변경
-- => 현재 세션에서 트렌젝션이 완료되지 않은 경우 다른 세션에서는 트렌젝션 관련 
--    데이타의 조작 불가능 
-- => 데이타 LOCK이 발생하여 다른 세션에서의 DML 명령은 대기상태로 구현

--현재 세션의 트렌섹션 처리 완료 후 데이타 LOCK이 해제되어 다른 세션의 DML 명령 실행
COMMIT;

--SAVEPOINT : 트렌젝션을 분할하기 위해 사용하는 명령
--형식) SAVEPOINT 라벨명;

--보너스 테이블에서 사원이름이 MARTIN인 사원정보 삭제
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--보너스 테이블에서 사원이름이 ALLEN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--ROLLBACK 명령에 의해 트렌젝션에 저장된 모든 DML 명령의 결과가 모두 제거
ROLLBACK;
SELECT * FROM BONUS;

--보너스 테이블에서 사원이름이 MARTIN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--SAVEPOINT 설정
SAVEPOINT SP1;

--보너스 테이블에서 사원이름이 ALLEN인 사원정보 삭제
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--SAVEPOINT 설정
SAVEPOINT SP2;

--보너스 테이블에서 모든 사원정보 삭제
DELETE FROM BONUS;
SELECT * FROM BONUS;

--SAVEPOINT로 설정한 라벨명을 이용하여 원하는 DML 명령까지만 취소되도록 ROLLBACK 가능
--형식) ROLLBACK TO 라벨명;
ROLLBACK TO SP2;--SP2 라벨 뒤에 존재하는 모든 DML 명령 취소
SELECT * FROM BONUS;

ROLLBACK TO SP1;--SP1 라벨 뒤에 존재하는 모든 DML 명령 취소
SELECT * FROM BONUS;

ROLLBACK;--모든 DML 명령 취소
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : 데이타 정의어
-- => 데이타베이스 객체(테이블,뷰,시퀸스등)를 생성,삭제,변경하기 위한 명령

--테이블(데이타(행)을 저장하기 위한 객체) 생성
--형식) CREATE TABLE 테이블명(컬럼명 자료형 [DEFAULT 기본값] [제약조건],
--       컬럼명 자료형 [DEFAULT 기본값] [제약조건],...);
-- => 선언된 컬럼 순서대로 속성이 정의된 테이블 생성

--식별자 작성 규칙
-- => 식별자는 문자로 시작하며 1~30 범위의 문자로 작성한다.
-- => 식별자는 A~Z,a~z,0~9,_,$,# 문자로 작성한다.
-- => 한글 사용도 가능하지만 권장하지 않는다.
-- => 동일 사용자는 같은 이름의 식별자가 중복되지 않도록 선언한다.
-- => ORACLE의 예약어(키워드)는 사용할 수 없다.
-- => 대소문자를 구분하지 않는다.

--자료형(DATA TYPE) : 컬럼값으로 저장할 수 있는 데이타의 형태
-- => 숫자형 : NUMBER[(전체자릿수[,소숫점자릿수])]
-- => 문자형 : CHAR(크기) : 크기 - 1BYTE~2000BYTE(고정길이)
--            VARCHAR2(크기) : 크기 - 1BYTE~4000BYTE(가변길이)
--            LONG : 2GBYTE(가변길이) => 가변길이 문자열 저장(테이블의 컬럼 하나에만 부여)
--            CLOB : 4GBYTE(가변길이) => 1BYTE 문자(유사 - DBCLOB : 2BYTE 문자)
-- => 날짜형 : DATE - 날짜와 시간정보에 대한 데이타 
--            TIMESTAMP - 1970년 1월 1일을 기준으로 증가되는 초 단위 데이타

--SALESMAM 테이블 생성 => 사원번호,사원이름,입사일에 대한 컬럼으로 구성
CREATE TABLE SALESMAN(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE);

--현재 로그인 사용자가 사용 가능한 테이블 목록 확인
-- => 유저 딕셔너리(USER_DICTIONARY) : 일반 사용자가 접근하여 검색할 수 있는 
--    시스템 정보를 저장한 가상의 테이블 - 유사 : ALL_DICTIONARY, DBA_DICTIONARY
-- => USER_OBJECTS : 객체 정보를 저장하고 있는 유저 딕셔너리
DESC USER_OBJECTS;
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

--USER_TABLES(TABS) : 테이블 정보를 저장하고 있는 유저 딕셔너리
DESC USER_TABLES;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT TABLE_NAME FROM TABS;

--테이블 구조 확인
DESC SALESMAN;

--테이블 데이타 삽입(저장) 및 확인
INSERT INTO SALESMAN VALUES(1000,'홍길동','17/07/19');
COMMIT;
SELECT * FROM SALESMAN;

--사원번호 컬럼에 PK 제약조건이 없으므로 중복 사원번호 저장 가능
INSERT INTO SALESMAN VALUES(1000,'임꺽정',SYSDATE);
COMMIT;
SELECT * FROM SALESMAN;

--데이타 저장시 컬럼이 생략될 경우 기본적으로 NULL 저장(묵시적 NULL 사용)
-- => 테이블 생성시 컬럼에 DEFAULT을 선언하지 않으면 기본값으로 NULL이 자동 설정
INSERT INTO SALESMAN(NO,NAME) VALUES(3000,'전우치');
COMMIT;
SELECT * FROM SALESMAN;

--EMP 테이블에 저장된 사원 중 업무가 SALESMAN인 사원을 검색하여 SALESMAN 테이블에 저장
-- => INSERT 또는 MARGE 명령 사용
INSERT INTO SALESMAN SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE JOB='SALESMAN';
COMMIT;
SELECT * FROM SALESMAN;

--테이블에 데이타 저장시 생략 컬럼에 NULL이 아닌 원하는 임의의 기본값이 저장되도록 
--설정하고자 할 경우 DEFAULT 옵션 사용
-- => DEFAULT의 기본값은 상수 또는 키워드 사용

--MANAGER 테이블 생성 
-- => 사원번호,사원이름,입사일(기본값:현재),급여(기본값:1000)에 대한 컬럼으로 구성
CREATE TABLE MANAGER(NO NUMBER(4),NAME VARCHAR2(20)
    ,STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER(4) DEFAULT 1000);
    
--테이블 생성 및 구조 확인
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='MANAGER';--테이블 목록 확인
DESC MANAGER;--테이블 구조 확인

--테이블의 컬럼에 부여한 DEFAULT 설정값 확인 => USER_TAB_COLUMNS 유저 딕셔너리 확인
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='MANAGER';

--MANAGER 테이블에 사원정보 삽입 => 사원번호,사원이름만 저장
INSERT INTO MANAGER(NO,NAME) VALUES(1000,'유재석');
COMMIT;
SELECT * FROM MANAGER;--생략 컬럼에는 DEFAULT 설정값 자동 저장

INSERT INTO MANAGER VALUES(2000,'박명수','17/07/20',2000);
COMMIT;
SELECT * FROM MANAGER;

--DEFAULT 키워드를 이용하면 컬럼에 부여된 DEFUALT 설정값을 이용할 수 있다.
INSERT INTO MANAGER VALUES(3000,'정준하',DEFAULT,DEFAULT);
COMMIT;
SELECT * FROM MANAGER;

--SUBQUERY를 이용한 테이블 생성 및 데이타 복사
--형식) CREATE TABLE 테이블명[(컬럼명,...)] AS SELECT 검색대상,... FROM 테이블명;
-- => SUBQUERY의 검색대상과 동일한 컬럼명과 자료형을 가진 테이블 생성
-- => 생성 테이블명 선언시 () 안에 컬럼명을 나열하면 컬럼명 변경 가능
-- => 생성된 테이블에 검색된 데이타를 복사되어 저장
-- => SUBQUERY의 검색대상과 동일한 구조를 같지만 제약조건은 복사되지 않는다.

--EMP 테이블에서 모든 사원의 전체 컬럼을 검색하여 EMP2 테이블 생성 및 데이타 복사
CREATE TABLE EMP2 AS SELECT * FROM EMP;

--테이블 구조 동일 => 제약조건 제외
DESC EMP;--EMPNO 컬럼에 PK 제약조건 부여 확인
DESC EMP2;--EMPNO 컬럼에 PK 제약조건 미부여 확인

--저장 데이타 동일
SELECT * FROM EMP;
SELECT * FROM EMP2;

--SUBQUERY의 검색대상 또는 조건식에 따라 생성 테이블 구조 및 복사 데이타가 변경
CREATE TABLE EMP3 AS SELECT EMPNO,ENAME,SAL FROM EMP;
DESC EMP3;
SELECT * FROM EMP3;

CREATE TABLE EMP4 AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>2000;
DESC EMP4;
SELECT * FROM EMP4;

--SUBQUERY의 검색대상과 다른 컬럼명 사용 가능
CREATE TABLE EMP5(NO,NAME,PAY) AS SELECT EMPNO,ENAME,SAL FROM EMP;
DESC EMP5;
SELECT * FROM EMP5;

--SUBQUERY를 이용하여 데이타 복사는 하지 않고 테이블 생성만 하고자 할 경우 SUBQUERY의
--조건식에서 무조건 거짓이 발생되도록 선언하면 가능
CREATE TABLE EMP6 AS SELECT * FROM EMP WHERE 0=1;
DESC EMP6;
SELECT * FROM EMP6;

--제약조건 : 컬럼에 잘못된 컬럼값이 저장되는 것을 방지하지 하기 위해 컬럼에 제약조건 설정
-- => 데이타 무결성이 유지되도록 하기 위한 기능
-- => 컬럼 수준의 제약조건 : 컬럼 생성시 제약조건 부여
-- => 테이블 수준의 제약조건 : 컬럼 생성 후 제약조건 부여

--NOT NULL : 컬럼에 NULL 저장을 허용하지 않는 제약조건
-- => 컬럼 수준의 제약조건으로만 부여 가능
--NOT NULL 제약조건이 부여되지 않은 컬럼은 NULL 저장을 허용(기본)
CREATE TABLE DEPT1(DEPTNO NUMBER(2),DNAME VARCHAR2(12),LOC VARCHAR2(11));
DESC DEPT1;
INSERT INTO DEPT1 VALUES(10,NULL,NULL);
COMMIT;
SELECT * FROM DEPT1;

--모든 컬럼이 NULL를 허용하지 않는 테이블 생성
CREATE TABLE DEPT2(DEPTNO NUMBER(2) NOT NULL
    ,DNAME VARCHAR2(12) NOT NULL,LOC VARCHAR2(11) NOT NULL);
DESC DEPT2;    
--NOT NULL 제약조건에 의해 컬럼값으로 NULL 저장시 에러 발생
INSERT INTO DEPT2 VALUES(10,NULL,NULL);--에러 발생

--컬럼에 부여된 DEFAULT 설정값 확인 => USER_TAB_COLUMNS 유저 딕셔너리
-- => 모든 컬럼의 DEFAULT 설정값은 NULL로 선언되어 있다.
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='DEPT2';

--생략된 컬럼에는 컬럼의 DEFAULT 설정값이 자동으로 저장
-- => LOC 컬럼의 DEFAULT 설정값이 NULL로 선언
-- => LOC 컬럼에 NOT NULL 제약조건이 부여되어 있으므로 NULL 저장 불가능
-- => 컬럼을 생략하여 데이타 저장 불가능(묵시적 NULL 사용 불가능)
INSERT INTO DEPT2(DEPTNO,DNAME) VALUES(10,'총무부');

--NOT NULL 제약조건이 부여된 컬럼에는 반드시 컬럼값을 입력하는 것을 권장
INSERT INTO DEPT2 VALUES(10,'총무부','서울');
COMMIT;
SELECT * FROM DEPT2;

--컬럼에 부여된 제약조건 확인 => USER_CONSTRAINTS 유저 딕셔너리
--CONSTRAINT_NAME : 컬럼에 부여된 제약조건의 이름 => 제약조건을 삭제하기 위해 사용
--제약조건의 이름을 따로 정의하지 않으면 SYS_XXXXXXX로 자동 설정된다.
--CONSTRAINT_TYPE : 제약조건의 종류 => C : CHECK
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';

--제약조건의 이름을 부여하면 컬럼에 부여된 제약조건을 관리하기 쉽다.
--형식) 컬럼명 자료형 CONSTRAINT 제약조건이름 제약조건  => 컬럼수준의 제약조건
CREATE TABLE DEPT3(DEPTNO NUMBER(2) CONSTRAINT DEPT3_DEPTNO_NN NOT NULL
    ,DNAME VARCHAR2(12) CONSTRAINT DEPT3_DNAME_NN NOT NULL
    ,LOC VARCHAR2(11) CONSTRAINT DEPT3_LOC_NN NOT NULL);

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT3';

--UNIQUE KEY : 컬럼에 중복된 컬럼값이 저장되는 것을 방지하기 위한 제약조건 
-- => 여러 개의 컬럼에 UNIQUE KEY 제약조건 부여 가능
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15));
DESC USER1;

--전화번호에 중복된 컬럼값 저장 가능
INSERT INTO USER1 VALUES(1000,'홍길동','111-1111');
INSERT INTO USER1 VALUES(2000,'임꺽정','111-1111');
COMMIT;
SELECT * FROM USER1;

--PHONE 컬럼에 UNIQUE KEY 제약조건 부여 => 컬럼 수준의 제약조건
CREATE TABLE USER2(NO NUMBER(4),NAME VARCHAR2(20)
    ,PHONE VARCHAR2(15) CONSTRAINT USER2_PHONE_UK UNIQUE);
DESC USER2;
--CONSTRAINT_TYPE : U - UNIQUE KEY
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

INSERT INTO USER2 VALUES(1000,'홍길동','111-1111');
--UNIQUE KEY 제약조건이 부여된 컬럼에 중복 컬럼값을 저장하면 에러 발생
INSERT INTO USER2 VALUES(2000,'임꺽정','111-1111');--에러 발생
INSERT INTO USER2 VALUES(2000,'임꺽정','222-2222');
COMMIT;
SELECT * FROM USER2;

--UNIQUE KEY가 부여된 컬럼에는 NULL 저장 허용
INSERT INTO USER2 VALUES(3000,'전우치',NULL);

--NULL 키워드는 존재하지 않는 컬럼값을 표현하기 위해 존재하므로 컬럼값으로 인식하지 않는다.
INSERT INTO USER2 VALUES(4000,'일지매',NULL);
COMMIT;
SELECT * FROM USER2;

--PHONE 컬럼에 UNIQUE KEY 제약조건 부여 => 테이블 수준의 제약조건
CREATE TABLE USER3(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';
    
INSERT INTO USER3 VALUES(1000,'홍길동','111-1111');
INSERT INTO USER3 VALUES(2000,'임꺽정','111-1111');--에러 발생
COMMIT;
SELECT * FROM USER3;
    
--NAME 컬럼과 PHONE 컬럼에 UNIQUE KEY 제약조건 부여 => 컬럼 수준의 제약조건
CREATE TABLE USER4(NO NUMBER(4),NAME VARCHAR2(20) CONSTRAINT 
    USER4_NAME_UK UNIQUE,PHONE VARCHAR2(15) CONSTRAINT USER4_PHONE_UK UNIQUE);

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';
    
INSERT INTO USER4 VALUES(1000,'홍길동','111-1111');    
--NAME 컬럼에 중복된 컬럼값을 저장하면 에러 발생
INSERT INTO USER4 VALUES(2000,'홍길동','222-2222');--에러 발생    
INSERT INTO USER4 VALUES(2000,'임꺽정','222-2222');
--PHONE 컬럼에 중복된 컬럼값을 저장하면 에러 발생
INSERT INTO USER4 VALUES(3000,'전우치','111-1111');--에러 발생
COMMIT;
--이름 또는 전화번호에 중복된 컬럼값을 저장할 수 없다.
SELECT * FROM USER4;

--NAME 컬럼과 PHONE 컬럼에 UNIQUE KEY 제약조건 부여 => 테이블 수준의 제약조건
CREATE TABLE USER5(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT USER5_NAME_UK UNIQUE(NAME),CONSTRAINT USER5_PHONE_UK UNIQUE(PHONE));

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER5';

INSERT INTO USER5 VALUES(1000,'홍길동','111-1111');    
--NAME 컬럼에 중복된 컬럼값을 저장하면 에러 발생
INSERT INTO USER5 VALUES(2000,'홍길동','222-2222');--에러 발생    
INSERT INTO USER5 VALUES(2000,'임꺽정','222-2222');
--PHONE 컬럼에 중복된 컬럼값을 저장하면 에러 발생
INSERT INTO USER5 VALUES(3000,'전우치','111-1111');--에러 발생
COMMIT;
--이름 또는 전화번호에 중복된 컬럼값을 저장할 수 없다.
SELECT * FROM USER5;

--NAME 컬럼과 PHONE 컬럼에 UNIQUE KEY 제약조건 부여 => 테이블 수준의 제약조건
CREATE TABLE USER6(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT USER6_NAME_PHONE_UK UNIQUE(NAME,PHONE));

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER6';

INSERT INTO USER6 VALUES(1000,'홍길동','111-1111');    
--NAME 컬럼의 컬럼값은 중복되지만 PHONE 컬럼의 컬럼값은 중복되지 않으므로 저장 가능
INSERT INTO USER6 VALUES(2000,'홍길동','222-2222');
--PHONE 컬럼의 컬럼값은 중복되지만 NAME 컬럼의 컬럼값은 중복되지 않으므로 저장 가능
INSERT INTO USER6 VALUES(3000,'임꺽정','222-2222');
--NAME 컬럼과 PHONE 컬럼에 중복된 컬럼값을 저장할 경우 에러 발생
INSERT INTO USER6 VALUES(4000,'홍길동','111-1111');--에러 발생
COMMIT;
--이름과 전화번호에 중복된 컬럼값을 저장할 경우 에러 발생
SELECT * FROM USER6;

--PRIMARY KEY : 컬럼에 중복된 컬럼값이 저장되는 것을 방지하기 위한 제약조건 
-- => 테이블의 반드시 하나의 컬럼에 부여하는 제약조건
-- => 컬럼값으로 NULL를 허용하지 않는다.
-- => PRIMARY KEY = NOT NULL + UNIQUE KEY

--NO 컬럼에 PRIMARY KEY 제약조건 부여 => 컬럼 수준의 제약조건
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MSG1_NO_PK PRIMARY KEY
    ,NAME VARCHAR2(20),PHONE VARCHAR2(15));

--NO 컬럼에 NOT NULL 제약조건 부여 확인
DESC MGR1;    

--CONSTRAINT_TYPE : P - PRIMARY KEY
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR1';
    
INSERT INTO MGR1 VALUES(1000,'홍길동','111-1111');    
--PK 제약조건이 부여된 컬럼에 중복 컬럼값을 저장하면 에러 발생
INSERT INTO MGR1 VALUES(1000,'임꺽정','222-2222');--에러 발생
--PK 제약조건이 부여된 컬럼은 NOT NULL 제약조건이 포함되어 있으므로 NULL 저장시 에러 발생
INSERT INTO MGR1 VALUES(NULL,'임꺽정','222-2222');--에러 발생
COMMIT;
SELECT * FROM MGR1;

--NO 컬럼에 PRIMARY KEY 제약조건 부여 => 테이블 수준의 제약조건
CREATE TABLE MGR2(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT MSG2_NO_PK PRIMARY KEY(NO));
DESC MGR2;    
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR2';
    
INSERT INTO MGR2 VALUES(1000,'홍길동','111-1111');    
INSERT INTO MGR2 VALUES(1000,'임꺽정','222-2222');--에러 발생
INSERT INTO MGR2 VALUES(NULL,'임꺽정','222-2222');--에러 발생
COMMIT;
SELECT * FROM MGR2;
