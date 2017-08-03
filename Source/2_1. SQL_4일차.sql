--����1.
SELECT EMPNO,ENAME,D.DEPTNO,DNAME FROM EMP E JOIN DEPT D 
    ON E.DEPTNO=D.DEPTNO ORDER BY ENAME;
   
--����2.    
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D
    ON E.DEPTNO=D.DEPTNO WHERE SAL>=2000 ORDER BY SAL DESC;
    
--����3.
SELECT EMPNO,ENAME,JOB,SAL,DNAME FROM EMP E JOIN DEPT D
    ON E.DEPTNO=D.DEPTNO WHERE JOB='MANAGER' AND SAL>=2500 ORDER BY EMPNO;
    
--����4.
SELECT EMPNO,ENAME,SAL,GRADE FROM EMP JOIN SALGRADE 
    ON SAL BETWEEN LOSAL AND HISAL WHERE GRADE=4 ORDER BY SAL DESC; 
    
--����5.
SELECT EMPNO,ENAME,DNAME,SAL,GRADE FROM EMP E JOIN DEPT D ON E.DEPTNO=D.DEPTNO
    JOIN SALGRADE ON SAL BETWEEN LOSAL AND HISAL ORDER BY GRADE DESC;
    
--����6.
SELECT W.ENAME �����,M.ENAME �����ڸ� FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO;
SELECT W.ENAME �����,M.ENAME �����ڸ� FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO;

--����7.
SELECT W.ENAME �����,M.ENAME �����ڸ�,MM.ENAME "�������� �����ڸ�" 
    FROM EMP W JOIN EMP M ON W.MGR=M.EMPNO JOIN EMP MM ON M.MGR=MM.EMPNO;
    
--����8.
SELECT W.ENAME �����,M.ENAME �����ڸ�,MM.ENAME "�������� �����ڸ�" 
    FROM EMP W LEFT JOIN EMP M ON W.MGR=M.EMPNO LEFT JOIN EMP MM ON M.MGR=MM.EMPNO;

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

--����1.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT SAL FROM EMP WHERE ENAME='BLAKE');

--����2.
SELECT EMPNO,ENAME,HIREDATE FROM EMP 
    WHERE HIREDATE>(SELECT HIREDATE FROM EMP WHERE ENAME='MILLER');
    
--����3.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>(SELECT AVG(SAL) FROM EMP);

--����4.
SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO=(SELECT DEPTNO FROM EMP 
    WHERE ENAME='CLARK') AND SAL>(SELECT SAL FROM EMP WHERE EMPNO=7698);
    
--����5.
SELECT EMPNO,ENAME,DEPTNO,SAL FROM EMP 
    WHERE SAL IN (SELECT MAX(SAL) FROM EMP GROUP BY DEPTNO);
    
--SET ������ : �� ���� SELECT ����� �̿��Ͽ� ������(UNION),������(INTERSECT)
--,������(MINUS) ����� ��ȯ�ϴ� ������    

--TEST1 ���̺� ���� => �̸� ���� �÷�
CREATE TABLE TEST1(NAME VARCHAR2(10));

--TEST1 ���̺� �� ����(����)
INSERT INTO TEST1 VALUES('ȫ�浿');
INSERT INTO TEST1 VALUES('�Ӳ���');
INSERT INTO TEST1 VALUES('����ġ');
INSERT INTO TEST1 VALUES('������');
INSERT INTO TEST1 VALUES('����');
COMMIT;

SELECT * FROM TEST1;

--TEST2 ���̺� ���� => ��ȣ �� �̸� ���� �÷�
CREATE TABLE TEST2(NUM NUMBER(1),NAME VARCHAR2(10));

--TEST2 ���̺� �� ����(����)
INSERT INTO TEST2 VALUES(1,'���۸�');
INSERT INTO TEST2 VALUES(2,'ȫ�浿');
INSERT INTO TEST2 VALUES(3,'��Ʈ��');
INSERT INTO TEST2 VALUES(4,'����ġ');
INSERT INTO TEST2 VALUES(5,'��Ʈ��');
COMMIT;

SELECT * FROM TEST2;

--UNION : �� ���� SELECT���� �˻��� ��� ���� ���Ͽ� �˻�(�ߺ� �˻�����Ÿ ����)
-- => �� ���� SELECT ����� �˻���� ������ �ڷ����� �ݵ�� �����ؾ� �ȴ�.
SELECT NAME FROM TEST1 UNION SELECT NAME FROM TEST2;

