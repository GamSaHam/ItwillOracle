
-- WITH CHECK OPTION : 뷰를 생성할 때 사용된 조건의 컬럼값을 변경하지 
--  못하도록 설정하는 옵션

CREATE OR REPLACE VIEW EMP_VIEWCHECK30 AS SELECT EMPNO,ENAME,SAL,DEPTNO
    FROM EMP_COPY WHERE DEPTNO = 30 WITH CHECK OPTION; -- DEPTNO 를 변경시 에러

-- 단순뷰 DML 명령어 사용해서 뷰를 통해서 테이블 변경 가능
SELECT * FROM EMP_VIEWCHECK30;

-- EMP_VIEWCHECK30에서 사원이름이 ALLEN인 사원의 급여를 2000으로 변경
--  => 뷰를 이용하여 DML 명령을 실행 할 경우 실제 테이블에 적용
UPDATE EMP_VIEWCHECK30 SET SAL = 2000 WHERE ENAME = 'ALLEN';
COMMIT;

SELECT * FROM EMP_COPY; -- 뷰를 변경해도 실제 값이 변경이 된다.

-- EMP_VIEWCHECK30에서 사원번호가 7521인 사원의 부서코드를 20번으로 변경
--  => WITH CHECK OPTION에 의해 뷰를 생성한 SELECT 명령의 조건식에서 사용된 컬럼의
--      컬럼값을 변경할 경우 에러 발생
--  => EMP_VIEWCHECK30는 부서코드를 이용하여 만든 뷰이므로 변경시 에러 발생
UPDATE EMP_VIEWCHECK30 SET DEPTNO = 20 WHERE EMPNO = 7521; -- DEPTNO를 변경하여 에러

-- WITH READ ONLY : 뷰에서 DML 명령을 사용하지 못하도록 설정하기 위한 옵션
-- OR REPLACE 를 거희 같이 쓴다.
CREATE OR REPLACE VIEW EMP_VIEWREAD30 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY
    WHERE DEPTNO = 30 WITH READ ONLY;

SELECT* FROM EMP_VIEWREAD30;

-- EMP_VIEWREAD30는 WITH READ ONLY 옵션에 의해 DML 명령을 사용할 경우 에러 발생
UPDATE EMP_VIEWREAD30 SET SAL = 3000 WHERE ENAME = 'ALLEN'; -- CANNOT PERFORM A DML OPERATION ON A READ-ONLY VIEW

-- VIEW 삭제 뷰는 ALTER가 없다
-- 형식) DROP VIEW 뷰이름; 
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

-- EMP_VIEW30 뷰 삭제
DROP VIEW EMP_VIEW30;

-- ROWNUM 키워드 : 검색된 행에 일련번호를 부여하는 키워드
SELECT EMPNO, ENAME, SAL FROM EMP;
SELECT ROWNUM, EMPNO, ENAME, SAL FROM EMP;


-- 모든 사원의 사원번호,사원이름, 급여를 급여로 내림차순 정렬 검색 한 후 행번호 부여
--  => 검색 데이터 행번호를 부여한 후 급여순으로 내림차순 정렬: 행번호가 불규칙하게 검색
SELECT ROWNUM, EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC; -- 검색 오류

-- 분석함수에서 급여로 내림차순 정렬 후 ROW_NUMBER() 순위함수에 의해
--  순위(행번호) 검색 : 순위 함수
-- 조건식에서는 엘리어스 이름을 쓸수없다 ORDER BY는 몰라도
-- 그래서 생긴게 인라인 함수이다.
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM, EMPNO, ENAME, SAL FROM EMP
    WHERE NUM BETWEEN 5 AND 10;

-- 모든 사원의 사원번호, 사원이름, 급여를 급여로 내림차순 정렬한 뷰 생성
CREATE OR REPLACE VIEW EMP_VIEW 
    AS SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

-- EMP_VIEW를 검색 할때 ROWNUM 키워드 사용
SELECT ROWNUM, EMPNO,ENAME, SAL FROM EMP_VIEW;

--행번호가 5이상인 사원들 검색
SELECT ROWNUM, EMPNO,ENAME, SAL FROM EMP_VIEW 
    WHERE ROWNUM <= 5;

