SET SERVEROUTPUT ON 

-- ���յ����� : RECORD( �ʵ�1, �ʵ�2.....) => ��ü
-- �����
DECLARE
     -- 1) TYPE ����
     TYPE ���ڵ�Ÿ���̸� IS RECORD
     (�ʵ��1 ������Ÿ��,
     �ʵ��2 ������Ÿ�� NOT NULL DEFAULT �ʱⰪ,
     �ʵ��3 ������Ÿ�� := �ʱⰪ, ...);
     
     --2) ���� ����
      ������ �����Ÿ���̸�;
BEGIN
     --3) ���� ��� : ������, �ʵ��
     ������.�ʵ��1 := ��;
     DBMS_OUTPUT.PUT_LINE(������.�ʵ��2);
     
END;
/
--------------------------------------------------------------------------------
--���� : ȸ�������� �ϳ��� ������ �ٷ�
DECLARE
    --ȸ������(���̵�, �̸�, ��������)�� �ǹ�
    --1) RECORD ����
    TYPE user_record_type IS RECORD
    (user_id NUMBER(6,0),
    user_name VARCHAR2(100) := '�͸�',
    join_date DATE NOT NULL DEFAULT SYSDATE);
    
    --2) ��������
    first_user  user_record_type;
    new_user useR_record_type;
BEGIN
    --3) ���� ��� : ������. �ʵ��
    --DBMS_OUTPUT.PUT_LINE(first_user);
    DBMS_OUTPUT.PUT_LINE(first_user.user_id);
    DBMS_OUTPUT.PUT_LINE(first_user.user_name);
    DBMS_OUTPUT.PUT_LINE(first_user.join_date);
END;
/SET SERVEROUTPUT ON
-- ���յ����� : RECORD ( �ʵ�1, �ʵ�2, ... ) => ��ü
-- �����
DECLARE
    -- 1) TYPE ����
    TYPE ���ڵ�Ÿ���̸� IS RECORD
        (�ʵ��1 ������Ÿ��,
         �ʵ��2 ������Ÿ�� NOT NULL DEFAULT �ʱⰪ,
         �ʵ��3 ������Ÿ�� := �ʱⰪ,
         ...);
    -- 2) ���� ����
    ������ ���ڵ�Ÿ���̸�;
BEGIN
    -- 3) ������� : ������.�ʵ��
    ������.�ʵ��1 := ��;
    DBMS_OUTPUT.PUT_LINE(������.�ʵ��2);
END;
/
--------------------------------------------------------------------------------

-- ����  : ȸ�������� �ϳ��� ������ �ٷ�
DECLARE
    -- ȸ������(���̵�, �̸�, ��������)�� �ǹ�
    -- 1) RECORD ����
    TYPE user_record_type IS RECORD
        ( user_id NUMBER(6,0),
          user_name VARCHAR2(100) := '�͸�',
          join_date DATE NOT NULL DEFAULT SYSDATE);
          
    -- 2) ��������
    first_user user_record_type;
    new_user user_record_type;
BEGIN
    -- 3) ���� ��� : ������.�ʵ��
    -- DBMS_OUTPUT.PUT_LINE(first_user);
    DBMS_OUTPUT.PUT_LINE(first_user.user_id);
    DBMS_OUTPUT.PUT_LINE(first_user.user_name);
    DBMS_OUTPUT.PUT_LINE(first_user.join_date);
END;
/
--------------------------------------------------------------------------------
-- Ư�� ����� �����ȣ, ����̸�, �޿��� ����ϼ���.
DECLARE
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_sal employees.salary%TYPE;
    
    v_new_eid employees.employee_id%TYPE;
    v_new_ename employees.last_name%TYPE;
    v_new_sal employees.salary%TYPE;
BEGIN
    SELECT employee_id, last_name, salary
    INTO v_eid, v_ename, v_sal
    FROM employees
    WHERE employee_id = 100;
    
    SELECT employee_id, last_name, salary
    INTO v_new_eid, v_new_ename, v_new_sal
    FROM employees
    WHERE employee_id = 200;
