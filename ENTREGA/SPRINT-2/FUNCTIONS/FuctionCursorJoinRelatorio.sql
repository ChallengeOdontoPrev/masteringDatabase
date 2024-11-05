CREATE OR REPLACE TYPE obj_clinic_address_report AS OBJECT (
    clinic_id   NUMBER,
    clinic_name VARCHAR2(255),
    cnpj        VARCHAR2(255),
    email       VARCHAR2(255),
    phone       VARCHAR2(255),
    street      VARCHAR2(255),
    num         VARCHAR2(255),
    city        VARCHAR2(255),
    state       VARCHAR2(255),
    zip_code    VARCHAR2(255)
);

CREATE OR REPLACE TYPE tbl_clinic_address_report 
AS TABLE OF obj_clinic_address_report;

CREATE OR REPLACE FUNCTION func_clinic_address_report 
RETURN tbl_clinic_address_report 
IS
    result tbl_clinic_address_report := tbl_clinic_address_report();
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
            a.zip_code
        FROM 
            tb_clinic c
        JOIN 
            tb_address a ON c.address_id = a.id
    ) LOOP
        result.EXTEND;
        result(result.COUNT) := obj_clinic_address_report(
            rec.clinic_id,
            rec.clinic_name,
            rec.cnpj,
            rec.email,
            rec.phone,
            rec.street,
            rec.num,
            rec.city,
            rec.state,
            rec.zip_code
        );
    END LOOP;

    RETURN result;
END func_clinic_address_report;

SELECT * FROM TABLE(func_clinic_address_report());
SELECT * FROM tb_clinic;

