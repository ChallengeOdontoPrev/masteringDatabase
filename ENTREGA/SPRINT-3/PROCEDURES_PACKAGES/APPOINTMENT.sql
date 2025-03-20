SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE appointment_pkg AS
    FUNCTION valida_data(p_date IN DATE) RETURN BOOLEAN;

    PROCEDURE INSERT_APPOINTMENT(
        p_date_appointment IN DATE,
        p_time_appointment IN VARCHAR2,
        p_user_id IN NUMBER,
        p_clinic_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_procedure_type_id IN NUMBER,
        p_procedure_validation_id IN NUMBER
    );

    PROCEDURE INSERT_APPOINTMENT_WITH_VALIDATION(
        p_date_appointment IN DATE,
        p_time_appointment IN VARCHAR2,
        p_user_id IN NUMBER,
        p_clinic_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_procedure_type_id IN NUMBER,
        p_img_url_initial IN VARCHAR2,
        p_img_url_final IN VARCHAR2,
        p_procedure_status_id IN NUMBER
    );

    PROCEDURE READ_APPOINTMENT(p_id IN NUMBER);

    PROCEDURE UPDATE_APPOINTMENT(
        p_id IN NUMBER,
        p_date_appointment IN DATE,
        p_time_appointment IN VARCHAR2,
        p_user_id IN NUMBER,
        p_clinic_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_procedure_type_id IN NUMBER,
        p_procedure_validation_id IN NUMBER
    );

    PROCEDURE DELETE_APPOINTMENT(p_id IN NUMBER);
END appointment_pkg;

CREATE OR REPLACE PACKAGE BODY appointment_pkg AS
    FUNCTION valida_data(p_date IN DATE) RETURN BOOLEAN IS
    BEGIN
        IF p_date IS NULL OR p_date < SYSDATE THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END valida_data;

    PROCEDURE INSERT_APPOINTMENT(
        p_date_appointment IN DATE,
        p_time_appointment IN VARCHAR2,
        p_user_id IN NUMBER,
        p_clinic_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_procedure_type_id IN NUMBER,
        p_procedure_validation_id IN NUMBER
    ) IS
        v_exists_user NUMBER;
        v_exists_clinic NUMBER;
        v_exists_patient NUMBER;
        v_exists_type NUMBER;
        v_exists_validation NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_exists_user FROM tb_user WHERE ID = p_user_id;
        SELECT COUNT(*) INTO v_exists_clinic FROM tb_clinic WHERE ID = p_clinic_id;
        SELECT COUNT(*) INTO v_exists_patient FROM tb_patient WHERE ID = p_patient_id;
        SELECT COUNT(*) INTO v_exists_type FROM tb_procedure_type WHERE ID = p_procedure_type_id;
        SELECT COUNT(*) INTO v_exists_validation FROM tb_procedure_validation WHERE ID = p_procedure_validation_id;

        IF NOT valida_data(p_date_appointment) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: Data do agendamento deve ser maior que a atual. A inserção não foi realizada.');
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
    END INSERT_APPOINTMENT;

    PROCEDURE INSERT_APPOINTMENT_WITH_VALIDATION(
        p_date_appointment IN DATE,
        p_time_appointment IN VARCHAR2,
        p_user_id IN NUMBER,
        p_clinic_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_procedure_type_id IN NUMBER,
        p_img_url_initial IN VARCHAR2,
        p_img_url_final IN VARCHAR2,
        p_procedure_status_id IN NUMBER
    ) IS
        v_procedure_validation_id NUMBER;
    BEGIN
        INSERT_PROCEDURE_VALIDATION(
            p_img_url_initial => p_img_url_initial,
            p_img_url_final => p_img_url_final,
            p_procedure_type_id => p_procedure_type_id,
            p_procedure_status_id => p_procedure_status_id,
            p_procedure_validation_id => v_procedure_validation_id 
        );

        INSERT_APPOINTMENT(
            p_date_appointment => p_date_appointment,
            p_time_appointment => p_time_appointment,
            p_user_id => p_user_id,
            p_clinic_id => p_clinic_id,
            p_patient_id => p_patient_id,
            p_procedure_type_id => p_procedure_type_id,
            p_procedure_validation_id => v_procedure_validation_id
        );

        DBMS_OUTPUT.PUT_LINE('Agendamento com validação inserido com sucesso.');
    END INSERT_APPOINTMENT_WITH_VALIDATION;

    PROCEDURE READ_APPOINTMENT(p_id IN NUMBER) IS
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
    END READ_APPOINTMENT;

    PROCEDURE UPDATE_APPOINTMENT(
        p_id IN NUMBER,
        p_date_appointment IN DATE,
        p_time_appointment IN VARCHAR2,
        p_user_id IN NUMBER,
        p_clinic_id IN NUMBER,
        p_patient_id IN NUMBER,
        p_procedure_type_id IN NUMBER,
        p_procedure_validation_id IN NUMBER
    ) IS
        v_exists_user NUMBER;
        v_exists_clinic NUMBER;
        v_exists_patient NUMBER;
        v_exists_type NUMBER;
        v_exists_validation NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_exists_user FROM tb_user WHERE ID = p_user_id;
        SELECT COUNT(*) INTO v_exists_clinic FROM tb_clinic WHERE ID = p_clinic_id;
        SELECT COUNT(*) INTO v_exists_patient FROM tb_patient WHERE ID = p_patient_id;
        SELECT COUNT(*) INTO v_exists_type FROM tb_procedure_type WHERE ID = p_procedure_type_id;
        SELECT COUNT(*) INTO v_exists_validation FROM tb_procedure_validation WHERE ID = p_procedure_validation_id;

        IF NOT valida_data(p_date_appointment) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: Data do agendamento inválida. A atualização não foi realizada.');
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
    END UPDATE_APPOINTMENT;

    PROCEDURE DELETE_APPOINTMENT(p_id IN NUMBER) IS
    BEGIN
        DELETE FROM tb_appointment WHERE ID = p_id;

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
    END DELETE_APPOINTMENT;
END appointment_pkg;



