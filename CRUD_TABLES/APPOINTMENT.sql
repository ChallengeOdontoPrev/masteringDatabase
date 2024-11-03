SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION valida_data (
    p_date IN DATE
) RETURN BOOLEAN
IS
BEGIN
    IF p_date IS NULL OR p_date < SYSDATE THEN
        RETURN FALSE;
    ELSE
        RETURN TRUE;
    END IF;
END valida_data;

CREATE OR REPLACE PROCEDURE INSERT_APPOINTMENT(
    p_date_appointment IN DATE,
    p_time_appointment IN VARCHAR2,
    p_user_id IN NUMBER,
    p_clinic_id IN NUMBER,
    p_patient_id IN NUMBER,
    p_procedure_type_id IN NUMBER,
    p_procedure_validation_id IN NUMBER
)
IS
    v_exists_user NUMBER;
    v_exists_clinic NUMBER;
    v_exists_patient NUMBER;
    v_exists_type NUMBER;
    v_exists_validation NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_exists_user
    FROM tb_user
    WHERE ID = p_user_id;

    SELECT COUNT(*)
    INTO v_exists_clinic
    FROM tb_clinic
    WHERE ID = p_clinic_id;

    SELECT COUNT(*)
    INTO v_exists_patient
    FROM tb_patient
    WHERE ID = p_patient_id;

    SELECT COUNT(*)
    INTO v_exists_type
    FROM tb_procedure_type
    WHERE ID = p_procedure_type_id;

    SELECT COUNT(*)
    INTO v_exists_validation
    FROM tb_procedure_validation
    WHERE ID = p_procedure_validation_id;

    IF NOT valida_data(p_date_appointment) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: Data do agendamento inválida. A inserção não foi realizada.');
    ELSIF v_exists_user = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: Usuário com ID ' || p_user_id || ' não existe.');
    ELSIF v_exists_clinic = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Erro: Clínica com ID ' || p_clinic_id || ' não existe.');
    ELSIF v_exists_patient = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Erro: Paciente com ID ' || p_patient_id || ' não existe.');
    ELSIF v_exists_type = 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Erro: Tipo de procedimento com ID ' || p_procedure_type_id || ' não existe.');
    ELSIF v_exists_validation = 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'Erro: Validação de procedimento com ID ' || p_procedure_validation_id || ' não existe.');
    ELSE
        INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, USER_ID, CLINIC_ID, PATIENT_ID, PROCEDURE_TYPE_ID, PROCEDURE_VALIDATION_ID)
        VALUES (p_date_appointment, p_time_appointment, SYSDATE, p_user_id, p_clinic_id, p_patient_id, p_procedure_type_id, p_procedure_validation_id);
        DBMS_OUTPUT.PUT_LINE('Agendamento inserido com sucesso.');
    END IF;
END;

CREATE OR REPLACE PROCEDURE READ_APPOINTMENT(
    p_id IN NUMBER
)
IS
    v_date_appointment tb_appointment.DATE_APPOINTMENT%TYPE;
    v_time_appointment tb_appointment.TIME_APPOINTMENT%TYPE;
    v_user_id tb_appointment.USER_ID%TYPE;
    v_clinic_id tb_appointment.CLINIC_ID%TYPE;
    v_patient_id tb_appointment.PATIENT_ID%TYPE;
    v_procedure_type_id tb_appointment.PROCEDURE_TYPE_ID%TYPE;
    v_procedure_validation_id tb_appointment.PROCEDURE_VALIDATION_ID%TYPE;
