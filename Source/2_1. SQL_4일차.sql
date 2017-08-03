--문제1.
SELECT EMPNO,ENAME,D.DEPTNO,DNAME FROM EMP E JOIN DEPT D 
    ON E.DEPTNO=D.DEPTNO ORDER BY ENAME;
   
--문제2.    
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D
    ON E.DEPTNO=D.DEPTNO WHERE SAL>=2000 ORDER BY SAL DESC;
    
--문제3.
SELECT EMPNO,ENAME,JOB,SAL,DNAME FROM EMP E JOIN DEPT D
    ON E.DEPTNO=D.DEPTNO WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;
    
--문제4.
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE 
    ON SAL BETWEEN LOSAL AND HISAL WHERE GRADE=4 ORDER BY SAL DESC; 
    
--문제5.
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP E JOIN DEPT D ON E.DEPTNO=D.DEPTNO
    JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;
    
--문제6.
SELECT W.ENAME 사원명,M.ENAME 관리자명 FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO;
SELECT W.ENAME 사원명,M.ENAME 관리자명 FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO;

--문제7.
SELECT W.ENAME 사원명,M.ENAME 관리자명,MM.ENAME "관리자의 관리자명" 
    FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO JOIN EMP MM ON M.MGR=MM.EMPNO;
    
--문제8.
SELECT W.ENAME 사원명,M.ENAME 관리자명,MM.ENAME "관리자의 관리자명" 
    FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO LEFT JOIN EMP MM ON M.MGR=MM.EMPNO;

--SUBQUERY : MAINQUERY(SELECT)에 포함되어 선언된 QUERY(SELECT)    
-- => 여러 번의 QUERY로 얻을 수 있는 결과를 하나의 QUERY로 얻어 수 있도록 하는 기능
-- => MAINQUERY는 SELECT 명령으로 구현되지만 다른 SQL 명령이 될 수도 있다.

--사원이름이 SCOTT인 사원보다 많은 급여를 받는 사원의 사원번호,사원이름,급여 검색
SELECT SAL FROM EMP WHERE ENAME='SCOTT';--SCOTT 사원의 급여 => 3000
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>3000;--급여가 3000 초과인 사원 검색

--SUBQUERY 사용
-- => SUBQUERY를 포함하고 있는 SELECT를 MAINQUERY라고 한다.
-- => MAINQUERY에서 () 안에 작성된 SELECT 명령을 SUBQUERY라고 한다.
-- => MAINQUERY 보다 SUBQUERY를 먼저 실행한다.
-- => 보편적으로 SUBQUERY는 WHERE 또는 HAVING에서 사용된다.
-- => 조건식에서 비교하고자 하는 컬럼과 SUBQUERY의 검색대상은 동일해야만 된다.
SELECT EMPNO,ENAME,SAL FROM EMP 
    WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='SCOTT');
    
--사원번호가 7844인 사원과 같은 업무를 하는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7844) AND EMPNO<>7844;

--사원번호가 7521인 사원과 같은 업무를 보는 사원 중 사원번호가 7900인 사원보다 급여를
--많이 받는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7521) AND EMPNO<>7521
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7900);
    
--SALES 부서에 근무하는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP JOIN DEPT 
    ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';--JOIN 이용

SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
    
--모든 사원 중 가장 급여를 적게 받는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP);

--부서코드가 30인 부서에서 가장 많은 급여를 받는 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE SAL=(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30);
    
--부서코드가 30인 부서에서 가장 적은 급여를 받는 사원의 급여보다 많은 급여를 받는
--부서의 부서코드 및 부서별 급여 중 최소급여 검색
SELECT DEPTNO,MIN(SAL) FROM EMP GROUP BY DEPTNO 
    HAVING MIN(SAL)>(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);
    
--부서별 평균급여 중 가장 많은 평균급여를 받는 부서코드,평균급여 검색
SELECT DEPTNO,CEIL(AVG(SAL)) FROM EMP GROUP BY DEPTNO
    HAVING AVG(SAL)=(SELECT MAX(AVG(SAL)) FROM EMP GROUP BY DEPTNO);

--부서별 최소급여를 받는 사원의 사원번호,사원이름,급여,부서코드를 부서코드로 
--오름차순 정렬하여 검색
-- => SUBQUERY에서 검색된 결과가 여러 개인 경우(MULTI-ROW SUBQUERY)에는
--    일반적인 비교연산자(=,<>,>,<,>=,<=)를 이용한 조건식을 사용할 경우 에러 발생
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL=(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO) ORDER BY DEPTNO;--에러 발생
    
