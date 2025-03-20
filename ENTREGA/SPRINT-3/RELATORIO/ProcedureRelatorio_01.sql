SET SERVEROUTPUT ON;

CREATE OR REPLACE TYPE obj_clinic_address_report AS OBJECT (
    clinic_id          NUMBER,
    clinic_name        VARCHAR2(255),
    cnpj               VARCHAR2(255),
    email              VARCHAR2(255),
    phone              VARCHAR2(255),
    street             VARCHAR2(255),
    num                VARCHAR2(255),
    city               VARCHAR2(255),
    state              VARCHAR2(255),
    zip_code           VARCHAR2(255),
    clinic_count_city  NUMBER
);

CREATE OR REPLACE TYPE tbl_clinic_address_report AS TABLE OF obj_clinic_address_report;

CREATE OR REPLACE PROCEDURE proc_clinic_address_report (
    p_result OUT SYS_REFCURSOR
)
IS
    v_result tbl_clinic_address_report := tbl_clinic_address_report();
BEGIN
    FOR rec IN (
        SELECT 
            c.id AS clinic_id,
            c.name AS clinic_name,
            c.cnpj,
            c.email,
            c.phone,
            a.street,
            a.num,
            a.city,
            a.state,
            a.zip_code,
            COUNT(c.id) OVER (PARTITION BY a.city) AS clinic_count_city
        FROM 
            tb_clinic c
        JOIN 
            tb_address a ON c.address_id = a.id
        ORDER BY c.name DESC
    ) LOOP
        v_result.EXTEND;
        v_result(v_result.COUNT) := obj_clinic_address_report(
            rec.clinic_id,
            rec.clinic_name,
            rec.cnpj,
            rec.email,
            rec.phone,
            rec.street,
            rec.num,
            rec.city,
            rec.state,
            rec.zip_code,
            rec.clinic_count_city
        );
    END LOOP;

    OPEN p_result FOR
        SELECT * FROM TABLE(v_result);
END proc_clinic_address_report;

--------------------------------------------------------
-- CHAMAR A PROCEDURE

DECLARE
    v_cursor SYS_REFCURSOR; 
    v_clinic_id NUMBER;
    v_clinic_name VARCHAR2(255);
    v_cnpj VARCHAR2(255);
    v_email VARCHAR2(255);
    v_phone VARCHAR2(255);
    v_street VARCHAR2(255);
    v_num VARCHAR2(255);
    v_city VARCHAR2(255);
    v_state VARCHAR2(255);
    v_zip_code VARCHAR2(255);
    v_clinic_count_city NUMBER;
BEGIN

    proc_clinic_address_report(v_cursor);

    LOOP
        FETCH v_cursor INTO 
            v_clinic_id,
            v_clinic_name,
            v_cnpj,
            v_email,
            v_phone,
            v_street,
            v_num,
            v_city,
            v_state,
            v_zip_code,
            v_clinic_count_city;

        EXIT WHEN v_cursor%NOTFOUND; 

        DBMS_OUTPUT.PUT_LINE(
            'Clinic ID: ' || v_clinic_id || ', ' ||
            'Name: ' || v_clinic_name || ', ' ||
            'City: ' || v_city || ', ' ||
            'Count: ' || v_clinic_count_city
        );
    END LOOP;

    CLOSE v_cursor;
END;
