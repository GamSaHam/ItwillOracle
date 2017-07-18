
-- ����1. 
SELECT EMPNO,ENAME,D.DEPTNO,D.DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO ORDER BY E.ENAME ASC;

-- ����2.
SELECT EMPNO,ENAME,SAL,D.DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO WHERE E.SAL >= 2000 ORDER BY E.SAL DESC;

-- ����3.
SELECT EMPNO,ENAME,JOB,SAL,D.DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO WHERE JOB='MANAGER' AND E.SAL >= 2500 ORDER BY E.EMPNO ASC;

-- ����4.
SELECT * FROM TAB;
SELECT * FROM SALGRADE;
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL WHERE GRADE = 4 ORDER BY SAL DESC;

-- ����5. ���� 3��
SELECT EMPNO,ENAME,SAL,DNAME,SAL,GRADE 
    FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;

-- ���� 6 ���� ����
SELECT W.ENAME �����, M.ENAME �����ڸ� FROM EMP W LEFT JOIN EMP M ON W.MGR = M.EMPNO;

-- ���� 7 
SELECT W.ENAME �����, M.ENAME �����ڸ�, MM.ENAME FROM EMP W JOIN EMP M ON W.MGR = M.EMPNO JOIN EMP MM ON M.MGR = MM.EMPNO;

-- ���� 8 LEFT ������ ��Ű�� �����ʿ� �ִ°��� ���� LEFT ������ ������� �Ѵ�.
SELECT W.ENAME �����, M.ENAME �����ڸ�, MM.ENAME FROM EMP W LEFT JOIN EMP M ON W.MGR = M.EMPNO LEFT JOIN EMP MM ON M.MGR = MM.EMPNO;

--SUBQUERY : MAINQUERY(SELECT)�� ���ԵǾ� ����� QUERY(SELECT)    
-- => ���� ���� QUERY�� ���� �� �ִ� ����� �ϳ��� QUERY�� ��� �� �ֵ��� �ϴ� ���
-- => MAINQUERY�� SELECT ������� ���������� �ٸ� SQL ����� �� ���� �ִ�.

--����̸��� SCOTT�� ������� ���� �޿��� �޴� ����� �����ȣ,����̸�,�޿� �˻�
SELECT SAL FROM EMP WHERE ENAME='SCOTT';--SCOTT ����� �޿� => 3000
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>3000;--�޿��� 3000 �ʰ��� ��� �˻�

--SUBQUERY ���
-- => SUBQUERY�� �����ϰ� �ִ� SELECT�� MAINQUERY��� �Ѵ�.
-- => MAINQUERY���� () �ȿ� �ۼ��� SELECT ����� SUBQUERY��� �Ѵ�.
-- => MAINQUERY ���� SUBQUERY�� ���� �����Ѵ�.
-- => ���������� SUBQUERY�� WHERE �Ǵ� HAVING���� ���ȴ�.
-- => ���ǽĿ��� ���ϰ��� �ϴ� �÷��� SUBQUERY�� �˻������ �����ؾ߸� �ȴ�.
SELECT EMPNO,ENAME,SAL FROM EMP 
    WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='SCOTT');
    
--�����ȣ�� 7844�� ����� ���� ������ �ϴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7844) AND EMPNO<>7844;

--�����ȣ�� 7521�� ����� ���� ������ ���� ��� �� �����ȣ�� 7900�� ������� �޿���
--���� �޴� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE JOB=(SELECT JOB FROM EMP WHERE EMPNO=7521) AND EMPNO<>7521
    AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7900);
    
--SALES �μ��� �ٹ��ϴ� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP JOIN DEPT 
    ON EMP.DEPTNO=DEPT.DEPTNO WHERE DNAME='SALES';--JOIN �̿�

SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
    
--��� ��� �� ���� �޿��� ���� �޴� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP WHERE SAL=(SELECT MIN(SAL) FROM EMP);

--�μ��ڵ尡 30�� �μ����� ���� ���� �޿��� �޴� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO,ENAME,JOB,SAL FROM EMP 
    WHERE SAL=(SELECT MAX(SAL) FROM EMP WHERE DEPTNO=30);
    
--�μ��ڵ尡 30�� �μ����� ���� ���� �޿��� �޴� ����� �޿����� ���� �޿��� �޴�
--�μ��� �μ��ڵ� �� �μ��� �޿� �� �ּұ޿� �˻�
SELECT DEPTNO,MIN(SAL) FROM EMP GROUP BY DEPTNO 
    HAVING MIN(SAL)>(SELECT MIN(SAL) FROM EMP WHERE DEPTNO=30);
    
