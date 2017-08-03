
-- 그룹함수 : 여러 개의 데이터를 입력받아 처리하여 결과를 반환하는 함수 

-- COUNT: 특정 컬럼에 저장된 데이터의 개수를 계산하여 반환하는 함수
SELECT COUNT(EMPNO) FROM EMP;

-- 그룹함수 사용시 다른 검색대상과 같이 사용할 수 없다.
-- EMPNO,ENAME은 14개의 행의 값이 나오고 EMPNO은 한개의 행의 값이 나오기 때문에 컴파일 에러
SELECT EMPNO,ENAME,COUNT(EMPNO) FROM EMP;

-- 그룹함수는 NULL을 데이터로 인식하지 않는다.
SELECT COUNT(COMM) FROM EMP;

-- COUNT 함수는 컬럼명 대신 *를 사용할 수 있다.
-- COUNT 그룹함수만 * 모든 컬럼이 가능하다.
--  => 테이블에 저장된 행의 갯수 반환
SELECT COUNT(*) FROM EMP;

-- MAX : 컬럼에 저장된 데이터 중 가장 큰 값을 반환하는 함수
SELECT MAX(SAL) FROM EMP;
SELECT MAX(ENAME) FROM EMP; -- A~Z , a가 A보다 크다. 한글이 영문보다 크다
SELECT MAX(HIREDATE) FROM EMP; -- 늦게 들어온 사람

-- MIN : 컬럼에 저장된 데이터 중 가장 작은 값을 반환하는 함수
SELECT MIN(SAL) FROM EMP;
SELECT MIN(ENAME) FROM EMP;
SELECT MIN(HIREDATE) FROM EMP; -- 먼저 들어온 사람

-- SUM : 컬럼에 저장된 데이터들의 합계 계산하여 반환
--      파라미터로 숫자형만 가능
SELECT SUM(SAL) FROM EMP;

-- AVG : 컬럼에 저장된 데이터들의 평균 계산하여 반환
--      파라미터로 숫자형만 가능
SELECT TO_CHAR(AVG(SAL),'$999,990.99') FROM EMP;
SELECT ROUND(AVG(SAL),2) FROM EMP;

-- 보너스가 NULL 아닌 사원들의 평균이 된다.
SELECT AVG(COMM) FROM EMP;

-- 모든 사원의 보너스 평균 검색
SELECT CEIL(AVG(NVL(COMM,0))) "평균보너스" FROM EMP;

-- 테이블에 저장된 모든 사원의 인원 수 검색
SELECT COUNT(*) FROM EMP;

-- 부서별 사원의 인원수
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 10;
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 20;
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 30;

-- GROUP BY : 그룹 함수 사용시 사용 가능 하며 컬럼에 저장된 데이터를 이용하여
-- 그룹을 세분화 하기 위해 사용 => 저장된 데이터가 같은 경우 같은 그룹으로 인식
-- 컬럼명 대신에 함수 또는 연산식 사용 가능하지만 ALIAS 이름은 사용 불가능
-- 형식) SELECT 검색대상(그룹함수), ... FROM 테이블명 [WHERE 조건식] 
--         GROUP BY 컬럼명 [ORDER BY 컬럼명 {ASC | DESC},...]
-- 부서별 사원의 인원수 검색 => 부서코드가 같은 경우 같은 그룹으로 인식
-- 검색 되는 행의 갯수가 동일하다, DEPTNO, COUNT(*) , GROUP BY 로 인한
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO;

-- 업무별 평균 급여를 계산하여 검색
SELECT JOB, TO_CHAR(AVG(SAL),'$999,990.99') FROM EMP GROUP BY JOB;
                
-- 엄무가 PRESIDENT인 사원을 제외한 엄무별 평균 급여 계산하여 검색
SELECT JOB, TO_CHAR(AVG(SAL),'$999,990.99') FROM EMP WHERE JOB != 'PRESIDENT' GROUP BY JOB;

-- 엄무가 PRESIDENT인 사원을 제외한 엄무별 평균 급여를 내림차순 계산하여 검색
SELECT JOB, TO_CHAR(AVG(SAL), '$999,990.99') AVG_SAL FROM EMP WHERE JOB != 'PRESIDENT' GROUP BY JOB ORDER BY AVG_SAL ASC;

