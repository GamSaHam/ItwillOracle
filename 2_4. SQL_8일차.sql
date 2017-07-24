
-- DCL (Data Control Language) : ������ �����
--  => �������� ������ �ο��ϰų� ȸ���ϱ� ���� ���
-- ����(Privilege) : �ý��� ����(������) �Ǵ� ��ü ����(�Ϲݰ���)
-- ���� �׷�(ROLE) :  �ý��� ���ѵ��� ���� ����ϱ� ���� ���� �׷��

-- �ý��� ���� �ο�
-- ����) GRANT (PRIVILEGE | ROLE) TO ������ [WITH ADMIN OPTION] [IDENTIFIED BY ��ȣ]
-- ������ ��� PUBLIC�� ����ϸ� ��� �������� ���� �ο�
-- ������ �ο��ϰ��� �ϴ� ������ �������� ���� ��� �ڵ����� ���� ����
--  => ������ �ڵ� ���� �� ��� �ݵ�� IDENTIFIED BY�� ����Ͽ� ��ȣ�� ����
-- WITH ADMIN OPTION : �ο� ���� �ý��� ������ �ٸ� �������� �ο� �� �� �ִ� �ɼ�
--  => ���� ������ �Ϲ� �������� �ο� ���� �ʴ� ���� ����

-- KIM ���� ����
-- DOS> SQLPLUS /NOLOG
-- SQL> CONN SYS/SYS AS SYSDBA;
-- SQL> CREATE USER KIM IDENTIFIED BY 1234;

-- KIM �������� DB ����
--  => CREATE SESSION ������ �����Ƿ� ORACLE DBMS ���� �ź�
-- SQL> CONN KIM/1234

-- �����ڰ� KIM �������� CREATE SESSION ���� ���� �ο�
-- SQL> CONN SYS/SYS AS SYSDBA
-- SQL> GRANT CREATE SESSION TO KIM
-- SQL> SHOW USER; => ���� DBMS ���� ���� Ȯ��


-- KIM �������� EMP ���̺� ����
--  => KIM �������� ���̺� ���� ������ �����Ƿ� ���� �߻�
-- SQL> CREATE TABLE EMP(EMPNO NUMBER(4),ENAME VARCHAR2(10),DEPTNO NUMBER(2));

--�����ڰ� KIM �������� CREATE TABLE ���� �� DEFAULT TABLESPACE ����
--SQL> CONN SYS/SYS AS SYSDBA
--SQL> GRANT CREATE TABLE TO KIM

--TABLESPACE ���� Ȯ�� => DBA_USERS ��ųʸ� �̿�
--SELECT USERNAME,DEFAULT_TABLESPACE FROM DBA_USERS WHERE USERNAME = 'KIM';
--KIM ������ TABLESPACE ũ�⸦ ���� => ������
--SQL> ALTER USER KIM QUOTA UNLIMITED ON SYSTEM;


--KIM �������� EMP ���̺� ����
--  => KIM �������� ���̺� ���� ������ �����Ƿ� ���� �߻�
--SQL> CREATE TABLE EMP(EMPNO NUMBER(4),ENAME VARCHAR2(10),DEPTNO NUMBER(2));

--��ü ���� : �Ϲ� ������ ��ü ���� ��� ��� ����
--  => INSERT,DELETE,UPDATE,SELECT���� ��� ��� ���õ� ����
--����) GRANT {ALL|PRIVILEGE,...} ON ��ü�� TO ������ {WITH GRANT OPTION};
--WITH GRANT OPTION : �ο� ���� ��ü ������ �ٸ� �Ϲ� �������� �ο� �� �� �ִ� �ɼ�

--SCOTT �������� ���� �� SQL ��� ����
-- => DEPT ���̺��� SCOTT ������ ���̺� ��ü
SELECT * FROM SCOTT.DEPT; -- SCOTT. �� ��Ű���̴�. ���� ����ϰ� �ִ���


--KIM �������� ���� �� SQL ��� ����
--SQL> CONN KIM/1234
--KIM �������Դ� DEPT ���̺��� ���� ���� �ʾ� ���� �߻�
--SQL> SELECT * FROM (KIM.)DEPT;
--SCOTT ������ DEPT ���̺� �˻� => SCOTT ��Ű���� �̿��Ͽ� ǥ��
--  => SCOTT ������ DEPT ���̺� �˻� ������ �������� �����Ƿ� ���� �߻�
--SQL> SELECT * FROM SCOTT.DEPT;

--SCOTT ����(GRANTOR)�� KIM �������� DEPT ���̺� �˻� ���� �ο�
GRANT SELECT ON DEPT TO KIM;