--MULTI-ROW SUBQUERY에서는 = 연산자 대신 IN 연산자를 이용    
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL IN (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO) ORDER BY DEPTNO;

--MULTI-ROW SUBQUERY에서는 >,<,>=,<= 연산자를 사용할 경우 MULTI-ROW SUBQUERY 앞에
--ANY 또는 ALL 키워드를 사용하여 비교해야만 된다.

--10번 부서에 근무하는 모든 사원보다 급여가 적은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO=10);

--10번 부서에 근무하는 어떠한 사원보다 급여가 적은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--20번 부서에 근무하는 모든 사원보다 급여가 많은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO=20);

--20번 부서에 근무하는 어떠한 사원보다 급여가 많은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;
    
--ANY 또는 ALL 대신 MAX 또는 MIN 그룹함수를 사용하는 것을 권장한다.
--컬럼명 > ALL(MULTI-ROW SUBQUERY) => 컬럼명 > (SINGLE-ROW SUBQUERY - MAX 그룹함수)
--컬럼명 > ANY(MULTI-ROW SUBQUERY) => 컬럼명 > (SINGLE-ROW SUBQUERY - MIN 그룹함수)
--컬럼명 < ALL(MULTI-ROW SUBQUERY) => 컬럼명 < (SINGLE-ROW SUBQUERY - MIN 그룹함수)
--컬럼명 < ANY(MULTI-ROW SUBQUERY) => 컬럼명 < (SINGLE-ROW SUBQUERY - MAX 그룹함수)

--10번 부서에 근무하는 모든 사원보다 급여가 적은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10);

--10번 부서에 근무하는 어떠한 사원보다 급여가 적은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--20번 부서에 근무하는 모든 사원보다 급여가 많은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--20번 부서에 근무하는 어떠한 사원보다 급여가 많은 사원의 
--사원번호,사원이름,급여,부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;
    
--사원이름이 ALLEN인 사원과 같은 관리자 아래서 일하고 있으며 업무가 같은 사원의
--사원번호,사원이름,관리자번호,업무,급여 검색
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP 
    WHERE MGR=(SELECT MGR FROM EMP WHERE ENAME='ALLEN')
    AND JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';

--MULTI-COLUMN SUBQUERY : 여러 개의 검색대상을 이용하여 검색하는 SUBQUERY
-- => 비교 컬럼은 () 안에 SUBQUERY와 동일한 컬럼으로 ,로 구분하여 선언
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP WHERE (MGR,JOB)=
    (SELECT MGR,JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';

--문제1.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');

--문제2.
SELECT EMPNO,ENAME,HIREDATE FROM EMP 
    WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='MILLER');
    
--문제3.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT AVG(SAL) FROM EMP);

--문제4.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM EMP 
    WHERE ENAME='CLARK') AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7698);
    
--문제5.
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP 
    WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
    
--SET 연산자 : 두 개의 SELECT 결과를 이용하여 합집합(UNION),교집합(INTERSECT)
--,차집합(MINUS) 결과를 반환하는 연산자    

--TEST1 테이블 생성 => 이름 저장 컬럼
CREATE TABLE TEST1(NAME VARCHAR2(10));

--TEST1 테이블에 행 삽입(저장)
INSERT INTO TEST1 VALUES('홍길동');
INSERT INTO TEST1 VALUES('임꺽정');
INSERT INTO TEST1 VALUES('전우치');
INSERT INTO TEST1 VALUES('일지매');
INSERT INTO TEST1 VALUES('장길산');
COMMIT;

SELECT * FROM TEST1;

--TEST2 테이블 생성 => 번호 및 이름 저장 컬럼
CREATE TABLE TEST2(NUM NUMBER(1),NAME VARCHAR2(10));

--TEST2 테이블에 행 삽입(저장)
INSERT INTO TEST2 VALUES(1,'슈퍼맨');
INSERT INTO TEST2 VALUES(2,'홍길동');
INSERT INTO TEST2 VALUES(3,'배트맨');
INSERT INTO TEST2 VALUES(4,'전우치');
INSERT INTO TEST2 VALUES(5,'앤트맨');
COMMIT;

