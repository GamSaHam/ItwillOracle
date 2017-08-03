
-- �׷��Լ� : ���� ���� �����͸� �Է¹޾� ó���Ͽ� ����� ��ȯ�ϴ� �Լ� 

-- COUNT: Ư�� �÷��� ����� �������� ������ ����Ͽ� ��ȯ�ϴ� �Լ�
SELECT COUNT(EMPNO) FROM EMP;

-- �׷��Լ� ���� �ٸ� �˻����� ���� ����� �� ����.
-- EMPNO,ENAME�� 14���� ���� ���� ������ EMPNO�� �Ѱ��� ���� ���� ������ ������ ������ ����
SELECT EMPNO,ENAME,COUNT(EMPNO) FROM EMP;

-- �׷��Լ��� NULL�� �����ͷ� �ν����� �ʴ´�.
SELECT COUNT(COMM) FROM EMP;

-- COUNT �Լ��� �÷��� ��� *�� ����� �� �ִ�.
-- COUNT �׷��Լ��� * ��� �÷��� �����ϴ�.
--  => ���̺� ����� ���� ���� ��ȯ
SELECT COUNT(*) FROM EMP;

-- MAX : �÷��� ����� ������ �� ���� ū ���� ��ȯ�ϴ� �Լ�
SELECT MAX(SAL) FROM EMP;
SELECT MAX(ENAME) FROM EMP; -- A~Z , a�� A���� ũ��. �ѱ��� �������� ũ��
SELECT MAX(HIREDATE) FROM EMP; -- �ʰ� ���� ���

-- MIN : �÷��� ����� ������ �� ���� ���� ���� ��ȯ�ϴ� �Լ�
SELECT MIN(SAL) FROM EMP;
SELECT MIN(ENAME) FROM EMP;
SELECT MIN(HIREDATE) FROM EMP; -- ���� ���� ���

-- SUM : �÷��� ����� �����͵��� �հ� ����Ͽ� ��ȯ
--      �Ķ���ͷ� �������� ����
SELECT SUM(SAL) FROM EMP;

-- AVG : �÷��� ����� �����͵��� ��� ����Ͽ� ��ȯ
--      �Ķ���ͷ� �������� ����
SELECT TO_CHAR(AVG(SAL),'$999,990.99') FROM EMP;
SELECT ROUND(AVG(SAL),2) FROM EMP;

-- ���ʽ��� NULL �ƴ� ������� ����� �ȴ�.
SELECT AVG(COMM) FROM EMP;

-- ��� ����� ���ʽ� ��� �˻�
SELECT CEIL(AVG(NVL(COMM,0))) "��պ��ʽ�" FROM EMP;

-- ���̺� ����� ��� ����� �ο� �� �˻�
SELECT COUNT(*) FROM EMP;

-- �μ��� ����� �ο���
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 10;
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 20;
SELECT COUNT(*) FROM EMP WHERE DEPTNO = 30;

-- GROUP BY : �׷� �Լ� ���� ��� ���� �ϸ� �÷��� ����� �����͸� �̿��Ͽ�
-- �׷��� ����ȭ �ϱ� ���� ��� => ����� �����Ͱ� ���� ��� ���� �׷����� �ν�
-- �÷��� ��ſ� �Լ� �Ǵ� ����� ��� ���������� ALIAS �̸��� ��� �Ұ���
-- ����) SELECT �˻����(�׷��Լ�), ... FROM ���̺�� [WHERE ���ǽ�] 
--         GROUP BY �÷��� [ORDER BY �÷��� {ASC | DESC},...]
-- �μ��� ����� �ο��� �˻� => �μ��ڵ尡 ���� ��� ���� �׷����� �ν�
-- �˻� �Ǵ� ���� ������ �����ϴ�, DEPTNO, COUNT(*) , GROUP BY �� ����
SELECT DEPTNO,COUNT(*) FROM EMP GROUP BY DEPTNO;

