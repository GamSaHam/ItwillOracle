
-- FOREIGN KEY : �ٸ� ���̺� ����� �÷����� �����Ͽ� �߸��� ������ ������ �����ϱ�
--              ���� ����� ������ �ִ� �������� => ���̺���� �߸��� JOIN�� �����ϱ� ���� ���
--  => FOREIGN KEY ���������� �÷��� ������ �� �ִ� �ٸ� ���̺��� �÷��� �ݵ�� PK ����
--                  ������ �ο� �Ǿ� �־�� �ȴ�.

-- SUBJECT ���̺� ���� => �����ڵ�(PK), ������� �����ϱ� ���� ���̺�
-- ������ �������̶� �������� �������� ��갪�� ������.
CREATE TABLE SUBJECT(SNO NUMBER(2),SNAME VARCHAR2(20)
        ,CONSTRAINT SUBJECT_SNO_PK PRIMARY KEY(SNO));

DESC SUBJECT;

SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SUBJECT';

-- ���� �ڵ� ���� �̸� ����
INSERT INTO SUBJECT VALUES(10,'JAVA');
INSERT INTO SUBJECT VALUES(20,'ORACLE');
INSERT INTO SUBJECT VALUES(30,'LINUX');
COMMIT;

SELECT * FROM SUBJECT;

-- TRAINEE1 ���̺� ���� => ������ �ڵ�(PK), ������ �̸�, ���� ���� �ڵ带 ����
--                          �ϱ� ���� ���̺�

CREATE TABLE TRAINEE1(TNO NUMBER(4), TNAME VARCHAR2(20),SCODE NUMBER(2)
                        ,CONSTRAINT TRAINEE1_TNO_PK PRIMARY KEY(TNO));

DESC TRAINEE1;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'TRAINEE1';

INSERT INTO TRAINEE1 VALUES(1000, 'ȫ�浿',10);
INSERT INTO TRAINEE1 VALUES(2000, '�Ӳ���',20);
INSERT INTO TRAINEE1 VALUES(3000, '����ġ',30);
INSERT INTO TRAINEE1 VALUES(4000, '������',40);
COMMIT;

SELECT * FROM TRAINEE1; -- �����Ŵ� ���� �μ��� ��� �ִ�.

-- �������ڵ�, �������̸�, ���������̸� �˻�
--  => TRAINEE1 ���̺�� SUBJECT ���̺��� JOIN �Ͽ� �˻�
--  => JOIN ���ǿ� ���� �ʴ� ������ ������ �˻����� �ʴ´�.
DESC TRAINEE1;
DESC SUBJECT;

-- JOIN ���ǿ� ���� �ʴ� ������ ������ �˻��ϰ��� �� ��� OUTER JOIN ���
--  => �������� ���� ������ ���������� ����. - ������ ���Ἲ ����
SELECT TNO,TNAME,SNAME FROM TRAINEE1 T JOIN SUBJECT S ON T.SCODE = S.SNO; 


CREATE TABLE TRAINEE2(TNO NUMBER(4), TNAME VARCHAR2(20),SCODE NUMBER(2)
                        ,CONSTRAINT TRAINEE2_TNO_PK PRIMARY KEY(TNO)
                        ,CONSTRAINT TRAINEE2_SCODE_FK FOREIGN KEY(SCODE) REFERENCES SUBJECT(SNO));

DESC TRAINEE2;

-- ���⼭ CONSTRAINTS [�������� ��] �������� �� �������� ���� ���´�.
-- CONSTRAINT_TYPE : R - FOREGIN KEY
-- R_CONSTRAINT_NAME : �����ϴ� �÷��� �������� �̸�
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE,R_CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME ='TRAINEE2';

INSERT INTO TRAINEE2 VALUES(1000, 'ȫ�浿',10);
INSERT INTO TRAINEE2 VALUES(2000, '�Ӳ���',20);
INSERT INTO TRAINEE2 VALUES(3000, '����ġ',30);

-- SUBJECT ���̺��� SNO �÷��� �÷������� �������� �ʴ� SCODE �÷����� ������ ��� ���� �߻�
INSERT INTO TRAINEE2 VALUES(4000, '������',40); -- ������ ���� - PARANT KEY NOT FOUND
COMMIT;

