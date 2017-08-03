--TCL(TRANSACTION CONTROL LANGUAGE) : Ʈ������ �����
-- => Ʈ�������� �����ϰų� ����ϴ� ���

--Ʈ������(TRANSACTION) : ���� ���ǿ��� �����Ǵ� SQL ����� �۾� ����
-- => ����(SESSION) : DBMS�� �����Ͽ� ����� ������ �� �ִ� �۾� ȯ��

--Ʈ������ ���� : ���ǿ��� SQL ���(DML,DDL,DCL)�� ����Ǹ� �ڵ����� Ʈ������ ����

--Ʈ������ ���� : ���� ���ǿ��� ����� SQL ����� ����� ���� ���̺� ���� �� ����
-- => ������ ���������� ����� ��� �ڵ����� Ʈ������ ����
-- => DDL �Ǵ� DCL ��� ���� �� �ڵ����� Ʈ������ ����
-- => DML ��� ���� �� COMMIT ����� �̿��Ͽ� Ʈ������ ����

--Ʈ������ ��� : ���� ���ǿ��� �����ϴ� Ʈ������ ����
-- => ������ ������������ ����� ��� �ڵ����� Ʈ������ ���
-- => DML ��� ���� �� ROLLBACK ����� �̿��Ͽ� Ʈ������ ���

--���ǿ� Ʈ�������� �������� �ʴ� ��� SELECT ����� ���� ���̺��� ����Ÿ �˻�
SELECT * FROM DEPT;

--�μ����̺��� 50�� �μ� ����
DELETE FROM DEPT WHERE DEPTNO=50;--Ʈ������ ����

--���ǿ� Ʈ�������� ������ ��� SELECT ����� Ʈ�����ǿ� �����ϴ� ���̺��� ����Ÿ �˻�
-- => 50�� �μ������� ���� �Ǿ����� ���� ���̺����� �������� �ʾҴ�.
SELECT * FROM DEPT;

--Ʈ������ ���
ROLLBACK;--Ʈ������ ����

--���� ���̺��� ����Ÿ �˻� => 50�μ� ����
SELECT * FROM DEPT;

--�μ����̺��� 50�� �μ� ����
DELETE FROM DEPT WHERE DEPTNO=50;
SELECT * FROM DEPT;--Ʈ������ �˻�

--Ʈ������ ���� : ���� ���̺� DML ����� ����� ���� 
-- => 50�� �μ����� ���� ���̺��� ����
COMMIT;--Ʈ������ ����

SELECT * FROM EMP;--���� ���̺� �˻�
DELETE FROM EMP;--��� ������� ���� => Ʈ������ ����
SELECT * FROM EMP;--Ʈ������ �˻�
ROLLBACK;--Ʈ������ ���
SELECT * FROM EMP;--���� ���̺� �˻�

--Ʈ�������� �̿��ϴ� ���� : ����Ÿ �ϰ��� ����
--���ʽ� ���̺��� ����̸��� LEE�� ��������� ����
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='LEE';--���� ������ Ʈ�����ǿ����� ����
SELECT * FROM BONUS;--LEE ��� ���� Ȯ��
--�ٸ� ���ǿ��� ���ʽ� ���̺��� �˻��� ��� LEE ��� ���� 
-- => ����Ÿ �ϰ��� : ������ �۾��� ����Ǳ� ������ ���� ����Ÿ Ȯ��
COMMIT;--���� ���̺� ����Ǿ� �ٸ� ���ǿ����� LEE ��� ���� Ȯ��

--����Ÿ LOCK : ���� ���ǿ��� ó������ Ʈ�������� ����Ÿ�� LOCK�� �ɾ� �ٸ� ���ǿ�����
--Ʈ�������� ����Ÿ�� ������� ���ϵ��� �ϴ� ���

--���ʽ� ���̺��� ����̸��� MARTIN�� ����� �޿��� 1400���� ����
SELECT * FROM BONUS;
UPDATE BONUS SET SAL=1400 WHERE ENAME='MARTIN';

--�ٸ� ���ǿ��� MARTIN ����� ���ʽ��� �޿��� 50%���� ����
-- => ���� ���ǿ��� Ʈ�������� �Ϸ���� ���� ��� �ٸ� ���ǿ����� Ʈ������ ���� 
--    ����Ÿ�� ���� �Ұ��� 
-- => ����Ÿ LOCK�� �߻��Ͽ� �ٸ� ���ǿ����� DML ����� �����·� ����

