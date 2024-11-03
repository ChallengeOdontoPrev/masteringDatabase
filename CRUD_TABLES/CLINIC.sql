SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION valida_cnpj (
    p_cnpj IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF REGEXP_LIKE(p_cnpj, '^[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}/?[0-9]{4}-?[0-9]{2}$') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END valida_cnpj;

CREATE OR REPLACE FUNCTION valida_email (
    p_email IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF REGEXP_LIKE(p_email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END valida_email;

CREATE OR REPLACE FUNCTION valida_telefone (
    p_telefone IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF REGEXP_LIKE(p_telefone, '^\(?[0-9]{2}\)? ?[0-9]{4,5}-?[0-9]{4}$') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END valida_telefone;

CREATE OR REPLACE PROCEDURE INSERT_CLINIC(
    CNPJ IN VARCHAR2, 
    EMAIL IN VARCHAR2,
    NAME IN VARCHAR2,
    PHONE IN VARCHAR2,
    ADDRESS_ID IN NUMBER
)
IS
    v_address_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_address_count 
    FROM tb_address 
    WHERE ID = ADDRESS_ID;

    IF v_address_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Erro: ADDRESS_ID não encontrado. A inserção não foi realizada.');
    ELSIF NOT valida_cnpj(CNPJ) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: CNPJ no formato inválido. A inserção não foi realizada.');
    ELSIF NOT valida_email(EMAIL) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: E-mail no formato inválido. A inserção não foi realizada.');
    ELSIF NOT valida_telefone(PHONE) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: Telefone no formato inválido. A inserção não foi realizada.');
    ELSE
        INSERT INTO tb_clinic(CNPJ, EMAIL, NAME, PHONE, ADDRESS_ID) 
        VALUES (CNPJ, EMAIL, NAME, PHONE, ADDRESS_ID);
        DBMS_OUTPUT.PUT_LINE('Clínica inserida com sucesso.');
    END IF;
END;

CREATE OR REPLACE PROCEDURE READ_CLINIC(
    p_id IN NUMBER
)
IS
    v_cnpj tb_clinic.CNPJ%TYPE;
    v_email tb_clinic.EMAIL%TYPE;
    v_name tb_clinic.NAME%TYPE;
    v_phone tb_clinic.PHONE%TYPE;
    v_address_id tb_clinic.ADDRESS_ID%TYPE;
BEGIN
    SELECT CNPJ, EMAIL, NAME, PHONE, ADDRESS_ID
    INTO v_cnpj, v_email, v_name, v_phone, v_address_id
    FROM tb_clinic
    WHERE ID = p_id;

    DBMS_OUTPUT.PUT_LINE('CNPJ: ' || v_cnpj);
    DBMS_OUTPUT.PUT_LINE('Email: ' || v_email);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Phone: ' || v_phone);
    DBMS_OUTPUT.PUT_LINE('Address ID: ' || v_address_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhuma clínica encontrada para o ID informado.');
END;

CREATE OR REPLACE PROCEDURE UPDATE_CLINIC(
    p_id IN NUMBER,
    p_cnpj IN VARCHAR2, 
    p_email IN VARCHAR2,
    p_name IN VARCHAR2,
    p_phone IN VARCHAR2
)
IS
BEGIN
    IF NOT valida_cnpj(p_cnpj) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: CNPJ no formato inválido. A atualização não foi realizada.');
    ELSIF NOT valida_email(p_email) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: E-mail no formato inválido. A atualização não foi realizada.');
    ELSIF NOT valida_telefone(p_phone) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: Telefone no formato inválido. A atualização não foi realizada.');
    ELSE
        UPDATE tb_clinic
        SET CNPJ = p_cnpj,
            EMAIL = p_email,
            NAME = p_name,
            PHONE = p_phone
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhuma clínica encontrada para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Clínica atualizada com sucesso.');
        END IF;
    END IF;
END;


CREATE OR REPLACE PROCEDURE DELETE_CLINIC(
    p_id IN NUMBER
)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM tb_appointment
    WHERE CLINIC_ID = p_id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Erro: Não é possível deletar a clínica, pois ela está referenciada em agendamentos.');
        RETURN;
    END IF;

    DELETE FROM tb_clinic
    WHERE ID = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Erro: Nenhuma clínica encontrada para o ID informado.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Clínica excluída com sucesso.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20006, 'Erro: Nenhuma clínica encontrada para o ID informado.');
    WHEN OTHERS THEN
        IF SQLCODE = -2292 THEN
            RAISE_APPLICATION_ERROR(-20012, 'Erro: Não é possível deletar a clínica, pois ela está referenciada em outra tabela.');
        ELSE
            RAISE;
        END IF;
END;


EXEC INSERT_CLINIC('12.345.678/0001-99', 'clinica@example.com', 'Clinica Saúde', '(11) 98765-4321', 1);
EXEC READ_CLINIC(1);
EXEC UPDATE_CLINIC(1, '12.345.678/0001-98', 'nova@example.com', 'Nova Clínica', '(11) 91234-5678');
EXEC DELETE_CLINIC(1);
