

-- ORDER BY: 특정 컬럼에 저장된 데이터를 이용하여 오름차순 정렬 또는 내림차순 정렬하여 검색
-- 형식) SELECT 검색 대상, ... FROM 테이블 [WHERE 조건식]
-- ORDER BY 컬럼명 {ASC||DESC}, 컬럼명 {ASC||DESC}

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO ASC;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY SAL DESC;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY ENAME;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO,HIREDATE FROM EMP ORDER BY HIREDATE;

SELECT EMPNO,ENAME,JOB,SAL*12 AS ANNUAL_SA FROM EMP ORDER BY ANNUAL_SA DESC;

-- 검색 대상을 INDEX로 표현 가능 => INDEX는 1부터 1씩 증가
SELECT EMPNO,ENAME,JOB,SAL*12 ANNUAL_SALARY FROM EMP ORDER BY 4 DESC;

-- 모든 사원의 요소를 부서코드로 오름차순 정렬하되
-- 부서코드가 같은 경우 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO,SAL DESC;

-- 급여가 3000이상인 사원의 사원번호,사원이름,업무,급여,부서코드를 부서코드로
-- 오름차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE SAL>=3000 ORDER BY DEPTNO;


-- 검색대상 : 사원번호,사원이름,업무,입사일,급여,부속코드 
-- 문제1. 사원이름이 SCOTT인 사원 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE ENAME = 'SCOTT';

-- 문제2. 급여가 1500이하인 사원 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE SAL <= 1500;

-- 문제3. 1981년도에 입사한 사원 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE HIREDATE LIKE '81%';

-- 문제4. 엄무가 SALESMAN이거나 MANAGER인 사원중 급여가 1500이상인 사원 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE JOB IN('SALESMAN','MANAGER') AND SAL >=1500;

--문제5.부서코드가 10인 사원 중 급여가 1000~3000인 사원 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE DEPTNO = 10 AND SAL BETWEEN 1000 AND 3000;

--문제6.사원이름이 C나 S로 시작되는 사원 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE ENAME LIKE 'C%' OR ENAME LIKE 'S%';

--문제7.부서코드가 30인 사원 중 보너스가 NULL이 아닌 사원 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO,COMM FROM EMP WHERE DEPTNO = 30 AND COMM IS NOT NULL;

--문제8.모든 사원을 업무로 오름차순 정렬하고 같은 경우 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP ORDER BY JOB ASC,SAL DESC;

--문제9.업무가 MANAGER인 사원을 급여로 내림차순 정렬하여 검색
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE JOB = 'MANAGER' ORDER BY SAL DESC;


-- 함수 (Function) : 데이터를 전달 받아 원하는 형태로 가공하여 반환하는 기능을 제공
--  => 단일행 함수 : 하나의 입력 데이터를 가공하여 결과를 반환하는 함수
--  => 그룹화 함수 : 여러 개의 입력 데이터를 가공하여 결과를 반환하는 함수

-- 단일행함수 : 문자함수, 숫자함수, 날짜함수, 일반함수, 변환함수
-- 문자함수 : 문자형 데이터를 가공하여 결과를 반환하는 함수
-- LOWER : 모든 문자를 소문자로 변환하여 반환하는 함수
-- UPPER : 모든 문자를 대문자로 변환하여 반환하는 함수
SELECT EMPNO,ENAME, LOWER(ENAME),UPPER(ENAME) FROM EMP;

-- 사원이름이 SMITH인 사원의 사원번호, 사원이름, 급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP WHERE ENAME = UPPER('SMiTH');

-- INITCAP: 첫번째 문자를 대문자로 변환하고 나머지 소문자로 변환하는 함수
SELECT EMPNO, ENAME, INITCAP(ENAME) FROM EMP WHERE EMPNO = 7369;

-- CONCAT : 문자를 서로 결합시켜 반환하는 함수
SELECT EMPNO, ENAME,JOB, CONCAT(ENAME,JOB) FROM EMP WHERE EMPNO = 7369;

-- || 기호와 동일
SELECT EMPNO, ENAME,JOB, ENAME || JOB FROM EMP WHERE EMPNO = 7369;

-- SUBSTR : 문자를 원하는 위치부터 갯수만큼 분리하여 반환하는 함수
SELECT EMPNO, ENAME, JOB, SUBSTR(JOB,6,3) FROM EMP WHERE EMPNO = 7499;

-- LENGTH : 문자의 갯수를 반환하는 함수
SELECT EMPNO, ENAME, LENGTH(ENAME) FROM EMP WHERE EMPNO = 7499;

-- INSTR : 시작 위치에서 원하는 문자를 찾아 INDEX를 반환하는 함수
SELECT EMPNO, ENAME, JOB, INSTR(JOB,'A') FROM EMP WHERE EMPNO = 7499;

