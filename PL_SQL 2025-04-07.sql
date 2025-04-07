SET SERVEROUTPUT ON 

-- PL/SQL���� DML
-- 1)  ������ �����ϸ� ������ Ȱ���� �� ����. 
DECLARE
    v_deptno departments.department_id%TYPE;
    v_comm employees.commission_pct%TYPE := .1;
BEGIN
    --1. SELECT��
    SELECT department_id
    INTO v_deptno
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    --2. INSERT��
    INSERT INTO employees
                    (employee_id, last_name, email, hire_date, job_id, department_id)
    VALUES(1000, 'Hong', 'hkd@google.com', sysdate, 'IT_PROG', v_deptno);
    
    --3 UPDATE��
    UPDATE employees
    SET salary = (NVL(salary, 0) + 10000) * v_comm
    WHERE employee_id = 1000;
END;
/
SELECT *
FROM employees
WHERE employee_id IN (200,1000);

-- 2) �Ͻ��� Ŀ���� RPWCOUNT �Ӽ��� �̿��ؼ� DML�� ����� Ȯ��
BEGIN
    DELETE FROM employees
    WHERE employee_id =0;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || '�� �� ��(��) �����Ǿ����ϴ�.');
    
    BEGIN
    DELETE FROM employees
    WHERE employee_id =1000;
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT || '�� �� ��(��) �����Ǿ����ϴ�.');
END;
/

--��� 1) ���ǹ� : IFans, CASE��
-- 1) IF-THEN ( �⺻ IF��) : �ش� ���ǽ��� TRUE�� ��츸
-- ����
IF ���ǽ� THEN
    ������ ��ɾ�;
END IF;

--����
DECLARE 
    v_number NUMBER(2,0) := 13;
BEGIN
    IF MOD(v_number, 2) =1 THEN
        DBMS_OUTPUT.PUT_LINE('v_number�� Ȧ�� �Դϴ�');
    END IF;
END;
/

-- 2) IF-THEM-ELSE ( IF ~ ELSE��)
-- : �ش� ���ǽ��� TRUE�� ���� FALSE�� ��� ���� ó��
-- ���� 
IF ���ǽ� THEN
     ���ǽ��� TRUE�� ��� ������ ��ɾ�;
ELSE
    ���� ��� ���ǽĵ��� FALSE�� ��� ������ ��ɾ�;
END IF;

--����
DECLARE 
    v_number NUMBER(2,0) := 12;
BEGIN
    IF MOD(v_number, 2) =1 THEN
        DBMS_OUTPUT.PUT_LINE('v_number�� Ȧ���Դϴ�');
    ELSE
     DBMS_OUTPUT.PUT_LINE('v_number�� ¦���Դϴ�');
    END IF;
END;
/

-- 3) IF-THEN-ELSIF ( ���� IF��) : ���� ��츦 ó��
-- ����
IF ���ǽ� THEN
    ���ǽ��� TRUE�� ��� ������ ��ɾ�;
ELSIF �߰� ���ǽ�1 THEN
     �߰� ���ǽ�1�� TRUE�� ��� ������ ��ɾ�;
ELSIF �߰� ���ǽ�2 THEN
    �߰� ���ǽ�2�� TURE�� ��� ������ ��ɾ�;
ELSE
    ���� ��� ���ǽĵ��� FALSE�� ��� ������ ��ɾ�;
END IF;

--����
DECLARE
    v_score NUMBER(2,0) := 87;
BEGIN
    IF v_score >= 90 THEN -- v_score BETWEEN 90 AND 99
         DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF v_score >= 80 THEN -- v_score BETWEEN 80 AND 89
         DBMS_OUTPUT.PUT_LINE('B����'); -- C������ �ڸ��� �ٲ۴ٸ� B������ ������� �ʰ� ����� C������ ���´�.
    ELSIF v_score >= 70 THEN -- v_score BETWEEN 70 AND 79
         DBMS_OUTPUT.PUT_LINE('C����'); -- �ڸ���ġ �߿���.
    ELSIF v_score >= 60 THEN -- v_score BETWEEN 60 AND 69
         DBMS_OUTPUT.PUT_LINE('D����');
    ELSE                      -- v_score BETWEEN -99 AND 59
         DBMS_OUTPUT.PUT_LINE('F����');
    END IF;
END;
/


--------------------------------------------------------------------------------------------------------------------------------

