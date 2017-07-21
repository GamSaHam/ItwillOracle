
-- WITH CHECK OPTION : �並 ������ �� ���� ������ �÷����� �������� 
--  ���ϵ��� �����ϴ� �ɼ�

CREATE OR REPLACE VIEW EMP_VIEWCHECK30 AS SELECT EMPNO,ENAME,SAL,DEPTNO
    FROM EMP_COPY WHERE DEPTNO = 30 WITH CHECK OPTION; -- DEPTNO �� ����� ����

-- �ܼ��� DML ��ɾ� ����ؼ� �並 ���ؼ� ���̺� ���� ����
SELECT * FROM EMP_VIEWCHECK30;

-- EMP_VIEWCHECK30���� ����̸��� ALLEN�� ����� �޿��� 2000���� ����
--  => �並 �̿��Ͽ� DML ����� ���� �� ��� ���� ���̺� ����
UPDATE EMP_VIEWCHECK30 SET SAL = 2000 WHERE ENAME = 'ALLEN';
COMMIT;

SELECT * FROM EMP_COPY; -- �並 �����ص� ���� ���� ������ �ȴ�.

-- EMP_VIEWCHECK30���� �����ȣ�� 7521�� ����� �μ��ڵ带 20������ ����
--  => WITH CHECK OPTION�� ���� �並 ������ SELECT ����� ���ǽĿ��� ���� �÷���
--      �÷����� ������ ��� ���� �߻�
--  => EMP_VIEWCHECK30�� �μ��ڵ带 �̿��Ͽ� ���� ���̹Ƿ� ����� ���� �߻�
UPDATE EMP_VIEWCHECK30 SET DEPTNO = 20 WHERE EMPNO = 7521; -- DEPTNO�� �����Ͽ� ����

-- WITH READ ONLY : �信�� DML ����� ������� ���ϵ��� �����ϱ� ���� �ɼ�
-- OR REPLACE �� ���� ���� ����.
CREATE OR REPLACE VIEW EMP_VIEWREAD30 AS SELECT EMPNO,ENAME,SAL,DEPTNO FROM EMP_COPY
    WHERE DEPTNO = 30 WITH READ ONLY;

SELECT* FROM EMP_VIEWREAD30;

-- EMP_VIEWREAD30�� WITH READ ONLY �ɼǿ� ���� DML ����� ����� ��� ���� �߻�
UPDATE EMP_VIEWREAD30 SET SAL = 3000 WHERE ENAME = 'ALLEN'; -- CANNOT PERFORM A DML OPERATION ON A READ-ONLY VIEW

-- VIEW ���� ��� ALTER�� ����
-- ����) DROP VIEW ���̸�; 
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;

-- EMP_VIEW30 �� ����
DROP VIEW EMP_VIEW30;

-- ROWNUM Ű���� : �˻��� �࿡ �Ϸù�ȣ�� �ο��ϴ� Ű����
SELECT EMPNO, ENAME, SAL FROM EMP;
SELECT ROWNUM, EMPNO, ENAME, SAL FROM EMP;


-- ��� ����� �����ȣ,����̸�, �޿��� �޿��� �������� ���� �˻� �� �� ���ȣ �ο�
--  => �˻� ������ ���ȣ�� �ο��� �� �޿������� �������� ����: ���ȣ�� �ұ�Ģ�ϰ� �˻�
SELECT ROWNUM, EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC; -- �˻� ����

-- �м��Լ����� �޿��� �������� ���� �� ROW_NUMBER() �����Լ��� ����
--  ����(���ȣ) �˻� : ���� �Լ�
-- ���ǽĿ����� ����� �̸��� �������� ORDER BY�� ����
-- �׷��� ����� �ζ��� �Լ��̴�.
SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) NUM, EMPNO, ENAME, SAL FROM EMP
    WHERE NUM BETWEEN 5 AND 10;

-- ��� ����� �����ȣ, ����̸�, �޿��� �޿��� �������� ������ �� ����
CREATE OR REPLACE VIEW EMP_VIEW 
    AS SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC;

-- EMP_VIEW�� �˻� �Ҷ� ROWNUM Ű���� ���
SELECT ROWNUM, EMPNO,ENAME, SAL FROM EMP_VIEW;

--���ȣ�� 5�̻��� ����� �˻�
SELECT ROWNUM, EMPNO,ENAME, SAL FROM EMP_VIEW 
    WHERE ROWNUM <= 5;