--���� ������ Ʈ������ ó�� �Ϸ� �� ����Ÿ LOCK�� �����Ǿ� �ٸ� ������ DML ��� ����
COMMIT;

--SAVEPOINT : Ʈ�������� �����ϱ� ���� ����ϴ� ���
--����) SAVEPOINT �󺧸�;

--���ʽ� ���̺��� ����̸��� MARTIN�� ������� ����
SELECT * FROM BONUS;
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--���ʽ� ���̺��� ����̸��� ALLEN�� ������� ����
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--ROLLBACK ��ɿ� ���� Ʈ�����ǿ� ����� ��� DML ����� ����� ��� ����
ROLLBACK;
SELECT * FROM BONUS;

--���ʽ� ���̺��� ����̸��� MARTIN�� ������� ����
DELETE FROM BONUS WHERE ENAME='MARTIN';
SELECT * FROM BONUS;

--SAVEPOINT ����
SAVEPOINT SP1;

--���ʽ� ���̺��� ����̸��� ALLEN�� ������� ����
DELETE FROM BONUS WHERE ENAME='ALLEN';
SELECT * FROM BONUS;

--SAVEPOINT ����
SAVEPOINT SP2;

--���ʽ� ���̺��� ��� ������� ����
DELETE FROM BONUS;
SELECT * FROM BONUS;

--SAVEPOINT�� ������ �󺧸��� �̿��Ͽ� ���ϴ� DML ��ɱ����� ��ҵǵ��� ROLLBACK ����
--����) ROLLBACK TO �󺧸�;
ROLLBACK TO SP2;--SP2 �� �ڿ� �����ϴ� ��� DML ��� ���
SELECT * FROM BONUS;

ROLLBACK TO SP1;--SP1 �� �ڿ� �����ϴ� ��� DML ��� ���
SELECT * FROM BONUS;

ROLLBACK;--��� DML ��� ���
SELECT * FROM BONUS;

--DDL(DATA DEFINITION LANGUAGE) : ����Ÿ ���Ǿ�
-- => ����Ÿ���̽� ��ü(���̺�,��,��������)�� ����,����,�����ϱ� ���� ���

--���̺�(����Ÿ(��)�� �����ϱ� ���� ��ü) ����
--����) CREATE TABLE ���̺��(�÷��� �ڷ��� [DEFAULT �⺻��] [��������],
--       �÷��� �ڷ��� [DEFAULT �⺻��] [��������],...);
-- => ����� �÷� ������� �Ӽ��� ���ǵ� ���̺� ����

--�ĺ��� �ۼ� ��Ģ
-- => �ĺ��ڴ� ���ڷ� �����ϸ� 1~30 ������ ���ڷ� �ۼ��Ѵ�.
-- => �ĺ��ڴ� A~Z,a~z,0~9,_,$,# ���ڷ� �ۼ��Ѵ�.
-- => �ѱ� ��뵵 ���������� �������� �ʴ´�.
-- => ���� ����ڴ� ���� �̸��� �ĺ��ڰ� �ߺ����� �ʵ��� �����Ѵ�.
-- => ORACLE�� �����(Ű����)�� ����� �� ����.
-- => ��ҹ��ڸ� �������� �ʴ´�.

--�ڷ���(DATA TYPE) : �÷������� ������ �� �ִ� ����Ÿ�� ����
-- => ������ : NUMBER[(��ü�ڸ���[,�Ҽ����ڸ���])]
-- => ������ : CHAR(ũ��) : ũ�� - 1BYTE~2000BYTE(��������)
--            VARCHAR2(ũ��) : ũ�� - 1BYTE~4000BYTE(��������)
--            LONG : 2GBYTE(��������) => �������� ���ڿ� ����(���̺��� �÷� �ϳ����� �ο�)
--            CLOB : 4GBYTE(��������) => 1BYTE ����(���� - DBCLOB : 2BYTE ����)
-- => ��¥�� : DATE - ��¥�� �ð������� ���� ����Ÿ 
--            TIMESTAMP - 1970�� 1�� 1���� �������� �����Ǵ� �� ���� ����Ÿ

--SALESMAM ���̺� ���� => �����ȣ,����̸�,�Ի��Ͽ� ���� �÷����� ����
CREATE TABLE SALESMAN(NO NUMBER(4),NAME VARCHAR2(20),STARTDATE DATE);

