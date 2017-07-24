
-- DCL (Data Control Language) : 데이터 제어어
--  => 계정에게 권한을 부여하거나 회수하기 위한 명령
-- 권한(Privilege) : 시스템 권한(관리자) 또는 객체 권한(일반계정)
-- 권한 그룹(ROLE) :  시스템 권한들을 묶어 사용하기 위한 권한 그룹명

-- 시스템 권한 부여
-- 형식) GRANT (PRIVILEGE | ROLE) TO 계정명 [WITH ADMIN OPTION] [IDENTIFIED BY 암호]
-- 계정명 대신 PUBLIC를 사용하면 모든 계정에게 권한 부여
-- 권한을 부여하고자 하는 계정이 존재하지 않을 경우 자동으로 계정 생성
--  => 계정이 자동 생성 될 경우 반드시 IDENTIFIED BY를 사용하여 암호를 설정
-- WITH ADMIN OPTION : 부여 받은 시스템 권한을 다른 계정한테 부여 할 수 있는 옵션
--  => 보안 문제로 일반 계정에게 부여 하지 않는 것을 권장

-- KIM 계정 새성
-- DOS> SQLPLUS /NOLOG
-- SQL> CONN SYS/SYS AS SYSDBA;
-- SQL> CREATE USER KIM IDENTIFIED BY 1234;

-- KIM 계정으로 DB 접속
--  => CREATE SESSION 권한이 없으므로 ORACLE DBMS 접속 거부
-- SQL> CONN KIM/1234

-- 관리자가 KIM 계정에게 CREATE SESSION 세션 권한 부여
-- SQL> CONN SYS/SYS AS SYSDBA
-- SQL> GRANT CREATE SESSION TO KIM
-- SQL> SHOW USER; => 현재 DBMS 접속 계정 확인


-- KIM 계정으로 EMP 테이블 생성
--  => KIM 계정에게 테이블 생성 권한이 없으므로 에러 발생
-- SQL> CREATE TABLE EMP(EMPNO NUMBER(4),ENAME VARCHAR2(10),DEPTNO NUMBER(2));

--관리자가 KIM 계정에게 CREATE TABLE 권한 및 DEFAULT TABLESPACE 설정
--SQL> CONN SYS/SYS AS SYSDBA
--SQL> GRANT CREATE TABLE TO KIM

--TABLESPACE 정보 확인 => DBA_USERS 딕셔너리 이용
--SELECT USERNAME,DEFAULT_TABLESPACE FROM DBA_USERS WHERE USERNAME = 'KIM';
--KIM 계정의 TABLESPACE 크기를 변경 => 무제한
--SQL> ALTER USER KIM QUOTA UNLIMITED ON SYSTEM;


--KIM 계정으로 EMP 테이블 생성
--  => KIM 계정에게 테이블 생성 권한이 없으므로 에러 발생
--SQL> CREATE TABLE EMP(EMPNO NUMBER(4),ENAME VARCHAR2(10),DEPTNO NUMBER(2));

--객체 권한 : 일반 계정의 객체 관련 명령 사용 권한
--  => INSERT,DELETE,UPDATE,SELECT등의 명령 사용 관련된 권한
--형식) GRANT {ALL|PRIVILEGE,...} ON 객체명 TO 계정명 {WITH GRANT OPTION};
--WITH GRANT OPTION : 부여 받은 객체 권한을 다른 일반 계정에게 부여 할 수 있는 옵션

--SCOTT 계쩡으로 접속 후 SQL 명령 실행
-- => DEPT 테이블은 SCOTT 계정의 테이블 객체
SELECT * FROM SCOTT.DEPT; -- SCOTT. 이 스키마이다. 누가 사용하고 있는지


--KIM 계정으로 접속 후 SQL 명령 실행
--SQL> CONN KIM/1234
--KIM 계정에게는 DEPT 테이블이 존재 하지 않아 에러 발생
--SQL> SELECT * FROM (KIM.)DEPT;
--SCOTT 계정의 DEPT 테이블 검색 => SCOTT 스키마를 이용하여 표현
--  => SCOTT 계정의 DEPT 테이블 검색 권한이 존재하지 않으므로 에러 발생
--SQL> SELECT * FROM SCOTT.DEPT;

