SET SERVEROUTPUT ON 

-- ����� Ŀ�� + Ŀ�� FOR LOOP : ����� Ŀ�� ������
-- 1) �����
DECLARE
    -- 1. Ŀ�� ����
    CURSOR Ŀ���̸� IS
        SELECT��;
BEGIN 
    -- 2. Ŀ�� ���� ( OPEN, FETCH, CLOSE)
   FOR �ӽú��� IN Ŀ���̸� LOOP -- �Ϲ������� OPEN �� FETCH ����
        -- �����Ͱ� �����ϴ� ��� ������ �۾�
        -- 2-1) �ӽú����� RECORD Ÿ��
        -- 2-2) Ŀ���� �����Ͱ� ���� ��� ����Ұ�
    END LOOP; -- �Ϲ������� CLOSE ����
END;
/

-------------------------------------------------------------------------------- 1
-- ����
DECLARE
    -- 1. Ŀ�� ����
        CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees
        WHERE department_id = &�μ���ȣ;
BEGIN
     -- 2. Ŀ�� ����
     FOR emp_rec IN emp_cursor LOOP
        DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ' );
        -- emp_rec : RECORD Ÿ���� �ӽú���, �ʵ�� Ŀ���� SELECT�� �÷��̸�
        DBMS_OUTPUT.PUT(emp_rec.employee_id);
        DBMS_OUTPUT.PUT(', ' || emp_rec.last_name);
        DBMS_OUTPUT.PUT_LINE(', ' || emp_rec.hire_date);  
     END LOOP;   
END;
/
-------------------------------------------------------------------------------- 2
/*
1.
���(employees) ���̺���
����� �����ȣ, ����̸�, �Ի翬����  => SELECT��, employees ��ü��ȸ / ����� Ŀ�� -- 1)

���� ���ؿ� �°� ���� test01, test02�� �Է��Ͻÿ�. => INSERT INTO test01, test02;

�Ի�⵵�� 2005��(����) ���� �Ի��� ����� test01 ���̺� �Է�
�Ի�⵵�� 2005�� ���� �Ի��� ����� test02 ���̺� �Է�
=> ���ǹ� IF ~ ELSE��
*/
DECLARE
    -- ����� Ŀ�� ����
    -- 1-1) Ŀ�� ����
     CURSOR emp_cursor IS
        SELECT employee_id, last_name, hire_date
        FROM employees;
     
BEGIN
    --Ŀ�� ����
    FOR emp_info IN emp_cursor LOOP
        -- emp_info ( employee_id, last_name, hire_date ) => emp_info.hire_date
        --DBMS_OUTPUT.PUT(emp_cursor%ROWCOUNT || ' : ' );
        IF TO_CHAR(emp_info.hire_date,'yyyy') <= '2005' THEN -- TO_CHAR : Ư�� ���� �������� ��.
            INSERT INTO test01 (empid, ename, hiredate)
            VALUES (emp_info.employee_id, emp_info.last_name, emp_info.hire_date);          
        ELSE            
            INSERT INTO test02 
            VALUES emp_info;
        END IF;
    END LOOP; -- Ŀ�� ����
END;
/

SELECT *
FROM TEST02;

DELETE TEST01;


--------------------------------------------------------------------------------3
/*
2.
�μ���ȣ�� �Է��� ���(&ġȯ���� ���)
�ش��ϴ� �μ��� ����̸�, �Ի�����, �μ����� ����Ͻÿ�.

�Է� : �μ���ȣ / ��� : ����̸�, �Ի�����, �μ���
SELECT ����̸�, �Ի�����, �μ���
FROM employees
     JOIN departments(�μ���ȣ, �μ���)
     ON (employees.�μ���ȣ = departments.�μ���ȣ)
WHERE employees.�μ���ȣ => ������ ��� / ����� Ŀ��

����̸�, �Ի�����, �μ����� ���
*/
DECLARE
    CURSOR emp_cursor IS
        SELECT e.employee_id, e.hire_date, d.department_name
        FROM employees e
            JOIN departments d
            ON (e.department_id = d.department_id)
        WHERE e.department_id = &�μ���ȣ;
               