--���� �α��� ����ڰ� ��� ������ ���̺� ��� Ȯ��
-- => ���� ��ųʸ�(USER_DICTIONARY) : �Ϲ� ����ڰ� �����Ͽ� �˻��� �� �ִ� 
--    �ý��� ������ ������ ������ ���̺� - ���� : ALL_DICTIONARY, DBA_DICTIONARY
-- => USER_OBJECTS : ��ü ������ �����ϰ� �ִ� ���� ��ųʸ�
DESC USER_OBJECTS;
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TABLE';

--USER_TABLES(TABS) : ���̺� ������ �����ϰ� �ִ� ���� ��ųʸ�
DESC USER_TABLES;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT TABLE_NAME FROM TABS;

--���̺� ���� Ȯ��
DESC SALESMAN;

--���̺� ����Ÿ ����(����) �� Ȯ��
INSERT INTO SALESMAN VALUES(1000,'ȫ�浿','17/07/19');
COMMIT;
SELECT * FROM SALESMAN;

--�����ȣ �÷��� PK ���������� �����Ƿ� �ߺ� �����ȣ ���� ����
INSERT INTO SALESMAN VALUES(1000,'�Ӳ���',SYSDATE);
COMMIT;
SELECT * FROM SALESMAN;

--����Ÿ ����� �÷��� ������ ��� �⺻������ NULL ����(������ NULL ���)
-- => ���̺� ������ �÷��� DEFAULT�� �������� ������ �⺻������ NULL�� �ڵ� ����
INSERT INTO SALESMAN(NO,NAME) VALUES(3000,'����ġ');
COMMIT;
SELECT * FROM SALESMAN;

--EMP ���̺� ����� ��� �� ������ SALESMAN�� ����� �˻��Ͽ� SALESMAN ���̺� ����
-- => INSERT �Ǵ� MARGE ��� ���
INSERT INTO SALESMAN SELECT EMPNO,ENAME,HIREDATE FROM EMP WHERE JOB='SALESMAN';
COMMIT;
SELECT * FROM SALESMAN;

--���̺� ����Ÿ ����� ���� �÷��� NULL�� �ƴ� ���ϴ� ������ �⺻���� ����ǵ��� 
--�����ϰ��� �� ��� DEFAULT �ɼ� ���
-- => DEFAULT�� �⺻���� ��� �Ǵ� Ű���� ���

--MANAGER ���̺� ���� 
-- => �����ȣ,����̸�,�Ի���(�⺻��:����),�޿�(�⺻��:1000)�� ���� �÷����� ����
CREATE TABLE MANAGER(NO NUMBER(4),NAME VARCHAR2(20)
    ,STARTDATE DATE DEFAULT SYSDATE,PAY NUMBER(4) DEFAULT 1000);
    
--���̺� ���� �� ���� Ȯ��
SELECT TABLE_NAME FROM TABS WHERE TABLE_NAME='MANAGER';--���̺� ��� Ȯ��
DESC MANAGER;--���̺� ���� Ȯ��

--���̺��� �÷��� �ο��� DEFAULT ������ Ȯ�� => USER_TAB_COLUMNS ���� ��ųʸ� Ȯ��
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='MANAGER';

--MANAGER ���̺� ������� ���� => �����ȣ,����̸��� ����
INSERT INTO MANAGER(NO,NAME) VALUES(1000,'���缮');
COMMIT;
SELECT * FROM MANAGER;--���� �÷����� DEFAULT ������ �ڵ� ����

INSERT INTO MANAGER VALUES(2000,'�ڸ��','17/07/20',2000);
COMMIT;
SELECT * FROM MANAGER;

--DEFAULT Ű���带 �̿��ϸ� �÷��� �ο��� DEFUALT �������� �̿��� �� �ִ�.
INSERT INTO MANAGER VALUES(3000,'������',DEFAULT,DEFAULT);
COMMIT;
SELECT * FROM MANAGER;

--SUBQUERY�� �̿��� ���̺� ���� �� ����Ÿ ����
--����) CREATE TABLE ���̺��[(�÷���,...)] AS SELECT �˻����,... FROM ���̺��;
-- => SUBQUERY�� �˻����� ������ �÷���� �ڷ����� ���� ���̺� ����
-- => ���� ���̺�� ����� () �ȿ� �÷����� �����ϸ� �÷��� ���� ����
-- => ������ ���̺� �˻��� ����Ÿ�� ����Ǿ� ����
-- => SUBQUERY�� �˻����� ������ ������ ������ ���������� ������� �ʴ´�.