SELECT * FROM TEST2;

--UNION : 두 개의 SELECT에서 검색된 모든 행을 합하여 검색(중복 검색데이타 제외)
-- => 두 개의 SELECT 명령의 검색대상 갯수와 자료형이 반드시 동일해야 된다.
SELECT NAME FROM TEST1 UNION SELECT NAME FROM TEST2;

--UNION ALL : 두 개의 SELECT에서 검색된 모든 행을 합하여 검색(중복 검색데이타 포함)
SELECT NAME FROM TEST1 UNION ALL SELECT NAME FROM TEST2;

--INTERSERT : 두 개의 SELECT에서 검색된 행 중 중복된 행만 검색
SELECT NAME FROM TEST1 INTERSECT SELECT NAME FROM TEST2;

--MINUS : 첫번째 SELECT에서 검색된 행에서 두번째 SELECT에서 검색된 행을 제거하여 검색
SELECT NAME FROM TEST1 MINUS SELECT NAME FROM TEST2;

--두 개의 SELECT 명령의 검색대상 갯수 및 자료형이 일치하지 않은 경우 에러 발생
--검색대상의 자료형이 다르기 때문에 에러 발생
SELECT NAME FROM TEST1 UNION SELECT NUM FROM TEST2;
--검색대상의 갯수가 다르기 때문에 에러 발생
SELECT NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;

--검색대상의 자료형이 다른 경우 => 변환함수 사용하여 자료형을 같게 만들어 사용
SELECT NAME FROM TEST1 UNION SELECT TO_CHAR(NUM,'0') FROM TEST2;

--검색대상의 갯수가 다른 경우 => 검색대상을 추가하거나 임의값(NULL)을 이용
SELECT 1,NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;
SELECT NULL,NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;

--DML(DATA MANIPLATION LANGUAGE) : 데이타 조작어
-- => 행을 삽입하거나 삭제,변경하기 위한 SQL 명령
-- => DML 명령 실행 후 COMMIT(DML 명령 적용) 또는 ROLLBACK(DML 명령 취소) 명령 실행

--INSERT : 테이블에 행을 삽입하는 명령
--형식1)INSERT INTO 테이블명 VALUES(컬럼값,컬럼값,컬럼값,...);
--저장되는 컬럼값은 테이블의 구조(컬럼 순서,자료형,크기)에 맞게 차례대로 나열하여 저장
--테이블의 구조 확인 => 형식) DESC 테이블명;

--부서테이블(DEPT)에 부서정보를 삽입(저장)
SELECT * FROM DEPT;
DESC DEPT;
INSERT INTO DEPT VALUES(50,'회계부','서울');
COMMIT;
SELECT * FROM DEPT;

--DEPT 테이블은 DEPTNO 컬럼에 PK(PRIMARY KEY) 제약조건이 부여되어 있다.
-- => PK 제약조건이 부여된 컬럼에 중복된 컬럼값을 저장할 경우 에러 발생
INSERT INTO DEPT VALUES(50,'총무부','수원');--중복값 저장에 따른 에러 발생
INSERT INTO DEPT VALUES(60,'총무부','수원');
COMMIT;
SELECT * FROM DEPT;

--저장 테이블의 컬럼 갯수와 컬럼값의 갯수가 다른 경우 에러 발생 => 컬럼값 생략 가능
INSERT INTO DEPT VALUES(70,'자재부');--부서위치에 대한 컬럼값이 생략 되어 에러 발생

--테이블에서 컬럼에 저장되는 컬럼값으로 NULL 사용이 가능한지 확인
DESC DEPT;

--컬럼값을 생략하고자 할 경우 컬럼에 NULL 저장 => 명시적 NULL 사용
INSERT INTO DEPT VALUES(70,'자재부',NULL);
COMMIT;
SELECT * FROM DEPT;

--형식2)INSERT INTO 테이블명(컬럼명,컬럼명,...) VALUES(컬럼값,컬럼값,...);
-- => 테이블명 뒤에 () 안에 나열된 컬럼 순서대로 컬럼값을 저장
INSERT INTO DEPT(DEPTNO,LOC,DNAME) VALUES(80,'인천','영업부');
COMMIT;
SELECT * FROM DEPT;