-- ������ ��� �޿��� ����Ͽ� �˻�
SELECT JOB, TO_CHAR(AVG(SAL),'$999,990.99') FROM EMP GROUP BY JOB;
                
-- ������ PRESIDENT�� ����� ������ ������ ��� �޿� ����Ͽ� �˻�
SELECT JOB, TO_CHAR(AVG(SAL),'$999,990.99') FROM EMP WHERE JOB != 'PRESIDENT' GROUP BY JOB;

-- ������ PRESIDENT�� ����� ������ ������ ��� �޿��� �������� ����Ͽ� �˻�
SELECT JOB, TO_CHAR(AVG(SAL), '$999,990.99') AVG_SAL FROM EMP WHERE JOB != 'PRESIDENT' GROUP BY JOB ORDER BY AVG_SAL ASC;

-- HAVING : �׷� �Լ��� ������ ��� Ư�� GROUP BY �� ������ ���
--          GROUP BY�� ���� ����ϸ� �׷쿡 ���� ������ �ο��Ͽ� �˻��ϴ� ���
-- ����) SELECT �˻����(�׷��Լ�), ... FROM ���̺�� [WHERE ���ǽ�] 
--         GROUP BY �÷��� HAVING �׷����� [ORDER BY �÷��� {ASC | DESC},...] 

-- �μ��� �޿� �հ� ����Ͽ� �˻�
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO;

-- �μ��� �޿� �հ踦 ����Ͽ� �޿� �հ谡 9000�̻��� �μ� �˻�
-- �׷캰�� �˻��� ���� �׷캰�� ������ �ɷ� ���� �� HAVING �� ���
SELECT DEPTNO, SUM(SAL) FROM EMP GROUP BY DEPTNO HAVING SUM(SAL) >= 9000;


-- ����1. ��� ���̺��� �μ��� �ο����� 6�� �̻��� �μ��ڵ� �˻�
SELECT DEPTNO, COUNT(*) FROM EMP GROUP BY DEPTNO HAVING COUNT(*) >= 6;

-- ����2. ��� ���̺�� ���� �μ���ȣ, ������ �ݿ� �հ踦 ����ϰ��� �Ѵ�.
--          ������ ���� ����� ��� �� �� �ִ� SQL ���� �ۼ���?
SELECT DEPTNO, SUM(DECODE(JOB,'CLERK',SAL)) CLERK, SUM(DECODE(JOB,'MANAGER',SAL)) MANAGER,SUM(DECODE(JOB,'PRESIDENT',SAL)) PRESIDENT,
             SUM(DECODE(JOB,'ANALYST',SAL)) ANALYST, SUM(DECODE(JOB,'SALESMAN',SAL)) SALESMAN FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO;

-- ����3. ������̺�κ��� �⵵��, ���� �޿��հ踦 ����� �� �ִ� SQL���� �ۼ�
SELECT TO_CHAR(HIREDATE,'YYYY') ��,TO_CHAR(HIREDATE,'MM') ��,SUM(SAL) FROM EMP GROUP BY  TO_CHAR(HIREDATE,'YYYY'),TO_CHAR(HIREDATE,'MM') ORDER BY ��,��;

-- ����4. ������̺��� �μ��� COMM(Ŀ�̼�) �� �������� ���� ������ �հ� ������
--        ������ ���� ���ϴ� SQL�� �ۼ� �Ͻÿ�.
--SELECT DEPTNO, SUM(SAL*12) FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO ASC;
SELECT DEPTNO, SUM((SAL+NVL(COMM,0))*12) FROM EMP GROUP BY DEPTNO ORDER BY DEPTNO ASC;

-- ����5. ������̺��� SALESMAN�� ������ JOB�� �޿� �հ�
SELECT JOB,SUM(SAL) FROM EMP WHERE JOB != 'SALESMAN' GROUP BY JOB; -- ����
SELECT JOB,SUM(SAL) FROM EMP GROUP BY JOB HAVING JOB != 'SALESMAN'; -- �����
-- ���� ���� ���̺� 4���� �׷��� ���ش�.
-- �Ʒ� ���� ���̺� 5���� �׷쿡�� �����Ѵ�.