BEGIN
    SELECT DATE_APPOINTMENT, TIME_APPOINTMENT, USER_ID, CLINIC_ID, PATIENT_ID, PROCEDURE_TYPE_ID, PROCEDURE_VALIDATION_ID
    INTO v_date_appointment, v_time_appointment, v_user_id, v_clinic_id, v_patient_id, v_procedure_type_id, v_procedure_validation_id
    FROM tb_appointment
    WHERE ID = p_id;

    DBMS_OUTPUT.PUT_LINE('Data do Agendamento: ' || v_date_appointment);
    DBMS_OUTPUT.PUT_LINE('Hora do Agendamento: ' || v_time_appointment);
    DBMS_OUTPUT.PUT_LINE('Usuário ID: ' || v_user_id);
    DBMS_OUTPUT.PUT_LINE('Clínica ID: ' || v_clinic_id);
    DBMS_OUTPUT.PUT_LINE('Paciente ID: ' || v_patient_id);
    DBMS_OUTPUT.PUT_LINE('Tipo de Procedimento ID: ' || v_procedure_type_id);
    DBMS_OUTPUT.PUT_LINE('Validação de Procedimento ID: ' || v_procedure_validation_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum agendamento encontrado para o ID informado.');
END;

CREATE OR REPLACE PROCEDURE UPDATE_APPOINTMENT(
    p_id IN NUMBER,
    p_date_appointment IN DATE,
    p_time_appointment IN VARCHAR2,
    p_user_id IN NUMBER,
    p_clinic_id IN NUMBER,
    p_patient_id IN NUMBER,
    p_procedure_type_id IN NUMBER,
    p_procedure_validation_id IN NUMBER
)
IS
    v_exists_user NUMBER;
    v_exists_clinic NUMBER;
    v_exists_patient NUMBER;
    v_exists_type NUMBER;
    v_exists_validation NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_exists_user
    FROM tb_user
    WHERE ID = p_user_id;

    SELECT COUNT(*)
    INTO v_exists_clinic
    FROM tb_clinic
    WHERE ID = p_clinic_id;

    SELECT COUNT(*)
    INTO v_exists_patient
    FROM tb_patient
    WHERE ID = p_patient_id;
    
    SELECT COUNT(*)
    INTO v_exists_type
    FROM tb_procedure_type
    WHERE ID = p_procedure_type_id;

    SELECT COUNT(*)
    INTO v_exists_validation
    FROM tb_procedure_validation
    WHERE ID = p_procedure_validation_id;

    IF NOT valida_data(p_date_appointment) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: Data do agendamento inválida. A atualização não foi realizada.');
    ELSIF NOT valida_hora(p_time_appointment) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Hora do agendamento no formato inválido. A atualização não foi realizada.');
    ELSIF v_exists_user = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: Usuário com ID ' || p_user_id || ' não existe.');
    ELSIF v_exists_clinic = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Erro: Clínica com ID ' || p_clinic_id || ' não existe.');
    ELSIF v_exists_patient = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Erro: Paciente com ID ' || p_patient_id || ' não existe.');
    ELSIF v_exists_type = 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Erro: Tipo de procedimento com ID ' || p_procedure_type_id || ' não existe.');
    ELSIF v_exists_validation = 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'Erro: Validação de procedimento com ID ' || p_procedure_validation_id || ' não existe.');
    ELSE
        UPDATE tb_appointment
        SET DATE_APPOINTMENT = p_date_appointment,
            TIME_APPOINTMENT = p_time_appointment,
            USER_ID = p_user_id,
            CLINIC_ID = p_clinic_id,
            PATIENT_ID = p_patient_id,
            PROCEDURE_TYPE_ID = p_procedure_type_id,
            PROCEDURE_VALIDATION_ID = p_procedure_validation_id
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20008, 'Erro: Nenhum agendamento encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Agendamento atualizado com sucesso.');
        END IF;
    END IF;
END;

CREATE OR REPLACE PROCEDURE DELETE_APPOINTMENT(
    p_id IN NUMBER
)
IS
BEGIN
    DELETE FROM tb_appointment
    WHERE ID = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20009, 'Erro: Nenhum agendamento encontrado para o ID informado.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Agendamento excluído com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2292 THEN
            RAISE_APPLICATION_ERROR(-20010, 'Erro: Não é possível deletar o agendamento, pois ele está referenciado em outra tabela.');
        ELSE
            RAISE;
        END IF;
END;


select * from tb_appointment;
EXEC INSERT_APPOINTMENT(TO_DATE('2024-11-01', 'YYYY-MM-DD'), '14:30', 1, 1, 1, 1, 1);

EXEC READ_APPOINTMENT(1);

EXEC UPDATE_APPOINTMENT(1, TO_DATE('2024-11-02', 'YYYY-MM-DD'), '14:30', 1, 1, 1, 1, 1);

EXEC DELETE_APPOINTMENT(1);