-- INLINE VIEW : SUBQUERY�� �Ͻ������� �����Ǵ� �並 �ζ��� ��
SELECT EMPNO,ENAME,SAL FROM EMP;
SELECT EMPNO,ENAME,SAL FROM (SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO = 30);
-- INLINE VIEW�� �˻� ����� �ƴ� �÷��� �˻� �� ��� ���� �߻�
SELECT EMPNO,ENAME,SAL,JOB FROM (SELECT EMPNO,ENAME,SAL FROM EMP WHERE DEPTNO = 30);
SELECT EMPNO,ENAME,SAL,JOB FROM (SELECT * FROM EMP WHERE DEPTNO = 30);

-- ��� ����� �����ȣ, ����̸�, �޿��� �޿��� �������� ���� �˻� �� �� ���ȣ �ο�
SELECT ROWNUM,EMPNO,ENAME,SAL 
    FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC);

SELECT ROWNUM,* -- ���� �ٸ� �˻����� ���� ��� �ɼ� ����.
    FROM (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC);


-- INLINE VIEW��  ALIAS�� �ο��� �� ALIAS�̸�.* �������� ��� ����
SELECT ROWNUM,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP; -- �̰Ŵ� �ʹ� �ű��ϳ�
    
-- �޿��� ���� ���� ��� 5�� �˻� : ���ȣ�� 5���� �۰ų� ���� ������� �˻�
SELECT ROWNUM,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM <=5; 

-- �޿��� �������� ���� 10�� ��ġ�� �ִ� ��������� �˻�
--  => ROWNUM Ű����� ���ǽ��� ������ ��� ��� ���� �����ڴ� < �Ǵ� <=�� ����
--  => �ٸ� �����ڸ� �̿��Ͽ� �˻��� ��� �˻��� ���� �ʴ´�.
SELECT ROWNUM,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP WHERE ROWNUM = 10; 


-- ROWNUM Ű���� ��� ����� ALIAS �̸� ������ INLINE VIEW ���� �� ALIAS �̸�����
-- ��� �����ڸ� ����� �� �ִ� ���ǽ� ���� ����
SELECT * FROM (SELECT ROWNUM RN, EMPNO,ENAME,SAL FROM EMP) WHERE RN = 10; -- ??

-- ����Ŭ������ �������� �ȿ� ��������
-- ���̺��� ��� ���� �ش� ����� ������ WHERE ���� ��� ����
--  => ���̺��� �����ͷ� ����¡ ó���ϱ� ���� ����ϴ� QUERY 
SELECT * FROM(SELECT ROWNUM RN,TEMP.* FROM 
    (SELECT EMPNO,ENAME,SAL FROM EMP ORDER BY SAL DESC) TEMP) WHERE RN >= 5 AND RN <= 10; 

-- ��� ����� �����ȣ,����̸��� �����ȣ�� �������� ���� �� �˻������ �� ���
-- �� �����ȣ, ����̸� �� �˻� ����� �� ����� �����ȣ, ����̸� �˻�
--  => ���� �� �Ǵ� �� ����� ���� ��� �����ȣ�� 0, ����̸� NULL�� �˻� �ǵ���

SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) BEFORE_EMPNO
    ,LAG(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) AFTER_EMPNO
    ,LEAD(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) AFTER_ENAME FROM EMP;

-- ��� ����� �����ȣ,����̸��� �����ȣ�� �������� ���� �� �˻������ �� �����
-- �����ȣ, ����̸� �� �˻������ �� ����� �����ȣ, ����̸� �˻��ϵ� �����ȣ��
-- 7844�� ����� �˻�
--  => ���� �� �Ǵ� �� ����� ���� ��� �����ȣ�� 0, ����̸� NULL�� �˻� �ǵ���
-- �����ȣ�� 7844�� ������� �˻� �� �� �Ǵ� �޻���� ���� �˻�
--  => �� �Ǵ� �޻���� �������� �ʴ´�. - �˻� ����

-- ��� ����� �˻� �� ���ϴ� �����ȣ�� ������� �˻� => INLINE VIEW
-- ��Ŀ������ ��� �Ǵ��� Ȯ��
SELECT *  FROM (SELECT EMPNO,ENAME,LAG(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) BEFORE_EMPNO
    ,LAG(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) BEFORE_ENAME
    ,LEAD(EMPNO,1,0) OVER(ORDER BY EMPNO ASC) AFTER_EMPNO
    ,LEAD(ENAME,1,NULL) OVER(ORDER BY EMPNO ASC) AFTER_ENAME FROM EMP) WHERE EMPNO = 7844;

