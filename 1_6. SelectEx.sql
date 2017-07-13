-- 설명문 처리

-- 워크 시트의 SQL 명령 실행 : ctrl + enter 
-- 현재 커서가 위치한 행의 명령을 실행하거나 블럭 영역 실행
-- F5 : 전체 위크시트의 명령을 실행하거나 블럭영역의 명령 실행

-- 현재 로그인 계정이 사용할 수 있는 테이블(데이터를 저장하기 위한 객체) 목록 확인
select table_name from tabs;
select * from tab;

-- 테이블의 구조(속성) 확인 => 형식) DESC 테이블명;
desc emp;
desc dept;

-- NUMBER(4) 0~9999 NUMBER(7,2) xx.xx
-- VARCHAR2(10) 10글자
-- NOT NULL 기본키

-- select : 하나 이상의 테이블에서 데이터를 검색하기 위한 명령어 (DQL: DATA QUERY LANGUAGE)
-- 형식) select 검색대상, 검색대상, ... from 테이블명;
-- 검색대상 : * (모두), 컬럼명, 연산식, 함수, 
select * from emp;
select empno,ename,sal,deptno from emp;

-- 컬럼 ALIAS : 컬럼에 별명을 부여하는 기능 (컬럼명을 단순화 하거나 명확한 의미를 부여)
-- 형식) select 검색대상 [as] 별명,검색대상 [as] 별명,... From 테이블명;
--       컬럼 ALIAS 사용시 공백 또는 특수기호를 사용해야 할 경우 " " 안에 표현
select empno as 사원번호,ename as 사원이름,sal as "급  여", deptno as 부서코드 from emp;

-- 검색대상으로 연산식 사용 가능 => 연산식에 대한 컬럼명 대신 칼럼 ALIAS 사용
-- DUAL : 테이블이 필요없는 검색 명령일 경우 사용하는 가상의 테이블
SELECT 20+10 FROM DUAL;
SELECT 20+10 RESULT FROM DUAL;

DESC DUAL;

-- EMP 테이블에서 사원번호, 사원이름, 연봉 검색
-- SQL에서는 식별자를 작성할때 단어와 단어의 구분자로 _를 사용한다.
select empno, ename, sal*12 ANNAUL_SALARY from emp;

-- 컬럼의 제약조건 중 NOT NULL이 부여된 컬럼인 경우 NULL이 저장되지 않지만
-- NOT NULL 제약조건이 없는 칼럼에는 NULL을 저장할 수 있다.
desc emp;
select * from emp;

-- emp 테이블에서 모든 사원의 사원번호, 사원이름, 연봉((급여+보너스) * 12) 검색
-- null은 연산 불가능 => 보너스가 null 인 사원의 연봉은 null로 검색(검색 오류)
select empno, ename, (sal+comm)*12 ANNAUL_SALARY from emp;

-- 검색대상에 대한 결과를 || 기호(문자열 결합)를 이용하여 연결 사용 가능
-- ORACLE에서는 문자형 상수 또는 날짜형 상수 ' ' 안에 표현
select ename||' 님의 엄무는 '|| job || '입니다.' as "사원의 업무" from emp;

-- 모든 사원의 엄무 검색 => 중복 결과값 검색
-- DISTINCT 중복 값을 배제 하나값만 출력
select distinct job from emp;

-- ORACLE은 두개 이상의 컬럼에 DISTINCT 키워드를 이용하여 검색이 가능
select distinct job,DEPTNO from emp;

-- WHERE : 조건식을 사용하여 결과가 참(TRUE)인 행(ROW)만 검색
-- 형식) SELECT 검색대상,... FROM 테이블명 WHERE 조건식

-- 모든 사원의 사원번호, 사원이름, 업무, 금여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP;

-- 사원번호가 7698인 사원의 사원번호, 사원이름, 엄무, 금여 검색
-- 조건식에서 가장 많이 사용하는 컬럼은 PK 제약조건이 부여된 컬럼
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE EMPNO = 7369;

-- 사원이름이 KING 인 사원의 사원번호, 사원이름, 업무, 급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME = 'KING';

-- SQL 명령은 대소문자를 구분하지 않지만 문자형 상수는 대소문자를 구분한다.(주의)

-- 입사일이 1981년 6월 9일 사원의 사원번호, 사원이름, 업무, 급여, 입사일 검색
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE FROM EMP WHERE HIREDATE = '81/06/09';
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE FROM EMP WHERE HIREDATE = '1981-06-09';

