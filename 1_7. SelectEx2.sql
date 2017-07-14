

-- ORDER BY: Ư�� �÷��� ����� �����͸� �̿��Ͽ� �������� ���� �Ǵ� �������� �����Ͽ� �˻�
-- ����) SELECT �˻� ���, ... FROM ���̺� [WHERE ���ǽ�]
-- ORDER BY �÷��� {ASC||DESC}, �÷��� {ASC||DESC}

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO ASC;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY SAL DESC;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY ENAME;

SELECT EMPNO,ENAME,JOB,SAL,DEPTNO,HIREDATE FROM EMP ORDER BY HIREDATE;

SELECT EMPNO,ENAME,JOB,SAL*12 AS ANNUAL_SA FROM EMP ORDER BY ANNUAL_SA DESC;

-- �˻� ����� INDEX�� ǥ�� ���� => INDEX�� 1���� 1�� ����
SELECT EMPNO,ENAME,JOB,SAL*12 ANNUAL_SALARY FROM EMP ORDER BY 4 DESC;

-- ��� ����� ��Ҹ� �μ��ڵ�� �������� �����ϵ�
-- �μ��ڵ尡 ���� ��� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP ORDER BY DEPTNO,SAL DESC;

-- �޿��� 3000�̻��� ����� �����ȣ,����̸�,����,�޿�,�μ��ڵ带 �μ��ڵ��
-- �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,SAL,DEPTNO FROM EMP WHERE SAL>=3000 ORDER BY DEPTNO;


-- �˻���� : �����ȣ,����̸�,����,�Ի���,�޿�,�μ��ڵ� 
-- ����1. ����̸��� SCOTT�� ��� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE ENAME = 'SCOTT';

-- ����2. �޿��� 1500������ ��� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE SAL <= 1500;

-- ����3. 1981�⵵�� �Ի��� ��� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE HIREDATE LIKE '81%';

-- ����4. ������ SALESMAN�̰ų� MANAGER�� ����� �޿��� 1500�̻��� ��� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE JOB IN('SALESMAN','MANAGER') AND SAL >=1500;

--����5.�μ��ڵ尡 10�� ��� �� �޿��� 1000~3000�� ��� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE DEPTNO = 10 AND SAL BETWEEN 1000 AND 3000;

--����6.����̸��� C�� S�� ���۵Ǵ� ��� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE ENAME LIKE 'C%' OR ENAME LIKE 'S%';

--����7.�μ��ڵ尡 30�� ��� �� ���ʽ��� NULL�� �ƴ� ��� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO,COMM FROM EMP WHERE DEPTNO = 30 AND COMM IS NOT NULL;

--����8.��� ����� ������ �������� �����ϰ� ���� ��� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP ORDER BY JOB ASC,SAL DESC;

--����9.������ MANAGER�� ����� �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO FROM EMP WHERE JOB = 'MANAGER' ORDER BY SAL DESC;


-- �Լ� (Function) : �����͸� ���� �޾� ���ϴ� ���·� �����Ͽ� ��ȯ�ϴ� ����� ����
--  => ������ �Լ� : �ϳ��� �Է� �����͸� �����Ͽ� ����� ��ȯ�ϴ� �Լ�
--  => �׷�ȭ �Լ� : ���� ���� �Է� �����͸� �����Ͽ� ����� ��ȯ�ϴ� �Լ�

-- �������Լ� : �����Լ�, �����Լ�, ��¥�Լ�, �Ϲ��Լ�, ��ȯ�Լ�
-- �����Լ� : ������ �����͸� �����Ͽ� ����� ��ȯ�ϴ� �Լ�
-- LOWER : ��� ���ڸ� �ҹ��ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
-- UPPER : ��� ���ڸ� �빮�ڷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME, LOWER(ENAME),UPPER(ENAME) FROM EMP;

-- ����̸��� SMITH�� ����� �����ȣ, ����̸�, �޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP WHERE ENAME = UPPER('SMiTH');