--KIM �������� SCOTT ������ DEPT ���̺� �˻�
--SQL> SELECT * FROM SCOTT.DEPT;

--�ٸ� �������� �ο��� ��ü ���� Ȯ�� => USER_TAB_PRIVS_MADE
SELECT * FROM USER_TAB_PRIVS_MADE;

--�ٸ� �������� �ο� ���� ��ü ���� Ȯ�� => USER_TAB_PRIVS_RECD ���� ��ųʸ� �̿�
--SQL> CONN KIM/1234
--SQL> SELECT * FROM USER_TAB_PRIVS_RECD;

--�ý��� ���� ȸ��
--����) REVOKE PRIVILEGE,... FROM ������;
--��ü ���� ȸ��
--����) REVOKE {ALL|PRIVILEGE,...} ON ��ü�� FROM ������
--SCOTT ������ KIM �������� DEP ���̺� �˻� ���� ȸ��
REVOKE SELECT ON DEPT FROM KIM; -- ����

--�����ڰ� KIM�������� �ο��� CREATE SESSION ������ ȸ��
--SQL> CONN SYS/SYS AS SYSDBA;
--SQL> REVOKE CREATE SESSION FROM KIM;

--KIM �������� DBMS ����
--  => KIM �������� CREATE SESSION ������ ���� ���� �ʾ�
-- ������ �ź� �ȴ�.
--  => ��� ������ ȸ���ص� ������ ���� ���� �ʴ´�.
--SQL> CONN KIM/1234

--��(ROLL) : �������� ���� ȿ�������� ������ �ο��ϰų� ȸ���� �� �ֵ��� ���� ����
--�ý��� ������ ���� �׷�ȭ �� ���
--����Ŭ�� �̸� ������� �ִ� ��
-- CONNECT ROLL : 8���� �ý��� ����(CREATE SESSION,CREATE TABLE,ALTER SESSION
--  ,CREATE SYNONYM ��)
--RESOURCE ROLL : ������ ��ü�� ������ �� �ִ� �ý��� ����
--  => CREATE TABLE, CREATE SEQUENCE,CREATE TRIGGER ��
--DBA ROLL : �ý��� ������ �ʿ��� ��� ���� => ������

--�����ڰ� LEE ������ �����Ͽ� CONNECT �� RESOURCE ROLL �ο�
--SQL> CONN SYS/SYS AS SYSDBA
--������ �ο��ϰ��� �ϴ� ������ ���� ���
--SQL> GRANT CONNECT,RESOURCE TO LEE IDENTIFIED BY 5678;

--LEE �������� DBMS ���� �� EMP ���̺� ����


--�����ڰ� LEE ������ �����Ͽ� CONNECT �� RESOURCE ROLL ȸ��
--SQL> CONN SYS/SYS AS DBA;
--SQL> REVOKE CONNECT,RESOURCE FROM LEE;

--LEE �������� DBMS ����
--  => CREATE SESSION �ý��� ������ �����Ƿ� DBMS ���� �ź�
--SQL> CONN LEE/5678

-- PL/SQL(PROCEDUAL LANGUAGE EXTENSION TO SQL)
--  => SQL���� ���� ���� ����, ���� ó��, �ݺ� ó���� �����ϱ� ���� ���

-- 3�κ��� ��� ������ ����
-- 1)DECLAER ����(�����) : DECLEAR
-- 2)EXCUTABLE ����(�����) : BEGIN
-- 3)EXCEPTION ����(����ó����) : EXCEPTION
--  => ������ �ϳ��� ����� ������ �� ���� ;�� ����Ѵ�.
--  => �� �������� END Ű����� �������Ͽ� ;�� ����Ѵ�.
--  => QUERY�� �����ϱ� ���� �ݵ�� .�� �ԷµǾ�� �ȴ�.

-- �޽����� ��� �� �� �ִ� SERVEROUTPUT ȯ�溯�� �� ����
SET SERVEROUTPUT ON

-- ������ �޽����� ����ϴ� PL/SQL �ۼ�

BEGIN

   DBMS_OUTPUT.PUT_LINE('HELLO, ORACLE');
END;
/


-- ���� ���� �� �ʱ�ȭ �Է� => �����
-- ����) ������ [CONSTANT] �ڷ��� [NOT NULL] [{:=|DEFAULT} ǥ����]
-- CONSTANT : ������ ����� ������ ���� �Ұ�
-- NOT NULL : NULL ���� ��� �Ұ�
-- := : ���Թ�
-- ǥ���� | ���,����,�����, �Լ��� �̿��Ͽ� ǥ���ϴ� ��


-- ������ ���� �� ���� => �����
-- ����) ������ := ǥ����

-- ����(��Į�� ���� : ������ �ڷ����� ���� �Է�) ���� �� ���� �Է�
-- �Ͽ� ȭ�鿡 ����ϴ� PL/SQL �ۼ�

DECLARE
    
    VEMPNO NUMBER(4);
    VENAME VARCHAR2(10);
    
BEGIN
    VEMPNO := 7788;
    VENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����̸�');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);

END;
/

-- ���۷��� ���� : �ٸ� ���� �Ǵ� ���̺��� �÷� �ڷ��� �̿� => �����
-- ����) ������ {������%TYPE | ���̺��.�÷���%TYPE}

-- ���̺��� �����͸� �˻��Ͽ� �÷����� ������ �����ϴ� ��� => �����
-- ����) SELECT �˻����,.. INTO ������,... FROM ���̺�� WHERE ���ǽ�;
--  => �˻����� ������ �ڷ��� �� ������ �����ؾ� �Ѵ�.

-- ����(���۷��� ����) ���� �� EMP ���̺��� SCOTT ����� ������ �˻��Ͽ� ������ 
-- �����ϰ� ȭ�鿡 ����ϴ� PL/SQL �ۼ�

DECLARE
    VEMPNO EMP.EMPNO%TYPE;
    VENAME EMP.ENAME%TYPE;
    
BEGIN
    SELECT EMPNO,ENAME INTO VEMPNO,VENAME FROM EMP WHERE ENAME = 'SCOTT';

    DBMS_OUTPUT.PUT_LINE('�����ȣ / ����̸�');
    DBMS_OUTPUT.PUT_LINE('-------------------');
    DBMS_OUTPUT.PUT_LINE(VEMPNO || ' / ' || VENAME);
    
END;
/


-- ���̺� ���� : ���� ���� ������ �����ϱ� ���� ���� (�迭)
--  => �ڷ����� ũ�Ⱑ ������ �����Ҹ� ���� �� ���� 
--  => ������(÷��) ���·� �� �����ҿ� �����Ͽ� ���
-- ����) TYPE ���̺�Ÿ�Ը� IS TABLE OF 
--  {�ڷ��� | ������%TYPE | ���̺��.�÷���%TYPE} [NOT NULL]
--  [INDEX BY BINARY_INTEGER];
--  ���̺� ������ ���̺� Ÿ�Ը�;

--EMP ���̺� ����� ��� ����� �����ȣ,����̸��� ������ ���� �� ȭ�鿡
--����ϴ� PL/SQL �ۼ�

DECLARE
    
    -- ���̺� Ÿ�� ����(�迭 �ڷ��� ����)
    TYPE EMPNO_TABLE_TYPE IS TABLE OF EMP.EMPNO%TYPE INDEX BY BINARY_INTEGER;
    TYPE ENAME_TABLE_TYPE IS TABLE OF EMP.ENAME%TYPE INDEX BY BINARY_INTEGER;

    -- ���̺� ���� ����(�迭 ����)
    VEMPNO_TABLE EMPNO_TABLE_TYPE;
    VENAME_TABLE ENAME_TABLE_TYPE;
    
    -- �ݺ� ó���� ���� ÷�� ���� ����
    I BINARY_INTEGER := 0;
    
BEGIN
    
    -- EMP ���̺��� ��� ��������� �˻��Ͽ� ���̺� ������ ���� => �ݺ� ó��
    FOR K IN(SELECT EMPNO,ENAME FROM EMP) LOOP
        I := I + 1;
        VEMPNO_TABLE(I) := K.EMPNO;
        VENAME_TABLE(I) := K.ENAME;
    END LOOP;
    
    -- ���̺� ������ ����� ������ ��� => �ݺ� ó��
    FOR J IN 1..I LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD(TO_CHAR(J),2)|| '/' || RPAD(VEMPNO_TABLE(J),6) || ' / ' || RPAD(VENAME_TABLE(J),12));
    END LOOP;
    
END;
/

-- ���� ���� �ڹ� ��������

-- ���ڵ� ���� : ���̺� ����� �������� �÷����� �����ϱ� ���� ���� => �ν��Ͻ�
-- ����) TYPE ���ڵ�Ÿ�Ը� IS RECORD (�ʵ�� {�ڷ��� | ������%TYPE | ���̺��.�÷���%TYPE}
--  [NOT NULL] [{|= |DEFAULT} ǥ����],...)
--  ���ڵ庯���� ���ڵ�Ÿ��

-- ���ڵ� ���� ��� ���
-- ����) ���ڵ庯����.�ʵ��

-- SCOTT ����� �����ȣ,����̸�,����,�޿�,�μ��ڵ带 �˻��Ͽ� 
-- ������ ���� �� ����ϴ� PL/SQL�ۼ�
DECLARE
    -- ���ڵ� Ÿ�� ����
    TYPE EMP_RECORD_TYPE IS RECORD(VEMPNO EMP.EMPNO%TYPE,VENAME EMP.ENAME%TYPE
    , VJOB EMP.JOB%TYPE, VSAL EMP.SAL%TYPE,VDEPTNO EMP.DEPTNO%TYPE);
    
    -- ���ڵ� ���� ����
    VEMP_RECORD EMP_RECORD_TYPE;

BEGIN
    SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO VEMP_RECORD.VEMPNO,VEMP_RECORD.VENAME
        ,VEMP_RECORD.VJOB,VEMP_RECORD.VSAL,VEMP_RECORD.VDEPTNO 
            FROM EMP WHERE ENAME = 'SCOTT';
        
        DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP_RECORD.VEMPNO);
        DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP_RECORD.VENAME);
        DBMS_OUTPUT.PUT_LINE('���� = ' || VEMP_RECORD.VJOB);
        DBMS_OUTPUT.PUT_LINE('�޿� = ' || VEMP_RECORD.VSAL);
        DBMS_OUTPUT.PUT_LINE('�μ��ڵ� = ' || VEMP_RECORD.VDEPTNO);

END;
/

-- ���۷��� ���� �������� �����Ͽ� �����͸� ������ �� �ִ� ���ڵ� ���� ���
-- ����) ���ڵ� ������ ���̺��%ROWTYPE;
--  => ��� ��� ����) ���ڵ� ������.�÷���

DECLARE     
    -- ���ڵ� ���� ����
    VEMP_RECORD EMP%ROWTYPE;

BEGIN
    --SELECT EMPNO,ENAME,JOB,SAL,DEPTNO INTO VEMP_RECORD.EMPNO,VEMP_RECORD.ENAME
    --    ,VEMP_RECORD.JOB,VEMP_RECORD.SAL,VEMP_RECORD.DEPTNO 
    --        FROM EMP WHERE ENAME = 'SCOTT';
            
     SELECT * INTO VEMP_RECORD FROM EMP WHERE ENAME = 'SCOTT';
        
        DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP_RECORD.EMPNO);
        DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP_RECORD.ENAME);
        DBMS_OUTPUT.PUT_LINE('���� = ' || VEMP_RECORD.JOB);
        DBMS_OUTPUT.PUT_LINE('�޿� = ' || VEMP_RECORD.SAL);
        DBMS_OUTPUT.PUT_LINE('�μ��ڵ� = ' || VEMP_RECORD.DEPTNO);

END;
/


-- ���ù� : ����� �����Ͽ� �����ϱ� ���� ��ɹ�
-- IF �� : ���ǽĿ� ���� ����� ���� ����
-- ����1) IF(���ǽ�) THEN ��� END IF;

-- EMP ���̺��� SCOTT ����� �˻��Ͽ� �����ȣ,����̸�,�μ��ڵ忡 ���� �μ����� ���
-- �ϴ� PL/SQL �ۼ�

DECLARE
    VEMP EMP%ROWTYPE;
    
    -- �μ����� �����ϱ� ���� ���� ����
    VDNAME VARCHAR2(20) := NULL;

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
    
    IF(VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNT';
    END IF;

    IF(VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    END IF;

    IF(VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    END IF;

    IF(VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATION';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� = ' || VDNAME);


END;
/

-- EMP ���̺��� SCOTT ����� �˻��Ͽ� �����ȣ, ����̸�
-- , ����((�޿�+���ʽ�)*12)�� ������ �����Ͽ� ����ϴ� PL/SQL �ۼ�

DECLARE
    VEMP EMP%ROWTYPE;

    AANUAL NUMBER(7,2);

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';

    -- ��� 1
    --IF VEMP.COMM IS NULL THEN
    --    VEMP.COMM = 0;
    --END IF;
   
    -- ���2 NVL ���
    AANUAL := (VEMP.SAL + NVL(VEMP.COMM,0)) * 12;
   
    DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = ' || TO_CHAR(AANUAL,'$999,990'));

END;
/

-- ����2) IF(���ǽ�) THEN ��� ELSE ��� END IF;
DECLARE
    VEMP EMP%ROWTYPE;

    AANUAL NUMBER(7,2);

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';


    IF(VEMP.COMM IS NULL) THEN
        AANUAL := (VEMP.SAL) * 12;
    ELSE
        AANUAL := (VEMP.SAL + VEMP.COMM) * 12;
    END IF;
   
   
    DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = ' || TO_CHAR(AANUAL,'$999,990'));

END;
/

-- ����3) IF(���ǽ�) THEN ��� ELSIF(���ǽ�) THEN ��� ELSE ��� END IF;
DECLARE
    VEMP EMP%ROWTYPE;
    
    -- �μ����� �����ϱ� ���� ���� ����
    VDNAME VARCHAR2(20) := NULL;

BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
    
    IF(VEMP.DEPTNO = 10) THEN
        VDNAME := 'ACCOUNT';
    ELSIF(VEMP.DEPTNO = 20) THEN
        VDNAME := 'RESEARCH';
    ELSIF(VEMP.DEPTNO = 30) THEN
        VDNAME := 'SALES';
    ELSIF(VEMP.DEPTNO = 40) THEN
        VDNAME := 'OPERATION';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('�μ��̸� = ' || VDNAME);
END;
/

-- CASE��: �÷��� ����� ������ �Ǵ� ���ǽ��� ������� �̿��Ͽ� ��� ���� ����
-- ����1) CASE ������ WHEN ��1 THEN ���; WHEN ��2 THEN ���; .. END CASE;

-- EMP ���̺� ����̸��� SCOTT �� ����� �˻��Ͽ� �����ȣ, ����̸�, ����
--  �޿�, ������ ���� �����޾��� ������ �����Ͽ� ����ϴ� PL/SQL �ۼ�
-- �����޾� => ANALYST : �޿� * 1.1, CLARK:�޿� * 1.2 , MANAGER: �޿�*1.3
--  PRESIDENT:�޿�*1.4 SALESMAN:�޿�*1.5

DECLARE
    VEMP EMP%ROWTYPE;
    VPAY NUMBER(7,2);
    
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
   
    CASE VEMP.JOB WHEN 'ANALYST' THEN VPAY := VEMP.SAL * 1.1;
                WHEN 'CLARK' THEN VPAY := VEMP.SAL * 1.2;
                WHEN 'MANAGER' THEN VPAY := VEMP.SAL * 1.3;
                WHEN 'PRISIDENT' THEN VPAY := VEMP.SAL * 1.4;
                WHEN 'SALESMAN' THEN VPAY := VEMP.SAL * 1.5; END CASE;
   
    DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = ' || VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = ' || VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('�����޾� = ' || VPAY);
    
END;
/

-- ����2) CASE WHEN ���ǽ�1 THEN ���;.. END CASE;

DECLARE
    VEMP EMP%ROWTYPE;
    VPAY NUMBER(7,2);
    
BEGIN
    SELECT * INTO VEMP FROM EMP WHERE ENAME = 'SCOTT';
   
    CASE  WHEN VEMP.JOB = 'ANALYST' THEN VPAY := VEMP.SAL * 1.1;
            WHEN VEMP.JOB= 'CLARK' THEN VPAY := VEMP.SAL * 1.2;
            WHEN VEMP.JOB='MANAGER' THEN VPAY := VEMP.SAL * 1.3;
            WHEN VEMP.JOB='PRISIDENT' THEN VPAY := VEMP.SAL * 1.4;
            WHEN VEMP.JOB='SALESMAN' THEN VPAY := VEMP.SAL * 1.5; END CASE;

    DBMS_OUTPUT.PUT_LINE('�����ȣ = ' || VEMP.EMPNO);
    DBMS_OUTPUT.PUT_LINE('����̸� = ' || VEMP.ENAME);
    DBMS_OUTPUT.PUT_LINE('���� = ' || VEMP.JOB);
    DBMS_OUTPUT.PUT_LINE('�޿� = ' || VEMP.SAL);
    DBMS_OUTPUT.PUT_LINE('�����޾� = ' || VPAY);
    
END;
/

-- �ݺ��� : ����� �ݺ��Ͽ� �����ϴ� ��ɹ�

-- �⺻ �ݺ���(BASIC LOOP)
-- ����) LOOP ���: ���;...EXIT[WHEN ���ǽ�] END LOOP;

-- 1~5�� ȭ�鿡 ����ϴ� PL/SQL �ۼ�
DECLARE

    I NUMBER(2) := 1;

BEGIN

    LOOP
        DBMS_OUTPUT.PUT_LINE(I);
        I := I + 1;
        IF I > 5 THEN
            EXIT;
        END IF;
    END LOOP;

END;
/


