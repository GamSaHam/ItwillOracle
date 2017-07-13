-- ���� ó��

-- ��ũ ��Ʈ�� SQL ��� ���� : ctrl + enter 
-- ���� Ŀ���� ��ġ�� ���� ����� �����ϰų� �� ���� ����
-- F5 : ��ü ��ũ��Ʈ�� ����� �����ϰų� �������� ��� ����

-- ���� �α��� ������ ����� �� �ִ� ���̺�(�����͸� �����ϱ� ���� ��ü) ��� Ȯ��
select table_name from tabs;
select * from tab;

-- ���̺��� ����(�Ӽ�) Ȯ�� => ����) DESC ���̺��;
desc emp;
desc dept;

-- NUMBER(4) 0~9999 NUMBER(7,2) xx.xx
-- VARCHAR2(10) 10����
-- NOT NULL �⺻Ű

-- select : �ϳ� �̻��� ���̺��� �����͸� �˻��ϱ� ���� ��ɾ� (DQL: DATA QUERY LANGUAGE)
-- ����) select �˻����, �˻����, ... from ���̺��;
-- �˻���� : * (���), �÷���, �����, �Լ�, 
select * from emp;
select empno,ename,sal,deptno from emp;

-- �÷� ALIAS : �÷��� ������ �ο��ϴ� ��� (�÷����� �ܼ�ȭ �ϰų� ��Ȯ�� �ǹ̸� �ο�)
-- ����) select �˻���� [as] ����,�˻���� [as] ����,... From ���̺��;
--       �÷� ALIAS ���� ���� �Ǵ� Ư����ȣ�� ����ؾ� �� ��� " " �ȿ� ǥ��
select empno as �����ȣ,ename as ����̸�,sal as "��  ��", deptno as �μ��ڵ� from emp;

-- �˻�������� ����� ��� ���� => ����Ŀ� ���� �÷��� ��� Į�� ALIAS ���
-- DUAL : ���̺��� �ʿ���� �˻� ����� ��� ����ϴ� ������ ���̺�
SELECT 20+10 FROM DUAL;
SELECT 20+10 RESULT FROM DUAL;

DESC DUAL;

-- EMP ���̺��� �����ȣ, ����̸�, ���� �˻�
-- SQL������ �ĺ��ڸ� �ۼ��Ҷ� �ܾ�� �ܾ��� �����ڷ� _�� ����Ѵ�.
select empno, ename, sal*12 ANNAUL_SALARY from emp;

-- �÷��� �������� �� NOT NULL�� �ο��� �÷��� ��� NULL�� ������� ������
-- NOT NULL ���������� ���� Į������ NULL�� ������ �� �ִ�.
desc emp;
select * from emp;

-- emp ���̺��� ��� ����� �����ȣ, ����̸�, ����((�޿�+���ʽ�) * 12) �˻�
-- null�� ���� �Ұ��� => ���ʽ��� null �� ����� ������ null�� �˻�(�˻� ����)
select empno, ename, (sal+comm)*12 ANNAUL_SALARY from emp;

-- �˻���� ���� ����� || ��ȣ(���ڿ� ����)�� �̿��Ͽ� ���� ��� ����
-- ORACLE������ ������ ��� �Ǵ� ��¥�� ��� ' ' �ȿ� ǥ��
select ename||' ���� ������ '|| job || '�Դϴ�.' as "����� ����" from emp;

-- ��� ����� ���� �˻� => �ߺ� ����� �˻�
-- DISTINCT �ߺ� ���� ���� �ϳ����� ���
select distinct job from emp;

-- ORACLE�� �ΰ� �̻��� �÷��� DISTINCT Ű���带 �̿��Ͽ� �˻��� ����
select distinct job,DEPTNO from emp;

-- WHERE : ���ǽ��� ����Ͽ� ����� ��(TRUE)�� ��(ROW)�� �˻�
-- ����) SELECT �˻����,... FROM ���̺�� WHERE ���ǽ�

-- ��� ����� �����ȣ, ����̸�, ����, �ݿ� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP;

-- �����ȣ�� 7698�� ����� �����ȣ, ����̸�, ����, �ݿ� �˻�
-- ���ǽĿ��� ���� ���� ����ϴ� �÷��� PK ���������� �ο��� �÷�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE EMPNO = 7369;

-- ����̸��� KING �� ����� �����ȣ, ����̸�, ����, �޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME = 'KING';

-- SQL ����� ��ҹ��ڸ� �������� ������ ������ ����� ��ҹ��ڸ� �����Ѵ�.(����)

-- �Ի����� 1981�� 6�� 9�� ����� �����ȣ, ����̸�, ����, �޿�, �Ի��� �˻�
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE FROM EMP WHERE HIREDATE = '81/06/09';
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE FROM EMP WHERE HIREDATE = '1981-06-09';

-- ����� ������ SALESMAN�� �ƴ� ����� �����ȣ, ����̸�, ����, �޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB != 'SALESMAN';
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB <> 'SALESMAN';