-- �м��Լ�: ������ �Լ�(�׷��Լ�, �����Լ�, �����Լ�, ...)�� ���� �߻��� ����� 
-- �м��Ͽ� ��ȯ�ϴ� �Լ�
-- ����) SELECT ������ �Լ� OVER([PATITION BY �÷���] [ORDER BY �÷���] [WINDOWING]) FROM ���̺�� [WHERE ���ǽ�] 
--         [GROUP BY �÷���] [HAVING �׷����ǽ�] [ORDER BY �÷��� {ASC | DESC},...] 
    
-- ��� ��� �� ���� ���� �޿��� �޴� ����� �޿��� �˻�
SELECT MAX(SAL) FROM EMP;

-- ��� ��� �� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿� �˻�
-- => �׷��Լ��� �ٸ� �˻����� ���� ����� �� ����.
SELECT EMPNO,ENAME,MAX(SAL) FROM EMP; -- ���� �߻�

-- �׷��Լ��� �м��Լ��� ���� ����ϸ� �ٸ� �˻���� ����� �� �ִ�.
SELECT EMPNO,ENAME,SAL,MAX(SAL) OVER () FROM EMP;

-- �μ��� ��ձ޿� �˻�
SELECT DEPTNO, CEIL(AVG(SAL)) "��ձ޿�" FROM EMP GROUP BY DEPTNO;

-- ��� ����� �����ȣ, ����̸�, �޿�, �μ� ��ձ޿� �˻�
-- OVER �Լ��� ����ϸ� GROUP BY ��� �Ұ���
-- OVER �Լ� �ȿ� PARTITION BY�� ����ϸ� GROUP BY�� ������ ��Ȱ ����
SELECT EMPNO,ENAME,SAL,DEPTNO,CEIL(AVG(SAL) OVER(PARTITION BY DEPTNO)) "�μ���ձ޿�" FROM EMP;

-- ��� ����� �����ȣ, ����̸�, �޿�, ���� �޿� �հ踦 �޿��� �������� �����Ͽ� �˻�
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL ASC) "�޿� �հ�" FROM EMP;

-- ��� ����� �����ȣ, ����̸�, �޿�, �μ��ڵ�, �μ������޿��հ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO, SUM(SAL) OVER (PARTITION BY DEPTNO ORDER BY SAL ASC) FROM EMP;

-- ��� ����� �����ȣ, ����̸�, �޿�, �����޿� �հ� �˻�
-- => �޿��� ������ ��� �����޿� �հ谡 �ѹ��� ���Ǿ� �ʵ��� �˻�
-- => OVER �Լ� �ȿ� WINDOWING ����� �̿��ϸ� ���� �˻����� �������� �˻� �ϰ��� �ϴ� 
--    �� �Ǵ� ������ �����Ͽ� �˻��� �� �� �ִ�.
-- => ROWS UNBOUNDED PRECEDING : �˻����� �������� ������ �����ϴ� ��� ���� ����
SELECT EMPNO,ENAME,SAL,DEPTNO, SUM(SAL) OVER (ORDER BY SAL ASC ROWS UNBOUNDED PRECEDING) "�����޿��հ�" FROM EMP;


-- ��� ����� �޿��� �������� �����Ͽ� �����ȣ, �����ȣ, ����̸�, �޿�, �˻� ����� �� ����� 
-- �޻���� �޿� �հ踦  ����Ͽ� �˻�
-- => ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING : �˻����� �������� ���� 1��� ���� 1�࿡ ���� �˻�
SELECT EMPNO,ENAME,SAL,SUM(SAL) OVER(ORDER BY SAL ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) FROM EMP;

