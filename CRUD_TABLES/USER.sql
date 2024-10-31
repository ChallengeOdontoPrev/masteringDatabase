SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION valida_data_nascimento (
    p_birth_date IN DATE
) RETURN BOOLEAN
IS
BEGIN
    IF p_birth_date < SYSDATE THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END valida_data_nascimento;

CREATE OR REPLACE FUNCTION valida_rg (
    p_rg IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF REGEXP_LIKE(p_rg, '^[0-9]{1,10}[-]?[0-9]{1}?$') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END valida_rg;

CREATE OR REPLACE PROCEDURE INSERT_USER(
    p_cro IN VARCHAR2,
    p_email IN VARCHAR2,
    p_name IN VARCHAR2,
    p_password IN VARCHAR2,
    p_role IN VARCHAR2,
    p_birth_date IN DATE,
    p_rg IN VARCHAR2,
    p_clinic_id IN NUMBER
)
IS
BEGIN
    IF NOT valida_email(p_email) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: E-mail no formato inv�lido. A inser��o n�o foi realizada.');
    ELSIF NOT valida_data_nascimento(p_birth_date) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Data de nascimento inv�lida. A inser��o n�o foi realizada.');
    ELSIF NOT valida_rg(p_rg) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: RG no formato inv�lido. A inser��o n�o foi realizada.');
    ELSE
        INSERT INTO tb_user(CRO, EMAIL, NAME, PASSWORD, ROLE, BIRTH_DATE, RG, CLINIC_ID, CREATED_AT)
        VALUES (p_cro, p_email, p_name, p_password, p_role, p_birth_date, p_rg, p_clinic_id, SYSDATE);
        DBMS_OUTPUT.PUT_LINE('Usu�rio inserido com sucesso.');
    END IF;
END;

CREATE OR REPLACE PROCEDURE READ_USER(
    p_id IN NUMBER
)
IS
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
    DBMS_OUTPUT.PUT_LINE('Data de Cria��o: ' || TO_CHAR(v_created_at, 'DD/MM/YYYY HH24:MI:SS'));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum usu�rio encontrado para o ID informado.');
END;


CREATE OR REPLACE PROCEDURE UPDATE_USER(
    p_id IN NUMBER,
    p_cro IN VARCHAR2,
    p_email IN VARCHAR2,
    p_name IN VARCHAR2,
    p_password IN VARCHAR2,
    p_role IN VARCHAR2,
    p_birth_date IN DATE,
    p_rg IN VARCHAR2
)
IS
BEGIN
    -- Valida��o dos campos
    IF NOT valida_email(p_email) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: E-mail no formato inv�lido. A atualiza��o n�o foi realizada.');
    ELSIF NOT valida_data_nascimento(p_birth_date) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Data de nascimento inv�lida. A atualiza��o n�o foi realizada.');
    ELSIF NOT valida_rg(p_rg) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: RG no formato inv�lido. A atualiza��o n�o foi realizada.');
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
            RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum usu�rio encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Usu�rio atualizado com sucesso.');
        END IF;
    END IF;
END;

CREATE OR REPLACE PROCEDURE DELETE_USER(
    p_id IN NUMBER
)
IS
BEGIN
    DELETE FROM tb_user
    WHERE ID = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum usu�rio encontrado para o ID informado.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Usu�rio exclu�do com sucesso.');
    END IF;
END;


EXEC INSERT_USER('12345', 'user@example.com', 'User Test', 'pass123', 'DENTISTA', TO_DATE('1990-01-01', 'YYYY-MM-DD'), '12345678', 1);
select * from tb_user;

EXEC READ_USER(5);

EXEC UPDATE_USER(5, '54321', 'new_user@example.com', 'User Updated', 'newpass', 'user', TO_DATE('1992-02-02', 'YYYY-MM-DD'), '87654321');

EXEC DELETE_USER(4);