/*
3.
�����ȣ�� �Է�(ġȯ�������&)�� ���
�Ի����� 2005�� ����(2005�� ����)�̸� 'New employee' ���
      2005�� �����̸� 'Career employee' ���
��, DBMS_OUTPUT.PUT_LINE ~ �� �ѹ��� ���

1) �Է� : �����ȣ -> �Ի��Ϸ� ��ȯ => SELECT��

 ) �Ի����� 2005�� ���� (2005�� ����) / 2005�� ���� ���� =>  ���ǹ�
If �Ի����� 2005�� ���� (2005�� ����) then
    'NEW employees' ���
else
    'Career employee' ���
END IF;
*/


DECLARE
    v_hdate employees.hire_date%TYPE;
    v_msg VARCHAR2(100);
BEGIN
    --1. SELECT��
    SELECT hire_date
    INTO v_hdate
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    --2.  ���ǹ�
    --IF v_hdate >= TO_DATE('20250101', 'yyyyMMdd') THEN
    IF TO_CHAR(v_hdate,'yyyy') >= '2005' THEN -- 2005�� �Ѵ����� ���� ���̱� ������ ���ϰ� �ҷ��� TO_CHAR�� ����ϴ°� ����.
        v_msg := 'NEW employees';
    ELSE
       v_msg := 'Career employee';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/
--------------------------------------------------------------------------------------------------------------------------------
/*
4.
create table test01(empid, ename, hiredate)
as
  select employee_id, last_name, hire_date
  from   employees
  where  employee_id = 0;

create table test02(empid, ename, hiredate)
as
  select employee_id, last_name, hire_date
  from   employees
  where  employee_id = 0;

�����ȣ�� �Է�(ġȯ�������&)�� ���
����� �� 2005�� ����(2005�� ����)�� �Ի��� ����� �����ȣ, ����̸�, �Ի����� test01 ���̺� �Է��ϰ�, 
2005�� ������ �Ի��� ����� �����ȣ,����̸�,�Ի����� test02 ���̺� �Է��Ͻÿ�.

1) �Է� : �����ȣ => �����ȣ, ����̸�, �Ի��� : SELECT��
SELECT �����ȣ, ����̸�, �Ի��� 
FROM employees
WHERE �����ȣ = &�����ȣ;

2)
IF 2005�� ����(2005�� ����)�� �Ի� THEN
����� �����ȣ, ����̸�, �Ի����� test01 ���̺� �Է�
INSERT INTO test01 (�����ȣ, ����̸�, �Ի���)
VALUES( �����ȣ, ����̸�, �Ի���)
ELSE
 test02 ���̺� �Է�
 
END IF;

 
*/
DECLARE 
   v_eid employees.employee_id%TYPE;
   v_ename employees.last_name%TYPE;
   v_edate employees.hire_date%TYPE;
BEGIN
    SELECT employee_id, last_name, hire_date 
    INTO v_eid, v_ename, v_edate
    FROM employees
    WHERE employee_id = &�����ȣ;

--2) ���ǹ�
    IF TO_CHAR(v_edate, 'yyyy') >= '2005' THEN

--3) insert��
    INSERT INTO test01 (empid, ename, hiredate)
    VALUES (v_eid, v_ename, v_edate);

ELSE
    INSERT INTO test02 (empid, ename, hiredate)
    VALUES (v_eid, v_ename, v_edate);

    END IF;

END;
/

SELECT * FROM test01;
SELECT * FROM test02;

--------------------------------------------------------------------------------------------------------------------------------
/*
5.
�޿���  5000�����̸� 20% �λ�� �޿�
�޿��� 10000�����̸� 15% �λ�� �޿�
�޿��� 15000�����̸� 10% �λ�� �޿�
�޿��� 15001�̻��̸� �޿� �λ����

�����ȣ�� �Է�(ġȯ����)�ϸ� ����̸�, �޿�, �λ�� �޿��� ��µǵ��� PL/SQL ����� �����Ͻÿ�.
*/
DECLARE
     v_ename employees.last_name%TYPE;
     v_sal employees.salary%type;
     v_raise NUMBER(4,2);
     v_new v_sal%TYPE;