-- SEQUENCE : �������� �����ϰ� ������ �ڵ� �����Ǵ� ���� ���� ��ȯ�ϴ� ��ü
--  => �ڵ� �����Ǵ� �������� �÷������� �����Ͽ� ��� EX) �Խñ� �۹�ȣ
--  => SEQUENCE ��ü�� ������ ���� ����ϴ� �÷��� �ݵ�� �������̸� PRIMARY KEY 
--  ���������� �ο� �Ǿ� �־�� �ȴ�.


-- ������ ����
-- ����) CREATE SEQUENCE �������� [START WITH ���۰�] [INCREMENT BY ������]
--      [MAXVALUE ���Ѱ�] [MINVALUE ���Ѱ�] [CYCLE] [CACHE ����];
--
-- START WITH ���۰� : ������ ��ü�� ����Ǵ� �ʱⰪ ���� => �����Ǹ� �ƹ��� ����
--  ���� ���� �ʴ´�.
-- INCREMENT BY ������ : �ڵ� ���� �Ǵ� ���������� �����Ǹ� �⺻ �������� 1�� ����
-- MAXVALUE ���Ѱ� : �ڵ� ���� �Ǵ� �������� �ִ� ���������� �����Ǹ� �������� ǥ���� �� �ִ�
--                  �ִ밪���� �����ȴ�.
-- MINVALUE ���Ѱ� : �ڵ� �����Ǵ� �������� �ּ� ���������� �����Ǹ� �ְ��� 1�� ����
-- CYCLE : �ڵ� �����Ǵ� �������� �ݺ� �ǵ��� ����
-- CACHE ���� : �ӽ� �޸𸮿� �̸� �ڵ� �����Ǵ� �������� �����Ͽ� ����ϱ� ���� ������
-- ���������� ������ ��� ������ 20���� ����


-- QNA ���̺� ���� => �۹�ȣ, ������, �۳���, 
CREATE TABLE QNA(NO NUMBER(4) PRIMARY KEY, CONTENT VARCHAR2(100));


-- QNA ���̺��� NO �÷����� ����ϱ� ���� ������ ����
CREATE SEQUENCE QNA_SEQ;

SELECT * FROM USER_SEQUENCES;

-- QNA ���̺� �Խñ� ���� => NO �÷��� QNA_SEQ �������� �̿��Ͽ� �÷��� ����
-- ������.CURRVAL : ���� �������� �����ϰ� �ִ� ������ ��ȯ
--  => ������ ���� �� �ʱⰪ�� �������� �ʾ� �������� ��ȯ���� �ʴ´�.
--  => ������.CURRVAL�� ������.NEXTVAL ���� �� ������ ��ȯ
SELECT QNA_SEQ.CURRVAL FROM DUAL;

-- QNA_SEQ.NEXTVAL : �������� ����� �������� �������� ���� �������� ��ȯ �� ��������
--  ���� �������� ���� => �������� ����� �������� ���� ��� MINVALUE ���� �̿��Ͽ� ��ȯ
-- 
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '����-1');
SELECT QNA_SEQ.CURRVAL FROM DUAL;

INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '����-2');
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '����-3');
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '����-4');

COMMIT;

SELECT * FROM QNA;

-- ������ ���� => START WITH�� ���� �Ұ���
-- ����) ALTER SEQUENCE �������� ����ɼ�

-- QNA_SEQ �������� ���Ѱ��� 9999�� �����ϰ� �������� 3���� ����
SELECT * FROM USER_SEQUENCES;

-- MAXVALUE 9999
-- INCREMENT BY 3
ALTER SEQUENCE QNA_SEQ MAXVALUE 9999 INCREMENT BY 3;


INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, '������');
INSERT INTO QNA VALUES(QNA_SEQ.NEXTVAL, 'ȣȣȣ');

COMMIT;

SELECT * FROM QNA;

-- ������ ����
-- ����) DROP SEQUENCE ��������;
DROP SEQUENCE QNA_SEQ;