--SCOTT 계정(GRANTOR)이 KIM 계정에게 DEPT 테이블 검색 권한 부여
GRANT SELECT ON DEPT TO KIM;

--KIM 계정으로 SCOTT 계정의 DEPT 테이블 검색
--SQL> SELECT * FROM SCOTT.DEPT;

--다른 계정에게 부여한 객체 권한 확인 => USER_TAB_PRIVS_MADE
SELECT * FROM USER_TAB_PRIVS_MADE;

--다른 계정에게 부여 받은 객체 권한 확인 => USER_TAB_PRIVS_RECD 유저 딕셔너리 이용
--SQL> CONN KIM/1234
--SQL> SELECT * FROM USER_TAB_PRIVS_RECD;

--시스템 권한 회수
--형식) REVOKE PRIVILEGE,... FROM 계정명;
--객체 권한 회수
--형식) REVOKE {ALL|PRIVILEGE,...} ON 객체명 FROM 계정명
--SCOTT 계정이 KIM 계정에게 DEP 테이블 검색 권한 회수
REVOKE SELECT ON DEPT FROM KIM; -- 실행

--관리자가 KIM계정에게 부여한 CREATE SESSION 권한을 회수
--SQL> CONN SYS/SYS AS SYSDBA;
--SQL> REVOKE CREATE SESSION FROM KIM;

--KIM 계정으로 DBMS 접속
--  => KIM 계정에게 CREATE SESSION 권한이 존재 하지 않아
-- 접속이 거부 된다.
--  => 모든 권한을 회수해도 계정은 삭제 되지 않는다.
--SQL> CONN KIM/1234

--롤(ROLL) : 계정에게 보다 효율적으로 권한을 부여하거나 회수할 수 있도록 여러 개의
--시스템 권한을 묶어 그룹화 한 기능
--오라클에 미리 만들어져 있는 롤
-- CONNECT ROLL : 8개의 시스템 권한(CREATE SESSION,CREATE TABLE,ALTER SESSION
--  ,CREATE SYNONYM 등)
--RESOURCE ROLL : 계정이 객체를 생성할 수 있는 시스템 권한
--  => CREATE TABLE, CREATE SEQUENCE,CREATE TRIGGER 등
--DBA ROLL : 시스템 관리에 필요한 모든 권한 => 관리자

--관리자가 LEE 계정을 생성하여 CONNECT 및 RESOURCE ROLL 부여
--SQL> CONN SYS/SYS AS SYSDBA
--권한을 부여하고자 하는 계정이 없는 경우
--SQL> GRANT CONNECT,RESOURCE TO LEE IDENTIFIED BY 5678;

--LEE 계정으로 DBMS 접속 후 EMP 테이블 생성


--관리자가 LEE 계정을 생성하여 CONNECT 및 RESOURCE ROLL 회수
--SQL> CONN SYS/SYS AS DBA;
--SQL> REVOKE CONNECT,RESOURCE FROM LEE;

--LEE 계정으로 DBMS 접속
--  => CREATE SESSION 시스템 권한이 없으므로 DBMS 접속 거부
--SQL> CONN LEE/5678

-- PL/SQL(PROCEDUAL LANGUAGE EXTENSION TO SQL)
--  => SQL에는 없는 변수 선언, 선택 처리, 반복 처리를 지원하기 위한 기능

-- 3부분의 블록 구조로 선언
-- 1)DECLAER 영역(선언부) : DECLEAR
-- 2)EXCUTABLE 영역(실행부) : BEGIN
-- 3)EXCEPTION 영역(예외처리부) : EXCEPTION
--  => 블럭에서 하나의 명령을 종료할 때 마다 ;를 사용한다.
--  => 블럭 마지막은 END 키워드로 마무리하여 ;를 사용한다.
--  => QUERY를 수행하기 위해 반드시 .이 입력되어야 된다.

-- 메시지를 출력 할 수 있는 SERVEROUTPUT 환경변수 값 변경
SET SERVEROUTPUT ON

-- 간단한 메시지를 출력하는 PL/SQL 작성

BEGIN

   DBMS_OUTPUT.PUT_LINE('HELLO, ORACLE');