SELECT * FROM TRAINEE2;

-- FK �������ǿ� ���� JOIN ���ǿ� ���� �ʴ� �������� �������� �ʴ´�.
SELECT TNO,TNAME,SNAME FROM TRAINEE2 T JOIN SUBJECT S ON T.SCODE = S.SNO;

-- SUBJECT ���̺��� �����ڵ� 10�� �������� ����
-- FOREGIN KEY �� ���ؼ� �����Ͱ� ��ȣ �޴´�.
--  => TRAINEE2 ���̺��� SCODE �÷������� ����Ǿ� �����Ǵ� SUBJECT ���̺��� 
--      SNO �÷����� ���� �����ʹ� ���� ���� �ʴ´�. => ������ ���Ἲ ����
--      �����ڴ� �������� �ʴ´�. �ӵ��� ������.
--      ���̺��� Ű�� �����ϴ��� ���θ� Ȯ�� �ϴ� ����� ��Ƿ�
DELETE FROM SUBJECT WHERE SNO = 10; -- ���� �߻�

-- CHECK : ������ ���ǿ� ������ ��쿡�� ������ ������ �����ϵ��� �����ϴ� ��������

-- SAWON1 ���̺� ���� => �����ȣ(PK), ����̸�, �޿��� �����ϱ� ���� ���̺�
CREATE TABLE SAWON1(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER(8)
                    ,CONSTRAINT SAWON1_NO_PK PRIMARY KEY(NO));


-- SAWON1 ���̺� ������� ���� => ����� �ּ� �޿� 300���� ����
INSERT INTO SAWON1 VALUES(1000,'ȫ�浿',5000000);
INSERT INTO SAWON1 VALUES(2000,'�Ӳ���',3000000);
-- ����ġ�� �޿��� : 1000���� - �Է� ���� �߻� : 100���� => ���� ����(���Ἲ ����)
INSERT INTO SAWON1 VALUES(3000,'����ġ',1000000);
COMMIT;

SELECT NO,NAME,TO_CHAR(PAY,'L999,999,990') PAY FROM SAWON1;


-- SAWON2 ���̺� ���� => �����ȣ(PK), ����̸�, �޿��� �����ϱ� ���� ���̺�
--  => ����� �޿��� 300���� �̻� �Է� �ǵ��� CHECK �������� �ο�

CREATE TABLE SAWON2(NO NUMBER(4),NAME VARCHAR2(20),PAY NUMBER(8)
                    ,CONSTRAINT SAWON2_NO_PK PRIMARY KEY(NO)
                    ,CONSTRAINT SAWON2_PAY_CHECK CHECK(PAY >= 3000000));

-- CONSTRAINT_TYPE : C - CHECK
-- SEARCH_CONDITION : CHECK ���������� ���ǽ�
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,SEARCH_CONDITION
        FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'SAWON2';

INSERT INTO SAWON2 VALUES(1000,'ȫ�浿',5000000);
INSERT INTO SAWON2 VALUES(2000,'�Ӳ���',3000000);

-- ����ġ�� �޿� : 1000���� - �Է� ���� : 100���� => CHECK �������ǿ� ���� ���� �Ұ���
INSERT INTO SAWON2 VALUES(3000,'����ġ',1000000);  -- ���� �߻�
INSERT INTO SAWON2 VALUES(3000,'����ġ',10000000);
COMMIT;

SELECT NO,NAME,TO_CHAR(PAY,'L999,999,990') PAY FROM SAWON2;

-- ���̺� ���� => ���̺� ����� ��� �����͵� ���� ����
-- ����) DROP TABLE ���̺��;
-- USER_TABES ���� ��ǳʸ����� ���� �α��� ����ڰ� ��� ������ ���̺� ��� Ȯ��
SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- USER1 ���̺� ����
DROP TABLE USER1;

SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- ����Ŭ������ ������ ���̺��� ���� �Ҽ� �ִ�.
-- ���̺� ��� Ȯ��
--  => BIN... : ����Ŭ �����뿡 �����ϴ� ��ü
SELECT * FROM TAB; -- TAB VIEW���� Ȯ�� => ������ ���̺� ��� Ȯ��

-- ����Ŭ ������(RECYCLEBIN)�� �����ϴ� ��ü ��� Ȯ��
SHOW RECYCLEBIN;