-- INDEX: ���̺� ����� �����͸� ���� ������ �˻��ϱ� ���� �ε��� ������
--  �����ϱ� ���� ��ü
--  => �ε����� ��������ó�� �÷��� �ο��Ͽ� ����
--  => �ε����� �����Ͱ� ���� ���� ��쿡�� �ο����� �ʴ� ���� ����
--      (���̺� ������ �ε��� �ο��� �����
--  => ���ǽĿ� ���� ����ϴ� �÷��� �ο��ϴ� ���� ����

-- UNIQUE INDEX : �÷��� �ߺ��� �÷����� ������� �ʵ��� PK �Ǵ� UK ����������
--  ������ �÷��� �ڵ����� ����� ���� �ε���
-- NON UNIQUE INDEX : �÷��� �ߺ��� �÷����� ����Ǵ� �÷��� �������� �ο��ϴ�
--  �ε���

-- USER ���̺� ���� => ��ȣ(PK),�̸�,��ȭ��ȣ(UK)�� �����ϱ� ���� ���̺�
CREATE TABLE USER1(NO NUMBER(4),NAME VARCHAR2(20),PHONE VARCHAR2(15)
                , CONSTRAINT USER1_NO_PK PRIMARY KEY(NO)
                , CONSTRAINT USER1_PHONE_UK UNIQUE(PHONE));
            
                
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER1';


-- USER1 ���̺��� �ε��� Ȯ��
SELECT C.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS,INDEX_TYPE 
    FROM USER_INDEXES I JOIN USER_IND_COLUMNS C ON I.INDEX_NAME = C.INDEX_NAME
    WHERE C.TABLE_NAME = 'USER1';


-- NON UNIQUE INDEX ����
-- ����) CREATE INDEX �ε����� ON ���̺��(�÷���);
--  => WHERE���� ���� ����ϴ� �÷��� �ο�
--  => �˻� ����� ��ü �������� 2%~4%�� ��� 
--  => ���̺��� ����� �������� ������ ���� ��� 
--  => JOIN���� ���� ����ϴ� �÷��̳� NULL�� ���� �����ϰ� �ִ� �÷��� �ο�

-- USER1 ���̺��� NAME �÷��� INDEX�� �����Ͽ� �ο�
CREATE INDEX USER1_NAME_INDEX ON USER1(NAME);

SELECT C.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS,INDEX_TYPE 
    FROM USER_INDEXES I JOIN USER_IND_COLUMNS C ON I.INDEX_NAME = C.INDEX_NAME
    WHERE C.TABLE_NAME = 'USER1';

-- ��Ʈ�� �ε��� -> ����Ʈ�� �ε���
-- ������ ���̽� �����ڰ� ������ ����� �ִ°Ŵ�.
-- ���ο��� �ӵ��� ���̳���.
-- DBA�� ���� �ε��� ��å�� �������� �Ѵ�. 

-- INDEX ����
-- ����) DROP INDEX �ε�����;

-- USER1_PHONE_UK �ε��� ����
DROP INDEX USER1_NO_PK; -- ����

-- �������� Ȯ��
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'USER1';

-- UNIQUE INDEX�� �ε����� ������ ���������� �����ϸ� �ڵ����� ���� �ȴ�.
ALTER TABLE USER1 DROP CONSTRAINT USER1_PHONE_UK;

-- �ڵ����� ���� �ε����� �ڵ����� �������δ� �������� ���� �ȴ�.
DROP INDEX USER1_NAME_INDEX;

-- �ε��� ������ ���� �˻� �ð� ��
-- ���� ���̺��� �˻��Ͽ� ���̺� ���� �� ������ ���� => ���������� ������� �ʴ´�.
CREATE TABLE EMP_INDEX AS SELECT * FROM EMP;

SELECT * FROM EMP_INDEX;

-- �ε��� Ȯ��
SELECT C.INDEX_NAME,COLUMN_NAME,COLUMN_POSITION,UNIQUENESS,INDEX_TYPE 
    FROM USER_INDEXES I JOIN USER_IND_COLUMNS C ON I.INDEX_NAME = C.INDEX_NAME
    WHERE C.TABLE_NAME = 'EMP_INDEX';

-- �������̺� �˻��Ͽ� �����͸� �����ߴ�.
INSERT INTO EMP_INDEX SELECT * FROM EMP_INDEX;
SELECT COUNT(*) FROM EMP_INDEX; -- 100���� �̻��� ������ ����
INSERT INTO EMP_INDEX(EMPNO,ENAME) VALUES(1111,'ABCD'); -- 1���� ����
COMMIT;

SET TIMING ON; -- SQL ��� ���� �ð� ��� Ȱ��ȭ
SELECT * FROM EMP_INDEX WHERE ENAME = 'ABCD';
SET TIMING OFF;

-- EMP_INDEX ���̺��� ENAME �÷��� �ε��� �ο�
CREATE INDEX EMP_INDEX_ENAME ON EMP_INDEX(ENAME);


DROP TABLE EMP_INDEX;