--EMP ���̺��� ��� ����� ��ü �÷��� �˻��Ͽ� EMP2 ���̺� ���� �� ����Ÿ ����
CREATE TABLE EMP2 AS SELECT * FROM EMP;

--���̺� ���� ���� => �������� ����
DESC EMP;--EMPNO �÷��� PK �������� �ο� Ȯ��
DESC EMP2;--EMPNO �÷��� PK �������� �̺ο� Ȯ��

--���� ����Ÿ ����
SELECT * FROM EMP;
SELECT * FROM EMP2;

--SUBQUERY�� �˻���� �Ǵ� ���ǽĿ� ���� ���� ���̺� ���� �� ���� ����Ÿ�� ����
CREATE TABLE EMP3 AS SELECT EMPNO,ENAME,SAL FROM EMP;
DESC EMP3;
SELECT * FROM EMP3;

CREATE TABLE EMP4 AS SELECT EMPNO,ENAME,SAL FROM EMP WHERE SAL>2000;
DESC EMP4;
SELECT * FROM EMP4;

--SUBQUERY�� �˻����� �ٸ� �÷��� ��� ����
CREATE TABLE EMP5(NO,NAME,PAY) AS SELECT EMPNO,ENAME,SAL FROM EMP;
DESC EMP5;
SELECT * FROM EMP5;

--SUBQUERY�� �̿��Ͽ� ����Ÿ ����� ���� �ʰ� ���̺� ������ �ϰ��� �� ��� SUBQUERY��
--���ǽĿ��� ������ ������ �߻��ǵ��� �����ϸ� ����
CREATE TABLE EMP6 AS SELECT * FROM EMP WHERE 0=1;
DESC EMP6;
SELECT * FROM EMP6;

--�������� : �÷��� �߸��� �÷����� ����Ǵ� ���� �������� �ϱ� ���� �÷��� �������� ����
-- => ����Ÿ ���Ἲ�� �����ǵ��� �ϱ� ���� ���
-- => �÷� ������ �������� : �÷� ������ �������� �ο�
-- => ���̺� ������ �������� : �÷� ���� �� �������� �ο�

--NOT NULL : �÷��� NULL ������ ������� �ʴ� ��������
-- => �÷� ������ �����������θ� �ο� ����
--NOT NULL ���������� �ο����� ���� �÷��� NULL ������ ���(�⺻)
CREATE TABLE DEPT1(DEPTNO NUMBER(2),DNAME VARCHAR2(12),LOC VARCHAR2(11));
DESC DEPT1;
INSERT INTO DEPT1 VALUES(10,NULL,NULL);
COMMIT;
SELECT * FROM DEPT1;

--��� �÷��� NULL�� ������� �ʴ� ���̺� ����
CREATE TABLE DEPT2(DEPTNO NUMBER(2) NOT NULL
    ,DNAME VARCHAR2(12) NOT NULL,LOC VARCHAR2(11) NOT NULL);
DESC DEPT2;    
--NOT NULL �������ǿ� ���� �÷������� NULL ����� ���� �߻�
INSERT INTO DEPT2 VALUES(10,NULL,NULL);--���� �߻�

--�÷��� �ο��� DEFAULT ������ Ȯ�� => USER_TAB_COLUMNS ���� ��ųʸ�
-- => ��� �÷��� DEFAULT �������� NULL�� ����Ǿ� �ִ�.
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='DEPT2';

--������ �÷����� �÷��� DEFAULT �������� �ڵ����� ����
-- => LOC �÷��� DEFAULT �������� NULL�� ����
-- => LOC �÷��� NOT NULL ���������� �ο��Ǿ� �����Ƿ� NULL ���� �Ұ���
-- => �÷��� �����Ͽ� ����Ÿ ���� �Ұ���(������ NULL ��� �Ұ���)
INSERT INTO DEPT2(DEPTNO,DNAME) VALUES(10,'�ѹ���');

--NOT NULL ���������� �ο��� �÷����� �ݵ�� �÷����� �Է��ϴ� ���� ����
INSERT INTO DEPT2 VALUES(10,'�ѹ���','����');
COMMIT;
SELECT * FROM DEPT2;

