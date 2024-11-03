SET SERVEROUTPUT ON;
 
CREATE OR REPLACE PROCEDURE INSERT_PATIENT(
    p_birth_date IN DATE,
    p_num_card IN VARCHAR2,
    p_name IN VARCHAR2,
    p_rg IN VARCHAR2
)
IS
BEGIN
    IF NOT valida_rg(p_rg) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: RG no formato inválido. A inserção não foi realizada.');
    ELSE
        INSERT INTO tb_patient(BIRTH_DATE, NUM_CARD, NAME, RG, CREATED_AT)
        VALUES (p_birth_date, p_num_card, p_name, p_rg, SYSDATE);
        DBMS_OUTPUT.PUT_LINE('Paciente inserido com sucesso.');
    END IF;
END;

CREATE OR REPLACE PROCEDURE READ_PATIENT(
    p_id IN NUMBER
)
IS
    v_birth_date tb_patient.BIRTH_DATE%TYPE;
    v_num_card tb_patient.NUM_CARD%TYPE;
    v_name tb_patient.NAME%TYPE;
    v_rg tb_patient.RG%TYPE;
BEGIN
    SELECT BIRTH_DATE, NUM_CARD, NAME, RG
    INTO v_birth_date, v_num_card, v_name, v_rg
    FROM tb_patient
    WHERE ID = p_id;

    DBMS_OUTPUT.PUT_LINE('Data de Nascimento: ' || v_birth_date);
    DBMS_OUTPUT.PUT_LINE('Número do Cartão: ' || v_num_card);
    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('RG: ' || v_rg);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum paciente encontrado para o ID informado.');
END;

CREATE OR REPLACE PROCEDURE UPDATE_PATIENT(
    p_id IN NUMBER,
    p_birth_date IN DATE,
    p_num_card IN VARCHAR2,
    p_name IN VARCHAR2,
    p_rg IN VARCHAR2
)
IS
BEGIN
    -- Validação do RG
    IF NOT valida_rg(p_rg) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: RG no formato inválido. A atualização não foi realizada.');
    ELSE
        UPDATE tb_patient
        SET BIRTH_DATE = p_birth_date,
            NUM_CARD = p_num_card,
            NAME = p_name,
            RG = p_rg
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro: Nenhum paciente encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Paciente atualizado com sucesso.');
        END IF;
    END IF;
END;

CREATE OR REPLACE PROCEDURE DELETE_PATIENT(
    p_id IN NUMBER
)
IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM tb_appointment
    WHERE PATIENT_ID = p_id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20012, 'Erro: Não é possível deletar o paciente, pois ele está referenciado em outra tabela.');
        RETURN;
    END IF;

    DELETE FROM tb_patient
    WHERE ID = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Erro: Nenhum paciente encontrado para o ID informado.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Paciente excluído com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2292 THEN
            RAISE_APPLICATION_ERROR(-20013, 'Erro: Não é possível deletar o paciente, pois ele está referenciado em outra tabela.');
        ELSE
            RAISE;
        END IF;
END;

select * from tb_patient;
EXEC INSERT_PATIENT(TO_DATE('1990-05-15', 'YYYY-MM-DD'), '1234567890', 'Paciente Teste', '12345678');

EXEC READ_PATIENT(1);

EXEC UPDATE_PATIENT(1, TO_DATE('1992-07-20', 'YYYY-MM-DD'), '0987654321', 'Paciente Atualizado', '87654321');

EXEC DELETE_PATIENT(21);