BEGIN
    FOR emp_info IN emp_cursor LOOP
    DBMS_OUTPUT.PUT(emp_info.employee_id);
    DBMS_OUTPUT.PUT(', ' || emp_info.hire_date);
    DBMS_OUTPUT.PUT_Line(emp_info.department_name);
    END LOOP;

END;
/

--------------------------------------------------------------------------------4
/*
3.
�μ���ȣ�� �Է�(&���)�� ��� 
����̸�, �޿�, ����->(�޿�*12+(�޿�*nvl(Ŀ�̼��ۼ�Ʈ,0)*12))
�� ����ϴ�  PL/SQL�� �ۼ��Ͻÿ�.
�Է� : �μ�����ȣ / ��� : ����̸� , �޿�, ���� => SELECT��
SELECT ����̸�, �޿�, Ŀ�̼��ۼ�Ʈ
FROM employees
WHERE �μ���ȣ => ������ ��� : ����� Ŀ��

���� ��� (�޿�*12+(�޿�*nvl(Ŀ�̼��ۼ�Ʈ,0)*12))

����̸�, �޿�, ������ ���
*/
DECLARE
    CURSOR emp_cursor IS
    SELECT last_name, salary, commission_pct
    FROM employees
    WHERE department_id = &�μ���ȣ;
    v_annual NUMBER(15,2); -- ����
BEGIN
    FOR emp_info IN emp_cursor LOOP
    -- emp_info( last_name, salary, commission_pct)
    v_annual := (emp_info.salary*12+(emp_info.salary*nvl(emp_info.commission_pct,0)*12));
    DBMS_OUTPUT.PUT(emp_info.last_name);
    DBMS_OUTPUT.PUT(', ' || emp_info.salary);
    DBMS_OUTPUT.PUT_LINE(', ' || v_annual); 
    
    END LOOP;
END;
/

--------------------------------------------------------------------------------5
BEGIN
    --����
EXCEPTION
    -- ����ó��
    WHEN �����̸�1 THEN
        ���ܰ� �߻����� �� ������ �ڵ�;
    WHEN �����̸�2 OR �����̸�3 THEN
        ���ܰ� �߻������� ������ �ڵ�;
    WHEN OTHERS THEN
    ���� ������� ���� ���ܰ� �߻��� ��� ������ �ڵ�;
END;
/
--------------------------------------------------------------------------------
-- 1) �������� : �̹� ����Ŭ�� ���ǵǾ� �հ� �̸��� �����ϴ� ����
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    SELECT last_name
    INTO v_ename
    FROM employees
    WHERE department_id = &�μ���ȣ;
-- �μ���ȣ 10 : �������
-- �μ���ȣ 50 : 1422����(TOO_MANY_ROWS)
-- �μ���ȣ 0 : 1403���� (NO_DATA_FOUND)

    DBMS_OUTPUT.PUT_LINE(v_ename);
EXCEPTION
--    WHEN TOO_MANY_ROWS THEN
--    DBMS_OUTPUT.PUT_LINE('�ش� �μ����� �������� ����� �����մϴ�.');
    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('�ش� �μ����� ����� �������� �ʽ��ϴ�.');
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('��Ÿ ���ܰ� �߻��߽��ϴ�.');
    DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
    DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM ); -- �α�, OTHERS�� �̿��ؼ� ����ϱ� ���ؼ� , INSERT���� ������, ������ ������� ó���ؾ���. ���������� �浹��
END;
/

-- 2) �������� : �̹� ����Ŭ�� ���ǵǾ� ������ �̸��� ���� ����
DECLARE
    -- 2-1) �����̸� ����
    e_emps_remaining EXCEPTION;
    -- 2-2) �����̸��� �����ڵ� ����
    PRAGMA EXCEPTION_INIT(e_emps_remaining,-02292); -- ���ܸ� �ʱ�ȭ
BEGIN
    DELETE FROM departments
    WHERE department_id = &�μ���ȣ;
EXCEPTION
    WHEN e_emps_remaining THEN
    DBMS_OUTPUT.PUT_LINE('���� �����Ͱ� �ֽ��ϴ�.');
END;
/

