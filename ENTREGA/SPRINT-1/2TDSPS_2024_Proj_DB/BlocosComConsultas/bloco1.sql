SET SERVEROUTPUT ON;

// Consulta o total de agendamentos por paciente e clínica, agrupando 
// e ordenando os resultados pelo nome do paciente. O resultado exibe a 
// contagem total de agendamentos, nome do paciente e nome da clínica.

DECLARE
    CURSOR c_appointments IS
        SELECT 
            COUNT(a.id) AS total_appointments,
            p.name AS patient_name,
            c.name AS clinic_name
        FROM 
            tb_appointment a
        INNER JOIN 
            tb_patient p ON a.patient_id = p.id
        INNER JOIN 
            tb_clinic c ON a.clinic_id = c.id
        GROUP BY 
            p.name, c.name
        ORDER BY 
            p.name;  -- Ordena pela data do agendamento

BEGIN
    FOR rec IN c_appointments LOOP
        DBMS_OUTPUT.PUT_LINE('Total Appointments: ' || rec.total_appointments ||
                             ', Patient: ' || rec.patient_name || 
                             ', Clinic: ' || rec.clinic_name);
    END LOOP;
END;