-- ����Ŭ �����뿡 �����ϴ� ��ü ����
FLASHBACK TABLE USER1 TO BEFORE DROP;

SELECT TABLE_NAME FROM TABS;

-- USER1 ���̺�� USER2 ���̺� ����
DROP TABLE USER1;
DROP TABLE USER2;

-- ����ũ�� �ο��ϸ� INDEX��� ��ü�� ����� ����.
SHOW RECYCLEBIN;

-- ����Ŭ �����뿡�� Ư�� ��ü�� �����Ҽ� �ֵ�� (���� �Ұ�)
PURGE TABLE USER2; -- ���̺� ���ӵ� INDEX ��ü ����
SHOW RECYCLEBIN;

-- ���̺� ���� (USER3,USER4,USER5)
DROP TABLE USER3;
DROP TABLE USER4;
DROP TABLE USER5;
SHOW RECYCLEBIN;

-- ����Ŭ �����뿡�� ��� ��ü ����
PURGE RECYCLEBIN;
SHOW RECYCLEBIN;

-- USER6 ���̺� ������ ����Ŭ ���������� �̵����� �ʰ� ������ ����
DROP TABLE USER6 PURGE; -- ���������� �̵����� ���� �ٷ� ����
SHOW RECYCLEBIN;
SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- ���̺� �ʱ�ȭ => ���̺� �����ϴ� ��� �����͸� �����Ͽ� ���̺� ���� ���� 
--                  ���� �����ϰ� ����� ���
--                  ����) TRUNCATE TABLE ���̺��

-- BONUS ���̺��� ��� ������ ����
SELECT * FROM BONUS;

-- ���� ������ Ʈ�����ǿ����� ���� => ���� ���̺����� �״�� ���� �Ѵ�.
DELETE FROM BONUS;

SELECT * FROM BONUS;

-- ���� ���̺� DML ����� ����� �������� �ʰ� ���
ROLLBACK;

-- ���̺� �ʱ�ȭ => DDL ����̹Ƿ� �ʱ�ȭ �� Ʈ�������� �ٷ� ����(AUTO COMMIT)
TRUNCATE TABLE BONUS;
ROLLBACK;

SELECT* FROM BONUS;

-- ���̺� �̸� ����
-- ����) RENAME ���� ���̺�� TO ���� ���̺��

-- BONUS ���̺��� �̸��� COMMISSION���� ����
SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

RENAME BONUS TO COMMISSION;

SELECT TABLE_NAME FROM TABS ORDER BY TABLE_NAME;

-- ���̺� ���� ���� => �÷� �߰�, �÷� ����, �÷��� �ڷ��� �Ǵ� ���� ũ�� ����
-- ����) ALTER TABLE ���̺�� ����ɼ�;

-- EMPLOYEE ���̺� ���� => �����ȣ, ����̸�, ��ȭ��ȣ�� �����ϴ� ���̺�
CREATE TABLE EMPLOYEE(ENO NUMBER(4), ENAME VARCHAR2(10), PHONE VARCHAR2(15));

DESC EMPLOYEE;

-- EMPLOYEE ���̺� �ּҸ� �����ϴ� �÷� �߰�
-- ���̺��� �߰��� �ٲٴ°��� �������� �ʴ´�.
ALTER TABLE EMPLOYEE ADD(ADDRESS VARCHAR2(50));
DESC EMPLOYEE;

-- EMPLOYEE ���̺� ENO Ŀ���� �ڷ����� NUMBER(4)���� VARCHAR2(4)�� ����
ALTER TABLE EMPLOYEE MODIFY (ENO VARCHAR2(4));

DESC EMPLOYEE;

-- EMPLOYEE ���̺� ������� ����
INSERT INTO EMPLOYEE VALUES(1000,'ȫ�浿','111-1111','����� ������ ���ﵿ');
COMMIT;

SELECT * FROM EMPLOYEE;

-- EMPLOYEE ���̺��� ENO �÷��� �ڷ����� VARCHAR2(4) ���� NUMBER(4)�� ����
--  => �����ϰ��� �ϴ� �÷��� �÷����� ����Ǿ� �ִ� ��� �ڷ��� ���� �Ұ�
ALTER TABLE EMPLOYEE MODIFY (ENO NUMBER(4)); -- ���� �߻�

