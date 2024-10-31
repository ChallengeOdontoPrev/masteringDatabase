SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE INSERT_PROCEDURE_TYPE(
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
        INSERT INTO tb_procedure_type(NAME, DESCRIPTION)
        VALUES (p_name, p_description);
        DBMS_OUTPUT.PUT_LINE('Tipo de procedimento inserido com sucesso.');
    END IF;
END;

CREATE OR REPLACE PROCEDURE READ_PROCEDURE_TYPE(
    p_id IN NUMBER
)
IS
    v_name tb_procedure_type.NAME%TYPE;
    v_description tb_procedure_type.DESCRIPTION%TYPE;
BEGIN
    SELECT NAME, DESCRIPTION
    INTO v_name, v_description
    FROM tb_procedure_type
    WHERE ID = p_id;

    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_name);
    DBMS_OUTPUT.PUT_LINE('Descrição: ' || v_description);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum tipo de procedimento encontrado para o ID informado.');
END;

CREATE OR REPLACE PROCEDURE UPDATE_PROCEDURE_TYPE(
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
        UPDATE tb_procedure_type
        SET NAME = p_name,
            DESCRIPTION = p_description
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Erro: Nenhum tipo de procedimento encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tipo de procedimento atualizado com sucesso.');
        END IF;
    END IF;
END;

CREATE OR REPLACE PROCEDURE DELETE_PROCEDURE_TYPE(
    p_id IN NUMBER
)
IS
BEGIN
    DELETE FROM tb_procedure_type
    WHERE ID = p_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum tipo de procedimento encontrado para o ID informado.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Tipo de procedimento excluído com sucesso.');
    END IF;
END;


EXEC INSERT_PROCEDURE_TYPE('Consulta', 'Tipo de procedimento de consulta.');
select * from tb_procedure_type;

EXEC READ_PROCEDURE_TYPE(21);

EXEC UPDATE_PROCEDURE_TYPE(21, 'Exame', 'Tipo de procedimento de exame.');

EXEC DELETE_PROCEDURE_TYPE(21);