-- INLINE VIEW : SUBQUERY로 일시적으로 생성되는 뷰를 인라인 뷰
SELECT EMPNO,ENAME,SAL FROM EMP;
SELECT EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO = 30);
-- INLINE VIEW의 검색 대상이 아닌 컬럼을 검색 할 경우 에러 발생
SELECT EMPNO,ENAME,SAL,JOB FROM (SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO = 30);
SELECT EMPNO,ENAME,SAL,JOB FROM (SELECT * FROM EMP WHERE DEPTNO = 30);

-- 모든 사원의 사원번호, 사원이름, 급여를 급여로 내림차순 정렬 검색 한 후 행번호 부여
SELECT ROWNUM,EMPNO,ENAME,SAL 
    FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC);

SELECT ROWNUM,* -- 별은 다른 검색대상과 같이 사용 될수 없다.
    FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC);


-- INLINE VIEW에  ALIAS를 부여한 후 ALIAS이름.* 형식으로 사용 가능
SELECT ROWNUM,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP; -- 이거는 너무 신기하네
    
-- 급여가 가장 많은 사원 5명만 검색 : 행번호가 5보다 작거나 같은 사원정보 검색
SELECT ROWNUM,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM <=5; 

-- 급여로 내림차순 정렬 10번 위치에 있는 사원정보를 검색
--  => ROWNUM 키워드로 조건식을 구현할 경우 사용 가능 연산자는 < 또는 <=만 가능
--  => 다른 연산자를 이용하여 검색할 경우 검색이 되지 않는다.
SELECT ROWNUM,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM = 10; 


-- ROWNUM 키워드 대신 사용할 ALIAS 이름 선언한 INLINE VIEW 생성 후 ALIAS 이름으로
-- 모든 연산자를 사용할 수 있는 조건식 선언 가능
SELECT * FROM (SELECT ROWNUM RN, EMPNO,ENAME,SAL FROM EMP) WHERE RN = 10; -- ??

-- 오라클에서만 서브쿼리 안에 서브쿼리
-- 테이블을 뷰로 만들어서 해당 엘리어스 변수로 WHERE 구문 사용 가능
--  => 테이블의 데이터로 페이징 처리하기 위해 사용하는 QUERY 
SELECT * FROM(SELECT ROWNUM RN,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RN >= 5 AND RN <= 10; 

-- 모든 사원의 사원번호,사원이름을 사원번호로 오름차순 정렬 후 검색사원의 앞 사원
-- 의 사원번호, 사원이름 및 검색 사원의 뒷 사원의 사원번호, 사원이름 검색
--  => 만약 앞 또는 뒷 사원이 없을 경우 사원번호는 0, 사원이름 NULL로 검색 되도록

SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) BEFORE_EMPNO
    ,LAG(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) AFTER_EMPNO
    ,LEAD(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) AFTER_ENAME FROM EMP;

-- 모든 사원의 사원번호,사원이름을 사원번호로 오름차순 정렬 후 검색사원의 앞 사원의
-- 사원번호, 사원이름 및 검색사원의 뒷 사원의 사원번호, 사원이름 검색하되 사원번호가
-- 7844인 사원만 검색
--  => 만약 앞 또는 뒷 사원이 없을 경우 사원번호는 0, 사원이름 NULL로 검색 되도록
-- 사원번호가 7844인 사원정보 검색 후 앞 또는 뒷사원의 정보 검색
--  => 앞 또는 뒷사원이 존재하지 않는다. - 검색 오류

-- 모든 사원을 검색 후 원하는 사원번호의 사원정보 검색 => INLINE VIEW
-- 메커니즘이 어떻게 되는지 확인
SELECT *  FROM (SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) BEFORE_EMPNO
    ,LAG(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) AFTER_EMPNO
    ,LEAD(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) AFTER_ENAME FROM EMP) WHERE EMPNO = 7844;