-- EMPLOYEE ���̺� ������� ����
--  => Ŀ���� ����ũ�⺸�� ū �÷����� ���� �� ��� ���� �߻�
--  => ENAME : 10 BYTE ~ �Է� �÷��� : 15BYTE
INSERT INTO EMPLOYEE VALUES('2000','�Ӳ�������','222-222','����� ���Ǳ� ��õ��'); -- ���� �߻�

-- EMPLOYEE ���̺��� ENAME �÷��� ���� ũ�⸦ 20����Ʈ�� ����
--  => �����ϰ��� �ϴ� �÷��� ���� ũ��� ����� �÷����� ũ�⺸�� ũ�� ���� ����
ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(20));

SELECT * FROM EMPLOYEE;

ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(10));

-- EMPLOYEE ���̺��� PHONE �÷� ���� => �÷����� ���� ����
ALTER TABLE EMPLOYEE DROP COLUMN PHONE;
DESC EMPLOYEE;
SELECT * FROM EMPLOYEE;

-- ���̺��� �÷��� ������ �����ϴ� �ͺ��� ���� ����� �����ϰ� ���߿�
-- �����ϴ� ���� �����Ѵ�.
-- EMPLOYEE ���̺��� ADDRESS �÷� ��� ����
-- �÷��� ���� �Ȱ��� �ƴϰ� ������ �Ⱥ��̵��� �� ���̴�.
ALTER TABLE EMPLOYEE SET UNUSED(ADDRESS);


DESC EMPLOYEE; -- ��巹�� ����

SELECT * FROM EMPLOYEE;

-- ���̺��� ��� ���ѵ� �÷��� ���� Ȯ��
SELECT * FROM USER_UNUSED_COL_TABS;

-- ���� �÷� ����
ALTER TABLE EMPLOYEE DROP UNUSED COLUMNS;

-- ���̺��� �÷��� ���������� �߰��ϰų� ����
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';

DESC EMPLOYEE;

-- EMPLOYEE ���̺��� ENO �÷��� PK �������� �߰� => ���̺� ������ ��������
ALTER TABLE EMPLOYEE ADD(CONSTRAINT EMPLOYEE_ENO_PK PRIMARY KEY(ENO));

-- EMPLOYEE ���̺��� ENAME �÷��� NOT NULL �������� �߰� => �÷� ������ ��������
--  => �÷� ������ ��������(�÷� ���� ���� �ɼ� �̿�)
ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(20) CONSTRAINT EMPLOYEE_ENAME_NN NOT NULL);

DESC EMPLOYEE;
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';

-- EMPLOYEE ���̺��� ENO �÷��� �ο��� PK ���������� ����
ALTER TABLE EMPLOYEE DROP PRIMARY KEY; -- �����̸Ӹ� Ű�� �ϳ� �̱⶧����

-- �̷��ٰ� ���Ű� ���� �ʴ´�.
ALTER TABLE EMPLOYEE MODIFY(ENAME VARCHAR2(20));

-- �������� ���� DROP �����ش�.
-- => �������ǿ� �ο��� �̸��� �̿��Ͽ� ����(����)
ALTER TABLE EMPLOYEE DROP CONSTRAINT EMPLOYEE_ENAME_NN;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMPLOYEE';

-- DEPT1 ���̺� ���� => �μ��ڵ�(PK), �μ� �̸�, �μ� ��ġ�� �����ϱ� ���� ���̺�
CREATE TABLE DEPT01 (DNO NUMBER(2),DNAME VARCHAR2(20), LOC VARCHAR2(20), CONSTRAINT DEPT01_DNO_PK PRIMARY KEY(DNO));


-- DEPT01 ���̺� �μ� ���� ����
INSERT INTO DEPT01 VALUES(10,'�ѹ���','����');
INSERT INTO DEPT01 VALUES(20,'������','����');
COMMIT;

SELECT * FROM DEPT01;


-- EMP01 ���̺� ���� = �����ȣ(PK), ����̸�, �μ� �ڵ�(FK: DEPT01 ���̺��� DNO �÷� ����)�� �����ϱ� ���� ���̺�
CREATE TABLE EMP01(ENO NUMBER(4), ENAME VARCHAR(20), DNO NUMBER(2)
                        ,CONSTRAINT EMP01_ENO_PK PRIMARY KEY(ENO)
                        ,CONSTRAINT EMP01_DNO_FK FOREIGN KEY(DNO) REFERENCES DEPT01(DNO));
                        