-- ����� �޿��� 2000�̻��� ����� �����ȣ, ����̸�, ����, �޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE SAL>=2000;

-- ������ �Ǵ� ��¥�� �����͵� ũ�⸦ ���� �� �ִ�.
-- ����� �Ի����� 1981�� 5�� 1�� ����� �����ȣ, ����̸�, ����, �޿�, �Ի��� �˻�
SELECT EMPNO, ENAME, JOB, SAL,HIREDATE FROM EMP WHERE HIREDATE < '81/05/01';

-- ������ SALESMAN�� ��� �� �޿��� 2500 �̻� ����� �����ȣ, ����̸�, ����, �޿�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB = 'SALESMAN' AND SAL >= 1500;

-- �μ��ڵ尡 10�̰ų� ������ MANAGER�� ����� �����ȣ, ����̸�, ����, �޿�, �μ��ڵ�
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP WHERE DEPTNO=10 OR JOB ='MANAGER';

-- �޿��� 1500~3000�� ����� �����ȣ, ����̸�, ����, �޿�
SELECT EMPNO, ENAME JOB, SAL FROM EMP WHERE SAL >=1500 AND SAL <=3000;

-- ���� ������ : ��1 ~ ��2�� ǥ���ϱ� ���� ������
-- ����) �÷��� BETWEEN ������ AND ū��
SELECT EMPNO, ENAME JOB, SAL FROM EMP WHERE SAL BETWEEN 1500 AND 3000;

-- ������ SALESMAN�̰ų� ANALYST�� ����� �����ȣ,����̸�,����,�޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB = 'SALESMAN' OR JOB = 'ANALYST';

-- ���� ������ : �÷��� ����� �����Ͱ� ���� ���� ������ �� �ϳ������� Ȯ���ϱ� ���� ������
-- ����) �÷��� IN (��1, ��2, ...)
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE JOB IN('SALESMAN', 'ANALYST');

-- ����̸��� ALLEN�� ����� �����ȣ, ����̸�, ����, �޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME = 'ALLEN';

-- ����̸��� A�� ���۵Ǵ� ����� �����ȣ, ����̸�,����,�޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME >= 'A' AND ENAME <'B';

-- �˻� ���� ��ȣ: �����͸� �˻��� �� ����ϴ� �˻� ��ȣ => % : ��ü _ �����ϳ�
-- �˻����ϱ�ȣ�� ����� ��� = �����ڸ� ����ϸ� �˻����� �ʴ´�. (�˻����ϱ�ȣ�� ���ڷ� �ν�)
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME = 'A%';

-- ���� ������ : �˻� ���� ��ȣ�� �̿��Ͽ� �˻��ϰ��� �� ��� ����ϴ� ������
-- ����) �÷��� LIKE '�� �Ǵ� �˻����ϱ�ȣ'
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE 'A%';


-- => = ������ ��� LIKE ������ ��� ����
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE 'ALLEN';

-- ����̸��� A���ڰ� �ִ� ��� �����ȣ, ����̸�,����,�޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE '%A%';

-- ����̸� �ι�° ���ڰ� L����� �����ȣ, ����̸�,����,�޿� �˻�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE '__L%';

-- EMP ���̺� ���ο� ��� �߰�
INSERT INTO EMP VALUES(9000,'M_BEER','CLERK',7788,'81/12/12',1300,NULL,10);

COMMIT;

SELECT *FROM EMP WHERE EMPNO=9000;

-- ����̸��� _�ٰ� �����ϴ� ��� �˻�
-- => LIKE �����ڴ� % �Ǵ� _�� ���ڰ� �ƴ� �˻� ���� ��ȣ�� �ν�
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE ENAME LIKE '%\_%' ESCAPE '\';

--% �Ǵ� _�� ���ڷ� �ν� ��Ű�� ���� ESCAPE Ű���� ���
-- => ESCAPE Ű����� ���й��ڸ� �����ϸ� �˻����� ��ȣ�� �ƴ� ���ڷ� �ν�

-- EMP ���̺� ����� ��� ����
DELETE FROM EMP WHERE EMPNO = 9000;

COMMIT;

SELECT * FROM EMP WHERE EMPNO =9000;

-- ������ SALESMAN�� �ƴ� ����� �����ȣ, ����̸�, ����, �޿� �˻�
-- NOT ������
SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE NOT(JOB ='SALESMAN');

-- ���ʽ��� NULL�� ����� �����ȣ, ����̸�, ����, �޿� , ���ʽ� �˻�
-- => NULL�� �� �����ڸ� �̿��Ͽ� ���ǽ� �ۼ� �Ұ���
-- IS [NOT] ������ : �÷��� ����� �����Ͱ� NULL�� ��� ���ϱ� ���� ������
SELECT EMPNO, ENAME, JOB, SAL,COMM FROM EMP WHERE COMM IS NOT NULL;