-- SYNONYM : ����Ŭ ��ü�� ���Ǿ�(����)�� �ο��ϱ� ���� ��ü
--  => ���� SYNONYM : Ư�� ����ڸ� ����� �� �ִ� ���Ǿ�(�Ϲ� ����� ����)
--  => ���� SYNONYM : ��� ����ڰ� ����� �� �ִ� ���Ǿ�(������ ����)

-- SYNONYM ����
-- ����) CREATE [PUBLIC] SYNONYM ���Ǿ�  FOR ��ü��;
--  => PUBLIC : ��� SYNONYM�� ������ �� ���

-- EMPLOYEE ���̺��� ��� ������ �˻�
SELECT * FROM EMPLOYEE;




--  CREATE SYNONYM �ý��� ������ �����Ƿ� ��� ���� ���� �߻�
--  => SCOTT ����ڰ� ��� ������ ���� SYNONYM
CREATE SYNONYM E FOR EMPLOYEE;

-- CREATE SYNONYM �ý��� ���� �ޱ� ���� �����ڿ��� ��û
-- DOS > SQLPLUS /NOLOG
-- SQL > CONN SYS/SYS AS SYSDBA
-- SQL > GRANT CREATE SYNONYM TO scott



-- EMPLOYEE ���̺� �Ǵ� EMPLOYEE SYNONYM�� �̿��� ������ �˻�
SELECT * FROM EMPLOYEE;
SELECT * FROM E;


-- SYNONYM Ȯ�� => ALL_SYNONYMS, DBA_SYNONYMS, USER_SYNONYMS;

SELECT * FROM USER_SYNONYMS;

SELECT OWNER, TABLE_NAME,SYNONYM_NAME,TABLE_OWNER FROM  ALL_SYNONYMS WHERE TABLE_NAME = 'EMPLOYEE';

-- ���� SYNONYM
-- DOS> SQLPLUS /NOLOG
-- SQL> CONN SYS/SYS AS SYSDBA
-- SQL> SELECT EMPNO,ENAME,SAL FROM EMP; -- ���� �߻�
-- SQL> SELECT EMPNO,ENAME,SAL FROM SCOTT.EMP;
-- SQL> CREATE PUBLIC SYNONYM EMP FOR SCOTT.EMP;
-- SQL> SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER 
-- FROM DBA_SYNONYMS WHERE TABLE_NAME = 'EMP';

-- ��ǥ���� PUBLIC SYNONYM => DUAL �Ǵ� ���� ��ųʸ�
SELECT 20+10 FROM DUAL;

SELECT OWNER,TABLE_NAME,SYNONYM_NAME,TABLE_OWNER
    FROM ALL_SYNONYMS WHERE TABLE_NAME = 'DUAL';
    
    
-- SYNONYM ����
-- ����) DROPT [PUBLIC] SYNONYM ���Ǿ�;
-- SQL> DROP PUBLIC SYNONYM EMP; -- ���� SYNONYM ����
-- SQL> SELECT EMPNO,ENAME,SAL FROM EMP; -- ���� �߻� 

DROP SYNONYM E; -- ���� SYNONYM ����

SELECT * FROM E; -- ���� �߻�


-- ���� : �ý����� ����� �� �ִ� ������� �����
-- ���� ���� : ������ �����ϰų� �����ϴ� ���(������) => �ý��� ����(����)
-- �Ϲ� ���� ����
-- ����) CREATE USER ������ IDENTIFIED BY ��ȣ;

-- DOS> SQLPLUS /NOLOG
-- SQL> CONN SYS/SYS AS SYSDBA
-- SQL> CREATE USER KIM IDENTIFIED BY 1234;


-- ���� Ȯ�� => DBA_USERS ��ųʸ� �̿�
-- SQL> SELECT USERNAME,ACCOUNT_STATUS,DEFAULT_TABLESPACE, 
-- CREATED FROM DBA_USERS WHERE USERNAME = 'KIM';

-- ���� ��ȣ ����
-- ����) ALTER USER ������ IDENTIFIED BY ��ȣ;
-- SQL> ALTER USER KIM IDENTIFIED BY 5678;

-- ������ ���� ���� ���� => ����Ŭ�� ������ ��ȣ�� 5�� Ʋ���� ������ LOCK ���·� ����
--  => ������ LOCK ���¸� OPEN ���·� ���� �ؾ߸� ���� ����
--  ����) ALTER USER ������ ACCOUNT UNLOCK;

-- ���� ����
-- SQL > DROP USER KIM;



