-- INITCAP: ù��° ���ڸ� �빮�ڷ� ��ȯ�ϰ� ������ �ҹ��ڷ� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, INITCAP(ENAME) FROM EMP WHERE EMPNO = 7369;

-- CONCAT : ���ڸ� ���� ���ս��� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME,JOB, CONCAT(ENAME,JOB) FROM EMP WHERE EMPNO = 7369;

-- || ��ȣ�� ����
SELECT EMPNO, ENAME,JOB, ENAME || JOB FROM EMP WHERE EMPNO = 7369;

-- SUBSTR : ���ڸ� ���ϴ� ��ġ���� ������ŭ �и��Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, JOB, SUBSTR(JOB,6,3) FROM EMP WHERE EMPNO = 7499;

-- LENGTH : ������ ������ ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, LENGTH(ENAME) FROM EMP WHERE EMPNO = 7499;

-- INSTR : ���� ��ġ���� ���ϴ� ���ڸ� ã�� INDEX�� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, JOB, INSTR(JOB,'A') FROM EMP WHERE EMPNO = 7499;

-- INSTR : �ι�° ��ġ���� ���ϴ� ���ڸ� ã�� INDEX�� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, JOB, INSTR(JOB,'A',1,2) FROM EMP WHERE EMPNO = 7499;

-- LPAD : ����ڸ��� �� ���� ä�� ���ڸ� �����Ͽ� ����� ��ȯ�ϴ� �Լ�
-- RPAD : ����ڸ��� �� ������ ä�� ���ڸ� �����Ͽ� ����� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, SAL, LPAD(SAL,6,'*'),RPAD(SAL,6,'*') FROM EMP WHERE EMPNO = 7844;

-- TRIM : �� �Ǵ� �ڿ� �����ϴ� Ư�� ���ڸ� �����Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME , JOB, TRIM(LEADING 'S' FROM JOB), TRIM(TRAILING 'N' FROM JOB)
    FROM EMP WHERE EMPNO = 7844;

-- REPLACE : Ư�� ���ڸ� ã�� �ٸ� ���ڷ� �����Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO, ENAME, JOB, REPLACE(JOB,'MAN','PERSON') FROM EMP WHERE EMPNO=7844;

-- ���� �Լ�: ���� �Ǵ� �Ǽ� �����͸� ó���ϱ� ���� �Լ�
-- ROUND : ���ڸ� ���ϴ� ��ġ���� �˻��ϰ� �������� �ݿø��Ͽ� ��ȯ�ϴ� �Լ�
SELECT ROUND(45.58,2), ROUND(45.58,0),ROUND(45.58,-1) FROM DUAL;

-- TRUNC : ���ڸ� ���ϴ� ��ġ���� �˻��ϰ� �������� ������ ��ȯ�ϴ� �Լ�
SELECT TRUNC(45.65,1) FROM DUAL;

-- CEIL : �Ǽ��� ��� ������ ��ȯ�ϵ� �����Ͽ� ��ȯ�ϴ� �Լ�
SELECT CEIL(45.67),CEIL(-45.67) FROM DUAL;

-- FLOOR : �Ǽ��� ��� ������ ��ȯ�ϵ� �����Ͽ� ��ȯ�ϴ� �Լ�
SELECT FLOOR(45.67), FLOOR(-45.65) FROM DUAL;

-- MOD : ������ ���� ��ȯ�ϴ� �Լ�
SELECT 20/8, MOD(20,8) FROM DUAL;

--POWER : X�� Y�� ���� ��ȯ�ϴ� �Լ�
SELECT POWER(3,5) FROM DUAL;

-- ��¥�Լ� : ��¥�� �ð��� ���õ� �Լ�
-- ����Ŭ�� ��¥�� ���������� ��¥ �� �ð������� ���������� ǥ�������δ� RR/MM/DD/ ��������
-- ǥ���ȴ�.
SELECT EMPNO, ENAME, HIREDATE FROM EMP;

