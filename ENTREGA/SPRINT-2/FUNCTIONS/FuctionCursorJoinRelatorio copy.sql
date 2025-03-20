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
    zip_code    VARCHAR2(255),
    clinic_count_city NUMBER
);

DROP TYPE tbl_clinic_address_report

CREATE OR REPLACE TYPE tbl_clinic_address_report 
AS TABLE OF obj_clinic_address_report;

DROP FUNCTION func_clinic_address_report 

CREATE OR REPLACE FUNCTION func_clinic_address_report 
RETURN tbl_clinic_address_report 
IS
    CURSOR clinic_cursor IS
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
        ORDER BY c.name DESC;

    result tbl_clinic_address_report := tbl_clinic_address_report();
    rec clinic_cursor%ROWTYPE;  
BEGIN
    OPEN clinic_cursor;
    LOOP
        FETCH clinic_cursor INTO rec;  
        EXIT WHEN clinic_cursor%NOTFOUND;  

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
            rec.zip_code,
            rec.clinic_count_city
        );
    END LOOP;

    CLOSE clinic_cursor;  
    RETURN result;  
END func_clinic_address_report;


SELECT * FROM TABLE(func_clinic_address_report());
SELECT * FROM tb_clinic;