-- 3) �������� : ����� ���ǿ��� => ����Ŭ ���忡�� ���� �ڵ�--PRAGMA�� ������.
DECLARE
    --3-1) �����̸� ����
    e_dept_del_fail EXCEPTION;
BEGIN
    DELETE FROM departments
    WHERE department_id = &0;
    -- 3-2) ���ܰ� �Ǵ� ��Ȳ�� ����
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_dept_del_fail; -- ���� �߻�
    END IF;
     DBMS_OUTPUT.PUT_LINE('���������� �����Ǿ����ϴ�.');
EXCEPTION
    WHEN e_dept_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �������� �ʽ��ϴ�.');
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ�� Ȯ�����ּ���.');
END;
/

-- ����� ���� ���ܻ��� VS ���ǹ�
-- �ش� ��쿡 ���̻� �ڵ尡 �����̵Ǹ� �ȵɶ� ����ó��

DECLARE
    --3-1) �����̸� ����
    e_dept_del_fail EXCEPTION;
BEGIN
    DELETE FROM departments
    WHERE department_id = &0;
    -- 3-2) ���ܰ� �Ǵ� ��Ȳ�� ����
    IF SQL%ROWCOUNT = 0 THEN
        RAISE e_dept_del_fail; -- ���� �߻�
     END IF;
EXCEPTION
    WHEN e_dept_del_fail THEN
        DBMS_OUTPUT.PUT_LINE('�ش� �μ��� �������� �ʽ��ϴ�.');
        DBMS_OUTPUT.PUT_LINE('�μ���ȣ�� Ȯ�����ּ���.'); 
        DBMS_OUTPUT.PUT_LINE('���������� �����Ǿ����ϴ�.');
END;
/

--PROCEDURE : ������ ����� �����ϴ� PL/SQL�� ��ü �� �ϳ�
CREATE PROCEDURE test_pro_01
(p_msg IN VARCHAR2)
IS
--DECLARE
     -- ����� : ����, Ŀ��, ����
     v_msg VARCHAR2(1000) := 'Hello';
BEGIN
    DBMS_OUTPUT.PUT_LINE(v_msg || p_msg);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('�����Ͱ� �������� �ʽ��ϴ�.');
END;
/

--����
DECLARE
    v_result VARCHAR2(1000);
BEGIN 
    -- v_result := test_pro_01('PL/SQL');
    -- ����Ŭ�� ���ν����� �Լ��� ȣ���ϴ� ������� ����
    -- => ���ν����� ȣ���� �� ���ʿ� ������ �����ϸ� �ȵ�.
    test_pro_01('PL/SQL');
END;
/

--IN ��� : ȣ��ȯ�� -> ���ν���
DROP PROCEDURE raise_salary;
CREATE PROCEDURE raise_salary
(p_eid  IN employees.employee_id%TYPE)
IS
    --�����
BEGIN
    --�����
    -- IN ��� : ����� �ν�
    
    -- p_eid := NVL(p_eid, 100);
    
    UPDATE employees
    SET salary = salary * 1.1
    WHERE employee_id = p_eid;
END;
/
-- ���� ������ �� ���� �����ε� �ǵ������� ���� �����ҷ��� �ϴϱ� ���� ����(PLS-00363: expression 'P_EID' cannot be used as an assignment target)\

DECLARE
    v_first NUMBER(3,0) := 100;
    v_second CONSTANT NUMBER(3,0) := 149;

BEGIN
    raise_salary(100); -- ���ͷ�
    raise_salary((v_first+10)); -- ǥ����(����)
    raise_salary(v_first); -- ���� ���� ����
    raise_salary(v_second); -- ���
END;
/

SELECT employee_id , salary
FROM employees
WHERE employee_id IN (100, 110, 149);

--OUT��� : ���ν��� -> ȣ��ȯ��
CREATE PROCEDURE test_p_out
(p_num IN NUMBER, P_OUT OUT NUMBER)
IS

BEGIN
    --OUT ���
    -- 1) �Ű������� ���޵Ǵ� ���� �־ ������ NULL�� ���� ����
    -- 2) OUT����� �Ű������� ���� ���� ���� ȣ��ȯ������ ��ȯ
      DBMS_OUTPUT.PUT_LINE('IN : ' ||p_num );
      DBMS_OUTPUT.PUT_LINE('OUT : ' ||P_OUT );