END;
/


-- 변수 선언 및 초기화 입력 => 선언부
-- 형식) 변수명 [CONSTANT] 자료형 [NOT NULL] [{:=|DEFAULT} 표현식]
-- CONSTANT : 변수에 저장된 변수값 변경 불가
-- NOT NULL : NULL 저장 허용 불가
-- := : 대입문
-- 표현식 | 상수,변수,연산식, 함수를 이용하여 표현하는 값


-- 변수값 저장 및 변경 => 실행부
-- 형식) 변수명 := 표현식

-- 변수(스칼라 변수 : 변수의 자료형을 직접 입력) 선언 후 값을 입력
-- 하여 화면에 출력하는 PL/SQL 작성

DECLARE
    
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
    
BEGIN
    VEMPNO := 7788;
    VENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);

END;
/

-- 레퍼런스 변수 : 다른 변수 또는 테이블의 컬럼 자료형 이용 => 선언부
-- 형식) 변수명 {변수명%TYPE | 테이블명.컬럼명%TYPE}

-- 테이블의 데이터를 검색하여 컬럼값을 변수에 저장하는 방법 => 실행부
-- 형식) SELECT 검색대상,.. INTO 변수명,... FROM 테이블명 WHERE 조건식;
--  => 검색대상과 변수는 자료형 및 갯수가 동일해야 한다.

-- 변수(레퍼런수 변수) 선언 후 EMP 테이블의 SCOTT 사원의 정보를 검색하여 변수에 
-- 저장하고 화면에 출력하는 PL/SQL 작성

DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
    
BEGIN
    SELECT EMPNO,ENAME INTO VEMPNO,VENAME FROM EMP WHERE ENAME = 'SCOTT';

    DBMS_OUTPUT.PUT_LINE('사원번호 / 사원이름');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
    
END;
/


-- 테이블 변수 : 여러 개의 값들을 저장하기 위한 변수 (배열)
--  => 자료형과 크기가 동일한 기억장소를 여러 개 생성 
--  => 변수명(첨자) 형태로 각 기억장소에 접근하여 사용
-- 형식) TYPE 테이블타입명 IS TABLE OF 
--  {자료형 | 변수명%TYPE | 테이블명.컬럼명%TYPE} [NOT NULL]
--  [INDEX BY BINARY_INTEGER];
--  테이블 변수명 테이블 타입명;

--EMP 테이블에 저장된 모든 사원의 사원번호,사원이름을 변수에 저장 후 화면에
--출력하는 PL/SQL 작성

DECLARE
    
    -- 테이블 타입 선언(배열 자료형 선언)
    TYPE EMPNO_TABLE_TYPE IS TABLE OF EMP.EMPNO%TYPE INDEX BY BINARY_INTEGER;
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE INDEX BY BINARY_INTEGER;

    -- 테이블 변수 선언(배열 선언)
    VEMPNO_TABLE EMPNO_TABLE_TYPE;
    VENAME_TABLE ENAME_TABLE_TYPE;
    
    -- 반복 처리를 위한 첨자 변수 선언
    I BINARY_INTEGER := 0;
    
BEGIN
    
    -- EMP 테이블의 모든 사원정보를 검색하여 테이블 변수에 저장 => 반복 처리
    FOR K IN(SELECT EMPNO,ENAME FROM EMP) LOOP
        I := I + 1;
        VEMPNO_TABLE(I) := K.EMPNO;
        VENAME_TABLE(I) := K.ENAME;
    END LOOP;
    
    -- 테이블 변수에 저장된 변수값 출력 => 반복 처리
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD(TO_CHAR(J),2)|| '/' || RPAD(VEMPNO_TABLE(J),6) || ' / ' || RPAD(VENAME_TABLE(J),12));
    END LOOP;
    
END;
/

-- 프로 시저 자바 가져오기

-- 레코드 변수 : 테이블에 저장된 데이터의 컬럼값을 저장하기 위한 변수 => 인스턴스
-- 형식) TYPE 레코드타입명 IS RECORD (필드명 {자료형 | 변수명%TYPE | 테이블명.컬럼명%TYPE}
--  [NOT NULL] [{|= |DEFAULT} 표현식],...)
--  레코드변수명 레코드타입

