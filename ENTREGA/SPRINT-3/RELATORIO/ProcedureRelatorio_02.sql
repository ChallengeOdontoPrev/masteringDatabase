SET SERVEROUTPUT ON;

CREATE OR REPLACE TYPE obj_appointment_report AS OBJECT (
    clinic_name          VARCHAR2(255),
    patient_name         VARCHAR2(255),
    procedure_type       VARCHAR2(255),
    procedure_status     VARCHAR2(255),
    total_appointments   NUMBER
);

DROP TYPE tbl_appointment_report

CREATE OR REPLACE TYPE tbl_appointment_report AS TABLE OF obj_appointment_report;

CREATE OR REPLACE PROCEDURE proc_appointment_report (
    p_result OUT SYS_REFCURSOR 
)
IS
    v_result tbl_appointment_report := tbl_appointment_report();
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
        v_result.EXTEND;
        v_result(v_result.COUNT) := obj_appointment_report(
            rec.clinic_name,
            rec.patient_name,
            rec.procedure_type,
            rec.procedure_status,
            rec.total_appointments
        );
    END LOOP;

    OPEN p_result FOR
        SELECT * FROM TABLE(v_result);
END proc_appointment_report;

-------------------------------------------------------------------------------
-- CHAMAR PROCEDURE

DECLARE
    v_cursor SYS_REFCURSOR;
    v_clinic_name VARCHAR2(255);
    v_patient_name VARCHAR2(255);
    v_procedure_type VARCHAR2(255);
    v_procedure_status VARCHAR2(255);
    v_total_appointments NUMBER;
BEGIN
    proc_appointment_report(v_cursor);

    LOOP
        FETCH v_cursor INTO 
            v_clinic_name,
            v_patient_name,
            v_procedure_type,
            v_procedure_status,
            v_total_appointments;

        EXIT WHEN v_cursor%NOTFOUND; 

        DBMS_OUTPUT.PUT_LINE(
            'Clinic Name: ' || v_clinic_name || ', ' ||
            'Patient Name: ' || v_patient_name || ', ' ||
            'Procedure Type: ' || v_procedure_type || ', ' ||
            'Procedure Status: ' || v_procedure_status || ', ' ||
            'Total Appointments: ' || v_total_appointments
        );
    END LOOP;

    CLOSE v_cursor;
END;