-- INSTR : 두번째 위치에서 원하는 문자를 찾아 INDEX를 반환하는 함수
SELECT EMPNO, ENAME, JOB, INSTR(JOB,'A',1,2) FROM EMP WHERE EMPNO = 7499;

-- LPAD : 출력자릿수 및 왼쪽 채울 문자를 지정하여 결과를 반환하는 함수
-- RPAD : 출력자릿수 및 오른쪽 채울 문자를 지정하여 결과를 반환하는 함수
SELECT EMPNO, ENAME, SAL, LPAD(SAL,6,'*'),RPAD(SAL,6,'*') FROM EMP WHERE EMPNO = 7844;

-- TRIM : 앞 또는 뒤에 존재하는 특정 문자를 제거하여 반환하는 함수
SELECT EMPNO, ENAME , JOB, TRIM(LEADING 'S' FROM JOB), TRIM(TRAILING 'N' FROM JOB)
    FROM EMP WHERE EMPNO = 7844;

-- REPLACE : 특정 문자를 찾아 다른 문자로 변경하여 반환하는 함수
SELECT EMPNO, ENAME, JOB, REPLACE(JOB,'MAN','PERSON') FROM EMP WHERE EMPNO=7844;

-- 숫자 함수: 정수 또는 실수 데이터를 처리하기 위한 함수
-- ROUND : 숫자를 원하는 위치까지 검색하고 나머지로 반올림하여 반환하는 함수
SELECT ROUND(45.58,2), ROUND(45.58,0),ROUND(45.58,-1) FROM DUAL;

-- TRUNC : 숫자를 원하는 위치까지 검색하고 나머지는 버리고 반환하는 함수
SELECT TRUNC(45.65,1) FROM DUAL;

-- CEIL : 실수인 경우 정수로 변환하되 증가하여 반환하는 함수
SELECT CEIL(45.67),CEIL(-45.67) FROM DUAL;

-- FLOOR : 실수인 경우 정수로 변환하되 감소하여 반환하는 함수
SELECT FLOOR(45.67), FLOOR(-45.65) FROM DUAL;

-- MOD : 나머지 값을 반환하는 함수
SELECT 20/8, MOD(20,8) FROM DUAL;

--POWER : X의 Y승 값을 반환하는 함수
SELECT POWER(3,5) FROM DUAL;

-- 날짜함수 : 날짜와 시간에 관련된 함수
-- 오라클의 날짜형 내부적으로 날짜 및 시간정보를 저장하지만 표면적으로는 RR/MM/DD/ 형식으로
-- 표현된다.
SELECT EMPNO, ENAME, HIREDATE FROM EMP;

-- SYSDATE는 오라클 서버의 현재 날짜 및 시간 정보를 표현하기 위한 키워드
SELECT SYSDATE FROM DUAL;

-- 날짜 연산 : 오라클에서는 날짜형 데이터의 연산 가능
-- 날짜 + 숫자 = 날짜, 날짜 - 숫자 = 날짜
SELECT SYSDATE+500 FROM DUAL;
SELECT SYSDATE-400 FROM DUAL;

-- 날짜 + 숫자/24 = 날짜 숫자는 시간을 말한다.
SELECT SYSDATE - 17/24 FROM DUA;

-- 날짜 - 날짜 = 숫자가 나온다. 6404일 이 지났다.
SELECT SYSDATE - TO_DATE('91/03/31') FROM DUAL;

SELECT EMPNO,ENAME,HIREDATE,CEIL(SYSDATE-HIREDATE) || '일' AS "근속일수" FROM EMP;

-- ADD_MONTHS : 날짜에 개월수를 더하여 반환하는 함수
SELECT SYSDATE, ADD_MONTHS(SYSDATE,5) FROM DUAL;

-- NEXT_DAY : 특정 요일에 대한 다음 날짜를 반환하는 메소드
SELECT SYSDATE, NEXT_DAY(SYSDATE,'토') FROM DUAL;

-- 언어 세션(작업 환경)
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';
SELECT SYSDATE, NEXT_DAY(SYSDATE,'SUN') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

-- TRUNC : 원하는 단위의 날짜까지만 검색하고 나머지는 1로 초기화 하여 반환하는 함수
SELECT SYSDATE, TRUNC(SYSDATE,'MONTH'), TRUNC(SYSDATE, 'YEAR') FROM DUAL;

-- 변환 함수: 오라클의 데이터 타입을 변환하는 함수
-- TO_NUMBER : 문자형 데이터를 숫자형 데이터로 변환하여 반환하는 함수
--  => 강제 형변환(명시적 형변환)
SELECT EMPNO, ENAME ,SAL FROM EMP WHERE EMPNO = TO_NUMBER('7839');