-- SEQUENCE : 정수값을 저장하고 있으며 자동 증가되는 정수 값을 반환하는 객체
--  => 자동 증가되는 정수값을 컬럼값으로 저장하여 사용 EX) 게시글 글번호
--  => SEQUENCE 객체의 정수를 저장 사용하는 컬럼은 반드시 숫자형이며 PRIMARY KEY 
--  제약조건이 부여 되어 있어야 된다.


-- 시퀸스 생성
-- 형식) CREATE SEQUENCE 시퀸스명 [START WITH 시작값] [INCREMENT BY 증가값]
--      [MAXVALUE 상한값] [MINVALUE 하한값] [CYCLE] [CACHE 갯수];
--
-- START WITH 시작값 : 시퀸스 객체에 저장되는 초기값 설정 => 생략되면 아무런 값도
--  저장 되지 않는다.
-- INCREMENT BY 증가값 : 자동 증가 되는 정수값으로 생략되면 기본 증가값을 1로 설정
-- MAXVALUE 상한값 : 자동 증가 되는 정수값의 최대 정수값으로 생략되면 숫자형이 표현할 수 있는
--                  최대값으로 설정된다.
-- MINVALUE 하한값 : 자동 증가되는 정수값의 최소 정수값으로 생략되면 최고값은 1로 설정
-- CYCLE : 자동 증가되는 정수값이 반복 되도록 설정
-- CACHE 갯수 : 임시 메모리에 미리 자동 증가되는 정수값을 저장하여 사용하기 위한 설정값
-- 설정값으로 생략될 경우 갯수는 20으로 설정


-- QNA 테이블 설정 => 글번호, 글제목, 글내용, 
CREATE TABLE QNA(NO NUMBER(4) PRIMARY KEY, CONTENT VARCHAR2(100));


-- QNA 테이블의 NO 컬럼에서 사용하기 위한 시퀸스 생성
CREATE SEQUENCE QNA_SEQ;

SELECT * FROM USER_SEQUENCES;

-- QNA 테이블에 게시글 저장 => NO 컬럼은 QNA_SEQ 시퀸스를 이용하여 컬럼값 저장
-- 시퀸스.CURRVAL : 현재 시퀸스가 저장하고 있는 정수값 반환
--  => 시컨스 생성 후 초기값이 설정되지 않아 정수값은 반환되지 않는다.
--  => 시컨스.CURRVAL는 시퀸스.NEXTVAL 실행 후 정수값 반환
SELECT QNA_SEQ.CURRVAL FROM DUAL;

-- QNA_SEQ.NEXTVAL : 시퀸스에 저장된 정수값에 증가값을 더한 정수값을 반환 후 시퀸스의
--  현재 정수값을 변경 => 시퀸스에 저장된 정수값이 없는 경우 MINVALUE 값을 이용하여 반환
-- 
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '연습-1');
SELECT QNA_SEQ.CURRVAL FROM DUAL;

INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '연습-2');
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '연습-3');
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '연습-4');

COMMIT;

SELECT * FROM QNA;

-- 시퀸스 변경 => START WITH는 변경 불가능
-- 형식) ALTER SEQUENCE 시퀸스명 변경옵션

-- QNA_SEQ 시퀸스의 상한값을 9999로 변경하고 증가값은 3으로 변경
SELECT * FROM USER_SEQUENCES;

-- MAXVALUE 9999
-- INCREMENT BY 3
ALTER SEQUENCE QNA_SEQ MAXVALUE 9999 INCREMENT BY 3;


INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '하하하');
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '호호호');

COMMIT;

SELECT * FROM QNA;

-- 시퀸스 삭제
-- 형식) DROP SEQUENCE 시퀸스명;
DROP SEQUENCE QNA_SEQ;