END;
/
--------------------------------------------------------------------------------
DECLARE
    --1) TYPE ����
    TYPE emp_record_type IS RECORD
    (empno NUMBER(6,0),
    ename employees.last_name%TYPE NOT NULL := 'Hong',
    sal employees.salary%TYPE := 0);
    --2) ���� ����
    v_emp_info emp_record_type;
    v_emp_record emp_record_type;
BEGIN
    -- ���� ���
     SELECT employee_id, last_name, salary
     -- INTO v_eid, v_ename, v_sal
     INTO v_emp_info
     --������ RECORD Ÿ�� ���� �ϳ��� ���
     FROM employees
     WHERE employee_id = 200;
     
       SELECT employee_id, last_name, salary
     -- INTO v_new_eid, v_new_ename, v_new_sal
     INTO v_emp_record
     FROM employees
     WHERE employee_id = 100;
       
     --�����ȣ 100
     DBMS_OUTPUT.PUT(v_emp_info.empno);
     DBMS_OUTPUT.PUT(', ' || v_emp_info.ename);
     DBMS_OUTPUT.PUT_LINE(', ' || v_emp_info.sal);
     
     -- �����ȣ 200
     DBMS_OUTPUT.PUT(v_emp_record.empno);
     DBMS_OUTPUT.PUT(', ' || v_emp_record.ename);
     DBMS_OUTPUT.PUT_LINE(', ' || v_emp_record.sal);
END;
/
--------------------------------------------------------------------------------
--%ROWTYPE
--���̺�.  VIEWM, ����� Ŀ���� ������ RECORD Ÿ������ �����ϵ��� ���
-- ������ : ��ȸ�� �� �ִ� ��
--1) �ʵ���� ���� ���� �Ұ�, �����ϴ� ���̺��� �÷���� ������ �ʵ�� ���
--2) SELECT�� �� ��� �� �ݵ�� �ش� ���̺��� ��� �÷��� ���� => * ���
DECLARE
    -- 1)  TYPE ���� => ����
    -- 2) ��������
    v_emp_info employees%ROWTYPE;
    
BEGIN
    -- 3) ���� ���
    SELECT *
    INTO v_emp_info
    FROM employees
    WHERE employee_id = 100;
    
    DBMS_OUTPUT.PUT_LINE(v_emp_info.employee_id);
    DBMS_OUTPUT.PUT_LINE(v_emp_info.last_name);
    DBMS_OUTPUT.PUT_LINE(v_emp_info.salary);
END;
/

SELECT *
FROM employees;

--------------------------------------------------------------------------------
-- ����� Ŀ��
-- ����
DECLARE
    CURSOR test_cursor IS
    SELECT employee_id, last_name
    FROM employees;
    
    v_eid employees.employee_id%TYPE;
    e_ename employees.last_name%TYPE;
BEGIN

    OPEN test_cursor;
    
    FETCH test_cursor INTO v_eid, e_ename;
    DBMS_OUTPUT.PUT_LINE(v_eid);
    DBMS_OUTPUT.PUT_LINE(e_ename);
    CLOSE test_cursor;

END;
/
SELECT employee_id, last_name
FROM employees;
--------------------------------------------------------------------------------
-- 1) ���� : ���� �� SELECT���� ���
DECLARE
    -- 1. Ŀ�� ���� => ����X 
    CURSOR emp_cursor IS
        SELECT  employee_id, last_name, hire_date
        FROM employees
        WHERE department_id = &�μ���ȣ;
        -- �μ���ȣ = 50
        -- �μ���ȣ 
    -- ���� ���� ���� ���� : Ŀ���� SELECT�� �÷� ����ŭ �ʿ�
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2. Ŀ�� ����
    -- 2-1. ���� SELECT���� ����
    -- 2-2. �������� ��ġ�� ���� ���� ��ġ
    OPEN emp_cursor;
    
    -- 3. ������ Ȯ�� �� ��ȯ => 1���� �����͸� 
    -- 3-1. �����͸� ������ �̵�
    -- 3-2. ���� �����Ͱ� ����Ű�� �� ���� ��ȯ
    FETCH emp_cursor INTO v_eid,v_ename,v_hdate;
    
    -- ������ �����͸� ������� �۾�
    DBMS_OUTPUT.PUT_LINE(v_eid);
    DBMS_OUTPUT.PUT_LINE(v_ename);
    DBMS_OUTPUT.PUT_LINE(v_hdate);
    
    --4. Ŀ�� ����
    -- 4-1. �޸𸮿��� ����� ����
    CLOSE emp_cursor;