-- SYSDATE�� ����Ŭ ������ ���� ��¥ �� �ð� ������ ǥ���ϱ� ���� Ű����
SELECT SYSDATE FROM DUAL;

-- ��¥ ���� : ����Ŭ������ ��¥�� �������� ���� ����
-- ��¥ + ���� = ��¥, ��¥ - ���� = ��¥
SELECT SYSDATE+500 FROM DUAL;
SELECT SYSDATE-400 FROM DUAL;

-- ��¥ + ����/24 = ��¥ ���ڴ� �ð��� ���Ѵ�.
SELECT SYSDATE - 17/24 FROM DUA;

-- ��¥ - ��¥ = ���ڰ� ���´�. 6404�� �� ������.
SELECT SYSDATE - TO_DATE('91/03/31') FROM DUAL;

SELECT EMPNO,ENAME,HIREDATE,CEIL(SYSDATE-HIREDATE) || '��' AS "�ټ��ϼ�" FROM EMP;

-- ADD_MONTHS : ��¥�� �������� ���Ͽ� ��ȯ�ϴ� �Լ�
SELECT SYSDATE, ADD_MONTHS(SYSDATE,5) FROM DUAL;

-- NEXT_DAY : Ư�� ���Ͽ� ���� ���� ��¥�� ��ȯ�ϴ� �޼ҵ�
SELECT SYSDATE, NEXT_DAY(SYSDATE,'��') FROM DUAL;

-- ��� ����(�۾� ȯ��)
ALTER SESSION SET NLS_LANGUAGE = 'AMERICAN';
SELECT SYSDATE, NEXT_DAY(SYSDATE,'SUN') FROM DUAL;
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';

-- TRUNC : ���ϴ� ������ ��¥������ �˻��ϰ� �������� 1�� �ʱ�ȭ �Ͽ� ��ȯ�ϴ� �Լ�
SELECT SYSDATE, TRUNC(SYSDATE,'MONTH'), TRUNC(SYSDATE, 'YEAR') FROM DUAL;

-- ��ȯ �Լ�: ����Ŭ�� ������ Ÿ���� ��ȯ�ϴ� �Լ�
-- TO_NUMBER : ������ �����͸� ������ �����ͷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
--  => ���� ����ȯ(����� ����ȯ)
SELECT EMPNO, ENAME ,SAL FROM EMP WHERE EMPNO = TO_NUMBER('7839');

-- ������ �����͸� ����� �÷����� ������ �����Ϳ� ���� ��� �ڵ����� ������ �����͸�
-- ������ ������ �ڵ� ��ȯ�Ͽ� �� => �ڵ� ����ȯ (������ ����ȯ)
SELECT EMPNO, ENAME ,SAL FROM EMP WHERE EMPNO = '7839';

-- ������ ����ȯ���� ���� TO_NUMBER�� �� �Ⱦ��δ�.
SELECT 5000-'1000' FROM DUAL;

-- TO_DATE : ������ �����͸� ��¥�� �����ͷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = TO_DATE('82/01/23');
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE HIREDATE = '82/01/23';

-- ��¥�� �����͸� ������ ��� �ݵ�� ������ �����͸� ��¥�� �����ͷ� ��ȯ�ؾ߸� ����
SELECT SYSDATE, FLOOR(TO_DATE('17/12/07')- SYSDATE)||'��' "���� �ϼ�" FROM DUAL;

-- ����Ŭ�� ��¥���� �⺻������ RR/MM/DD �������� ǥ��
-- TO_DATE �Լ��� �̿��Ͽ� ���ϴ� ��¥ ������ �������� ǥ��
SELECT SYSDATE, FLOOR(TO_DATE('2017-12-07','YYYY-MM-DD') - SYSDATE)||'��' "���� �ϼ�" FROM DUAL;