-- FOR LOOP : �ݺ�Ƚ���� ������ �ִ� ��� ����ϴ� �ݺ���
-- ����1) FOR INDEX_COUNTER [REVERSE] IN LOWER_BOUND..UPPER_BOUND LOOP
--  ���; ���; ... END LOOP;
-- INDEX_COUNTER : LOWER_BOUND���� UPPER_BOUND���� 1�� �����Ǵ� ���� �����ϱ�
--  ���� ����

-- 1~10 ������ ���� �հ踦 ����Ͽ� ����ϴ� PL/SQL �ۼ�
DECLARE
    TOT NUMBER(2) := 0;
    
    
BEGIN
    
    FOR I IN 1..10 LOOP
        TOT := TOT + I;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~10���� ������ ���� �հ� = ' || TOT);    
END;
/

-- ����2) FOR ���ڵ庯���� IN (�˻����) LOOP ���;... END LOOP;
--  => �˻��� �����Ͱ� ���� ���� ��� ���ڵ� ������ �����Ͽ� �ݺ� ó�� �ϱ� ���� ���
--  => ���ڵ庯���� ����� �÷����� ��� ����.�÷������� ǥ���Ͽ� ���


-- EMP ���̺� ����� ��� ����� �����ȣ,����̸� �˻��Ͽ� ��� PL/SQL �ۼ�

BEGIN
    FOR VEMP IN (SELECT * FROM EMP) LOOP
    
        DBMS_OUTPUT.PUT_LINE('�����ȣ = '||VEMP.EMPNO||', ����̸� = '||VEMP.ENAME);
    
    END LOOP;

END;
/

-- WHILE LOOP : �ݺ��� Ƚ���� ������ ���� ���� ��� ���
-- ����) WHILE ���ǽ� LOOP ���; ���;... END LOOP;

DECLARE
    
    I NUMBER(2) := 2;
    TOT NUMBER(2) :=0;
BEGIN

    WHILE I<=10 LOOP
        TOT := TOT + I;
        I := I+2;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('1~���� 10 ������ ¦���� ��'|| TOT);
    
END;
/

-- ���� ���ν���(STORED PROCEDURE) : ������ SQL ��ɵ��� ���ν����� �����Ͽ� �ʿ���
-- ��� ȣ���Ͽ� ����� ���� �� �ִ� ���
-- ����) CREATE [OR REPLACE] PROCEDURE ���ν����� [(�Ű����� [MODE] �ڷ���,...)]
--  IS ���� ����� BEGIN ���; ���; ... END;

-- EMP01 ���̺��� ��� �����͸� �����ϴ� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE DELETE_ALL IS 

BEGIN 
    DELETE FROM EMP01;
END;
/

-- ���� ���ν��� ����
-- ����) EXECUTE ���ν�����(�� �Ǵ� ����,...);
SELECT * FROM EMP01;

EXECUTE DELETE_ALL;

ROLLBACK;

-- EMP01 ���̺��� ��� �����͸� �����ϴ� ���� ���ν��� ����
--  => ���� �߻� (�����Ϸ� �α� Ȯ��)
CREATE OR REPLACE PROCEDURE DELETE_ALL IS 

    DELETE FROM EMP01;
END;
/

SHOW ERROR;

-- ���� ���ν��� Ȯ�� => USER_SOURCE ���� ��ųʸ� �̿�
SELECT NAME,TEXT FROM USER_SOURCE;

-- EMP01 ���̺� ����� ��� �̸��� ���� �޾� �����ϴ� ���� ���ν��� ���� �� ����
CREATE  OR REPLACE PROCEDURE DELETE_ENAME(VENAME EMP.ENAME%TYPE) IS

BEGIN
    DELETE FROM EMP01 WHERE ENAME = VENAME;
END;
/

SELECT * FROM EMP01;
EXECUTE DELETE_ENAME('ȫ�浿');
ROLLBACK;

-- �Ű����� MODE
--  => IN : �ܺε����͸� ���� ���ν����� ���� ���� ������ �Ű����� ����
--  => OUT : ���� ���ν����� ���� �����͸� �ܺη� ���� �� ������ �Ű����� ����
--  => INOUT : IN �� OUT ����� ��� ���� �Ű����� ����

-- �����ȣ�� ���޹޾� EMP ���̺� ����� �ش� ����� ����̸�,����,�޿��� 
-- �ܺη� �����ϴ� ���ν����� �����Ͽ� ����
CREATE OR REPLACE PROCEDURE SELECT_EMPNO(VEMPNO IN EMP.EMPNO%TYPE
    , VENAME OUT EMP.ENAME%TYPE, VJOB OUT EMP.JOB%TYPE, VSAL OUT EMP.SAL%TYPE) IS BEGIN

    SELECT ENAME,JOB,SAL INTO VENAME,VJOB,VSAL FROM EMP WHERE EMPNO = VEMPNO;