END;
/

DECLARE
    v_result NUMBER(4,0) := 1234;
BEGIN
    
    DBMS_OUTPUT.PUT_LINE('1) result : ' ||v_result );
    test_p_out(1000, v_result);
    DBMS_OUTPUT.PUT_LINE('2) result : ' ||v_result );
END;
/

--���ϱ�
drop PROCEDURE plus;
CREATE PROCEDURE plus
(p_x IN NUMBER,
p_y IN NUMBER,
p_result OUT NUMBER)
IS

BEGIN
    p_result := (p_x + p_y);
    --return (x + y);
END;
/

DECLARE
    v_total NUMBER(10,0);
BEGIN
    plus(10, 25, v_total);
    DBMS_OUTPUT.PUT_LINE(v_total);
 END;
/
--IN OUT ��� : ȣ��ȯ�� <-> ���ν���
-- '01012341234' => '010-1234-1234'

DROP PROCEDURE format_phone;
CREATE PROCEDURE format_phone
(p_phone_no IN OUT VARCHAR2)
IS
BEGIN
    -- 1) OUT ���� �޸� ȣ��ȯ�濡�� ���޹��� ���� ���� �� ����.
        DBMS_OUTPUT.PUT_LINE('before : ' ||p_phone_no);
    -- 2) in ���� �޸� ���� ������ �� ����.
        p_phone_no := SUBSTR(p_phone_no,1,3) -- '010'
            || '_' || SUBSTR(p_phone_no, 4, 4) -- '1234'
            || '_' || SUBSTR(p_phone_no, 8); -- '1234'
    -- 3) OUT ���ó�� ���� ���� ȣ��ȯ������ ��ȯ
        DBMS_OUTPUT.PUT_LINE('after : ' || p_phone_no);
END;
/

DECLARE
    v_no VARCHAR2(100) := '01012341234';
BEGIN
    format_phone(v_no);
    DBMS_OUTPUT.PUT_LINE(v_no);
END;
/

--------------------------------------------------------------------------------
/*
1.
�ֹε�Ϲ�ȣ�� �Է��ϸ� 
������ ���� ��µǵ��� yedam_ju ���ν����� �ۼ��Ͻÿ�.
EXECUTE yedam_ju('9501011667777');
950101-1******
EXECUTE yedam_ju('1511013689977');
151101-3******

���ν���, �Ű�����(�ϳ�, ���ͷ�) IN ���
=> ���ο��� DBMS_OUTPUT.PUT_LINE
'9501011667777' -> 950101-1******
*/
CREATE PROCEDURE yedam_ju
(p_ssn IN VARCHAR2)
IS
    v_result VARCHAR2(20); -- IN ���� ���
BEGIN
            v_result := SUBSTR(p_ssn,1,6) 
            || '_' || SUBSTR(p_ssn, 7, 1) 
            || '******'; 
            -- v_result := SUBSTR(p_ssn,1,6) 
            --|| '_' || RPAD(SUBSTR(p_ssn, 7, 1), 7, '*'); 
        DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
BEGIN
    yedam_ju('9501011667777');  
END;
/
EXECUTE yedam_ju('9501011667777');
SELECT last_name, RPAD(last_name, 10, '-'), LPAD(last_name, 10, '-') -- ( ���� ���� �÷�, ���̼� , ��ü)
FROM employees;

--------------------------------------------------------------------------------

/*
2.
�����ȣ�� �Է��� ���
�����ϴ� TEST_PRO ���ν����� �����Ͻÿ�.
��, �ش����� ���� ��� "�ش����� �����ϴ�." ���
��) EXECUTE TEST_PRO(176)
*/
DECLARE
    v_ename employees.last_name%TYPE;
BEGIN
    DELETE FROM departments
    WHERE department_id = &�����ȣ;

    DBMS_OUTPUT.PUT_LINE(v_ename);
EXCEPTION

    WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('�ش����� �������� �ʽ��ϴ�.');
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('EXECUTE : ' || TO_CHAR(SQLCODE));
  
END;
/