-- INDEX: 테이블에 저장된 데이터를 보다 빠르게 검색하기 위한 인덱스 영역을
--  구축하기 위한 객체
--  => 인덱스는 제약조건처럼 컬럼에 부여하여 설정
--  => 인덱스는 데이터가 별로 없는 경우에는 부여하지 않는 것을 권장
--      (테이블 생성시 인덱스 부여는 비권장
--  => 조건식에 많이 사용하는 컬럼에 부여하는 것을 권장

-- UNIQUE INDEX : 컬럼에 중복된 컬럼값이 저장되지 않도록 PK 또는 UK 제약조건이
--  설정된 컬럼에 자동으로 만들어 지는 인덱스
-- NON UNIQUE INDEX : 컬럼에 중복된 컬럼값이 저장되는 컬럼에 수동으로 부여하는
--  인덱스

-- USER 테이블 생성 => 번호(PK),이름,전화번호(UK)를 저장하기 위한 테이블
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
                , CONSTRAINT USER1_NO_PK PRIMARY KEY(NO)
                , CONSTRAINT USER1_PHONE_UK UNIQUE(PHONE));
            
                
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER1';


-- USER1 테이블의 인덱스 확인
SELECT C.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS,INDEX_TYPE 
    FROM USER_INDEXES I JOIN USER_IND_COLUMNS C ON I.INDEX_NAME = C.INDEX_NAME
    WHERE C.TABLE_NAME = 'USER1';


-- NON UNIQUE INDEX 생성
-- 형식) CREATE INDEX 인덱스명 ON 테이블명(컬럼명);
--  => WHERE에서 많이 사용하는 컬럼에 부여
--  => 검색 결과가 전체 데이터의 2%~4%인 경우 
--  => 테이블의 저장된 데이터의 갯수가 많은 경우 
--  => JOIN에서 많이 사용하는 컬럼이나 NULL을 많이 포함하고 있는 컬럼에 부여

-- USER1 테이블의 NAME 컬럼에 INDEX를 생성하여 부여
CREATE INDEX USER1_NAME_INDEX ON USER1(NAME);

SELECT C.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS,INDEX_TYPE 
    FROM USER_INDEXES I JOIN USER_IND_COLUMNS C ON I.INDEX_NAME = C.INDEX_NAME
    WHERE C.TABLE_NAME = 'USER1';

-- 비트리 인덱스 -> 이진트리 인덱스
-- 데이터 베이스 관리자가 색인을 만들어 주는거다.
-- 조인에서 속도가 차이난다.
-- DBA는 색인 인덱스 정책을 만들어줘야 한다. 

-- INDEX 삭제
-- 형식) DROP INDEX 인덱스명;

-- USER1_PHONE_UK 인덱스 삭제
DROP INDEX USER1_NO_PK; -- 에러

-- 제약조건 확인
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER1';

-- UNIQUE INDEX는 인덱스를 생성한 제약조건을 삭제하면 자동으로 삭제 된다.
ALTER TABLE USER1 DROP CONSTRAINT USER1_PHONE_UK;

-- 자동으로 만든 인덱스는 자동으로 수동으로는 수동으로 삭제 된다.
DROP INDEX USER1_NAME_INDEX;

-- 인덱스 유무에 따른 검색 시간 비교
-- 기존 테이블을 검색하여 테이블 생성 및 데이터 복사 => 제약조건은 복사되지 않는다.
CREATE TABLE EMP_INDEX AS SELECT * FROM EMP;

SELECT * FROM EMP_INDEX;

-- 인덱스 확인
SELECT C.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS,INDEX_TYPE 
    FROM USER_INDEXES I JOIN USER_IND_COLUMNS C ON I.INDEX_NAME = C.INDEX_NAME
    WHERE C.TABLE_NAME = 'EMP_INDEX';

-- 기존테이블에 검색하여 데이터를 복사했다.
INSERT INTO EMP_INDEX SELECT * FROM EMP_INDEX;
SELECT COUNT(*) FROM EMP_INDEX; -- 100만개 이상의 데이터 저장
INSERT INTO EMP_INDEX(EMPNO,ENAME) VALUES(1111,'ABCD'); -- 1번만 실행
COMMIT;

SET TIMING ON; -- SQL 명령 실행 시간 기능 활성화
SELECT * FROM EMP_INDEX WHERE ENAME = 'ABCD';
SET TIMING OFF;

-- EMP_INDEX 테이블의 ENAME 컬럼에 인덱스 부여
CREATE INDEX EMP_INDEX_ENAME ON EMP_INDEX(ENAME);


DROP TABLE EMP_INDEX;