-- 레코드 변수 사용 방법
-- 형식) 레코드변수명.필드명

-- SCOTT 사원의 사원번호,사원이름,업무,급여,부서코드를 검색하여 
-- 변수에 저장 후 출력하는 PL/SQL작성
DECLARE
    -- 레코드 타입 선언
    TYPE EMP_RECORD_TYPE IS RECORD(VEMPNO EMP.EMPNO%TYPE,VENAME EMP.ENAME%TYPE
    , VJOB EMP.JOB%TYPE, VSAL EMP.SAL%TYPE,VDEPTNO EMP.DEPTNO%TYPE);
    
    -- 레코드 변수 선언
    VEMP_RECORD EMP_RECORD_TYPE;

BEGIN
    SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO VEMP_RECORD.VEMPNO,VEMP_RECORD.VENAME
        ,VEMP_RECORD.VJOB,VEMP_RECORD.VSAL,VEMP_RECORD.VDEPTNO 
            FROM EMP WHERE ENAME = 'SCOTT';
        
        DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP_RECORD.VEMPNO);
        DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP_RECORD.VENAME);
        DBMS_OUTPUT.PUT_LINE('업무 = ' || VEMP_RECORD.VJOB);
        DBMS_OUTPUT.PUT_LINE('급여 = ' || VEMP_RECORD.VSAL);
        DBMS_OUTPUT.PUT_LINE('부서코드 = ' || VEMP_RECORD.VDEPTNO);

END;
/

-- 레퍼런스 변수 형식으로 선언하여 데이터를 저장할 수 있는 레코드 선언 방법
-- 형식) 레코드 변수명 테이블명%ROWTYPE;
--  => 사용 방법 형식) 레코드 변수명.컬럼명

DECLARE     
    -- 레코드 변수 선언
    VEMP_RECORD EMP%ROWTYPE;

BEGIN
    --SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO VEMP_RECORD.EMPNO,VEMP_RECORD.ENAME
    --    ,VEMP_RECORD.JOB,VEMP_RECORD.SAL,VEMP_RECORD.DEPTNO 
    --        FROM EMP WHERE ENAME = 'SCOTT';
            
     SELECT * INTO VEMP_RECORD FROM EMP WHERE ENAME = 'SCOTT';
        
        DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP_RECORD.EMPNO);
        DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP_RECORD.ENAME);
        DBMS_OUTPUT.PUT_LINE('업무 = ' || VEMP_RECORD.JOB);
        DBMS_OUTPUT.PUT_LINE('급여 = ' || VEMP_RECORD.SAL);
        DBMS_OUTPUT.PUT_LINE('부서코드 = ' || VEMP_RECORD.DEPTNO);

END;
/


-- 선택문 : 명령을 선택하여 실행하기 위한 명령문
-- IF 문 : 조건식에 의해 명령을 선택 실행
-- 형식1) IF(조건식) THEN 명령 END IF;

-- EMP 테이블에서 SCOTT 사원을 검색하여 사원번호,사원이름,부서코드에 따른 부서명을 출력
-- 하는 PL/SQL 작성