BEGIN
    SELECT last_name, salary
    INTO v_ename,v_sal
    FROM employees
    WHERE employee_id = &�����ȣ;
    
    IF v_sal <= 5000 THEN 
         v_raise := 20;
    ELSIF v_sal <= 10000 THEN 
          v_raise := 15;
    ELSIF v_sal <=  15000 THEN 
          v_raise := 10;
    ELSE                 
         v_raise := 0;
    END IF;
    
    -- 3) �λ�� �޿� ���
    v_new := v_sal + (v_sal * v_raise/100);
    
    --4) ��� : ����̸�, �޿�, �λ�� �޿�
    DBMS_OUTPUT.PUT_LINE(v_ename);
    DBMS_OUTPUT.PUT_LINE(v_sal);
    DBMS_OUTPUT.PUT_LINE(v_new);
END;
/

--------------------------------------------------------------------------------------------------------------------------------
--(loop)
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('HELLO');
        EXIT;
    END LOOP;
END;
/
--------------------------------------------------------------------------------------------------------------------------------
--1) �⺻ LOOP�� : ������ �ݺ��Ѵٸ� ������ ���
-- ��빮�� : EXIT���� ����
LOOP
    --�ݺ��ϰ��� �ϴ� �ڵ�
    EXIT WHEN �������� ������ ���ǽ�;
END LOOP;

--����
DECLARE
 v_num NUMBER(1,0) := 1; -- �ݺ����� ������ ����
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('���� v_num : ' || v_num);
        
        --EXIT WHEN�� ����ϴ� ������ ����Ǵ� �ڵ尡 �ݵ�� �ʿ�
        v_num := v_num + 1;
        -- �ݺ����� ������ ����
        EXIT WHEN V_NUM > 4; -- 4���� Ŀ���� ���� ����
    END LOOP;
END;
/
--------------------------------------------------------------------------------------------------------------------------------
--�ǽ� ) ���� 1���� 10���� ���� ������ ���ϼ���.
--1) ���� 1���� 10������ ǥ���� ���� => LOOP��
--(1,2,3,4,5,6,7,8,9,10)
DECLARE
    v_num NUMBER(2,0) := 1; --���� 1~10
    --2) ��� ������ ���� ���� ����
    v_sum NUMBER(2,0) := 0;
BEGIN
    LOOP
    --���� ������ �ڵ� => �ݺ�
        --DBMS_OUTPUT.PUT_LINE(v_num);
         v_sum := v_sum + v_num;
         
         v_num := v_num + 1;
    --�ݺ����� ����
        EXIT WHEN v_num > 10;
    END LOOP;
    
      DBMS_OUTPUT.PUT_LINE('����:' || v_sum);
END;
/

--------------------------------------------------------------------------------------------------------------------------------
/*

6. ������ ���� ��µǵ��� �Ͻÿ�.
*         
**        
***       
****     
*****    

*/
DECLARE
    v_tree VARCHAR2(6) := '*'; -- '*'�� ���� ����
    v_count NUMBER(1,0) := 1; -- LOOP���� ������ ����
BEGIN
    LOOP
        --�ݺ��ڵ� : '*' ������ �ϳ��� �����ؼ� ���
        DBMS_OUTPUT.PUT_LINE(v_tree);
        v_tree := v_tree || '*';
    
        v_count := v_count +1;
        EXIT WHEN v_count >5;        
        END LOOP;
END;
/
--------------------------------------------------------------------------------------------------------------------------------

/*
7. ġȯ����(&)�� ����ϸ� ���ڸ� �Է��ϸ� 
�ش� �������� ��µǵ��� �Ͻÿ�.
��) 2 �Է½� �Ʒ��� ���� ���
2 * 1 = 2
2 * 2 = 4
...
*/
DECLARE
  v_num NUMBER(1,0) := 2;   -- ��;
  v_gob NUMBER := 1;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_gob || '=' ||(v_num * v_gob));
        v_gob := v_gob + 1;

        EXIT WHEN v_gob > 9;
    END LOOP;
END;
/
--------------------------------------------------------------------------------------------------------------------------------
/*
8. ������ 2~9�ܱ��� ��µǵ��� �Ͻÿ�.
*/
DECLARE
  v_num NUMBER := 2;   -- ��;
  v_gob NUMBER := 1;
BEGIN
    LOOP -- ���� �����ϴ� �ݺ���
        DBMS_OUTPUT.PUT_LINE(v_num);
        v_gob := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_num || '*' || v_gob || '=' ||(v_num * v_gob));
        v_gob := v_gob + 1;
        EXIT WHEN v_gob > 9;
    END LOOP;
        v_num := v_num + 1;
    EXIT WHEN v_num > 9;
    END LOOP;