--테이블명 뒤의 () 안에 나열되는 컬럼명은 생략 가능
-- => 생략된 컬럼에는 테이블 생성시 선언된 DEFAULT 컬럼값이 자동으로 저장된다.
-- => DEFAULT 컬럼값을 설정하지 않으면 자동으로 NULL이 DEFAULT 컬럼값으로 설정
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'인사부');
COMMIT;
SELECT * FROM DEPT;

--사원테이블(EMP)에 새로운 사원정보를 삽입(저장)
DESC EMP;
INSERT INTO EMP VALUES(9000,'LEE','MANAGER',7298,'17/07/18',3000,100,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;

--입사일을 현재로 하여 사원테이블에 새로운 사원정보를 삽입(저장)
INSERT INTO EMP VALUES(9001,'KIM','ANALYST',9000,SYSDATE,2000,NULL,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9001;

--EMP 테이블은 DEPTNO 컬럼에 FK(FOREIGN KEY) 제약조건이 부여되어 있다.
--FK 제약조건이 부여된 컬럼은 다른 테이블의 PK 제약조건이 부여된 컬럼값을 참조하여
--데이타를 저장되도록 설정된 제약조건
-- => EMP 테이블의 DEPTNO 컬럼은 데이타 저장시 DEPT 테이블의 DEPTNO 컬럼값을 참조
--    하여 저장되며 참조할 컬럼값이 존재하지 않을 경우 에러 발생 => 데이타 무결성 유지
--DEPT 테이블에 45번 부서가 없어 참조할 수 없어 에러 발생
INSERT INTO EMP VALUES(9002,'PARK','CLERK',9000,SYSDATE,1200,NULL,45);
SELECT * FROM DEPT WHERE DEPTNO=45;--45번 부서가 존재하지 않는다.

--SUBQUERY를 이용한 행 삽입 => 테이블 행 복사
--형식)INSERT INTO 테이블명 SELECT 검색대상,... FROM 테이블명;
-- => INSERT 명령의 SUBQUERY는 () 안에 작성하지 않는다.
-- => INSERT 테이블의 컬럼과 SUBQUERY 검색대상의 구조가 동일해야만 된다.
--    (컬럼 갯수 및 자료형은 반드시 같아야 되며 컬럼명은 같지 않아도 된다.)
SELECT TABLE_NAME FROM TABS;--현재 로그인 사용자가 사용 가능한 테이블 목록 확인
DESC BONUS;
SELECT * FROM BONUS;

--EMP 테이블에 저장된 사원 중 보너스가 NULL이 아닌 사원의 사원이름,업무,급여,보너스를
--검색하여 BONUS 테이블에 저장
INSERT INTO BONUS SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
COMMIT;
SELECT * FROM BONUS;

--UPDATE : 테이블에 저장된 데이타를 변경하는 명령
--형식) UPDATE 테이블명 SET 컬럼명=변경값,컬럼명=변경값,... [WHERE 조건식];
-- => WHERE 조건식이 생략되면 테이블에 저장된 모든 행의 컬럼값을 일괄적으로 변경
-- => WHERE의 조건식에서 사용되는 컬럼은 PK 제약조건이 부여된 컬럼을 사용하는 것을 권장

--부서코드가 50번인 부서정보를 검색
SELECT * FROM DEPT WHERE DEPTNO=50;--부서명:회계부,부서위치=서울

--부서코드가 50인 부서의 부서명을 경리부로 변경하고 부서위치는 부천으로 변경
-- => PK가 부여된 컬럼값은 변경하지 않는 것을 권장
UPDATE DEPT SET DNAME='경리부',LOC='부천' WHERE DEPTNO=50;
COMMIT;
SELECT * FROM DEPT WHERE DEPTNO=50;

--사원번호가 9000인 사원의 부서코드를 45로 변경
-- => FK가 부여된 컬럼값은 참조되는 다른 테이블의 컬럼값으로만 변경 가능
UPDATE EMP SET DEPTNO=45 WHERE EMPNO=9000;--에러 발생

--자재부의 부서위치를 총무부의 부서위치와 동일한 곳으로 변경
SELECT * FROM DEPT WHERE DNAME='자재부';--부서위치 : NULL
SELECT * FROM DEPT WHERE DNAME='총무부';--부서위치 : 수원

--변경 컬럼값으로 SUBQUERY 사용
UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='총무부') WHERE DNAME='자재부';
COMMIT;
SELECT * FROM DEPT WHERE DNAME='자재부';