END;
/
--------------------------------------------------------------------------------
-- ����� Ŀ�� + �⺻ LOOP��
-- 1) ���� : ���� �� SELECT���� ���
DECLARE
    -- 1. Ŀ�� ���� => ����X 
    CURSOR emp_cursor IS
        SELECT  employee_id, last_name, hire_date
        FROM employees
        WHERE department_id = &�μ���ȣ;
        -- �μ���ȣ = 50
        -- �μ���ȣ 
    -- ���� ���� ���� ���� : Ŀ���� SELECT�� �÷� ����ŭ �ʿ�
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    -- 2. Ŀ�� ���� 
    OPEN emp_cursor;   
    LOOP
        -- 3. ������ Ȯ�� �� ��ȯ => 1���� �����͸� 
        FETCH emp_cursor INTO v_eid,v_ename,v_hdate; -- ������ �ִ� �����͸� ���ش�( FETCH)
        -- FETCH�� ������� ������ �����Ͱ� ���ο� �����Ͱ� �ƴ� ���
        EXIT WHEN emp_cursor%NOTFOUND; -- ���ο� ���������� �Ǵ��Ŀ� �۾��ؾ���.
        
         -- 1) LOOP�� �ȿ��� ���� ������ �� ���� ����, ������
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ' ); -- ROWCOUNT : �����͸� �������� ��
         -- ������ �����͸� ������� �۾�
        DBMS_OUTPUT.PUT(v_eid);
        DBMS_OUTPUT.PUT(', ' || v_ename);
        DBMS_OUTPUT.PUT_LINE(', ' || v_hdate);      
    END LOOP; -- Ŀ���� ���� ��� �����͸� ������ ��Ȳ
    
     -- 2) LOOP�� �ٱ����� Ŀ���� ������ �ִ� �� �������� ����, ������
     DBMS_OUTPUT.PUT_LINE('LOOP ���� : ' || emp_cursor%ROWCOUNT);   -- ������ ���� ������ ���� (�ٱ����� ����ϴ� ROWCOUNT)
        --4. Ŀ�� ����
        CLOSE emp_cursor;
END;
/

--------------------------------------------------------------------------------
-- ����� ����
DECLARE
    -- 1) Ŀ�� ����
    CURSOR Ŀ���� IS
        Ŀ���� ������ SELECT��;
BEGIN
    -- 2) Ŀ�� ����
    OPEN Ŀ����;

    LOOP
        -- 3) ������ Ȯ�� �� ��ȯ
        FETCH Ŀ���� INTO ���� ���� ������;
        EXIT WHEN Ŀ����%NOTFOUND
        
        -- ���ο� �����Ͱ� �ִ� ��� ������ �۾�
        -- Ŀ����%ROWCOUNT : ���� ���° ��, ������
    END LOOP;
    -- Ŀ����%ROWCOUNT : Ŀ���� ���� �� ��� , ������
    --4) Ŀ�� ����
    CLOSE Ŀ����;
    -- CLOSE �� %ISOPEN�� ������ �Ӽ��� ���� �Ұ�
END;
/

--------------------------------------------------------------------------------
/*
Ư�� ������ �����ϴ� ����� ������ ����ϼ���.
����� ����� ������ �����ȣ, ����̸�, �Ի����� �Դϴ�.
1) ��� : SELECT��, ������ => ����� Ŀ��
2) �Է� :Ư������(job_id) => ��� :  �����ȣ, ����̸�, �Ի�����
��, �ش� ������ �����ϴ� ����� ���� ���
'�ش� ����� �����ϴ�.'��� ����մϴ�
*/
-- SELCET��
SELECT  employee_id, last_name, hire_date
FROM employees
WHERE job_id LIKE UPPER('&����%');
v_eid employees.employee_id%TYPE;
v_ename employees.last_name%TYPE;
v_hdate employees.hire_date%TYPE;