--�÷��� �ο��� �������� Ȯ�� => USER_CONSTRAINTS ���� ��ųʸ�
--CONSTRAINT_NAME : �÷��� �ο��� ���������� �̸� => ���������� �����ϱ� ���� ���
--���������� �̸��� ���� �������� ������ SYS_XXXXXXX�� �ڵ� �����ȴ�.
--CONSTRAINT_TYPE : ���������� ���� => C : CHECK
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT2';

--���������� �̸��� �ο��ϸ� �÷��� �ο��� ���������� �����ϱ� ����.
--����) �÷��� �ڷ��� CONSTRAINT ���������̸� ��������  => �÷������� ��������
CREATE TABLE DEPT3(DEPTNO NUMBER(2) CONSTRAINT DEPT3_DEPTNO_NN NOT NULL
    ,DNAME VARCHAR2(12) CONSTRAINT DEPT3_DNAME_NN NOT NULL
    ,LOC VARCHAR2(11) CONSTRAINT DEPT3_LOC_NN NOT NULL);

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT3';

--UNIQUE KEY : �÷��� �ߺ��� �÷����� ����Ǵ� ���� �����ϱ� ���� �������� 
-- => ���� ���� �÷��� UNIQUE KEY �������� �ο� ����
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15));
DESC USER1;

--��ȭ��ȣ�� �ߺ��� �÷��� ���� ����
INSERT INTO USER1 VALUES(1000,'ȫ�浿','111-1111');
INSERT INTO USER1 VALUES(2000,'�Ӳ���','111-1111');
COMMIT;
SELECT * FROM USER1;

--PHONE �÷��� UNIQUE KEY �������� �ο� => �÷� ������ ��������
CREATE TABLE USER2(NO NUMBER(4),NAME VARCHAR2(20)
    ,PHONE VARCHAR2(15) CONSTRAINT USER2_PHONE_UK UNIQUE);
DESC USER2;
--CONSTRAINT_TYPE : U - UNIQUE KEY
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER2';

INSERT INTO USER2 VALUES(1000,'ȫ�浿','111-1111');
--UNIQUE KEY ���������� �ο��� �÷��� �ߺ� �÷����� �����ϸ� ���� �߻�
INSERT INTO USER2 VALUES(2000,'�Ӳ���','111-1111');--���� �߻�
INSERT INTO USER2 VALUES(2000,'�Ӳ���','222-2222');
COMMIT;
SELECT * FROM USER2;

--UNIQUE KEY�� �ο��� �÷����� NULL ���� ���
INSERT INTO USER2 VALUES(3000,'����ġ',NULL);

--NULL Ű����� �������� �ʴ� �÷����� ǥ���ϱ� ���� �����ϹǷ� �÷������� �ν����� �ʴ´�.
INSERT INTO USER2 VALUES(4000,'������',NULL);
COMMIT;
SELECT * FROM USER2;

--PHONE �÷��� UNIQUE KEY �������� �ο� => ���̺� ������ ��������
CREATE TABLE USER3(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT USER3_PHONE_UK UNIQUE(PHONE));

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER3';
    
INSERT INTO USER3 VALUES(1000,'ȫ�浿','111-1111');
INSERT INTO USER3 VALUES(2000,'�Ӳ���','111-1111');--���� �߻�
COMMIT;
SELECT * FROM USER3;
    
--NAME �÷��� PHONE �÷��� UNIQUE KEY �������� �ο� => �÷� ������ ��������
CREATE TABLE USER4(NO NUMBER(4),NAME VARCHAR2(20) CONSTRAINT 
    USER4_NAME_UK UNIQUE,PHONE VARCHAR2(15) CONSTRAINT USER4_PHONE_UK UNIQUE);

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER4';
    
INSERT INTO USER4 VALUES(1000,'ȫ�浿','111-1111');    
--NAME �÷��� �ߺ��� �÷����� �����ϸ� ���� �߻�
INSERT INTO USER4 VALUES(2000,'ȫ�浿','222-2222');--���� �߻�    
INSERT INTO USER4 VALUES(2000,'�Ӳ���','222-2222');
--PHONE �÷��� �ߺ��� �÷����� �����ϸ� ���� �߻�
INSERT INTO USER4 VALUES(3000,'����ġ','111-1111');--���� �߻�
COMMIT;
--�̸� �Ǵ� ��ȭ��ȣ�� �ߺ��� �÷����� ������ �� ����.
SELECT * FROM USER4;

