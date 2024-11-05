CREATE OR REPLACE TYPE obj_appointment_report AS OBJECT (
    clinic_name          VARCHAR2(255),
    patient_name         VARCHAR2(255),
    procedure_type       VARCHAR2(255),
    procedure_status     VARCHAR2(255),
    total_appointments   NUMBER
);

CREATE OR REPLACE TYPE tbl_appointment_report
AS TABLE OF obj_appointment_report;

CREATE OR REPLACE FUNCTION func_appointment_report 
RETURN tbl_appointment_report 
IS
    result tbl_appointment_report := tbl_appointment_report();
BEGIN
    FOR rec IN (
        SELECT 
            c.name AS clinic_name,
            p.name AS patient_name,
            pt.name AS procedure_type,
            ps.name AS procedure_status,
            COUNT(a.id) AS total_appointments
        FROM 
            tb_appointment a
        INNER JOIN 
            tb_clinic c ON a.clinic_id = c.id
        INNER JOIN 
            tb_patient p ON a.patient_id = p.id
        INNER JOIN 
            tb_procedure_type pt ON a.procedure_type_id = pt.id
        INNER JOIN 
            tb_procedure_validation pv ON a.procedure_validation_id = pv.id
        INNER JOIN 
            tb_procedure_status ps ON pv.procedure_status_id = ps.id
        GROUP BY 
            c.name, p.name, pt.name, ps.name
        ORDER BY 
            c.name
    ) LOOP
        result.EXTEND;
        result(result.COUNT) := obj_appointment_report(
            rec.clinic_name,
            rec.patient_name,
            rec.procedure_type,
            rec.procedure_status,
            rec.total_appointments
        );
    END LOOP;

    RETURN result;
END func_appointment_report;

SELECT * FROM TABLE(func_appointment_report());
SELECT * FROM  tb_appointment;
SELECT * FROM  tb_procedure_validation;