-- 숫자형 데이터를 저장된 컬럼값을 문자형 데이터와 비교할 경우 자동으로 문자형 데이터를
-- 숫자형 데이터 자동 변환하여 비교 => 자동 현변환 (묵시적 형변환)
SELECT EMPNO, ENAME ,SAL FROM EMP WHERE EMPNO = '7839';

-- 묵시적 형변환으로 인해 TO_NUMBER가 잘 안쓰인다.
SELECT 5000-'1000' FROM DUAL;

-- TO_DATE : 문자형 데이터를 날짜형 데이터로 변환하여 반환하는 함수
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('82/01/23');
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = '82/01/23';

-- 날짜형 데이터를 연산할 경우 반드시 문자형 데이터를 날짜형 데이터로 변환해야만 연산
SELECT SYSDATE, FLOOR(TO_DATE('17/12/07')- SYSDATE)||'일' "남은 일수" FROM DUAL;

-- 오라클의 날짜형은 기본적으로 RR/MM/DD 형식으로 표현
-- TO_DATE 함수를 이용하여 원하는 날짜 형식의 패턴으로 표현
SELECT SYSDATE, FLOOR(TO_DATE('2017-12-07','YYYY-MM-DD') - SYSDATE)||'일' "남은 일수" FROM DUAL;

-- TO_CHAR : 숫자형 데이터 또는 날짜형 데이터를 원하는 패턴의 문자형 데이터로 변환하는 함수
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-- 모든 사원의 사원번호, 사원이름, 입사일(년-월-일) 검색
SELECT EMPNO,ENAME, TO_CHAR(HIREDATE,'YYYY-MM-DD') HIREDATE FROM EMP;

-- 1981년도에 입사한 사원의 사원번호,사원이름,입사일 검색
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY') = 1981;

-- 숫자형 데이터를 변환 할 때 제공하는 패턴은 0또는 9 사용
SELECT TO_CHAR(1000000,'999,999,990') FROM DUAL;

SELECT EMPNO, ENAME, TO_CHAR(SAL,'999,990') SAL FROM EMP;

SELECT EMPNO, ENAME, TO_CHAR(SAL,'L999,990') SAL FROM EMP;

SELECT EMPNO, ENAME, TO_CHAR(SAL,'$999,990.00') SAL FROM EMP;

-- 일반함수 : 조건에 따른 데이터 처리 함수
-- 모든 사원에 사원번호, 사원이름, 연봉((급여+보너스)*12) 검색
-- 보너스가 NULL인경우 연산결과가 NULL이 발생
SELECT EMPNO,ENAME,(SAL+NVL(COMM,0))*12 ANNUAL_SALARY FROM EMP;

-- NVL : 컬럼에 저장된 데이터가 NULL인 경우 원하는 데이터로 변환하여 반환하는 함수

-- NVL2 : 컬럼에 저장된 데이터가 NULL이 아닌 경우에 사용값과 NULL인 경우 사용값을 
--  구분 후 변환하여 반환하는 함수
SELECT EMPNO,ENAME,(SAL+NVL2(COMM,COMM,0))*12 ANNUAL_SALARY FROM EMP;

-- DECODE : 컬럼에 저장된 데이터를 비교하여 같은 경우 특정 데이터를 변환하여 반환하는 함수
-- 모든 사원에 사원번호, 사원이름, 급여, 업무별 실지급액 검색
-- 업무별 실지급액 : 업무별로 급여를 계산하여 지급할 급여
-- => ANALYST : 급여 * 1.1 CLERK : 급여 * 1.2 MANAGER: 급여*1.3 PRESIDENT: 급여 *1.4 SALESMAN:급여*1.5
SELECT EMPNO, ENAME, JOB,SAL, DECODE(JOB,'ANALYST',SAL*1.1, 'CLERK',SAL*1.2, 'MANAGER',SAL*1.3, 'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5,SAL) "실지급액" FROM EMP;

-- 엄무별 급여 현황 검색
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

-- F5번에서 표형식으로 보여주기 위해 사용
SELECT EMPNO,ENAME,DECODE(JOB,'ANALYST',SAL) "ANALYST",
            DECODE(JOB,'CLERK',SAL) "CLERK",
            DECODE(JOB,'MANAGER',SAL) "MANAGER",
            DECODE(JOB,'PRESIDENT',SAL) "PRESIDENT",
            DECODE(JOB,'SALESMAN',SAL) "SALESMAN"FROM EMP;


-- 문제1 사원테이블에서 입사일이 12월인 사원의 사번,사원명,입사일 검색
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM') = '12';

-- 문제2 다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "급여" FROM EMP;

-- 문제3 다음과 같은 결과를 검색할 수 있는 SQL 문장을 작성하시오.
SELECT EMPNO,ENAME,TO_CHAR(HIREDATE,'YYYY-MM-DD') "입사일" FROM EMP;


