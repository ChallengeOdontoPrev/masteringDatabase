SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION valida_nome (
    p_name IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF p_name IS NULL OR TRIM(p_name) = '' THEN
        RETURN FALSE;
    ELSIF LENGTH(p_name) > 50 THEN
        RETURN FALSE; -- Supondo que o nome não pode ter mais de 50 caracteres
    ELSE
        RETURN TRUE;
    END IF;
END valida_nome;

CREATE OR REPLACE FUNCTION valida_descricao (
    p_description IN VARCHAR2
) RETURN BOOLEAN
IS
BEGIN
    IF p_description IS NULL OR TRIM(p_description) = '' THEN
        RETURN FALSE;
    ELSIF LENGTH(p_description) > 255 THEN
        RETURN FALSE; -- Supondo que a descrição não pode ter mais de 255 caracteres
    ELSE
        RETURN TRUE;
    END IF;
END valida_descricao;

CREATE OR REPLACE PROCEDURE INSERT_PROCEDURE_STATUS(
    p_name IN VARCHAR2,
    p_description IN VARCHAR2
)
IS
BEGIN
    IF NOT valida_nome(p_name) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: Nome no formato inválido. A inserção não foi realizada.');
    ELSIF NOT valida_descricao(p_description) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Descrição no formato inválido. A inserção não foi realizada.');
    ELSE
        INSERT INTO tb_procedure_status(NAME, DESCRIPTION)
        VALUES (p_name, p_description);
        DBMS_OUTPUT.PUT_LINE('Status de procedimento inserido com sucesso.');
    END IF;
END;

CREATE OR REPLACE PROCEDURE READ_PROCEDURE_STATUS(
    p_id IN NUMBER
)
IS
    v_name tb_procedure_status.NAME%TYPE;
    v_description tb_procedure_status.DESCRIPTION%TYPE;
BEGIN
    SELECT NAME, DESCRIPTION
    INTO v_name, v_description
    FROM tb_procedure_status
    WHERE ID = p_id;

    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Descrição: ' || v_description);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum status de procedimento encontrado para o ID informado.');
END;

CREATE OR REPLACE PROCEDURE UPDATE_PROCEDURE_STATUS(
    p_id IN NUMBER,
    p_name IN VARCHAR2,
    p_description IN VARCHAR2
)
IS
BEGIN
    IF NOT valida_nome(p_name) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Erro: Nome no formato inválido. A atualização não foi realizada.');
    ELSIF NOT valida_descricao(p_description) THEN
        RAISE_APPLICATION_ERROR(-20002, 'Erro: Descrição no formato inválido. A atualização não foi realizada.');
    ELSE
        UPDATE tb_procedure_status
        SET NAME = p_name,
            DESCRIPTION = p_description
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Erro: Nenhum status de procedimento encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Status de procedimento atualizado com sucesso.');
        END IF;
    END IF;
END;

CREATE OR REPLACE PROCEDURE DELETE_PROCEDURE_STATUS(
    p_id IN NUMBER
)
IS
BEGIN
    DELETE FROM tb_procedure_status
    WHERE ID = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum status de procedimento encontrado para o ID informado.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Status de procedimento excluído com sucesso.');
    END IF;
END;

select * from tb_procedure_status;
EXEC INSERT_PROCEDURE_STATUS('Teste', 'Status de procedimento teste.');

EXEC READ_PROCEDURE_STATUS(21);

EXEC UPDATE_PROCEDURE_STATUS(21, 'Em Teste', 'Status de procedimento em Teste.');

EXEC DELETE_PROCEDURE_STATUS(21);



