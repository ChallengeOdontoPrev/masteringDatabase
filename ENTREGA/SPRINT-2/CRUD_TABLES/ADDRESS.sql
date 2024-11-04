SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION valida_cep (
    p_cep IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF REGEXP_LIKE(p_cep, '^[0-9]{5}-?[0-9]{3}$') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END valida_cep;

CREATE OR REPLACE FUNCTION valida_sigla_estado (
    p_sigla IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF REGEXP_LIKE(p_sigla, '^[A-Z]{2}$') THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END valida_sigla_estado;

CREATE OR REPLACE PROCEDURE INSERT_ADDRESS(
    STREET IN VARCHAR2, 
    NUM IN VARCHAR2,
    CITY IN VARCHAR2,
    STATE IN VARCHAR2,
    ZIP_CODE IN VARCHAR2
)
IS
BEGIN
    IF NOT valida_cep(ZIP_CODE) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: CEP no formato inválido. A inserção não foi realizada.');
    ELSIF NOT valida_sigla_estado(STATE) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Estado no formato inválido. A inserção não foi realizada.');
    ELSE
        INSERT INTO tb_address(STREET, NUM, CITY, STATE, ZIP_CODE) 
        VALUES (STREET, NUM, CITY, STATE, ZIP_CODE);
        DBMS_OUTPUT.PUT_LINE('Endereço inserido com sucesso.');
    END IF;
END;

CREATE OR REPLACE PROCEDURE READ_ADDRESS(
    p_id IN NUMBER
)
IS
    v_street tb_address.STREET%TYPE;
    v_num tb_address.NUM%TYPE;
    v_city tb_address.CITY%TYPE;
    v_state tb_address.STATE%TYPE;
    v_zip_code tb_address.ZIP_CODE%TYPE;
BEGIN
    SELECT STREET, NUM, CITY, STATE, ZIP_CODE
    INTO v_street, v_num, v_city, v_state, v_zip_code
    FROM tb_address
    WHERE ID = p_id;

    DBMS_OUTPUT.PUT_LINE('Street: ' || v_street);
    DBMS_OUTPUT.PUT_LINE('Number: ' || v_num);
    DBMS_OUTPUT.PUT_LINE('City: ' || v_city);
    DBMS_OUTPUT.PUT_LINE('State: ' || v_state);
    DBMS_OUTPUT.PUT_LINE('ZIP Code: ' || v_zip_code);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum endereço encontrado para o ID informado.');
END;

CREATE OR REPLACE PROCEDURE UPDATE_ADDRESS(
    p_id IN NUMBER,
    p_street IN VARCHAR2, 
    p_num IN VARCHAR2,
    p_city IN VARCHAR2,
    p_state IN VARCHAR2,
    p_zip_code IN VARCHAR2
)
IS
BEGIN
    IF NOT valida_cep(p_zip_code) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: CEP no formato inválido. A atualização não foi realizada.');
    ELSIF NOT valida_sigla_estado(p_state) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Estado no formato inválido. A atualização não foi realizada.');
    ELSE
        UPDATE tb_address
        SET STREET = p_street,
            NUM = p_num,
            CITY = p_city,
            STATE = p_state,
            ZIP_CODE = p_zip_code
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Erro: Nenhum endereço encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Endereço atualizado com sucesso.');
        END IF;
    END IF;
END;

CREATE OR REPLACE PROCEDURE DELETE_ADDRESS(
    p_id IN NUMBER
)
IS
BEGIN
    DELETE FROM tb_address
    WHERE ID = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum endereço encontrado para o ID informado.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Endereço excluído com sucesso.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE = -2292 THEN
            RAISE_APPLICATION_ERROR(-20005, 'Erro: Não é possível deletar o endereço, pois ele está referenciado em outra tabela.');
        ELSE
            RAISE;
        END IF;
END;

select * from tb_address;
EXEC INSERT_ADDRESS('Rua Josué', '931', 'São Paulo', 'SP', '09878-726');
EXEC READ_ADDRESS(1);
EXEC UPDATE_ADDRESS(5, 'Rua João', '999', 'São Paulo', 'RJ', '09878-722');
EXEC DELETE_ADDRESS(1);