-- ��� ����� �޿��� �������� �����Ͽ� �����ȣ, �����ȣ, ����̸�, �޿�, �˻� ����� �޿�����
-- 100�۰ų� 200 ū ����� �ο��� �˻�
SELECT EMPNO,ENAME,SAL,COUNT(*) OVER(ORDER BY SAL RANGE BETWEEN 100 PRECEDING AND 200 FOLLOWING)-1 "�ο���" FROM EMP; 

-- ���� �Լ� : RANK, DENSE_RANK, ROW_NUMBER
-- ��� ����� �����ȣ,����̸�,�޿��� �޿������� �������� �����Ͽ� �˻�
SELECT EMPNO, ENAME, SAL FROM EMP ORDER BY SAL DESC;

-- RANK() : �����Ͱ� ���� ��� ���� ���� ���� �� ������ �ǳ� ��� ����
SELECT RANK() OVER(ORDER BY SAL DESC) "��ŷ", EMPNO, ENAME, SAL FROM EMP;
-- ���� ���� �ȸ� ��ǰ 10��

-- DENSE_RANK() : �����Ͱ� ���� ��� ���� ���� �� ���� ����
SELECT DENSE_RANK() OVER(ORDER BY SAL DESC) "��ŷ", EMPNO, ENAME, SAL FROM EMP;

-- ROW_NUMBER() : �����Ͱ� ���� ��쿡�� �ٸ� ���� ���� => �� ��ȣ
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "��ŷ", EMPNO, ENAME, SAL FROM EMP;

-- ���� �Լ� : FIRST_VALUE, LAST_VALUE, LAG, LEAD
-- ��� ����� �޿��� ���� ���� �����Ͽ� �����ȣ, ����̸�, �޿�, �޿��� ���帹�� �޴�
-- ����̸��� �޿��� ���� ���� �޴� ����̸� �˻�
SELECT EMPNO,ENAME,SAL,FIRST_VALUE(ENAME) OVER(ORDER BY SAL DESC ROWS UNBOUNDED PRECEDING) MAX_NAME,
        LAST_VALUE(ENAME) OVER(ORDER BY SAL DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) MIN_NAME FROM EMP;

-- LAG: �˻����� �պκп� �����͸� ����� �� ���
-- LEAD: �˻����� �ںκп� �����͸� ����� �� ���
-- ��� ����� �޿��� �������� �����Ͽ� �����ȣ,����̸�,�޿�,�˻������ �� �����
-- �޿��� �˻������ �� ��� �޿��� �˻�
--  => �� �Ǵ� �� ����� ���� ��� �޿��� 0���� �˻�
-- �ձ� �ޱۿ� ���� �̸�
SELECT EMPNO,ENAME,SAL,LAG(SAL,1,0) OVER(ORDER BY SAL DESC) "�ջ�� �޿�",LEAD(SAL,1,0)  OVER(ORDER BY SAL DESC) "�޻�� �޿�" FROM EMP;

-- JOIN : �� �� �̻��� ���̺��� ���ϴ� �����͸� �˻��ϱ� ���� ���

-- ��� ����� �����ȣ, ����̸�, �޿�, �μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP;

-- ��� �μ��� �μ��ڵ�, �μ���, ��ġ �˻�
SELECT DEPTNO, DNAME, LOC FROM DEPT;

-- ��� ����� �����ȣ,����̸�,�޿�,�μ��� �˻�
--  => ���̺��� JOIN �Ͽ� �˻��ϱ� ���ؼ��� JOIN ������ �ݵ�� �ʿ�
--  => ī�׽þ� ���δ�Ʈ : JOIN ������ ���ų� �߸��� JOIN ������ ����� ��� => �������� JOIN
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP,DEPT;