SELECT CONSTRAINT_NAME FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP01';

-- EMP01 ���̺� ������� ���� => EMP01 ���̺��� DNO �÷��� DEPT ���̺��� DNO �÷��� �����Ͽ� ����
INSERT INTO EMP01 VALUES(1000,'ȫ�浿',10); -- 
INSERT INTO EMP01 VALUES(2000,'�Ӳ���',20); -- 
INSERT INTO EMP01 VALUES(3000,'����ġ',30); -- FK �������ǿ� ���ؼ� parant key not found ���� �߻�
COMMIT;

SELECT * FROM EMP01;

-- DEPT01 ���̺� ����� 10�� �μ� ����
DELETE FROM DEPT01 WHERE DNO = 10; -- FK �������ǿ� ���ؼ� child record found ���� �߻�

-- �������� - ���Ἲ�� �����ϱ� ���ؼ� ���� �߻�

-- FK ���������� �����ϰ� ���� �ϰ� �ʹ�.

-- FK �������� ��Ȱ��ȭ ó��
-- ����) ALTER TABLE ���̺�� DISABLE CONSTRAINT �������Ǹ�
-- => FK �������ǿ� ���� ������ �߻����� �ʴ´�.
ALTER TABLE EMP01 DISABLE CONSTRAINT EMP01_DNO_FK;

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP01';

INSERT INTO EMP01 VALUES(3000,'����ġ',30);
COMMIT;

SELECT * FROM EMP01;

DELETE  FROM DEPT01 WHERE DNO = 10;

SELECT * FROM DEPT01;

-- ��Ȱ��ȭ ������ Ȱ��ȭ ó��
-- ����) ALTER TABLE ���̺�� ENABLE CONSTRAINT �������� �̸�;

ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DNO_FK; -- ���� �߻� ������ ���Ἲ�� ������
                                                -- FOREIGN Ű�� �ټ��� ����.
                                                -- 10��, 30�� �μ� ������ FK ���������� Ȱ��ȭ
                                                -- ���� �ʴ´�.

-- 10�� �Ǵ� 30�� �μ��� �����ϰų� 10�� �Ǵ� 30�μ��� ��������� ����
--  => ������ ���Ἲ�� �����ǵ��� ����, ����, ����
INSERT INTO DEPT01 VALUES(10,'�ѹ���','����');
DELETE FROM EMP01 WHERE ENO = 3000;

COMMIT;

SELECT * FROM EMP01;
SELECT * FROM DEPT01;

-- ��Ȱ��ȭ�� �������� Ȱ��ȭ
ALTER TABLE EMP01 ENABLE CONSTRAINT EMP01_DNO_FK; -- �������ǿ� �������� ����

SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME = 'EMP01';

-- FK �������ǿ� ���� �θ����̺�(DEPT01)�� �ڽ����̺�(EMP01) ���� ���� ������ �Ǿ� �ִ� ���
-- �θ����̺��� PK ���������� ��Ȱ��ȭ �ϰų� ������ �� ����.
--  => �ڽ� ���̺� �ο��� FK ���������� ��� ���� �� ��Ȱ��ȭ �Ǵ� ���� ����
ALTER TABLE DEPT01 DISABLE PRIMARY KEY;
ALTER TABLE DEPT01 DROP PRIMARY KEY;

-- CASCADE Ű���带 ����ϸ� �θ����̺� PK ���������� ��Ȱ��ȭ �ϰų� ����
-- �Ұ�� �ڽ� ���̺��� FK �������ǵ� ��Ȱ��ȭ �Ǵ� ���� �Ҽ� �ִ�.
-- DEPT01 ���̺� DNO �÷��� �ο��� PK �������� ��Ȱ��ȭ
--

-- DEPT01 ���̺� DNO �÷��� �ο��� PK ���������� CASCADE ��Ȱ��ȭ
ALTER TABLE DEPT01 DISABLE PRIMARY KEY CASCADE;