--NAME �÷��� PHONE �÷��� UNIQUE KEY �������� �ο� => ���̺� ������ ��������
CREATE TABLE USER5(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT USER5_NAME_UK UNIQUE(NAME),CONSTRAINT USER5_PHONE_UK UNIQUE(PHONE));

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER5';

INSERT INTO USER5 VALUES(1000,'ȫ�浿','111-1111');    
--NAME �÷��� �ߺ��� �÷����� �����ϸ� ���� �߻�
INSERT INTO USER5 VALUES(2000,'ȫ�浿','222-2222');--���� �߻�    
INSERT INTO USER5 VALUES(2000,'�Ӳ���','222-2222');
--PHONE �÷��� �ߺ��� �÷����� �����ϸ� ���� �߻�
INSERT INTO USER5 VALUES(3000,'����ġ','111-1111');--���� �߻�
COMMIT;
--�̸� �Ǵ� ��ȭ��ȣ�� �ߺ��� �÷����� ������ �� ����.
SELECT * FROM USER5;

--NAME �÷��� PHONE �÷��� UNIQUE KEY �������� �ο� => ���̺� ������ ��������
CREATE TABLE USER6(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT USER6_NAME_PHONE_UK UNIQUE(NAME,PHONE));

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='USER6';

INSERT INTO USER6 VALUES(1000,'ȫ�浿','111-1111');    
--NAME �÷��� �÷����� �ߺ������� PHONE �÷��� �÷����� �ߺ����� �����Ƿ� ���� ����
INSERT INTO USER6 VALUES(2000,'ȫ�浿','222-2222');
--PHONE �÷��� �÷����� �ߺ������� NAME �÷��� �÷����� �ߺ����� �����Ƿ� ���� ����
INSERT INTO USER6 VALUES(3000,'�Ӳ���','222-2222');
--NAME �÷��� PHONE �÷��� �ߺ��� �÷����� ������ ��� ���� �߻�
INSERT INTO USER6 VALUES(4000,'ȫ�浿','111-1111');--���� �߻�
COMMIT;
--�̸��� ��ȭ��ȣ�� �ߺ��� �÷����� ������ ��� ���� �߻�
SELECT * FROM USER6;

--PRIMARY KEY : �÷��� �ߺ��� �÷����� ����Ǵ� ���� �����ϱ� ���� �������� 
-- => ���̺��� �ݵ�� �ϳ��� �÷��� �ο��ϴ� ��������
-- => �÷������� NULL�� ������� �ʴ´�.
-- => PRIMARY KEY = NOT NULL + UNIQUE KEY

--NO �÷��� PRIMARY KEY �������� �ο� => �÷� ������ ��������
CREATE TABLE MGR1(NO NUMBER(4) CONSTRAINT MSG1_NO_PK PRIMARY KEY
    ,NAME VARCHAR2(20),PHONE VARCHAR2(15));

--NO �÷��� NOT NULL �������� �ο� Ȯ��
DESC MGR1;    

--CONSTRAINT_TYPE : P - PRIMARY KEY
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR1';
    
INSERT INTO MGR1 VALUES(1000,'ȫ�浿','111-1111');    
--PK ���������� �ο��� �÷��� �ߺ� �÷����� �����ϸ� ���� �߻�
INSERT INTO MGR1 VALUES(1000,'�Ӳ���','222-2222');--���� �߻�
--PK ���������� �ο��� �÷��� NOT NULL ���������� ���ԵǾ� �����Ƿ� NULL ����� ���� �߻�
INSERT INTO MGR1 VALUES(NULL,'�Ӳ���','222-2222');--���� �߻�
COMMIT;
SELECT * FROM MGR1;

--NO �÷��� PRIMARY KEY �������� �ο� => ���̺� ������ ��������
CREATE TABLE MGR2(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
    ,CONSTRAINT MSG2_NO_PK PRIMARY KEY(NO));
DESC MGR2;    
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE 
    FROM USER_CONSTRAINTS WHERE TABLE_NAME='MGR2';
    
INSERT INTO MGR2 VALUES(1000,'ȫ�浿','111-1111');    
INSERT INTO MGR2 VALUES(1000,'�Ӳ���','222-2222');--���� �߻�
INSERT INTO MGR2 VALUES(NULL,'�Ӳ���','222-2222');--���� �߻�
COMMIT;
SELECT * FROM MGR2;