-- EQUI JOIN : JOIN ������ �´� ���� �����Ͽ� �˻�
-- JOIN �ϰ��� �ϴ� ���̺��� �˻��ϰ��� �ϴ� �÷��� ���̺�� ���
-- ����) ���̺��.�÷��� => ���̺��̸��� ���� �����ϴ�.
-- JOIN �ϰ��� �ϴ� ���̺� ������ �÷����� ������ ��� �ݵ�� ���̺���� ����ؾ߸�
-- �ȴ�. 
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- ��� ����� �����ȣ,����̸�,�޿�,�μ��ڵ�,�μ��� �˻�
-- ��ȣ�� ��� ������ ���־�� �Ѵ�.
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DNAME FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- ��� ����� �����ȣ,����̸�,�޿�, ��� �μ��ڵ�, �μ� �μ��ڵ�, �μ��� �˻�
--  => ������ �÷����� �˻��� ��� �ι�° �÷��� �÷���_���� �������� �÷����� �ڵ� ����
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO,DEPT.DEPTNO,DNAME FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

--  => ������ �÷����� �˻��� ��쿡�� �÷��� ALIAS �����Ͽ� �˻��ϴ� ���� ����
SELECT EMPNO,ENAME,SAL,EMP.DEPTNO "EMP.DEPTNO",DEPT.DEPTNO "DEPT.DEPTNO",DNAME 
    FROM EMP,DEPT WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- ���̺� ALIAS : ���̺��� JOIN �� ��� ���̺� ������ �ο��ϴ� ���
--  => JOIN �� �� ���̺���� ����ؾ� �� ��� ���� ���� ����� �� �ֵ���
--      �ο��ϴ� ���
--      ����) ���̺�� ����

SELECT EMPNO,ENAME,SAL,E.DEPTNO "E.DEPTNO",D.DEPTNO "D.DEPTNO",DNAME 
    FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO;

-- ���̺� ALIAS ��� ���� �� ���� ���̺���� ����� ��쿡�� ���� �߻�
SELECT EMPNO,ENAME,SAL,E.DEPTNO "E.DEPTNO",D.DEPTNO "D.DEPTNO",DNAME 
    FROM EMP E,DEPT D WHERE EMP.DEPTNO = DEPT.DEPTNO;

-- NON-EQUI JOIN : JOIN ������ ��Ȯ�ϰ� ��ġ ���� �ʾƵ� �Ǵ� ����   
-- ��� ����� �����ȣ,����̸�,�޿� �˻�
SELECT EMPNO,ENAME,SAL FROM EMP;

-- SALGRADE ���̺� : �޿� ��� ���̺�
SELECT * FROM SALGRADE;

-- ��� ����� �����ȣ,����̸�,�޿�,�޿���� �˻�
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP,SALGRADE WHERE SAL BETWEEN LOSAL AND HISAL;

-- OUTER JOIN : ���̺��� JOIN �� ��� JOIN ������ ���� �ʴ� ��� �����͵� ���� �˻�
-- �ǵ��� JOIN ��Ű�� ��� => JOIN ������ ���� �ʴ� ��쿡�� NULL�� �˻�
SELECT DISTINCT DEPTNO FROM EMP; -- 10,20,30

SELECT DEPTNO FROM DEPT; -- 10,20,30 �μ��ڵ� �˻�

SELECT * FROM DEPT WHERE DEPTNO = 40;

-- ��� ����� �����ȣ,����̸�,�޿�,�μ��ڵ�,�μ��� �˻�
--  => 40�� �μ��� �ٹ��ϴ� ����� �������� �������� �˻����� �ʴ´�.
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO;

-- JOIN ������ ���� �ʾƵ� �˻��ǵ��� �ϱ� ���� OUTER JOIN ���
--  => JOIN ���ǿ� (+)�� ����� ���̺� JOIN ������ ���� �ʴ� ��� NULL �˻�
SELECT EMPNO,ENAME,SAL,D.DEPTNO,DNAME FROM EMP E,DEPT D WHERE E.DEPTNO(+) = D.DEPTNO;
-- �߸��� �����Ͱ� �ִ��� �˻��ϱ� ���� ������ ���Ἲ �˻�

-- ��� ����� �����ȣ, ����̸�, �Ŵ��� ��ȣ �˻�
SELECT EMPNO,ENAME,MGR FROM EMP;

