SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE user_pkg AS
    FUNCTION valida_data_nascimento(p_birth_date IN DATE) RETURN BOOLEAN;
    FUNCTION valida_rg(p_rg IN VARCHAR2) RETURN BOOLEAN;

    PROCEDURE INSERT_USER(
        p_cro IN VARCHAR2,
        p_email IN VARCHAR2,
        p_name IN VARCHAR2,
        p_password IN VARCHAR2,
        p_role IN VARCHAR2,
        p_birth_date IN DATE,
        p_rg IN VARCHAR2,
        p_clinic_id IN NUMBER
    );

    PROCEDURE READ_USER(p_id IN NUMBER);

    PROCEDURE UPDATE_USER(
        p_id IN NUMBER,
        p_cro IN VARCHAR2,
        p_email IN VARCHAR2,
        p_name IN VARCHAR2,
        p_password IN VARCHAR2,
        p_role IN VARCHAR2,
        p_birth_date IN DATE,
        p_rg IN VARCHAR2
    );

    PROCEDURE DELETE_USER(p_id IN NUMBER);
END user_pkg;

CREATE OR REPLACE PACKAGE BODY user_pkg AS
    FUNCTION valida_data_nascimento(p_birth_date IN DATE) RETURN BOOLEAN IS
    BEGIN
        IF p_birth_date < SYSDATE THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END valida_data_nascimento;

    FUNCTION valida_rg(p_rg IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        IF REGEXP_LIKE(p_rg, '^[0-9]{1,10}[-]?[0-9]{1}?$') THEN
            RETURN TRUE;
        ELSE
            RETURN FALSE;
        END IF;
    END valida_rg;

    PROCEDURE INSERT_USER(
        p_cro IN VARCHAR2,
        p_email IN VARCHAR2,
        p_name IN VARCHAR2,
        p_password IN VARCHAR2,
        p_role IN VARCHAR2,
        p_birth_date IN DATE,
        p_rg IN VARCHAR2,
        p_clinic_id IN NUMBER
    ) IS
    BEGIN
        IF NOT valida_email(p_email) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: E-mail no formato inválido. A inserção não foi realizada.');
        ELSIF NOT valida_data_nascimento(p_birth_date) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro: Data de nascimento deve ser menor que a data atual. A inserção não foi realizada.');
        ELSIF NOT valida_rg(p_rg) THEN
            RAISE_APPLICATION_ERROR(-20003, 'Erro: RG no formato inválido. A inserção não foi realizada.');
        ELSE
            INSERT INTO tb_user(CRO, EMAIL, NAME, PASSWORD, ROLE, BIRTH_DATE, RG, CLINIC_ID, CREATED_AT)
            VALUES (p_cro, p_email, p_name, p_password, p_role, p_birth_date, p_rg, p_clinic_id, SYSDATE);
            DBMS_OUTPUT.PUT_LINE('Usuário inserido com sucesso.');
        END IF;
    END INSERT_USER;

    PROCEDURE READ_USER(p_id IN NUMBER) IS
        v_cro tb_user.CRO%TYPE;
        v_email tb_user.EMAIL%TYPE;
        v_name tb_user.NAME%TYPE;
        v_role tb_user.ROLE%TYPE;
        v_birth_date tb_user.BIRTH_DATE%TYPE;
        v_rg tb_user.RG%TYPE;
        v_clinic_id tb_user.CLINIC_ID%TYPE;
        v_created_at tb_user.CREATED_AT%TYPE;
    BEGIN
        SELECT CRO, EMAIL, NAME, ROLE, BIRTH_DATE, RG, CLINIC_ID, CREATED_AT
        INTO v_cro, v_email, v_name, v_role, v_birth_date, v_rg, v_clinic_id, v_created_at
        FROM tb_user
        WHERE ID = p_id;

        DBMS_OUTPUT.PUT_LINE('CRO: ' || v_cro);
        DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Role: ' || v_role);
        DBMS_OUTPUT.PUT_LINE('Data de Nascimento: ' || TO_CHAR(v_birth_date, 'DD/MM/YYYY'));
        DBMS_OUTPUT.PUT_LINE('RG: ' || v_rg);
        DBMS_OUTPUT.PUT_LINE('Clinic ID: ' || v_clinic_id);
        DBMS_OUTPUT.PUT_LINE('Data de Criação: ' || TO_CHAR(v_created_at, 'DD/MM/YYYY HH24:MI:SS'));
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Nenhum usuário encontrado para o ID informado.');
    END READ_USER;

    PROCEDURE UPDATE_USER(
        p_id IN NUMBER,
        p_cro IN VARCHAR2,
        p_email IN VARCHAR2,
        p_name IN VARCHAR2,
        p_password IN VARCHAR2,
        p_role IN VARCHAR2,
        p_birth_date IN DATE,
        p_rg IN VARCHAR2
    ) IS
    BEGIN
        IF NOT valida_email(p_email) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: E-mail no formato inválido. A atualização não foi realizada.');
        ELSIF NOT valida_data_nascimento(p_birth_date) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro: Data de nascimento inválida. A atualização não foi realizada.');
        ELSIF NOT valida_rg(p_rg) THEN
            RAISE_APPLICATION_ERROR(-20003, 'Erro: RG no formato inválido. A atualização não foi realizada.');
        ELSE
            UPDATE tb_user
            SET CRO = p_cro,
                EMAIL = p_email,
                NAME = p_name,
                PASSWORD = p_password,
                ROLE = p_role,
                BIRTH_DATE = p_birth_date,
                RG = p_rg
            WHERE ID = p_id;

            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum usuário encontrado para o ID informado.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Usuário atualizado com sucesso.');
            END IF;
        END IF;
    END UPDATE_USER;

    PROCEDURE DELETE_USER(p_id IN NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM tb_appointment
        WHERE USER_ID = p_id;

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20012, 'Erro: Não é possível deletar o usuário, pois ele está referenciado em outra tabela.');
            RETURN;
        END IF;

        DELETE FROM tb_user
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum usuário encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Usuário excluído com sucesso.');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN
                RAISE_APPLICATION_ERROR(-20013, 'Erro: Não é possível deletar o usuário, pois ele está referenciado em outra tabela.');
            ELSE
                RAISE;
            END IF;
    END DELETE_USER;
END user_pkg;