--BONUS 테이블에서 ALEEN 보다 보너스가 적은 사원에게 200를 더하도록 변경
-- => WHERE에서 SUBQUERY 사용
SELECT * FROM BONUS;
UPDATE BONUS SET COMM=COMM+200 
    WHERE COMM<(SELECT COMM FROM BONUS WHERE ENAME='ALLEN');
COMMIT;
SELECT * FROM BONUS;

--DELETE : 테이블에 저장된 행을 삭제하는 명령
--형식) DELETE FROM 테이블명 [WHERE 조건식];
-- => WHERE 조건식이 생략되면 테이블에 저장된 모든 행 삭제
-- => WHERE의 조건식에서 사용되는 컬럼은 PK 제약조건이 부여된 컬럼을 사용하는 것을 권장

--부서테이블에서 부서코드가 90인 부서정보 삭제
SELECT * FROM DEPT WHERE DEPTNO=90;
DELETE FROM DEPT WHERE DEPTNO=90;
COMMIT;
SELECT * FROM DEPT WHERE DEPTNO=90;


--부서테이블에서 부서코드가 10인 부서정보 삭제
DELETE FROM DEPT WHERE DEPTNO=10;--에러 발생
--EMP 테이블의 DEPTNO 컬럼에 부여된 FK 제약조건은 DEPT 테이블의 DEPTNO 컬럼값 참조
--EMP 테이블에 DEPTNO 컬럼값이 참조하는 DEPT 테이블의 DEPTNO 컬럼값이 존재하는 
--행은 삭제되지 않는다. => 데이타 무결성 유지
SELECT * FROM EMP WHERE DEPTNO=10;

--EMP 테이블에 저장된 부서코드를 중복되지 않도록 검색
-- => 10,20,30,40 부서코드를 가진 부서정보는 DEPT 테이블에서 삭제되지 않는다.
SELECT DISTINCT DEPTNO FROM EMP;
DELETE FROM DEPT WHERE DEPTNO=20;--에러 발생
DELETE FROM DEPT WHERE DEPTNO=80;--삭제 가능
COMMIT;
SELECT * FROM DEPT;

--자재부와 동일한 위치에 있는 모든 부서정보 삭제(자재부 포함)
-- => WHERE에서 SUBQUERY 사용 가능
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE LOC=(SELECT LOC FROM DEPT WHERE DNAME='자재부');
COMMIT;
SELECT * FROM DEPT;

--MERGE : 타겟 테이블에 기존 테이블의 데이타로 동기화 할 때 사용하는 명령
-- => 조건에 따라 기존 테이블의 행을 타겟 테이블에 삽입하거나 변경하는 명령
--형식) MERGE INTO 타겟테이블 USING 기존테이블 ON (조건식)
--      WHEN MATCHED THEN UPDATE SET 타겟컬럼명=기존컬럼값,타겟컬럼명=기존컬럼값,...
--      WHEN NOT MATCHED THEN INSERT (타겟컬럼명,...) VALUES(기존컬럼값,...);

--MERGE_DEPT 테이블 생성 => 타겟테이블
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(10),LOC VARCHAR2(11));

--MERGE_DEPT 테이블에 행 삽입
INSERT INTO MERGE_DEPT VALUES(30,'총무부','서울');
INSERT INTO MERGE_DEPT VALUES(60,'자재부','인천');
COMMIT;
SELECT * FROM MERGE_DEPT;

--DEPT 테이블에 존재하는 부서정보로 MERGE_DEPT 테이블에 부서정보를 변경 또는 삽입
-- => 부서코드가 같은 부서정보가 있는 경우 DEPT 테이블의 부서명 및 위치로
--    MERGE_DEPT 테이블의 부서명 및 위치 변경
-- => 부서코드가 존재하지 않는 경우 DEPT 테이블의 부서정보를 MERGE_DEPT 
--    테이블에 부서정보로 삽입
SELECT * FROM DEPT;
SELECT * FROM MERGE_DEPT;

MERGE INTO MERGE_DEPT M USING DEPT D ON (M.DEPTNO=D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME=D.DNAME,M.LOC=D.LOC
    WHEN NOT MATCHED THEN INSERT (DEPTNO,DNAME,LOC) VALUES(D.DEPTNO,D.DNAME,D.LOC);
COMMIT;
SELECT * FROM MERGE_DEPT ORDER BY DEPTNO;