--  ����� Ŀ��
DECLARE
    -- 1) Ŀ�� ����
    CURSOR emp_cursor;
    SELECT  employee_id, last_name, hire_date
    FROM employees
    WHERE job_id LIKE UPPER('&����%');
    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
    
BEGIN
    -- 2) Ŀ�� ����
    OPEN emp_cursor;
    
    LOOP
        -- 3) ������ ���� �� Ȯ��
        FETCH emp_cursor v_eid, v_ename, v_hdate;
        EXIT WHEN emp_cursor%NOTFOUND;
    
        --�����Ͱ� �����ϴ� ��� ������ �۾�
        DBMS_OUTPUT.PUT(v_eid);
        DBMS_OUTPUT.PUT(', ' || v_ename);
        DBMS_OUTPUT.PUT_LINE(', ' || v_hdate);
    END LOOP; -- Ŀ���� �����͸� �� ������ ��Ȳ
    
    IF emp_cursor%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUTF_LINE('�ش� ����� �����ϴ�.');
    END IF;
    
    -- 4) Ŀ�� ����
    CLOSE emp_cursor;
END;
/

   
--------------------------------------------------------------------------------
/*
1.
���(employees) ���̺���
����� �����ȣ, ����̸�, �Ի翬���� 
���� ���ؿ� �°� ���� test01, test02�� �Է��Ͻÿ�.
=> SELECT��, employees ��ü��ȸ
�Ի�⵵�� 2005��(����) ���� �Ի��� ����� test01 ���̺� �Է�
�Ի�⵵�� 2005�� ���� �Ի��� ����� test02 ���̺� �Է�
=> ���ǹ� IF ~ ELSE��
*/
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;

    v_eid employees.employee_id%TYPE;
    v_ename employees.last_name%TYPE;
    v_hdate employees.hire_date%TYPE;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO v_eid, v_ename, v_hdate;
        EXIT WHEN emp_cursor%NOTFOUND;
        
        IF TO_CHAR(v_hdate, 'yyyy') <= '2005' THEN
            INSERT INTO test01(empid, ename, hiredate)
            VALUES (v_eid, v_ename, v_hdate);
        ELSE
            INSERT INTO test02(empid, ename, hiredate)
            VALUES (v_eid, v_ename, v_hdate);
        END IF;
    END LOOP;
    CLOSE emp_cursor;
END;
/
DELETE test02;
SELECT * FROM test01;
SELECT * FROM test02;


-- ����� Ŀ���� RECORD 
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id eid, last_name ename, hire_date
        FROM employees;
        
    -- Ŀ���� ���� SELECT���� �÷� �������� RECORD Ÿ�� ����
    v_emp_info emp_cursor%ROWTYPE;
    -- employee_id , last_name , hire_date
BEGIN
    OPEN emp_cursor;

    LOOP 
        FETCH emp_cursor INTO v_emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;

        -- �����Ͱ� �����ϴ� ���
        IF TO_CHAR(v_hdate,'yyyy') <= '2015' THEN
            INSERT INTO test01 (empid, ename, hiredate)
            -- Ŀ���� ������� ������� RECORD Ÿ���� �ʵ�� �÷���. ��, ��Ī�� ����� ��� ��Ī�� �ʵ��
            VALUES (v_emp_info.eid, v_emp_info.ename, v_emp_info.hire_date); -- ��Ī�� ������� ���������.
        ELSE 
            -- ���ڵ� Ÿ���� ������ ���̺��� �÷� ������ ���� ���
            INSERT INTO test02 
            VALUES v_emp_info;
        END IF;
    END LOOP;

    CLOSE emp_cursor;
END;
/

--------------------------------------------------------------------------------