--�μ��� ��ձ޿� �� ���� ���� ��ձ޿��� �޴� �μ��ڵ�,��ձ޿� �˻�
SELECT DEPTNO,CEIL(AVG(SAL)) FROM EMP GROUP BY DEPTNO
    HAVING AVG(SAL)=(SELECT MAX(AVG(SAL)) FROM EMP GROUP BY DEPTNO);

--�μ��� �ּұ޿��� �޴� ����� �����ȣ,����̸�,�޿�,�μ��ڵ带 �μ��ڵ�� 
--�������� �����Ͽ� �˻�
-- => SUBQUERY���� �˻��� ����� ���� ���� ���(MULTI-ROW SUBQUERY)����
--    �Ϲ����� �񱳿�����(=,<>,>,<,>=,<=)�� �̿��� ���ǽ��� ����� ��� ���� �߻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL=(SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO) ORDER BY DEPTNO;--���� �߻�
    
--MULTI-ROW SUBQUERY������ = ������ ��� IN �����ڸ� �̿�    
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL IN (SELECT MIN(SAL) FROM EMP GROUP BY DEPTNO) ORDER BY DEPTNO;

--MULTI-ROW SUBQUERY������ >,<,>=,<= �����ڸ� ����� ��� MULTI-ROW SUBQUERY �տ�
--ANY �Ǵ� ALL Ű���带 ����Ͽ� ���ؾ߸� �ȴ�.

--10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO=10);

--10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > ALL(SELECT SAL FROM EMP WHERE DEPTNO=20);

--20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > ANY(SELECT SAL FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;
    
--ANY �Ǵ� ALL ��� MAX �Ǵ� MIN �׷��Լ��� ����ϴ� ���� �����Ѵ�.
--�÷��� > ALL(MULTI-ROW SUBQUERY) => �÷��� > (SINGLE-ROW SUBQUERY - MAX �׷��Լ�)
--�÷��� > ANY(MULTI-ROW SUBQUERY) => �÷��� > (SINGLE-ROW SUBQUERY - MIN �׷��Լ�)
--�÷��� < ALL(MULTI-ROW SUBQUERY) => �÷��� < (SINGLE-ROW SUBQUERY - MIN �׷��Լ�)
--�÷��� < ANY(MULTI-ROW SUBQUERY) => �÷��� < (SINGLE-ROW SUBQUERY - MAX �׷��Լ�)

--10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=10);

--10�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL < (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=10) AND DEPTNO<>10;

--20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > (SELECT MAX(SAL) FROM EMP WHERE DEPTNO=20);

--20�� �μ��� �ٹ��ϴ� ��� ������� �޿��� ���� ����� 
--�����ȣ,����̸�,�޿�,�μ��ڵ� �˻�
SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP 
    WHERE SAL > (SELECT MIN(SAL) FROM EMP WHERE DEPTNO=20) AND DEPTNO<>20;
    
