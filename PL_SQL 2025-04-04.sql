SET SERVEROUTPUT ON
-- PL/SQL ���
BEGIN
-- ���� �ּ�
/*
 ������ �ּ�
 */
    DBMS_OUTPUT.PUT_LINE('HELLO, PL/SQL!');
END;
/

--���� ����
DECLARE
    -- IDENTIFIER[constant] datatype[not null] [:= | DEFAULT expr];
    --�⺻ ��� : ������ ������Ÿ��;
    v_str VARCHAR2(100); --�ʱⰪ�� NULL
    
    --������� : ������ CONSTANT ������Ÿ�� := ǥ����; -- ���� ó������ ���� �� �ֵ��� �ؾ���.
    v_num CONSTANT NUMBER(2,0) := 10;
    
    --NOT NULL ���� : ������ ������Ÿ�� NOT NULL := ǥ����;
    v_count number(1,0) not null :=  5;
    
    --���� ���� �� �ʱ�ȭ : ������ ������Ÿ�� := ǥ����;
    v_sum NUMBER(3,0) := (v_num + v_count);
BEGIN
--v_str :='Hello';
--v_num := 100; 
--CONSTANT) : ����� ������ ������ ���� ������ ���
-- ���ο� ������ ������� �ϴϱ� �浹���� ����(cannot be used as an assignment target) ������ ����̱� ������ ������ �� ���ٴ� ��.
--v_count := null; 
-- NOT NULL ���� ���� �ߵ�, ������ NULL���� �õ��߱� ������ ������
--NOT NULL ) NOT NULL  ���������� ������ ������ NULL�� �Ҵ��� ���
--v_sum := v_num + 1234;
-- ������ ũ���� ���� 

DBMS_OUTPUT.PUT_LINE('v_str : ' || v_str);
DBMS_OUTPUT.PUT_LINE('v_str : ' || v_num);
DBMS_OUTPUT.PUT_LINE('v_str : ' || v_count);
DBMS_OUTPUT.PUT_LINE('v_str : ' || v_sum);
END;
/ -- ���� �����ϴ� ����

-- PL/SQL���� �Լ� ���
DECLARE
    --�����
    v_today DATE := SYSDATE;
    v_after_day v_today%TYPE; -- (=v_after_day employee.hire_date%TYPE;
    v_msg VARCHAR2(100);
BEGIN
--�����
    v_after_day := ADD_MONTHS(v_today, 3);
    v_msg := TO_CHAR(v_after_day,'yyyy"��" MM"��" dd"��"');
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/

-- PL/SQL�� SELECT��
--1)����
DECLARE
v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    --��ȸ�� �����͸� ������ ��� ����
    INTO v_ename
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE(v_ename);
END;
/

 SELECT last_name
    --INTO v_ename
    FROM employees
    WHERE employee_id = 100;
    
    --2) ����� �ݵ�� Only one!
DECLARE
v_ename VARCHAR2(100);
BEGIN
SELECT last_name
INTO v_ename
FROM employees
WHERE department_id =&�μ���ȣ;
-- �μ���ȣ : 10 : Whalen, �������
-- �μ���ȣ : 50 : ����(too many rows : ORA-01422:exact fetch returns more than requested number of rows)
-- �μ���ȣ : 0 : ORA-01403: no data found

DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename);

END;
/

-- 3) SELECT ���� �÷��� INTO ���� ���� ����
DECLARE
    v_eid employees.employee_id%type;
    v_ename VARCHAR2(100);
BEGIN
    SELECT employee_id, last_name
    INTO v_eid, v_ename
    -- SELECT > INTO )ORA-00947: not enough values
    -- SELECT < INTO ) ORA-00913: too many values
    FROM employees
    WHERE employee_id = 100;
 DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid ||', ����̸� : ' || v_ename);
END;
/
 
 --�ǽ�����
 /*
 �����ȣ�� �Է�(ġȯ����) �� ��� �ش�
 ����� �̸��� �Ի����ڸ� ����ϴ� PL/SQL�� �ۼ��ϼ���
 1)SQL�� Ȯ�� ��� => SELECT��
 �Է� : �����ȣ -> ��� : ����� �̸�, �Ի����� (���̺� employees)
 
 SELECT ����̸�, �Ի�����
 FROM employees
 WHERE �����ȣ
 
 2) PL/SQL ��� ����
 */
 SELECT employee_id, hire_date
 FROM employees
 WHERE employee_id = &�����ȣ;
 
  --2) PL/SQL ��� ���� 
 DECLARE
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
 BEGIN
    SELECT last_name, hire_date
    INTO v_ename, v_hdate
    FROM employees
    WHERE employee_id = &�����ȣ;
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename ||', �Ի����� : ' || v_hdate);
 END;
 /
 
 -- ��������~~~~~ ��������
 
 
/*
1.
�����ȣ�� �Է�(ġȯ�������&)�� ���
�����ȣ, ����̸�, �μ��̸�  
�� ����ϴ� PL/SQL�� �ۼ��Ͻÿ�.
*/

DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_dept_name departments.department_name%TYPE;
 BEGIN
    SELECT employee_id, last_name, department_name
    INTO v_eid, v_ename, v_dept_name
    FROM employees e
    JOIN departments d
    ON e.department_id = d.department_id
    WHERE employee_id = &�����ȣ;
    DBMS_OUTPUT.PUT_LINE('�����ȣ : ' || v_eid ||', ����̸� : ' || v_ename ||', �μ��̸� : ' || v_dept_name);
 END;
 /

/*
2.
�����ȣ�� �Է�(ġȯ�������&)�� ��� 
����̸�, 
�޿�, 
����->(�޿�*12+(nvl(�޿�,0)*nvl(Ŀ�̼��ۼ�Ʈ,0)*12))
�� ����ϴ�  PL/SQL�� �ۼ��Ͻÿ�.
*/
DECLARE
    v_ename employees.last_name%TYPE;
    v_esal employees.salary%TYPE;
    v_com number(15,2);
 BEGIN
    SELECT last_name, salary, (salary*12+(nvl(salary,0)*nvl(commission_pct,0)*12))
    INTO v_ename, v_esal, v_com
    FROM employees
    WHERE employee_id = &�����ȣ;
    DBMS_OUTPUT.PUT_LINE('����̸� : ' || v_ename ||', �޿� : ' || v_esal ||', ���� : ' || v_com );
 END;
 /
 