END;
/
-- ��ø LOOP���� ��� ���ǻ���
--���� LOOP���� ����ɶ� ������ �������ϴ� ������ �۾��� ����

--2) FOR LOOP�� : Ƚ���� �������� �ݺ�
-- ����
FOR �ӽú��� IN  �ּҰ�.. �ִ밪 LOOP
        -- �ӽú���, �ּҰ�, �ִ밪�� ���� ����Ÿ��
        �ݺ� ���� �۾�;
END LOOP;
--���ǻ��� 1) �ӽú����� �����Ұ�(Read Only)
--����
BEGIN
    --FOR idx IN -115 ..-111 LOOP
    FOR idx IN 1 ..5 LOOP
        DBMS_OUTPUT.PUT_LINE('�ӽú��� idx : ' || idx);
    END LOOP;
END;
/

--------------------------------------------------------------------------------------------------------------------------------
--���ǻ��� 2) �ּҰ� ���� �׻� �ִ밪�� ũ�ų�
--REVERSE: �������� ���� �����ö� ���
BEGIN  
    FOR idx IN REVERSE 1..5 LOOP -- ������ �ȵȴ�.
        DBMS_OUTPUT.PUT_LINE(idx);
    END LOOP;
END;
/

--------------------------------------------------------------------------------------------------------------------------------
--���� 1~10���� ����
-- (1,2,3,4,5,6,7,8,9,10) => LOOP��
DECLARE
    v_sum NUMBER(2,0) := 0;
BEGIN
    FOR num IN 1..10 LOOP
        v_sum := v_sum + num;     
        END LOOP;
        
        DBMS_OUTPUT.PUT_LINE(v_sum);
END;
/
--------------------------------------------------------------------------------------------------------------------------------
--���� LOOP��
BEGIN
    FOR line IN 1..5  LOOP
        FOR count IN 1.. line LOOP -- �� line �� '*' ����
        DBMS_OUTPUT.PUT('*') -- JAVA �� SYSTEM.OUT.PRINT()
        END LOOP;
        DBMS_OUTPUT.PUT)LINE(''); -- �ݵ�� �������� PUT_LINE�� �����ؾ� ��.
    END LOOP;
END;
/
/*
6. ������ ���� ��µǵ��� �Ͻÿ�.
*         
**        
***       
****     
*****    
*/
DECLARE
    v_tree VARCHAR2(6) :='*';
BEGIN
    FOR idx IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(v_tree);
        v_tree := v_tree||'*';     
    END LOOP;
    
END;
/
--------------------------------------------------------------------------------------------------------------------------------

/*
7. ġȯ����(&)�� ����ϸ� ���ڸ� �Է��ϸ� 
�ش� �������� ��µǵ��� �Ͻÿ�.
��) 2 �Է½� �Ʒ��� ���� ���
2 * 1 = 2
2 * 2 = 4
...

*/
DECLARE
    v_num NUMBER(1,0) := &��;
BEGIN
    FOR idx IN 1..9 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num || '*' || idx || '=' ||(v_num * idx));
    END LOOP;
END;
/

--------------------------------------------------------------------------------------------------------------------------------

/*
8. ������ 2~9�ܱ��� ��µǵ��� �Ͻÿ�.
*/
DECLARE
BEGIN
    FOR idx IN 1..9 LOOP 
       FOR gob in 2..9 LOOP 
       DBMS_OUTPUT.PUT (gob || '*' || idx || '=' ||(idx * gob));
       DBMS_OUTPUT.PUT('    ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(' ');
        END LOOP;
END;
/


-- �� ���� ���η� ����Ͻÿ�.

--------------------------------------------------------------------------------------------------------------------------------
/*
9. ������ 1~9�ܱ��� ��µǵ��� �Ͻÿ�. (��, Ȧ���� ���)*/
DECLARE
v_gogo NUMBER := 1;
BEGIN
    FOR idx IN 2..9 LOOP 
    IF MOD(idx,2) = 1 THEN     
       FOR gob in 1..9 LOOP 
       -- CCONTINUE WHEN MOD(idx,2) = 0;
            DBMS_OUTPUT.PUT (gob || '*' || idx || '=' ||(idx * gob));
            DBMS_OUTPUT.PUT('    ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END IF;
END LOOP;
END;
/