-- CASCADE ���ÿ� ������ �޶�
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE,STATUS FROM USER_CONSTRAINTS WHERE TABLE_NAME IN('EMP01','DEPT01');

-- DEPT01 ���̺� DNO �÷��� �ο��� PK ���������� CASCADE ����
--  => EMP01 ���̺��� DNO �÷��� �ο��� FK �������ǵ� ����

CREATE TABLE DEPT02 (DNO NUMBER(2),DNAME VARCHAR2(20), LOC VARCHAR2(20), CONSTRAINT DEPT02_DNO_PK PRIMARY KEY(DNO));


-- DEPT02 ���̺� �μ� ���� ����
INSERT INTO DEPT02 VALUES(10,'�ѹ���','����');
INSERT INTO DEPT02 VALUES(20,'������','����');
COMMIT;

-- EMP02 ���̺� ���� = �����ȣ(PK), ����̸�, �μ� �ڵ�(FK: DEPT01 ���̺��� DNO �÷� ����)�� �����ϱ� ���� ���̺�
-- => ON DELETE CASCADE : �θ� ���̺��� �����͸� �����ϸ� �ڽ����̺��� �����ϴ� �÷����� �����͵�
--                      ���� ���� �Ѵ�. - ON DELETE SET NULL(�÷����� NULL�� ����)
CREATE TABLE EMP02(ENO NUMBER(4), ENAME VARCHAR(15), DNO NUMBER(2)
                        ,CONSTRAINT EMP02_ENO_PK PRIMARY KEY(ENO)
                        ,CONSTRAINT EMP02_DNO_FK FOREIGN KEY(DNO) REFERENCES DEPT02(DNO) ON DELETE CASCADE);


-- EMP02 ���̺� ����� �߰�
--  => EMP02 ���̺��� DNO �÷���
INSERT INTO EMP02 VALUES(1000,'ȫ�浿',10); -- 
INSERT INTO EMP02 VALUES(2000,'�Ӳ���',20); -- 
COMMIT;

SELECT * FROM EMP02;

-- DEPT02 ���̺��� ����� 10�� �μ����� ����
--  => 10�� �μ��� �ٹ��ϴ� ��� ��������� EMP02 ���̺��� ����
DELETE FROM DEPT02 WHERE DNO = 10;
COMMIT;

SELECT * FROM DEPT02; -- �����ε� ����
SELECT * FROM EMP02; -- ȫ�浿�� ����

-- VIEW : ���� ���̺��� �̿��Ͽ� ������� ������ ���̺�
--  => ���� ���̺��� �˻��ϴ� �ϳ��� SELECT ������� �����Ǵ� ��ü

-- SELECT ����� �̿��� ���̺� ���� �� ������ ����
CREATE TABLE EMP_COPY AS SELECT * FROM EMP; -- SELECT * FROM EMP; ������ VIEW �̴�.
SELECT * FROM EMP_COPY;

-- ���������� ���� ���� �ʴ´�.

-- �ܼ��� : �ϳ��� ���̺��� �̿��Ͽ� ������ VIEW 
--  => ������ �˻��Ӹ� �ƴ϶� DML ����� ����Ͽ� ���� ���̺� ���� ����
--  => �׷��Լ� �� DISTINCT ��� �Ұ���

-- ���պ� : �� ���̻��� ���̺��� JOIN �Ͽ� ������ ��
--  => ������ �˻��� �����ϸ� DML ��� ��� �Ұ���
--  => �׷��Լ� �� DISTINCT Ű���� ��� ����

-- VIEW ����
-- ����) CREATE [OR REPLACE] [{FORCE|NOFORCE}] VIEW ���̸�[(�÷���,...)]
--      AS SELECT �˻����,... FROM ���̺��
--      [WITH CHECK OPTION] [WITH READ ONLY]
--  => ������ �����ϴ� ���� ������ ���� �Ұ��� - ���� �� ���� �� �ٽ� ����
--  => OR REPLACE�� ����ϸ� �䰡 �������� ������ ���� 
--  ������ ���� �� ���� �� �ٽ� ����(����)
--  => FORCE : ���� ���̺��� �������� �ʾƵ� VIEW�� �����ϱ� ���� Ű����
--  => WITH CHECK OPTION : �ش� �並 ���� �˻��Ǵ� ���������� INSERT �Ǵ� UPDATE
--                          ����� ���ǵ��� �����ϴ� �ɼ�
--  => WITH READ ONLY : VIEW�� �̿��Ͽ� �˻��� �����ϵ��� �����ϴ� �ɼ� - ����
--                      ���� ������ DML ��� ��� ����

-- EMP_COPY ���̺� ����� ��� �� 30�� �μ��� �ٹ��ϴ� ����� �����ȣ, ����̸�
--  �μ��ڵ带 �˻��Ͽ� EMP_VIEW30�̶�� �� ���� => �ܼ���
-- VIEW�� ���õ� ��� ������ ��� ��ɽ� ���� �߻� => �����ڿ��� VIEW�� ���õ�
-- ���� �ο� ��ġ


-- �����ڷ� �����Ͽ� SCOTT ����ڿ��� VIEW ���� �ý��� ���� �ο�
-- DOS > SQLPLUS /NOLOG
-- SQL > CONN SYS/SYS AS SYSDBA
-- SQL > GRANT CREATE VIEW TO scott;

-- ���� �ο��� ��� �����ϸ� �䰡 ������ �ȴ�. ��� DBA���� ������ �޾ƾ� �Ѵ�.
CREATE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO = 30;

SELECT * FROM EMP_VIEW30; -- ���������� �������� �ʴ´�. �������θ� �����Ѵ�.

-- �� ��� Ȯ�� => USER_VIEWS ���� ��ǳʸ� �̿�
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

-- VIEW�� ������ ����
INSERT INTO EMP_VIEW30 VALUES(1111,'ȫ�浿',30);

COMMIT;

SELECT * FROM EMP_VIEW30;

-- �信 �����Ͱ� ���ԵǴ� ���� �ƴ϶� �並 ������ ���̺� ������ ����
--  => EMP_VIEW30 �䰡 �ƴ� EMP_COPY ���̺� ������ ����
--  => �信 ���� ������� ���� �÷����� DEFAULT ������ ����

SELECT * FROM EMP_COPY;

-- �並 ����ϴ� ����
-- 1) ���� ����ϴ� ������ SELECT ����� ��� �����ϸ� ���� ���� ���ϴ� ����Ÿ �˻�
SELECT EMPNO,ENAME,DEPTNO FROM EMP_COPY WHERE DEPTNO = 30;
SELECT * FROM EMP_VIEW30;

-- 2) �並 �̿��Ͽ� ���� ���� ���� ������ �����ϴ�.

-- ������ : �����ȣ,����̸�,�޿�,���ʽ� �˻� ����
CREATE VIEW EMP_VIEW01 AS SELECT EMPNO,ENAME,SAL,COMM FROM EMP_COPY;

-- �����δ� EMP_COPY �� �������� ���ϵ��� �����Ѵ�.

SELECT * FROM EMP_VIEW01;


-- �λ�� : �����ȣ,����̸�,����,�޿�,�Ի��� �˻� ���� => EMP_VIEW02
CREATE VIEW EMP_VIEW02 AS SELECT EMPNO,ENAME,JOB,HIREDATE,SAL FROM EMP_COPY;

SELECT * FROM EMP_VIEW02;

--EMP ���̺�� DEPT ���̺��� JOIN �Ͽ� �����ȣ,����̸�,�޿�,�μ��� �˻�
SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO;



-- ���� �˻� ����� EMP_VIEW �� ���� => ���պ� 
CREATE VIEW EMP_VIEW AS SELECT EMPNO,ENAME,SAL,DNAME FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO;

SELECT * FROM EMP_VIEW;

SELECT VIEW_NAME,TEXT FROM USER_VIEWS;

-- EMP_VIEW30 �� �˻� => EMP_COPY ���̺� �˻��Ͽ� VIEW ����
SELECT * FROM EMP_VIEW30;


-- OR REPLACE ����� �̿��Ͽ� ���� �� ��� ���ο� �並 �����Ѵ�.
CREATE OR REPLACE VIEW EMP_VIEW30 AS SELECT EMPNO,ENAME,SAL,DEPTNO 
        FROM EMP_COPY WHERE DEPTNO = 30;    -- ���� �߻�
    
-- TEXT ���� Ȯ��
SELECT VIEW_NAME,TEXT FROM USER_VIEWS;