DECLARE
    VEMP EMP%ROWTYPE;
    
    -- 부서명을 저장하기 위한 변수 선언
    VDNAME VARCHAR2(20) := NULL;

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
    
    IF(VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNT';
    END IF;

    IF(VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    END IF;

    IF(VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    END IF;

    IF(VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATION';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서이름 = ' || VDNAME);


END;
/

-- EMP 테이블에서 SCOTT 사원을 검색하여 사원번호, 사원이름
-- , 연봉((급여+보너스)*12)를 변수에 저장하여 출력하는 PL/SQL 작성

DECLARE
    VEMP EMP%ROWTYPE;

    AANUAL NUMBER(7,2);

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';

    -- 방법 1
    --IF VEMP.COMM IS NULL THEN
    --    VEMP.COMM = 0;
    --END IF;
   
    -- 방법2 NVL 사용
    AANUAL := (VEMP.SAL + NVL(VEMP.COMM,0)) * 12;
   
    DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('연봉 = ' || TO_CHAR(AANUAL,'$999,990'));

END;
/

-- 형식2) IF(조건식) THEN 명령 ELSE 명령 END IF;
DECLARE
    VEMP EMP%ROWTYPE;

    AANUAL NUMBER(7,2);

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';


    IF(VEMP.COMM IS NULL) THEN
        AANUAL := (VEMP.SAL) * 12;
    ELSE
        AANUAL := (VEMP.SAL + VEMP.COMM) * 12;
    END IF;
   
   
    DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('연봉 = ' || TO_CHAR(AANUAL,'$999,990'));

END;
/

-- 형식3) IF(조건식) THEN 명령 ELSIF(조건식) THEN 명령 ELSE 명령 END IF;
DECLARE
    VEMP EMP%ROWTYPE;
    
    -- 부서명을 저장하기 위한 변수 선언
    VDNAME VARCHAR2(20) := NULL;

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
    
    IF(VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNT';
    ELSIF(VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    ELSIF(VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    ELSIF(VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATION';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('부서이름 = ' || VDNAME);
END;
/

-- CASE문: 컬럼에 저장된 데이터 또는 조건식의 결과값을 이용하여 명령 선택 실행
-- 형식1) CASE 변수명 WHEN 값1 THEN 명령; WHEN 값2 THEN 명령; .. END CASE;

-- EMP 테이블에 사원이름이 SCOTT 인 사원을 검색하여 사원번호, 사원이름, 업무
--  급여, 업무에 따른 실지급액을 변수에 저장하여 출력하는 PL/SQL 작성
-- 실지급액 => ANALYST : 급여 * 1.1, CLARK:급여 * 1.2 , MANAGER: 급여*1.3
--  PRESIDENT:급여*1.4 SALESMAN:급여*1.5

DECLARE
    VEMP EMP%ROWTYPE;
    VPAY NUMBER(7,2);
    
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
   
    CASE VEMP.JOB WHEN 'ANALYST' THEN VPAY := VEMP.SAL * 1.1;
                WHEN 'CLARK' THEN VPAY := VEMP.SAL * 1.2;
                WHEN 'MANAGER' THEN VPAY := VEMP.SAL * 1.3;
                WHEN 'PRISIDENT' THEN VPAY := VEMP.SAL * 1.4;
                WHEN 'SALESMAN' THEN VPAY := VEMP.SAL * 1.5; END CASE;
   
    DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = ' || VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('급여 = ' || VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('실지급액 = ' || VPAY);
    
END;
/

-- 형식2) CASE WHEN 조건식1 THEN 명령;.. END CASE;

DECLARE
    VEMP EMP%ROWTYPE;
    VPAY NUMBER(7,2);
    
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
   
    CASE  WHEN VEMP.JOB = 'ANALYST' THEN VPAY := VEMP.SAL * 1.1;
            WHEN VEMP.JOB= 'CLARK' THEN VPAY := VEMP.SAL * 1.2;
            WHEN VEMP.JOB='MANAGER' THEN VPAY := VEMP.SAL * 1.3;
            WHEN VEMP.JOB='PRISIDENT' THEN VPAY := VEMP.SAL * 1.4;
            WHEN VEMP.JOB='SALESMAN' THEN VPAY := VEMP.SAL * 1.5; END CASE;

    DBMS_OUTPUT.PUT_LINE('사원번호 = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('사원이름 = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('업무 = ' || VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('급여 = ' || VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('실지급액 = ' || VPAY);
    
END;
/

-- 반복문 : 명령을 반복하여 실행하는 명령문

-- 기본 반복문(BASIC LOOP)
-- 형식) LOOP 명령: 명령;...EXIT[WHEN 조건식] END LOOP;

-- 1~5를 화면에 출력하는 PL/SQL 작성
DECLARE

    I NUMBER(2) := 1;

BEGIN

    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        IF I > 5 THEN
            EXIT;
        END IF;
    END LOOP;

END;
/


-- FOR LOOP : 반복횟수가 정해져 있는 경우 사용하는 반복문
-- 형식1) FOR INDEX_COUNTER [REVERSE] IN LOWER_BOUND..UPPER_BOUND LOOP
--  명령; 명령; ... END LOOP;
-- INDEX_COUNTER : LOWER_BOUND부터 UPPER_BOUND까지 1씩 증가되는 값을 저장하기
--  위한 변수

-- 1~10 범위에 정수 합계를 계산하여 출력하는 PL/SQL 작성
DECLARE
    TOT NUMBER(2) := 0;
    
    
BEGIN
    
    FOR I IN 1..10 LOOP
        TOT := TOT + I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10까지 범위의 정수 합계 = ' || TOT);    
END;
/

-- 형식2) FOR 레코드변수명 IN (검색명령) LOOP 명령;... END LOOP;
--  => 검색된 데이터가 여러 개인 경우 레코드 변수에 저장하여 반복 처리 하기 위한 명령
--  => 레코드변수명에 저장된 컬럼값은 결과 변수.컬럼명으로 표현하여 사용


-- EMP 테이블에 저장된 모든 사원의 사원번호,사원이름 검색하여 출력 PL/SQL 작성

BEGIN
    FOR VEMP IN (SELECT * FROM EMP) LOOP
    
        DBMS_OUTPUT.PUT_LINE('사원번호 = '||VEMP.EMPNO||', 사원이름 = '||VEMP.ENAME);
    
    END LOOP;

END;
/

-- WHILE LOOP : 반복의 횟수가 정해져 있지 않을 경우 사용
-- 형식) WHILE 조건식 LOOP 명령; 명령;... END LOOP;

DECLARE
    
    I NUMBER(2) := 2;
    TOT NUMBER(2) :=0;
BEGIN

    WHILE I<=10 LOOP
        TOT := TOT + I;
        I := I+2;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~부터 10 범위의 짝수의 합'|| TOT);
    
END;
/

-- 저장 프로시저(STORED PROCEDURE) : 복잡한 SQL 명령들을 프로시저로 선언하여 필요한
-- 경우 호출하여 결과를 얻을 수 있는 기능
-- 형식) CREATE [OR REPLACE] PROCEDURE 프로시저명 [(매개변수 [MODE] 자료형,...)]
--  IS 변수 선언부 BEGIN 명령; 명령; ... END;

-- EMP01 테이블의 모든 데이터를 삭제하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE DELETE_ALL IS 

BEGIN 
    DELETE FROM EMP01;
END;
/

-- 저장 프로시저 실행
-- 형식) EXECUTE 프로시저명(값 또는 변수,...);
SELECT * FROM EMP01;