END;
/

-- OUT �ŰԺ����� �����͸� �����ϱ� ���� ���� ���� => ���ε� ����
-- ����) VARIABLE ������ �ڷ���;
VARIABLE VAR_ENAME VARCHAR2(15);
VARIABLE VAR_JOB VARCHAR2(20);
VARIABLE VAR_SAL NUMBER;

-- SELECT_EMPNO ���� ���ν��� ����
--  => OUT �ŰԺ����� ������ �����͸� �����ϴ� ���ε� ������ �տ� :�� �ٿ� ����Ѵ�.
EXECUTE SELECT_EMPNO(7369,:VAR_ENAME,:VAR_JOB,:VAR_SAL);

-- ���ε� ������ ����� ������ ���
-- ����) PRINT ���ε� ������;
PRINT VAR_ENAME;
PRINT VAR_JOB;
PRINT VAR_SAL;


-- ���� �Լ�(STORED FUNCTION) : ���� ���ν����� ������ ��Ȱ�� ����
--  => �����͸� ��ȯ ����
-- ����) CREATE [OR REPLACE] �Լ��� [(�Ű����� [MODE] �ڷ���,...)] RETURN �ڷ��� IS ������ �ڷ���;...
--  BEGIN ���; ���; ... RETURN ������ END;


-- �����ȣ�� ���޹޾� �ش� ������� 200%�� Ư�������� �����ϱ� ���� �����Լ� ���� �� ����
CREATE OR REPLACE FUNCTION CAL_BONUS(VEMPNO IN EMP.EMPNO%TYPE)

    RETURN NUMBER IS VSAL NUMBER(7,2);
    
BEGIN
    SELECT SAL INTO VSAL FROM EMP WHERE EMPNO = VEMPNO;

    RETURN (VSAL*2.0);

END;
/

SHOW ERROR;

-- ���� �Լ� ���� => EXECUTE ��� ���

VARIABLE VAR_BONUS NUMBER;
 EXECUTE :VAR_BONUS := CAL_BONUS(7788);

PRINT VAR_BONUS;

-- �����Լ��� SQL��ɿ� ���� ����
SELECT EMPNO,ENAME,SAL,CAL_BONUS(EMPNO) "Ư������" FROM EMP;

-- Ŀ��(CURSOR) : �˻��� �����͸� ó���ϱ� ���� ���
--  => ������ Ŀ�� : �˻� ����� �ϳ��� ���� ��츦 ó���ϱ� ���� Ŀ��
--  => ����� Ŀ�� : �˻� ����� ���� ���� ��� ó���ϱ� ���� Ŀ��

-- ����� Ŀ�� ���� �� ��� ���
-- ����) DECLARE CURSOR Ŀ���� IS �˻� ���;
--  BEGIN
--      OPEN Ŀ����;
--      FETCH Ŀ���� INTO ������,...;
--      CLOSE Ŀ����;
--  END;

-- DEPT ���̺� ����� ��� �μ������� ȭ�鿡 ����ϴ� ���� ���ν��� ����
CREATE OR REPLACE PROCEDURE CURSOR_EXAMPLE1 IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C IS SELECT * FROM DEPT;

BEGIN
    OPEN C;
    
    LOOP
        FETCH C INTO VDEPT.DEPTNO, VDEPT.DNAME, VDEPT.LOC;
        -- Ŀ�� ��ġ�� ���̻� �����Ͱ� ���� ���� �ʴ°��
        EXIT WHEN C%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('�μ��ڵ� = ' || VDEPT.DEPTNO || ', �μ��̸� = '
            || VDEPT.DNAME || ', �μ���ġ ='|| VDEPT.LOC);
        
        
    END LOOP;
    
    CLOSE C;
END;
/


EXECUTE CURSOR_EXAMPLE1;


CREATE OR REPLACE PROCEDURE CURSOR_EXAMPLE2 IS
    VDEPT DEPT%ROWTYPE;
    CURSOR C IS SELECT * FROM DEPT;

BEGIN
    -- FOR LOOP �̿��Ͽ� �ݺ�ó�� �� ��� Ŀ���� ���� OPEN,FETCH,CLOSE�� ������� 
    -- �ʾƵ� �ȴ�.
    FOR VDEPT IN C LOOP
        -- Ŀ�� ��ġ�� ���̻� �����Ͱ� ���� ���� �ʴ°��
        EXIT WHEN C%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('�μ��ڵ� = ' || VDEPT.DEPTNO || ', �μ��̸� = '
            || VDEPT.DNAME || ', �μ���ġ ='|| VDEPT.LOC);
        
    END LOOP;