--UNION ALL : �� ���� SELECT���� �˻��� ��� ���� ���Ͽ� �˻�(�ߺ� �˻�����Ÿ ����)
SELECT NAME FROM TEST1 UNION ALL SELECT NAME FROM TEST2;

--INTERSERT : �� ���� SELECT���� �˻��� �� �� �ߺ��� �ุ �˻�
SELECT NAME FROM TEST1 INTERSECT SELECT NAME FROM TEST2;

--MINUS : ù��° SELECT���� �˻��� �࿡�� �ι�° SELECT���� �˻��� ���� �����Ͽ� �˻�
SELECT NAME FROM TEST1 MINUS SELECT NAME FROM TEST2;

--�� ���� SELECT ����� �˻���� ���� �� �ڷ����� ��ġ���� ���� ��� ���� �߻�
--�˻������ �ڷ����� �ٸ��� ������ ���� �߻�
SELECT NAME FROM TEST1 UNION SELECT NUM FROM TEST2;
--�˻������ ������ �ٸ��� ������ ���� �߻�
SELECT NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;

--�˻������ �ڷ����� �ٸ� ��� => ��ȯ�Լ� ����Ͽ� �ڷ����� ���� ����� ���
SELECT NAME FROM TEST1 UNION SELECT TO_CHAR(NUM,'0') FROM TEST2;

--�˻������ ������ �ٸ� ��� => �˻������ �߰��ϰų� ���ǰ�(NULL)�� �̿�
SELECT 1,NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;
SELECT NULL,NAME FROM TEST1 UNION SELECT NUM,NAME FROM TEST2;

--DML(DATA MANIPLATION LANGUAGE) : ����Ÿ ���۾�
-- => ���� �����ϰų� ����,�����ϱ� ���� SQL ���
-- => DML ��� ���� �� COMMIT(DML ��� ����) �Ǵ� ROLLBACK(DML ��� ���) ��� ����

--INSERT : ���̺� ���� �����ϴ� ���
--����1)INSERT INTO ���̺�� VALUES(�÷���,�÷���,�÷���,...);
--����Ǵ� �÷����� ���̺��� ����(�÷� ����,�ڷ���,ũ��)�� �°� ���ʴ�� �����Ͽ� ����
--���̺��� ���� Ȯ�� => ����) DESC ���̺��;

--�μ����̺�(DEPT)�� �μ������� ����(����)
SELECT * FROM DEPT;
DESC DEPT;
INSERT INTO DEPT VALUES(50,'ȸ���','����');
COMMIT;
SELECT * FROM DEPT;

--DEPT ���̺��� DEPTNO �÷��� PK(PRIMARY KEY) ���������� �ο��Ǿ� �ִ�.
-- => PK ���������� �ο��� �÷��� �ߺ��� �÷����� ������ ��� ���� �߻�
INSERT INTO DEPT VALUES(50,'�ѹ���','����');--�ߺ��� ���忡 ���� ���� �߻�
INSERT INTO DEPT VALUES(60,'�ѹ���','����');
COMMIT;
SELECT * FROM DEPT;

--���� ���̺��� �÷� ������ �÷����� ������ �ٸ� ��� ���� �߻� => �÷��� ���� ����
INSERT INTO DEPT VALUES(70,'�����');--�μ���ġ�� ���� �÷����� ���� �Ǿ� ���� �߻�

--���̺��� �÷��� ����Ǵ� �÷������� NULL ����� �������� Ȯ��
DESC DEPT;

--�÷����� �����ϰ��� �� ��� �÷��� NULL ���� => ����� NULL ���
INSERT INTO DEPT VALUES(70,'�����',NULL);
COMMIT;
SELECT * FROM DEPT;

--����2)INSERT INTO ���̺��(�÷���,�÷���,...) VALUES(�÷���,�÷���,...);
-- => ���̺�� �ڿ� () �ȿ� ������ �÷� ������� �÷����� ����
INSERT INTO DEPT(DEPTNO,LOC,DNAME) VALUES(80,'��õ','������');
COMMIT;
SELECT * FROM DEPT;

--���̺�� ���� () �ȿ� �����Ǵ� �÷����� ���� ����
-- => ������ �÷����� ���̺� ������ ����� DEFAULT �÷����� �ڵ����� ����ȴ�.
-- => DEFAULT �÷����� �������� ������ �ڵ����� NULL�� DEFAULT �÷������� ����
INSERT INTO DEPT(DEPTNO,DNAME) VALUES(90,'�λ��');
COMMIT;
SELECT * FROM DEPT;