EXECUTE DELETE_ALL;

ROLLBACK;

-- EMP01 테이블의 모든 데이터를 삭제하는 저장 프로시저 생성
--  => 에러 발생 (컴파일러 로그 확인)
CREATE OR REPLACE PROCEDURE DELETE_ALL IS 

    DELETE FROM EMP01;
END;
/

SHOW ERROR;

-- 저장 프로시저 확인 => USER_SOURCE 유저 딕셔너리 이용
SELECT NAME,TEXT FROM USER_SOURCE;

-- EMP01 테이블에 저장된 사원 이름을 전달 받아 삭제하는 저장 프로시저 생성 후 실행
CREATE  OR REPLACE PROCEDURE DELETE_ENAME(VENAME EMP.ENAME%TYPE) IS

BEGIN
    DELETE FROM EMP01 WHERE ENAME = VENAME;
END;
/

SELECT * FROM EMP01;
EXECUTE DELETE_ENAME('홍길동');
ROLLBACK;

-- 매개변수 MODE
--  => IN : 외부데이터를 저장 프로시저에 전달 받을 목적의 매개변수 선언
--  => OUT : 저장 프로시저의 내부 데이터를 외부로 전달 할 목적의 매개변수 선언
--  => INOUT : IN 과 OUT 기능을 모두 가진 매개변수 선언

-- 사원번호를 전달받아 EMP 테이블에 저장된 해당 사원의 사원이름,업무,급여를 
-- 외부로 전달하는 프로시저를 생성하여 실행
CREATE OR REPLACE PROCEDURE SELECT_EMPNO(VEMPNO IN EMP.EMPNO%TYPE
    , VENAME OUT EMP.ENAME%TYPE, VJOB OUT EMP.JOB%TYPE, VSAL OUT EMP.SAL%TYPE) IS BEGIN

    SELECT ENAME,JOB,SAL INTO VENAME,VJOB,VSAL FROM EMP WHERE EMPNO = VEMPNO;