END;
/

EXECUTE CURSOR_EXAMPLE2;

CREATE OR REPLACE PROCEDURE CURSOR_EXAMPLE3 IS
    VDEPT DEPT%ROWTYPE;

BEGIN
    -- FOR LOOP �̿��Ͽ� �ݺ�ó�� �� ��� Ŀ���� ���� OPEN,FETCH,CLOSE�� ������� 
    -- �ʾƵ� �ȴ�.
    FOR VDEPT IN(SELECT * FROM DEPT) LOOP
        
        DBMS_OUTPUT.PUT_LINE('�μ��ڵ� = ' || VDEPT.DEPTNO || ', �μ��̸� = '
            || VDEPT.DNAME || ', �μ���ġ ='|| VDEPT.LOC);
        
    END LOOP;
END;
/

EXECUTE CURSOR_EXAMPLE3;

-- Ʈ����(TRIGGER) : � ������ �߻��� ��� �ڵ����� ���۵ǵ��� �����ϴ� ���
-- Ʈ���� ����
-- ����) CREATE [OR REPLACE] TRIGGER Ʈ���Ÿ� {BEFORE | AFTER}
--  DML ��� ON ���̺�� [FOR EACH ROW] [WITH ���ǽ�]
--  BEGIN ���; ���; ... END;
-- FOR EACH ROW : �����Ǹ� ���� ���� Ʈ����, �����ϸ� �� ���� Ʈ����
--  => ���� ���� Ʈ���� : �̺�Ʈ DML ����� ����Ǹ� Ʈ���Ű� �ѹ��� ����
--  => �� ���� Ʈ���� : �̺�Ʈ DML ����� ����Ǹ� Ʈ���Ű� ������ ����

-- EMP02 ���̺� ���� => �����ȣ(PK),����̸�,������ �����ϱ� ���� ���̺�
CREATE TABLE EMP03(EMPNO NUMBER(4) PRIMARY KEY,ENAME VARCHAR2(20)
    ,JOB VARCHAR(20));

DESC EMP03;

-- EMP03 ���̺� ��������� ������ �� �޽����� ����ϴ� Ʈ���� ����
CREATE OR REPLACE TRIGGER TRI01 AFTER INSERT ON EMP03
BEGIN
    DBMS_OUTPUT.PUT_LINE('���ο� ����� �Ի� �Ͽ����ϴ�');
END;
/



INSERT INTO EMP03 VALUES(1000,'ȫ�浿','SALESMAN');
INSERT INTO EMP03 VALUES(2000,'��浿','MANAGER');

DELETE FROM EMP03;
COMMIT;


-- SAL03 ���̺� ���� => �޿���ȣ(PK),�޿�,�����ȣ(FK => EMP ���̺��� EMP �÷�)��
-- �����ϱ� ���� ���̺�
CREATE TABLE SAL03(SALNO NUMBER(4) PRIMARY KEY,SAL NUMBER(7,2),EMPNO NUMBER(4) REFERENCES EMP03(EMPNO));
        
-- ������ ��ü
CREATE SEQUENCE SAL03_SEQ;
        
        
-- EMP03 ���̺� ��������� �����ϸ� SAL03 ���̺� �޿� ���� �ڵ� ����
CREATE OR REPLACE TRIGGER TRI02 AFTER INSERT ON EMP03 FOR EACH ROW

BEGIN
    -- NEW.�÷��� : ���� �Ǵ� ���� �������� �÷� ǥ��
    -- OLD.�÷��� : ���� �Ǵ� ���� �������� �÷� ǥ��
    INSERT INTO SAL03 VALUES(SAL03_SEQ.NEXTVAL,2000,:NEW.EMPNO);
END;
/


INSERT INTO EMP03 VALUES(2000,'�Ӳ���','����');
INSERT INTO EMP03 VALUES(3000,'����ġ','�븮');

SELECT * FROM EMP03;
SELECT * FROM SAL03;
        
COMMIT;

SELECT * FROM USER_TRIGGERS;


-- Ʈ���� ����
-- ����) DROP TRIGGER Ʈ���Ÿ�;
DROP TABLE TRI02;

INSERT
INSERT INTO EMP03 VALUES(4000,'������','���');
SELECT * FROM EMP03;
SELECT * FROM SAL03;
        