--������̺�(EMP)�� ���ο� ��������� ����(����)
DESC EMP;
INSERT INTO EMP VALUES(9000,'LEE','MANAGER',7298,'17/07/18',3000,100,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9000;

--�Ի����� ����� �Ͽ� ������̺� ���ο� ��������� ����(����)
INSERT INTO EMP VALUES(9001,'KIM','ANALYST',9000,SYSDATE,2000,NULL,40);
COMMIT;
SELECT * FROM EMP WHERE EMPNO=9001;

--EMP ���̺��� DEPTNO �÷��� FK(FOREIGN KEY) ���������� �ο��Ǿ� �ִ�.
--FK ���������� �ο��� �÷��� �ٸ� ���̺��� PK ���������� �ο��� �÷����� �����Ͽ�
--����Ÿ�� ����ǵ��� ������ ��������
-- => EMP ���̺��� DEPTNO �÷��� ����Ÿ ����� DEPT ���̺��� DEPTNO �÷����� ����
--    �Ͽ� ����Ǹ� ������ �÷����� �������� ���� ��� ���� �߻� => ����Ÿ ���Ἲ ����
--DEPT ���̺� 45�� �μ��� ���� ������ �� ���� ���� �߻�
INSERT INTO EMP VALUES(9002,'PARK','CLERK',9000,SYSDATE,1200,NULL,45);
SELECT * FROM DEPT WHERE DEPTNO=45;--45�� �μ��� �������� �ʴ´�.

--SUBQUERY�� �̿��� �� ���� => ���̺� �� ����
--����)INSERT INTO ���̺�� SELECT �˻����,... FROM ���̺��;
-- => INSERT ����� SUBQUERY�� () �ȿ� �ۼ����� �ʴ´�.
-- => INSERT ���̺��� �÷��� SUBQUERY �˻������ ������ �����ؾ߸� �ȴ�.
--    (�÷� ���� �� �ڷ����� �ݵ�� ���ƾ� �Ǹ� �÷����� ���� �ʾƵ� �ȴ�.)
SELECT TABLE_NAME FROM TABS;--���� �α��� ����ڰ� ��� ������ ���̺� ��� Ȯ��
DESC BONUS;
SELECT * FROM BONUS;

--EMP ���̺� ����� ��� �� ���ʽ��� NULL�� �ƴ� ����� ����̸�,����,�޿�,���ʽ���
--�˻��Ͽ� BONUS ���̺� ����
INSERT INTO BONUS SELECT ENAME,JOB,SAL,COMM FROM EMP WHERE COMM IS NOT NULL;
COMMIT;
SELECT * FROM BONUS;

--UPDATE : ���̺� ����� ����Ÿ�� �����ϴ� ���
--����) UPDATE ���̺�� SET �÷���=���氪,�÷���=���氪,... [WHERE ���ǽ�];
-- => WHERE ���ǽ��� �����Ǹ� ���̺� ����� ��� ���� �÷����� �ϰ������� ����
-- => WHERE�� ���ǽĿ��� ���Ǵ� �÷��� PK ���������� �ο��� �÷��� ����ϴ� ���� ����

--�μ��ڵ尡 50���� �μ������� �˻�
SELECT * FROM DEPT WHERE DEPTNO=50;--�μ���:ȸ���,�μ���ġ=����

--�μ��ڵ尡 50�� �μ��� �μ����� �渮�η� �����ϰ� �μ���ġ�� ��õ���� ����
-- => PK�� �ο��� �÷����� �������� �ʴ� ���� ����
UPDATE DEPT SET DNAME='�渮��',LOC='��õ' WHERE DEPTNO=50;
COMMIT;
SELECT * FROM DEPT WHERE DEPTNO=50;

--�����ȣ�� 9000�� ����� �μ��ڵ带 45�� ����
-- => FK�� �ο��� �÷����� �����Ǵ� �ٸ� ���̺��� �÷������θ� ���� ����
UPDATE EMP SET DEPTNO=45 WHERE EMPNO=9000;--���� �߻�

--������� �μ���ġ�� �ѹ����� �μ���ġ�� ������ ������ ����
SELECT * FROM DEPT WHERE DNAME='�����';--�μ���ġ : NULL
SELECT * FROM DEPT WHERE DNAME='�ѹ���';--�μ���ġ : ����

--���� �÷������� SUBQUERY ���
UPDATE DEPT SET LOC=(SELECT LOC FROM DEPT WHERE DNAME='�ѹ���') WHERE DNAME='�����';
COMMIT;
SELECT * FROM DEPT WHERE DNAME='�����';