/*
2.
�μ���ȣ�� �Է��� ���(&ġȯ���� ���)
�ش��ϴ� �μ��� ����̸�, �Ի�����, �μ����� ����Ͻÿ�.
*/
DECLARE
    CURSOR emp_cursor IS
        SELECT v_ename, hire_date, department_name
        FROM employees;

    v_ename employees.v_ename%TYPE;
    hdate employees.hire_date%TYPE;
    dname employees.department_name%TYPE;
    
BEGIN
    LOOP
    --
    FETCH emp_cursor INTO v_ename, hire_date, department_name
    EXIT WHEN emp_cursor%NOTFOUND;
    --
        DBMS_OUTPUT.PUT(v_ename);
        DBMS_OUTPUT.PUT(', ' || hdate);
        DBMS_OUTPUT.PUT_LINE(', ' || dname);
    END LOOP;
    
    CLOSE emp_cursor;
  
END;
/

--------------------------------------------------------------------------------

/*
3.
�μ���ȣ�� �Է�(&���)�� ��� 
����̸�, �޿�, ����->(�޿�*12+(�޿�*nvl(Ŀ�̼��ۼ�Ʈ,0)*12))
�� ����ϴ�  PL/SQL�� �ۼ��Ͻÿ�.
*/
DECLARE 
    CURSOR emp_cursor IS
                  SELECT last_name,
                         salary,
                         salary*12+(salary*nvl(commission_pct,0)*12) AS years
                  FROM employees
                  WHERE department_id = &�����ȣ;
    emp_info emp_cursor%ROWTYPE;
    
BEGIN
    OPEN emp_cursor;
   LOOP
        FETCH emp_cursor INTO emp_info;
        EXIT WHEN emp_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(emp_info.last_name);
        DBMS_OUTPUT.PUT_LINE(emp_info.salary);
        DBMS_OUTPUT.PUT_LINE(emp_info.years);
   END LOOP;
   CLOSE emp_cursor;
END;
/

DECLARE
    CURSOR emp_of_dept_cursor IS
        SELECT last_name, salary, commission_pct
        FROM employees
        WHERE department_id = &�μ���ȣ;
    
    v_ename employees.last_name%TYPE;
    v_sal   employees.salary%TYPE;
    v_comm  employees.commission_pct%TYPE;
    
    v_annual NUMBER;
BEGIN
    OPEN emp_of_dept_cursor;

    LOOP
        FETCH emp_of_dept_cursor INTO v_ename, v_sal, v_comm;
        EXIT WHEN emp_of_dept_cursor%NOTFOUND;

        -- �����Ͱ� �����ϴ� ���
        v_annual := (v_sal*12+(v_sal*nvl(v_comm,0)*12));

        DBMS_OUTPUT.PUT(v_ename);
        DBMS_OUTPUT.PUT(', ' || v_sal);
        DBMS_OUTPUT.PUT_LINE(', ' || v_annual);
    END LOOP;

    CLOSE emp_of_dept_cursor;
END;
/





--------------------------------------------------------------------------------

-- Ŀ�� FOR LOOP
-- ����
DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees;
        
BEGIN
    FOR emp_info IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ');
        DBMS_OUTPUT.PUT(emp_info.employee_id);
        DBMS_OUTPUT.PUT(', ' || emp_info.last_name);
        DBMS_OUTPUT.PUT_LINE(', ' || emp_info.salary);
    END LOOP;
END;
/

DECLARE
    CURSOR emp_cursor IS
        SELECT employee_id, last_name, salary
        FROM employees;
        
BEGIN
    FOR emp_info IN emp_cursor LOOP -- �Ϲ������� OPEN�� FETCH ����
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ');
        DBMS_OUTPUT.PUT(emp_info.employee_id);
        DBMS_OUTPUT.PUT(', ' || emp_info.last_name);
        DBMS_OUTPUT.PUT_LINE(', ' || emp_info.salary);
    END LOOP; -- �Ϲ������� CLOSE ����
    DBMS_OUTPUT.PUT_LINE('Result : ' || emp_cursor%ROWCOUNT);
    
END;
/