-- 사원의 엄무가 SALESMAN이 아닌 사원의 사원번호, 사원이름, 업무, 급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB != 'SALESMAN';
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB <> 'SALESMAN';

-- 사원의 급여가 2000이상인 사원의 사원번호, 사원이름, 업무, 급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL>=2000;

-- 문자형 또는 날짜형 데이터도 크기를 비교할 수 있다.
-- 사원의 입사일이 1981년 5월 1일 사원의 사원번호, 사원이름, 업무, 급여, 입사일 검색
SELECT EMPNO, ENAME, JOB, SAL,HIREDATE FROM EMP WHERE HIREDATE < '81/05/01';

-- 엄무가 SALESMAN인 사원 중 급여가 2500 이상 사원의 사원번호, 사원이름, 업무, 급여
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB = 'SALESMAN' AND SAL >= 1500;

-- 부서코드가 10이거나 엄무가 MANAGER인 사원의 사원번호, 사원이름, 업무, 급여, 부서코드
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE DEPTNO=10 OR JOB ='MANAGER';

-- 급여가 1500~3000인 사원의 사원번호, 사원이름, 업무, 급여
SELECT EMPNO, ENAME JOB, SAL FROM EMP WHERE SAL >=1500 AND SAL <=3000;

-- 범위 연산자 : 값1 ~ 값2를 표현하기 위한 연산자
-- 형식) 컬럼명 BETWEEN 작은값 AND 큰값
SELECT EMPNO, ENAME JOB, SAL FROM EMP WHERE SAL BETWEEN 1500 AND 3000;

-- 업무가 SALESMAN이거나 ANALYST인 사원의 사원번호,사원이름,업무,급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB = 'SALESMAN' OR JOB = 'ANALYST';

-- 선택 연산자 : 컬럼에 저장된 데이터가 여러 개의 데이터 중 하나인지를 확인하기 위한 연산자
-- 형식) 컬럼명 IN (값1, 값2, ...)
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB IN('SALESMAN', 'ANALYST');

-- 사원이름이 ALLEN인 사원의 사원번호, 사원이름, 업무, 급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME = 'ALLEN';

-- 사원이름이 A로 시작되는 사원의 사원번호, 사원이름,업무,급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME >= 'A' AND ENAME <'B';

-- 검색 패턴 기호: 데이터를 검색할 때 사용하는 검색 기호 => % : 전체 _ 문자하나
-- 검색패턴기호를 사용할 경우 = 연산자를 사용하면 검색되지 않는다. (검색패턴기호를 문자로 인식)
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME = 'A%';

-- 패턴 연산자 : 검색 패턴 기호를 이용하여 검색하고자 할 경우 사용하는 연산자
-- 형식) 컬럼명 LIKE '값 또는 검색패턴기호'
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE 'A%';


-- => = 연산자 대신 LIKE 연산자 사용 가능
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE 'ALLEN';

-- 사원이름에 A문자가 있는 사원 사원번호, 사원이름,업무,급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE '%A%';

-- 사원이름 두번째 문자가 L사원의 사원번호, 사원이름,업무,급여 검색
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE '__L%';

-- EMP 테이블에 새로운 사원 추가
INSERT INTO EMP VALUES(9000,'M_BEER','CLERK',7788,'81/12/12',1300,NULL,10);

COMMIT;

SELECT *FROM EMP WHERE EMPNO=9000;

-- 사원이름에 _바가 존재하는 사원 검색
-- => LIKE 연산자는 % 또는 _를 문자가 아닌 검색 패턴 기호로 인식
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE '%\_%' ESCAPE '\';

--% 또는 _를 문자로 인식 시키기 위해 ESCAPE 키워드 사용
-- => ESCAPE 키워드로 구분문자를 선언하면 검색패턴 기호가 아닌 문자로 인식

-- EMP 테이블에 저장된 사원 삭제
DELETE FROM EMP WHERE EMPNO = 9000;

COMMIT;

SELECT * FROM EMP WHERE EMPNO =9000;

-- 업무가 SALESMAN이 아닌 사원의 사원번호, 사원이름, 업무, 급여 검색
-- NOT 연산자
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE NOT(JOB ='SALESMAN');

-- 보너스가 NULL인 사원의 사원번호, 사원이름, 업무, 급여 , 보너스 검색
-- => NULL은 비교 연산자를 이용하여 조건식 작성 불가능
-- IS [NOT] 연산자 : 컬럼에 저장된 데이터가 NULL인 경우 비교하기 위한 연산자
SELECT EMPNO, ENAME, JOB, SAL,COMM FROM EMP WHERE COMM IS NOT NULL;