-- SYNONYM : 오라클 객체에 동의어(별명)을 부여하기 위한 객체
--  => 전용 SYNONYM : 특정 사용자만 사용할 수 있는 동의어(일반 사용자 생성)
--  => 공용 SYNONYM : 모든 사용자가 사용할 수 있는 동의어(관리자 생성)

-- SYNONYM 생성
-- 형식) CREATE [PUBLIC] SYNONYM 동의어  FOR 객체명;
--  => PUBLIC : 고용 SYNONYM을 생성할 때 사용

-- EMPLOYEE 테이블의 모든 데이터 검색
SELECT * FROM EMPLOYEE;




--  CREATE SYNONYM 시스템 권한이 없으므로 명령 사용시 에러 발생
--  => SCOTT 사용자가 사용 가능한 전용 SYNONYM
CREATE SYNONYM E FOR EMPLOYEE;

-- CREATE SYNONYM 시스템 권한 받기 위해 관리자에게 요청
-- DOS > SQLPLUS /NOLOG
-- SQL > CONN SYS/SYS AS SYSDBA
-- SQL > GRANT CREATE SYNONYM TO scott



-- EMPLOYEE 테이블 또는 EMPLOYEE SYNONYM을 이용한 데이터 검색
SELECT * FROM EMPLOYEE;
SELECT * FROM E;


-- SYNONYM 확인 => ALL_SYNONYMS, DBA_SYNONYMS, USER_SYNONYMS;

SELECT * FROM USER_SYNONYMS;

SELECT OWNER, TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM  ALL_SYNONYMS WHERE TABLE_NAME = 'EMPLOYEE';

-- 공용 SYNONYM
-- DOS> SQLPLUS /NOLOG
-- SQL> CONN SYS/SYS AS SYSDBA
-- SQL> SELECT EMPNO,ENAME,SAL FROM EMP; -- 에러 발생
-- SQL> SELECT EMPNO,ENAME,SAL FROM SCOTT.EMP;
-- SQL> CREATE PUBLIC SYNONYM EMP FOR SCOTT.EMP;
-- SQL> SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER 
-- FROM DBA_SYNONYMS WHERE TABLE_NAME = 'EMP';

-- 대표적인 PUBLIC SYNONYM => DUAL 또는 각종 딕셔너리
SELECT 20+10 FROM DUAL;

SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER
    FROM ALL_SYNONYMS WHERE TABLE_NAME = 'DUAL';
    
    
-- SYNONYM 삭제
-- 형식) DROPT [PUBLIC] SYNONYM 동의어;
-- SQL> DROP PUBLIC SYNONYM EMP; -- 공용 SYNONYM 제거
-- SQL> SELECT EMPNO,ENAME,SAL FROM EMP; -- 에러 발생 

DROP SYNONYM E; -- 전용 SYNONYM 삭제

SELECT * FROM E; -- 에러 발생


-- 계정 : 시스템을 사용할 수 있는 허락받은 사용자
-- 계정 관리 : 계정을 생성하거나 삭제하는 기능(관리자) => 시스템 보안(권한)
-- 일반 계정 생성
-- 형식) CREATE USER 계정명 IDENTIFIED BY 암호;

-- DOS> SQLPLUS /NOLOG
-- SQL> CONN SYS/SYS AS SYSDBA
-- SQL> CREATE USER KIM IDENTIFIED BY 1234;


-- 계정 확인 => DBA_USERS 딕셔너리 이용
-- SQL> SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE, 
-- CREATED FROM DBA_USERS WHERE USERNAME = 'KIM';

-- 계정 암호 변경
-- 형식) ALTER USER 계정명 IDENTIFIED BY 암호;
-- SQL> ALTER USER KIM IDENTIFIED BY 5678;

-- 계정의 접속 상태 변경 => 오라클은 계정의 암호가 5번 틀리면 계정을 LOCK 상태로 변경
--  => 계정의 LOCK 상태를 OPEN 상태로 변경 해야만 접속 가능
--  형식) ALTER USER 계정명 ACCOUNT UNLOCK;

-- 계정 삭제
-- SQL > DROP USER KIM;



