--����̸��� ALLEN�� ����� ���� ������ �Ʒ��� ���ϰ� ������ ������ ���� �����
--�����ȣ,����̸�,�����ڹ�ȣ,����,�޿� �˻�
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP 
    WHERE MGR=(SELECT MGR FROM EMP WHERE ENAME='ALLEN')
    AND JOB=(SELECT JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';

--MULTI-COLUMN SUBQUERY : ���� ���� �˻������ �̿��Ͽ� �˻��ϴ� SUBQUERY
-- => �� �÷��� () �ȿ� SUBQUERY�� ������ �÷����� ,�� �����Ͽ� ����
SELECT EMPNO,ENAME,MGR,JOB,SAL FROM EMP WHERE (MGR,JOB)=
    (SELECT MGR,JOB FROM EMP WHERE ENAME='ALLEN') AND ENAME<>'ALLEN';

    
-- ����1
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL > (SELECT SAL FROM EMP WHERE ENAME = 'BLAKE');

-- ����2
SELECT EMPNO,ENAME,HIREDATE FROM EMP 
        WHERE HIREDATE > (SELECT HIREDATE FROM EMP WHERE ENAME = 'MILLER');

-- ����3
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL > (SELECT AVG(SAL) FROM EMP);

-- ����4
SELECT EMPNO,ENAME,SAL FROM EMP 
    WHERE DEPTNO = (SELECT DEPTNO FROM EMP WHERE ENAME ='CLARK') 
        AND SAL > (SELECT SAL FROM EMP WHERE EMPNO = 7698);

-- ����5
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP WHERE SAL IN(SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);


-- SET ������ : �� ���� SELECT ����� �̿��Ͽ� ������(UNION), ������(INTERSECT), ������(MINUS)
-- ����� �߻��ϴ� ������

-- TEST1 ���̺� ���� => �̸��� �����ϴ� �÷�
CREATE TABLE TEST1(NAME VARCHAR2(10));

-- TEST1 ���̺� �� ����(����)
INSERT INTO TEST1 VALUES('ȫ�浿');
INSERT INTO TEST1 VALUES('�Ӳ���');
INSERT INTO TEST1 VALUES('����ġ');
INSERT INTO TEST1 VALUES('������');
INSERT INTO TEST1 VALUES('����');
COMMIT;

SELECT * FROM TEST1;

-- TEST2 ���̺� ���� ��ȣ �̸�
CREATE TABLE TEST2(NUM NUMBER(1), NAME VARCHAR2(10));

INSERT INTO TEST2 VALUES(1,'���۸�');
INSERT INTO TEST2 VALUES(2,'ȫ�浿');
INSERT INTO TEST2 VALUES(3,'��Ʈ��');
INSERT INTO TEST2 VALUES(4,'����ġ');
INSERT INTO TEST2 VALUES(5,'��Ʈ��');
COMMIT;

SELECT * FROM TEST2;

--UNION : �� ���� SELECT���� �˻��� ��� ���� ���Ͽ� �˻�(�ߺ� �˻� ������ ����)
--  => �� ���� SELECT ����� �˻���� ������ �ڷ����� �ݵ�� �����ؾ� �ȴ�.
SELECT NAME FROM TEST1 UNION SELECT NAME FROM TEST2;

-- UNION ALL : �� ���� SELECT���� �˻��� ��� ���� ���Ͽ� �˻�(�ߺ� �˻������� ����)
SELECT NAME FROM TEST1 UNION ALL SELECT NAME FROM TEST2;

-- INTERSECT : �ΰ��� SELECT���� �˻��� �� �� �ߺ��� �ุ �˻�
SELECT NAME FROM TEST1 INTERSECT SELECT NAME FROM TEST2;

-- MINUS : ù��° SELECT���� �˻��� �࿡�� �ι�° SELECT���� �˻��� ���� �����Ͽ� �˻�
SELECT NAME FROM TEST1 MINUS SELECT NAME FROM TEST2;

-- �� ���� SELECT ����� �˻���� ���� �� �ڷ����� ��ġ���� ���� ��� ���� �߻�
SELECT NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;

-- �˻������ �ڷ����� �ٸ���� => ��ȯ�Լ� ����Ͽ� �ڷ����� ���� ����� �ش�.
SELECT NAME FROM TEST1 UNION SELECT TO_CHAR(NUM,'0') FROM TEST2;

-- �˻������ ������ �ٸ� ��� => �˻������ �߰��ϰų� ���ǰ�(NULL)�� �̿�
SELECT 1, NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;
SELECT NULL, NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;

--DML (DATA MANIPLATION LANGUAGE) : ������ ���۾�
--  => ���� �����ϰų� ����,�����ϱ� ���� SQL ���
--  => DML ��� ���� �� COMMIT(DML ��� ����) �Ǵ� ROLLBACK(DML ��� ���) ��� ���

-- INSERT : ���̺� ���� �����ϴ� SQL ���
-- ����1) INSERT INTO ���̺�� VALUES(��,��,...);
-- ����Ǵ� �÷����� ���̺��� ����(�÷� ����, �ڷ���, ũ��) �� 
-- �°� ���ʴ�� �����Ͽ� ����
-- ���̺��� ���� Ȯ�� => ����) DESC ���̺��;

-- �μ�(DEPT) ���̺� �μ� ������ ����(�߰�)
DESC DEPT;
INSERT INTO DEPT VALUES(50,'ȸ���','����');
COMMIT; -- ���̺� ���� �Ϸ�
SELECT * FROM DEPT;

-- DEPT ���̺��� DEPTNO �÷��� PK(PRIMARY KEY) ���������� �ο��Ǿ� �ִ�.
--  => PK ���������� �ο��� �÷����� �ߺ��� �÷����� ������ ��� ���� �߻�
INSERT INTO DEPT VALUES(50,'�ѹ���','����');
INSERT INTO DEPT VALUES(60,'�ѹ���','����');
COMMIT; -- ���̺� ���� �Ϸ�
SELECT * FROM DEPT;