END;
/

-- OUT 매게변수의 데이터를 저장하기 위한 변수 선언 => 바인딩 변수
-- 형식) VARIABLE 변수명 자료형;
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_JOB VARCHAR2(20);
VARIABLE VAR_SAL NUMBER;

-- SELECT_EMPNO 저장 프로시저 실행
--  => OUT 매게변수가 전달할 데이터를 저장하는 바인딩 변수는 앞에 :를 붙여 사용한다.
EXECUTE SELECT_EMPNO(7369,:VAR_ENAME,:VAR_JOB,:VAR_SAL);

-- 바인딩 변수에 저장된 데이터 출력
-- 형식) PRINT 바인딩 변수명;
PRINT VAR_ENAME;
PRINT VAR_JOB;
PRINT VAR_SAL;


-- 저장 함수(STORED FUNCTION) : 저장 프로시저와 동일한 역활을 수행
--  => 데이터를 반환 가능
-- 형식) CREATE [OR REPLACE] 함수명 [(매개변수 [MODE] 자료형,...)] RETURN 자료형 IS 변수명 자료형;...
--  BEGIN 명령; 명령; ... RETURN 변수명 END;


-- 사원번호를 전달받아 해당 사원에게 200%의 특별수당을 지급하기 위한 저장함수 선언 및 실행
CREATE OR REPLACE FUNCTION CAL_BONUS(VEMPNO IN EMP.EMPNO%TYPE)

    RETURN NUMBER IS VSAL NUMBER(7,2);
    
BEGIN
    SELECT SAL INTO VSAL FROM EMP WHERE EMPNO = VEMPNO;

    RETURN (VSAL*2.0);

END;
/

SHOW ERROR;

-- 저장 함수 실행 => EXECUTE 명령 사용

VARIABLE VAR_BONUS NUMBER;
 EXECUTE :VAR_BONUS := CAL_BONUS(7788);

PRINT VAR_BONUS;

-- 저장함수는 SQL명령에 포함 가능
SELECT EMPNO,ENAME,SAL,CAL_BONUS(EMPNO) "특별수당" FROM EMP;

-- 커서(CURSOR) : 검색된 데이터를 처리하기 위한 기능
--  => 묵시적 커서 : 검색 결과가 하나의 행인 경우를 처리하기 위한 커서
--  => 명시적 커서 : 검색 결과가 여러 개인 경우 처리하기 위한 커서

-- 명시적 커서 선언 및 사용 방법
-- 형식) DECLARE CURSOR 커서명 IS 검색 명령;
--  BEGIN
--      OPEN 커서명;
--      FETCH 커서명 INTO 변수명,...;
--      CLOSE 커서명;
--  END;

-- DEPT 테이블에 저장된 모든 부서정보를 화면에 출력하는 저장 프로시저 생성
CREATE OR REPLACE PROCEDURE CURSOR_EXAMPLE1 IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C IS SELECT * FROM DEPT;

BEGIN
    OPEN C;
    
    LOOP
        FETCH C INTO VDEPT.DEPTNO, VDEPT.DNAME, VDEPT.LOC;
        -- 커서 위치의 더이상 데이터가 존재 하지 않는경우
        EXIT WHEN C%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('부서코드 = ' || VDEPT.DEPTNO || ', 부서이름 = '
            || VDEPT.DNAME || ', 부서위치 ='|| VDEPT.LOC);
        
        
    END LOOP;
    
    CLOSE C;
END;
/


EXECUTE CURSOR_EXAMPLE1;


CREATE OR REPLACE PROCEDURE CURSOR_EXAMPLE2 IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C IS SELECT * FROM DEPT;

BEGIN
    -- FOR LOOP 이용하여 반복처리 할 경우 커서에 대한 OPEN,FETCH,CLOSE를 사용하지 
    -- 않아도 된다.
    FOR VDEPT IN C LOOP
        -- 커서 위치의 더이상 데이터가 존재 하지 않는경우
        EXIT WHEN C%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('부서코드 = ' || VDEPT.DEPTNO || ', 부서이름 = '
            || VDEPT.DNAME || ', 부서위치 ='|| VDEPT.LOC);
        
    END LOOP;