-- TO_CHAR : ������ ������ �Ǵ� ��¥�� �����͸� ���ϴ� ������ ������ �����ͷ� ��ȯ�ϴ� �Լ�
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') FROM DUAL;

-- ��� ����� �����ȣ, ����̸�, �Ի���(��-��-��) �˻�
SELECT EMPNO,ENAME, TO_CHAR(HIREDATE,'YYYY-MM-DD') HIREDATE FROM EMP;

-- 1981�⵵�� �Ի��� ����� �����ȣ,����̸�,�Ի��� �˻�
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'YYYY') = 1981;

-- ������ �����͸� ��ȯ �� �� �����ϴ� ������ 0�Ǵ� 9 ���
SELECT TO_CHAR(1000000,'999,999,990') FROM DUAL;

SELECT EMPNO, ENAME, TO_CHAR(SAL,'999,990') SAL FROM EMP;

SELECT EMPNO, ENAME, TO_CHAR(SAL,'L999,990') SAL FROM EMP;

SELECT EMPNO, ENAME, TO_CHAR(SAL,'$999,990.00') SAL FROM EMP;

-- �Ϲ��Լ� : ���ǿ� ���� ������ ó�� �Լ�
-- ��� ����� �����ȣ, ����̸�, ����((�޿�+���ʽ�)*12) �˻�
-- ���ʽ��� NULL�ΰ�� �������� NULL�� �߻�
SELECT EMPNO,ENAME,(SAL+NVL(COMM,0))*12 ANNUAL_SALARY FROM EMP;

-- NVL : �÷��� ����� �����Ͱ� NULL�� ��� ���ϴ� �����ͷ� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�

-- NVL2 : �÷��� ����� �����Ͱ� NULL�� �ƴ� ��쿡 ��밪�� NULL�� ��� ��밪�� 
--  ���� �� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
SELECT EMPNO,ENAME,(SAL+NVL2(COMM,COMM,0))*12 ANNUAL_SALARY FROM EMP;

-- DECODE : �÷��� ����� �����͸� ���Ͽ� ���� ��� Ư�� �����͸� ��ȯ�Ͽ� ��ȯ�ϴ� �Լ�
-- ��� ����� �����ȣ, ����̸�, �޿�, ������ �����޾� �˻�
-- ������ �����޾� : �������� �޿��� ����Ͽ� ������ �޿�
-- => ANALYST : �޿� * 1.1 CLERK : �޿� * 1.2 MANAGER: �޿�*1.3 PRESIDENT: �޿� *1.4 SALESMAN:�޿�*1.5
SELECT EMPNO, ENAME, JOB,SAL, DECODE(JOB,'ANALYST',SAL*1.1, 'CLERK',SAL*1.2, 'MANAGER',SAL*1.3, 'PRESIDENT',SAL*1.4,'SALESMAN',SAL*1.5,SAL) "�����޾�" FROM EMP;

-- ������ �޿� ��Ȳ �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP;

-- F5������ ǥ�������� �����ֱ� ���� ���
SELECT EMPNO,ENAME,DECODE(JOB,'ANALYST',SAL) "ANALYST",
            DECODE(JOB,'CLERK',SAL) "CLERK",
            DECODE(JOB,'MANAGER',SAL) "MANAGER",
            DECODE(JOB,'PRESIDENT',SAL) "PRESIDENT",
            DECODE(JOB,'SALESMAN',SAL) "SALESMAN"FROM EMP;


-- ����1 ������̺��� �Ի����� 12���� ����� ���,�����,�Ի��� �˻�
SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE TO_CHAR(HIREDATE,'MM') = '12';

-- ����2 ������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT EMPNO,ENAME,LPAD(SAL,10,'*') "�޿�" FROM EMP;

-- ����3 ������ ���� ����� �˻��� �� �ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT EMPNO,ENAME,TO_CHAR(HIREDATE,'YYYY-MM-DD') "�Ի���" FROM EMP;