-- HAVING : 그룹 함수가 나왔을 경우 특히 GROUP BY 가 나왔을 경우
--          GROUP BY와 같이 사용하며 그룹에 대한 조건을 부여하여 검색하는 기능
-- 형식) SELECT 검색대상(그룹함수), ... FROM 테이블명 [WHERE 조건식] 
--         GROUP BY 컬럼명 HAVING 그룹조건 [ORDER BY 컬럼명 {ASC | DESC},...] 

-- 부서별 급여 합계 계산하여 검색
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO;

-- 부서별 급여 합계를 계산하여 급여 합계가 9000이상인 부서 검색
-- 그룹별로 검색을 한후 그룹별로 조건을 걸로 싶을 때 HAVING 절 사용
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) >= 9000;


-- 문제1. 사원 테이블에서 부서별 인원수가 6명 이상인 부서코드 검색
SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*) >= 6;

-- 문제2. 사원 테이블로 부터 부서번호, 업무별 금여 합계를 계산하고자 한다.
--          다음과 같은 결과를 출력 할 수 있는 SQL 문장 작성은?
SELECT DEPTNO, SUM(DECODE(JOB,'CLERK',SAL)) CLERK, SUM(DECODE(JOB,'MANAGER',SAL)) MANAGER,SUM(DECODE(JOB,'PRESIDENT',SAL)) PRESIDENT,
             SUM(DECODE(JOB,'ANALYST',SAL)) ANALYST, SUM(DECODE(JOB,'SALESMAN',SAL)) SALESMAN FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

-- 문제3. 사원테이블로부터 년도별, 월별 급여합계를 출력할 수 있는 SQL문장 작성
SELECT TO_CHAR(HIREDATE,'YYYY') 년,TO_CHAR(HIREDATE,'MM') 월,SUM(SAL) FROM EMP GROUP BY  TO_CHAR(HIREDATE,'YYYY'),TO_CHAR(HIREDATE,'MM') ORDER BY 년,월;

-- 문제4. 사원테이블에서 부서별 COMM(커미션) 을 포함하지 않은 연봉의 합과 포함한
--        연봉의 합을 구하는 SQL을 작성 하시오.
--SELECT DEPTNO, SUM(SAL*12) FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO ASC;
SELECT DEPTNO, SUM((SAL+NVL(COMM,0))*12) FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO ASC;

-- 문제5. 사원테이블에서 SALESMAN을 제외한 JOB별 급여 합계
SELECT JOB,SUM(SAL) FROM EMP WHERE JOB != 'SALESMAN' GROUP BY JOB; -- 권장
SELECT JOB,SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB != 'SALESMAN'; -- 비권장
-- 위에 꺼는 테이블 4개의 그룹을 해준다.
-- 아래 꺼는 테이블 5개의 그룹에서 제외한다.

-- 분석함수: 윈도우 함수(그룹함수, 순위함수, 순서함수, ...)에 의해 발생된 결과를 
-- 분석하여 반환하는 함수
-- 형식) SELECT 윈도우 함수 OVER([PATITION BY 컬럼명] [ORDER BY 컬럼명] [WINDOWING]) FROM 테이블명 [WHERE 조건식] 
--         [GROUP BY 컬럼명] [HAVING 그룹조건식] [ORDER BY 컬럼명 {ASC | DESC},...] 
    
-- 모든 사원 중 가장 많은 급여를 받는 사원의 급여를 검색
SELECT MAX(SAL) FROM EMP;

-- 모든 사원 중 가장 많은 급여를 받는 사원의 사원번호,사원이름,급여 검색
-- => 그룹함수는 다른 검색대상과 같이 사용할 수 없다.
SELECT EMPNO,ENAME,MAX(SAL) FROM EMP; -- 에러 발생

-- 그룹함수를 분석함수와 같이 사용하면 다른 검색대상를 사용할 수 있다.
SELECT EMPNO,ENAME,SAL,MAX(SAL) OVER () FROM EMP;