-- ���� ���̺��� �÷� ������ �÷��� ������ �ٸ���� ���� �߻� => �÷��� ���� ����
INSERT INTO DEPT VALUES(70,'�����'); -- �μ���ġ�� ���� �÷����� ���� �Ǿ� ���� �߻�

-- ���̺��� �÷��� ����Ǵ� �÷������� NULL ����� �������� Ȯ��

-- ����� �λ��
INSERT INTO DEPT VALUES(70,'�����',NULL);
COMMIT;
SELECT * FROM DEPT;


-- ����2) INSERT INTO ���̺��(�÷���,�÷���,...) VALUES(�÷���,�÷���,...);
--  => ���̺�� �ڿ� () �ȿ� ������ �÷� ������� �÷����� ����
INSERT INTO DEPT(DEPTNO,LOC,DNAME) VALUES(80,'��õ','������');
COMMIT;
SELECT * FROM DEPT;

-- ���̺�� �ڿ� () �ȿ� �÷����� ���� ����
--  => ������ �÷����� ���̺� ������ ����� �÷� DEFAULT�� ������ �÷� ���� �ڵ����� ����ȴ�.
--  => �÷� NULL�� ����ϸ� DEFAULT �÷����� �������� ������ �ڵ����� NULL�� ����ȴ�.
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'�λ��');
COMMIT;
SELECT * FROM DEPT;

-- ������̺�(EMP)�� ���ο� ��������� ����(����)
DESC EMP;
INSERT INTO EMP VALUES(9000,'LEE','MAMANGER',7298,'17/07/18',3000,100,40);
COMMIT;
SELECT * FROM EMP;

-- �Ի����� ����� �Ͽ� ��� ���̺� ���ο� ��������� ����
INSERT INTO EMP VALUES(9001,'KIM','ANALYST',9000,SYSDATE,2000,NULL,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO = 9001;

-- EMP ���̺��� DEPTNO �÷��� FK(FOREIGN KEY) ���������� �ο���
-- FK ���������� �ο��� �÷��� �ٸ� ���̺��� PK ���������� �ο��� �÷����� ����
-- �Ͽ� �����͸� ����ǵ��� ������ ��������
--  => EMP ���̺��� DEPTNO �÷��� ������ ����� DEPT ���̺��� DEPTNO �÷� ����
--      �����Ͽ� ����Ǹ� ������ �÷����� �������� ���� ��� ���� �߻�
INSERT INTO EMP VALUES(9002,'PARK','CLERK',9000,SYSDATE,1200,NULL,45);

-- DEPTNO ���̺� 45�� �μ��� ���� ������ �� ���� ���� �߻�
SELECT* FROM DEPT WHERE DEPTNO = 45; 

-- SUBQUERY�� �̿��� �� ���� => ���̺� �� ����
-- ����) INSERT INTO ���̺� SELECT �˻�,... FROM ���̺��
--  => INSERT ����� SUBQUERY�� () �ȿ� �ۼ����� ���礤��.
--  => INSERT ���̺��� �÷��� SUBQUERY �˻������ ������ �����ؾ߸� �ȴ�.
--      (�÷� ���� �� �ڷ����� �ݵ�� ���ƾ� �Ǹ� �÷����� ���� �ʾƵ� �ȴ�)
SELECT TABLE_NAME FROM TABS;
DESC BONUS;

-- EMP ���̺� ����� ��� �� ���ʽ��� NULL�� �ƴ� ����� ����̸�,����,�޿�,���ʽ��� 
-- �˻��Ͽ� BONUS ���̺� ����
INSERT INTO BONUS SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;

-- UPDATE : ���̺� ����� �����͸� �����ϴ� ���
-- ����) UPDATE ���̺�� SET �÷��� = ���氪, �÷��� = ���氪
--  => WHERE ���ǽ��� �����Ǹ� ���̺� ����� ��� ���� �÷����� �ϰ������� �����Ѵ�.

-- 
SELECT * FROM DEPT WHERE DEPTNO = 50; 

UPDATE DEPT SET DNAME = '�渮��', LOC = '��õ' WHERE DEPTNO = 50;
COMMIT;

SELECT * FROM DEPT WHERE DEPTNO = 50;