--BONUS ���̺��� ALEEN ���� ���ʽ��� ���� ������� 200�� ���ϵ��� ����
-- => WHERE���� SUBQUERY ���
SELECT * FROM BONUS;
UPDATE BONUS SET COMM=COMM+200 
    WHERE COMM<(SELECT COMM FROM BONUS WHERE ENAME='ALLEN');
COMMIT;
SELECT * FROM BONUS;

--DELETE : ���̺� ����� ���� �����ϴ� ���
--����) DELETE FROM ���̺�� [WHERE ���ǽ�];
-- => WHERE ���ǽ��� �����Ǹ� ���̺� ����� ��� �� ����
-- => WHERE�� ���ǽĿ��� ���Ǵ� �÷��� PK ���������� �ο��� �÷��� ����ϴ� ���� ����

--�μ����̺��� �μ��ڵ尡 90�� �μ����� ����
SELECT * FROM DEPT WHERE DEPTNO=90;
DELETE FROM DEPT WHERE DEPTNO=90;
COMMIT;
SELECT * FROM DEPT WHERE DEPTNO=90;


--�μ����̺��� �μ��ڵ尡 10�� �μ����� ����
DELETE FROM DEPT WHERE DEPTNO=10;--���� �߻�
--EMP ���̺��� DEPTNO �÷��� �ο��� FK ���������� DEPT ���̺��� DEPTNO �÷��� ����
--EMP ���̺� DEPTNO �÷����� �����ϴ� DEPT ���̺��� DEPTNO �÷����� �����ϴ� 
--���� �������� �ʴ´�. => ����Ÿ ���Ἲ ����
SELECT * FROM EMP WHERE DEPTNO=10;

--EMP ���̺� ����� �μ��ڵ带 �ߺ����� �ʵ��� �˻�
-- => 10,20,30,40 �μ��ڵ带 ���� �μ������� DEPT ���̺��� �������� �ʴ´�.
SELECT DISTINCT DEPTNO FROM EMP;
DELETE FROM DEPT WHERE DEPTNO=20;--���� �߻�
DELETE FROM DEPT WHERE DEPTNO=80;--���� ����
COMMIT;
SELECT * FROM DEPT;

--����ο� ������ ��ġ�� �ִ� ��� �μ����� ����(����� ����)
-- => WHERE���� SUBQUERY ��� ����
SELECT * FROM DEPT;
DELETE FROM DEPT WHERE LOC=(SELECT LOC FROM DEPT WHERE DNAME='�����');
COMMIT;
SELECT * FROM DEPT;

--MERGE : Ÿ�� ���̺� ���� ���̺��� ����Ÿ�� ����ȭ �� �� ����ϴ� ���
-- => ���ǿ� ���� ���� ���̺��� ���� Ÿ�� ���̺� �����ϰų� �����ϴ� ���
--����) MERGE INTO Ÿ�����̺� USING �������̺� ON (���ǽ�)
--      WHEN MATCHED THEN UPDATE SET Ÿ���÷���=�����÷���,Ÿ���÷���=�����÷���,...
--      WHEN NOT MATCHED THEN INSERT (Ÿ���÷���,...) VALUES(�����÷���,...);

--MERGE_DEPT ���̺� ���� => Ÿ�����̺�
CREATE TABLE MERGE_DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(10),LOC VARCHAR2(11));

--MERGE_DEPT ���̺� �� ����
INSERT INTO MERGE_DEPT VALUES(30,'�ѹ���','����');
INSERT INTO MERGE_DEPT VALUES(60,'�����','��õ');
COMMIT;
SELECT * FROM MERGE_DEPT;

--DEPT ���̺� �����ϴ� �μ������� MERGE_DEPT ���̺� �μ������� ���� �Ǵ� ����
-- => �μ��ڵ尡 ���� �μ������� �ִ� ��� DEPT ���̺��� �μ��� �� ��ġ��
--    MERGE_DEPT ���̺��� �μ��� �� ��ġ ����
-- => �μ��ڵ尡 �������� �ʴ� ��� DEPT ���̺��� �μ������� MERGE_DEPT 
--    ���̺� �μ������� ����
SELECT * FROM DEPT;
SELECT * FROM MERGE_DEPT;

MERGE INTO MERGE_DEPT M USING DEPT D ON (M.DEPTNO=D.DEPTNO)
    WHEN MATCHED THEN UPDATE SET M.DNAME=D.DNAME,M.LOC=D.LOC
    WHEN NOT MATCHED THEN INSERT (DEPTNO,DNAME,LOC) VALUES(D.DEPTNO,D.DNAME,D.LOC);
COMMIT;
SELECT * FROM MERGE_DEPT ORDER BY DEPTNO;