-- 부서별 평균급여 검색
SELECT DEPTNO, CEIL(AVG(SAL)) "평균급여" FROM EMP GROUP BY DEPTNO;

-- 모든 사원의 사원번호, 사원이름, 급여, 부서 평균급여 검색
-- OVER 함수를 사용하면 GROUP BY 사용 불가능
-- OVER 함수 안에 PARTITION BY를 사용하면 GROUP BY와 동일한 역활 수행
SELECT EMPNO,ENAME,SAL,DEPTNO,CEIL(AVG(SAL) OVER(PARTITION BY DEPTNO)) "부서평균급여" FROM EMP;

-- 모든 사원의 사원번호, 사원이름, 급여, 누적 급여 합계를 급여로 오름차순 정렬하여 검색
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL ASC) "급여 합계" FROM EMP;

-- 모든 사원의 사원번호, 사원이름, 급여, 부서코드, 부서누적급여합계 검색
SELECT EMPNO,ENAME,SAL,DEPTNO, SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL ASC) FROM EMP;

-- 모든 사원의 사원번호, 사원이름, 급여, 누적급여 합계 검색
-- => 급여가 동일한 경우 누적급여 합계가 한번에 계산되어 않도록 검색
-- => OVER 함수 안에 WINDOWING 기능을 이용하면 현재 검색행을 기준으로 검색 하고자 하는 
--    행 또는 범위를 지정하여 검색을 할 수 있다.
-- => ROWS UNBOUNDED PRECEDING : 검색행을 기준으로 이전에 존재하는 모든 행을 지정
SELECT EMPNO,ENAME,SAL,DEPTNO, SUM(SAL) OVER (ORDER BY SAL ASC ROWS UNBOUNDED PRECEDING) "누적급여합계" FROM EMP;


-- 모든 사원의 급여로 오름차순 정렬하여 사원번호, 사원번호, 사원이름, 급여, 검색 사원의 앞 사원과 
-- 뒷사원의 급여 합계를  계산하여 검색
-- => ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING : 검색행을 기준으로 이전 1행과 이후 1행에 대한 검색
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) FROM EMP;

-- 모든 사원의 급여로 오름차순 정렬하여 사원번호, 사원번호, 사원이름, 급여, 검색 사원의 급여보다
-- 100작거나 200 큰 사원의 인원수 검색
SELECT EMPNO,ENAME,SAL,COUNT(*) OVER(ORDER BY SAL RANGE BETWEEN 100 PRECEDING AND 200 FOLLOWING)-1 "인원수" FROM EMP; 

-- 순위 함수 : RANK, DENSE_RANK, ROW_NUMBER
-- 모든 사원의 사원번호,사원이름,급여를 급여순으로 내림차순 정렬하여 검색
SELECT EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC;

-- RANK() : 데이터가 같은 경우 같은 순위 지정 후 순위를 건너 띄어 지정
SELECT RANK() OVER(ORDER BY SAL DESC) "랭킹", EMPNO, ENAME, SAL FROM EMP;
-- 가장 많이 팔린 제품 10개

-- DENSE_RANK() : 데이터가 같은 경우 순위 지정 후 순위 지정
SELECT DENSE_RANK() OVER(ORDER BY SAL DESC) "랭킹", EMPNO, ENAME, SAL FROM EMP;

-- ROW_NUMBER() : 데이터가 같은 경우에도 다른 순의 지정 => 행 번호
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "랭킹", EMPNO, ENAME, SAL FROM EMP;

-- 순서 함수 : FIRST_VALUE, LAST_VALUE, LAG, LEAD
-- 모든 사원을 급여로 내림 차순 정렬하여 사원번호, 사원이름, 급여, 급여를 가장많이 받는
-- 사원이름과 급여를 가장 적게 받는 사원이름 검색
SELECT EMPNO,ENAME,SAL,FIRST_VALUE(ENAME) OVER(ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) MAX_NAME,
        LAST_VALUE(ENAME) OVER(ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) MIN_NAME FROM EMP;