END;
/

EXECUTE CURSOR_EXAMPLE2;

CREATE OR REPLACE PROCEDURE CURSOR_EXAMPLE3 IS
    VDEPT DEPT%ROWTYPE;

BEGIN
    -- FOR LOOP 이용하여 반복처리 할 경우 커서에 대한 OPEN,FETCH,CLOSE를 사용하지 
    -- 않아도 된다.
    FOR VDEPT IN(SELECT * FROM DEPT) LOOP
        
        DBMS_OUTPUT.PUT_LINE('부서코드 = ' || VDEPT.DEPTNO || ', 부서이름 = '
            || VDEPT.DNAME || ', 부서위치 ='|| VDEPT.LOC);
        
    END LOOP;
END;
/

EXECUTE CURSOR_EXAMPLE3;

-- 트리거(TRIGGER) : 어떤 동작이 발생될 경우 자동으로 동작되도록 설정하는 기능
-- 트리거 생성
-- 형식) CREATE [OR REPLACE] TRIGGER 트리거명 {BEFORE | AFTER}
--  DML 명령 ON 테이블명 [FOR EACH ROW] [WITH 조건식]
--  BEGIN 명령; 명령; ... END;
-- FOR EACH ROW : 생략되면 문장 레벨 트리거, 선언하면 행 레벨 트리거
--  => 문장 레벨 트리거 : 이벤트 DML 명령이 실행되면 트리거가 한번만 실행
--  => 행 레벨 트리거 : 이벤트 DML 명령이 실행되면 트리거가 여러번 실행

-- EMP02 테이블 생성 => 사원번호(PK),사원이름,업무를 저장하기 위한 테이블
CREATE TABLE EMP03(EMPNO NUMBER(4) PRIMARY KEY,ENAME VARCHAR2(20)
    ,JOB VARCHAR(20));

DESC EMP03;

-- EMP03 테이블에 사원정보를 삽입한 후 메시지를 출력하는 트리거 생성
CREATE OR REPLACE TRIGGER TRI01 AFTER INSERT ON EMP03
BEGIN
    DBMS_OUTPUT.PUT_LINE('새로운 사원이 입사 하였습니다');
END;
/



INSERT INTO EMP03 VALUES(1000,'홍길동','SALESMAN');
INSERT INTO EMP03 VALUES(2000,'김길동','MANAGER');

DELETE FROM EMP03;
COMMIT;


-- SAL03 테이블 생성 => 급여번호(PK),급여,사원번호(FK => EMP 테이블의 EMP 컬럼)를
-- 저장하기 위한 테이블
CREATE TABLE SAL03(SALNO NUMBER(4) PRIMARY KEY,SAL NUMBER(7,2),EMPNO NUMBER(4) REFERENCES EMP03(EMPNO));
        
-- 시퀸스 객체
CREATE SEQUENCE SAL03_SEQ;
        
        
-- EMP03 테이블에 사원정보를 저장하면 SAL03 테이블에 급여 정보 자동 저장
CREATE OR REPLACE TRIGGER TRI02 AFTER INSERT ON EMP03 FOR EACH ROW

BEGIN
    -- NEW.컬럼명 : 저장 또는 변경 데이터의 컬럼 표현
    -- OLD.컬럼명 : 삭제 또는 변경 데이터의 컬럼 표현
    INSERT INTO SAL03 VALUES(SAL03_SEQ.NEXTVAL,2000,:NEW.EMPNO);
END;
/


INSERT INTO EMP03 VALUES(2000,'임꺽정','사장');
INSERT INTO EMP03 VALUES(3000,'전우치','대리');

SELECT * FROM EMP03;
SELECT * FROM SAL03;
        
COMMIT;

SELECT * FROM USER_TRIGGERS;


-- 트리거 제거
-- 형식) DROP TRIGGER 트리거명;
DROP TABLE TRI02;

INSERT
INSERT INTO EMP03 VALUES(4000,'일지매','사원');
SELECT * FROM EMP03;
SELECT * FROM SAL03;
        