-- ��� ����� �����ȣ, ����̸�, �Ŵ��� �̸� �˻�
--  => SELF JOIN : �ϳ��� ���̺��� �ΰ��� ���̺�� ALIAS�Ͽ� JOIN �ϴ� ���
SELECT WORKER.EMPNO, WORKER.ENAME WOKER_ENAME, MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER, EMP MANAGER WHERE WORKER.MGR = MANAGER.EMPNO;

-- => OUTER JOIN : KING ��� ����
SELECT WORKER.EMPNO, WORKER.ENAME WOKER_ENAME, MANAGER.ENAME MANAGER_ENAME 
    FROM EMP WORKER, EMP MANAGER WHERE WORKER.MGR = MANAGER.EMPNO(+);

-- SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,�޿�,�μ��� �˻�
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E,DEPT D WHERE E.DEPTNO = D.DEPTNO AND DNAME = 'SALES';

--1999 JOIN : 1999�� ä�õ� ǥ�� SQL�� �߰��� JOIN ���

--CROSS JOIN : JOIN ������ �������� �ʴ� JOIN
--����) SELECT �˻����,... FROM ���̺��1 CROSS JOIN ���̺��2;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP CROSS JOIN DEPT;

--NATURAL JOIN : JOIN �ϰ��� �ϴ� ���̺� ������ �÷����� �ϳ� ������ �ִ� ���
--�÷��� ����� ����Ÿ�� �̿��Ͽ� JOIN ���
--����) SELECT �˻����,... FROM ���̺��1 NATURAL JOIN ���̺��2;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP NATURAL JOIN DEPT;

--JOIN~USING : JOIN �ϰ��� �ϴ� ���̺� ������ �÷����� ���� �� ������ �ִ� ���
--Ư�� ���� �÷��� ����� ����Ÿ�� �̿��Ͽ� JOIN ���
--����) SELECT �˻����,... FROM ���̺��1 JOIN ���̺��2 USING(�÷���);
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT USING(DEPTNO);

--JOIN~ON(INNER JOIN) : JOIN �ϰ��� �ϴ� ���̺��� JOIN ������ ON �ڿ� �ۼ��ϴ� JOIN
--����) SELECT �˻����,... FROM ���̺��1 JOIN ���̺��2 ON JOIN����;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP JOIN DEPT ON EMP.DEPTNO=DEPT.DEPTNO;

--��� ����� �����ȣ,����̸�,�޿�,�޿���� �˻�
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL; 

--SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,�޿�,�μ��� �˻�
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D 
    ON E.DEPTNO=D.DEPTNO WHERE DNAME='SALES';

--OUTER JOIN : JOIN ������ ���� �ʴ� ����Ÿ�� �˻�
-- => LEFT JOIN,RIGHT JOIN,FULL JOIN

--��� ����� �����ȣ,����̸�,�޿�,�μ��� �˻�
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
SELECT * FROM DEPT;--40�� �μ� ���� => JOIN ���ǿ� ���� �ʾ� �˻����� �ʴ´�.

--��� ����� �����ȣ,����̸�,�޿�,�μ��� �˻� => ��� �μ� �˻�(RIGHT JOIN)
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E LEFT JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E RIGHT JOIN DEPT D ON E.DEPTNO=D.DEPTNO;
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E FULL JOIN DEPT D ON E.DEPTNO=D.DEPTNO;

--��� ����� �����ȣ,����̸�,�Ŵ����̸� �˻�
-- => KING ����� ���� �����Ǿ� �˻�
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;
    
--��� ����� �����ȣ,����̸�,�Ŵ����̸� �˻� => KING ��� �˻�
SELECT WORKER.EMPNO,WORKER.ENAME WORKER_ENAME,MANAGER.ENAME MANAGER_ENAME
    FROM EMP WORKER LEFT JOIN EMP MANAGER ON WORKER.MGR=MANAGER.EMPNO;