-- �����ȣ�� 9000�� ����� �μ��ڵ带 45�� ����
UPDATE EMP SET DEPTNO = 45 WHERE EMPNO = 9000;

SELECT * FROM DEPT WHERE DNAME = '�����'; -- :NULL
SELECT * FROM DEPT WHERE DNAME = '�ѹ���'; -- :����

-- ���� �÷� ������ SUBQUERY ���
UPDATE DEPT SET LOC = (SELECT * FROM DEPT WHERE DNAME = '�����') WHERE DNAME = '�����';
COMMIT;

SELECT * FROM DEPT;

-- => WHERE ���� SUBQUERY ���
UPDATE BONUS SET COMM = COMM+200
    WHERE COMM < (SELECT COMM FROM BONUS WHERE ENAME = 'ALLEN');
    
COMMIT;
    
SELECT * FROM BONUS;

--DELETE : ���̺� ����� ���� �����ϴ� ��ɾ�
--  ����) DELETE FROM ���̺�� [WHERE ���ǽ�];
--  => WHERE ���ǽ��� �����Ǹ� ���̺� ����� ��� �� ����


-- �μ����̺��� �μ��ڵ尡 90�� �μ����� ����
SELECT* FROM DEPT WHERE DEPTNO = 90;
DELETE FROM DEPT WHERE DEPTNO = 90;
COMMIT;
SELECT * FROM DEPT;

--
DELETE FROM DEPT WHERE DEPTNO = 10;
-- EMP ���̺��� DEPTNO �÷��� �ο��� FK ���������� DEPT ���̺���  DEPTNO �÷����� ����
-- EMP �����̺� DEPTNO �÷����� �����ϴ�DEPT ���̺��� DEPTNO �÷����� �����ϴ�
-- ���� �������� �ʴ´�. => ������ ���Ἲ ����
SELECT DISTINCT DEPTNO FROM EMP; -- 10 20 30 40 �μ� �ڵ带 ���� �μ������� ���� ���� �ʴ´�.


-- EMP ���̺� ����� �μ��ڵ带 �ߺ����� �ʵ��� �˻�
-- => 10, 20,30,40 �μ��ڵ带 ���� �μ� ������ DEPT ���̺��� ���� ���� �ʴ´�.
-- ����ο� ������ ��ġ�� �ִ� ��� �μ����� ����(����� ����)
-- => WHERE ���� SUBQUERY ��� ����
DELETE FROM DEPT WHERE LOC = (SELECT LOC FROM DEPT WHERE DNAME = '�����');
COMMIT;
SELECT * FROM DEPT;


-- MERGE : ���� ���̺� �ٸ� ���̺� �����ϴ� ����Ÿ�� ����ȭ �� �� ����ϴ� ���
--  => ��Ȳ�� ���� ���̺� ���� �����ϰų� �����ϴ� ���
--  ����) MERGE INTO Ÿ�����̺� USING �������̺� ON ����
--      WHEN MATCHED THEN UPDATE SET Ÿ�� �÷��� = ���� �÷���,Ÿ���÷��� = �����÷���,...
--      WHEN NOT MATCHED THEN INSERT (Ÿ���÷���,...) VALUES(�����÷���,...);

-- MERGE_DEPT ���̺�

CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(10),LOC VARCHAR2(11));

SELECT TABLE_NAME FROM TABS;

-- MERGE_DEPT ���̺� �� ����
INSERT INTO MERGE_DEPT VALUES(30,'�ѹ���','����');

INSERT INTO MERGE_DEPT VALUES(60,'�����','��õ');


COMMIT;


SELECT * FROM MERGE_DEPT;

MERGE INTO MERGE_DEPT M USING DEPT D ON (M.DEPTNO = D.DEPTNO)
        WHEN MATCHED THEN UPDATE SET M.DNAME = D.DNAME, M.LOC = D.LOC
        WHEN NOT MATCHED THEN INSERT (DEPTNO,DNAME,LOC) VALUES(D.DEPTNO,D.DNAME,D.LOC);

-- DEPT ���̺� �����ϴ� �μ������� MERGE_DEPT ���̺� �μ������� ���� �Ǵ� ����
--  => �μ��ڵ尡 ���� �μ������� �ִ� ��� �μ��� �� ��ġ ����
--  => �μ� �ڵ尡 �������� �ʴ� ��� DEPT ���̺��� �μ������� MERGE_DEPT ���̺�
--      �μ������� ����
COMMIT;

SELECT * FROM MERGE_DEPT ORDER BY DEPTNO;