-- LAG: 검색행의 앞부분에 데이터를 얻고자 할 경우
-- LEAD: 검색행의 뒤부분에 데이터를 얻고자 할 경우
-- 모든 사원을 급여로 내림차순 정렬하여 사원번호,사원이름,급여,검색사원의 앞 사원의
-- 급여와 검색사원의 뒷 사원 급여를 검색
--  => 앞 또는 귓 사원이 없을 경우 급여는 0으로 검색
-- 앞글 뒷글에 제목 이름
SELECT EMPNO,ENAME,SAL,LAG(SAL,1,0) OVER(ORDER BY SAL DESC) "앞사원 급여",LEAD(SAL,1,0)  OVER(ORDER BY SAL DESC) "뒷사원 급여" FROM EMP;

-- JOIN : 두 개 이상의 테이블에서 원하는 데이터를 검색하기 위한 기술

-- 모든 사원의 사원번호, 사원이름, 급여, 부서코드 검색
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

-- 모든 부서의 부서코드, 부서명, 위치 검색
SELECT DEPTNO, DNAME, LOC FROM DEPT;

-- 모든 사원의 사원번호,사원이름,급여,부서명 검색
--  => 테이블을 JOIN 하여 검색하기 위해서는 JOIN 조건이 반드시 필요
--  => 카테시안 프로덕트 : JOIN 조건이 없거나 잘못된 JOIN 조건을 사용할 경우 => 부적절한 JOIN
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP,DEPT;


-- EQUI JOIN : JOIN 조건이 맞는 행을 연결하여 검색
-- JOIN 하고자 하는 테이블에서 검색하고자 하는 컬럼은 테이블명 명시
-- 형식) 테이블명.컬럼명 => 테이블이름은 생략 가능하다.
-- JOIN 하고자 하는 테이블에 동일한 컬럼명이 존재할 경우 반드시 테이블명을 명시해야만
-- 된다. 
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 모든 사원의 사원번호,사원이름,급여,부서코드,부서명 검색
-- 모호할 경우 지정을 해주어야 한다.
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 모든 사원의 사원번호,사원이름,급여, 사원 부서코드, 부서 부서코드, 부서명 검색
--  => 동일한 컬럼명을 검색할 경우 두번째 컬럼은 컬럼명_숫자 형식으로 컬럼명이 자동 변경
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DEPT.DEPTNO,DNAME FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

--  => 동일한 컬럼명을 검색할 경우에는 컬럼명 ALIAS 설정하여 검색하는 것을 권장
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO "EMP.DEPTNO",DEPT.DEPTNO "DEPT.DEPTNO",DNAME 
    FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- 테이블 ALIAS : 테이블을 JOIN 할 경우 테이블에 별명을 부여하는 기능
--  => JOIN 할 때 테이블명을 명시해야 될 경우 보다 쉽게 사용할 수 있도록
--      부여하는 기능
--      형식) 테이블명 별명

SELECT EMPNO,ENAME,SAL,E.DEPTNO "E.DEPTNO",D.DEPTNO "D.DEPTNO",DNAME 
    FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO;

-- 테이블 ALIAS 기능 설정 후 실제 테이블명을 사용할 경우에는 에러 발생
SELECT EMPNO,ENAME,SAL,E.DEPTNO "E.DEPTNO",D.DEPTNO "D.DEPTNO",DNAME 
    FROM EMP E,DEPT D WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- NON-EQUI JOIN : JOIN 조건이 명확하게 일치 하지 않아도 되는 조인   
-- 모든 사원의 사원번호,사원이름,급여 검색
SELECT EMPNO,ENAME,SAL FROM EMP;

-- SALGRADE 테이블 : 급여 등급 테이블
SELECT * FROM SALGRADE;

-- 모든 사원의 사원번호,사원이름,급여,급여등급 검색
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP,SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

-- OUTER JOIN : 테이블을 JOIN 할 경우 JOIN 조건이 맞지 않는 경우 데이터도 같이 검색
-- 되도록 JOIN 시키는 기능 => JOIN 조건이 맞지 않는 경우에는 NULL로 검색
SELECT DISTINCT DEPTNO FROM EMP; -- 10,20,30

SELECT DEPTNO FROM DEPT; -- 10,20,30 부서코드 검색

SELECT * FROM DEPT WHERE DEPTNO = 40;

-- 모든 사원의 사원번호,사원이름,급여,부서코드,부서명 검색
--  => 40번 부서에 근무하는 사원이 존재하지 않음으로 검색되지 않는다.
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO;

-- JOIN 조건이 맞지 않아도 검색되도록 하기 위해 OUTER JOIN 사용
--  => JOIN 조건에 (+)를 사용한 테이블에 JOIN 조건이 맞지 않는 경우 NULL 검색
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME FROM EMP E,DEPT D WHERE E.DEPTNO(+) = D.DEPTNO;
-- 잘못된 데이터가 있는지 검사하기 위해 데이터 무결성 검사

-- 모든 사원의 사원번호, 사원이름, 매니져 번호 검색
SELECT EMPNO,ENAME,MGR FROM EMP;

-- 모든 사원의 사원번호, 사원이름, 매니져 이름 검색
--  => SELF JOIN : 하나의 테이블을 두개의 테이블로 ALIAS하여 JOIN 하는 기능
SELECT WORKER.EMPNO, WORKER.ENAME WOKER_ENAME, MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER, EMP MANAGER WHERE WORKER.MGR = MANAGER.EMPNO;

-- => OUTER JOIN : KING 사원 포함
SELECT WORKER.EMPNO, WORKER.ENAME WOKER_ENAME, MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER, EMP MANAGER WHERE WORKER.MGR = MANAGER.EMPNO(+);

-- SALES 부서에 근무하는 사원의 사원번호,사원이름,급여,부서명 검색
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO AND DNAME = 'SALES';

--1999 JOIN : 1999에 채택된 표준 SQL에 추가된 JOIN 명령

--CROSS JOIN : JOIN 조건이 존재하지 않는 JOIN
--형식) SELECT 검색대상,... FROM 테이블명1 CROSS JOIN 테이블명2;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP CROSS JOIN DEPT;

--NATURAL JOIN : JOIN 하고자 하는 테이블에 동일한 컬럼명을 하나 가지고 있는 경우
--컬럼에 저장된 데이타를 이용하여 JOIN 기능
--형식) SELECT 검색대상,... FROM 테이블명1 NATURAL JOIN 테이블명2;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP NATURAL JOIN DEPT;

--JOIN~USING : JOIN 하고자 하는 테이블에 동일한 컬럼명을 여러 개 가지고 있는 경우
--특정 동일 컬럼에 저장된 데이타를 이용하여 JOIN 기능
--형식) SELECT 검색대상,... FROM 테이블명1 JOIN 테이블명2 USING(컬럼명);
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT USING(DEPTNO);

--JOIN~ON(INNER JOIN) : JOIN 하고자 하는 테이블의 JOIN 조건을 ON 뒤에 작성하는 JOIN
--형식) SELECT 검색대상,... FROM 테이블명1 JOIN 테이블명2 ON JOIN조건;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--모든 사원의 사원번호,사원이름,급여,급여등급 검색
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL; 

--SALES 부서에 근무하는 사원의 사원번호,사원이름,급여,부서명 검색
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D 
    ON E.DEPTNO=D.DEPTNO WHERE DNAME='SALES';

--OUTER JOIN : JOIN 조건이 맞지 않는 데이타도 검색
-- => LEFT JOIN,RIGHT JOIN,FULL JOIN

--모든 사원의 사원번호,사원이름,급여,부서명 검색
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
SELECT * FROM DEPT;--40번 부서 누락 => JOIN 조건에 맞지 않아 검색되지 않는다.

--모든 사원의 사원번호,사원이름,급여,부서명 검색 => 모든 부서 검색(RIGHT JOIN)
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E LEFT JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E RIGHT JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E FULL JOIN DEPT D ON E.DEPTNO=D.DEPTNO;

--모든 사원의 사원번호,사원이름,매니저이름 검색
-- => KING 사원의 정보 누락되어 검색
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;
    
--모든 사원의 사원번호,사원이름,매니저이름 검색 => KING 사원 검색
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER LEFT JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;
