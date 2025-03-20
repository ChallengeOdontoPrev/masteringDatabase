SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE procedure_type_pkg AS
    PROCEDURE INSERT_PROCEDURE_TYPE(
        p_name IN VARCHAR2,
        p_description IN VARCHAR2
    );

    PROCEDURE READ_PROCEDURE_TYPE(p_id IN NUMBER);

    PROCEDURE UPDATE_PROCEDURE_TYPE(
        p_id IN NUMBER,
        p_name IN VARCHAR2,
        p_description IN VARCHAR2
    );

    PROCEDURE DELETE_PROCEDURE_TYPE(p_id IN NUMBER);
END procedure_type_pkg;

CREATE OR REPLACE PACKAGE BODY procedure_type_pkg AS
    PROCEDURE INSERT_PROCEDURE_TYPE(
        p_name IN VARCHAR2,
        p_description IN VARCHAR2
    ) IS
    BEGIN
        IF NOT valida_nome(p_name) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: Nome no formato inv�lido. A inser��o n�o foi realizada.');
        ELSIF NOT valida_descricao(p_description) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro: Descri��o no formato inv�lido. A inser��o n�o foi realizada.');
        ELSE
            INSERT INTO tb_procedure_type(NAME, DESCRIPTION)
            VALUES (p_name, p_description);
            DBMS_OUTPUT.PUT_LINE('Tipo de procedimento inserido com sucesso.');
        END IF;
    END INSERT_PROCEDURE_TYPE;

    PROCEDURE READ_PROCEDURE_TYPE(p_id IN NUMBER) IS
        v_name tb_procedure_type.NAME%TYPE;
        v_description tb_procedure_type.DESCRIPTION%TYPE;
    BEGIN
        SELECT NAME, DESCRIPTION
        INTO v_name, v_description
        FROM tb_procedure_type
        WHERE ID = p_id;

        DBMS_OUTPUT.PUT_LINE('Nome: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Descri��o: ' || v_description);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Nenhum tipo de procedimento encontrado para o ID informado.');
    END READ_PROCEDURE_TYPE;

    PROCEDURE UPDATE_PROCEDURE_TYPE(
        p_id IN NUMBER,
        p_name IN VARCHAR2,
        p_description IN VARCHAR2
    ) IS
    BEGIN
        IF NOT valida_nome(p_name) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: Nome no formato inv�lido. A atualiza��o n�o foi realizada.');
        ELSIF NOT valida_descricao(p_description) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro: Descri��o no formato inv�lido. A atualiza��o n�o foi realizada.');
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
    END UPDATE_PROCEDURE_TYPE;

    PROCEDURE DELETE_PROCEDURE_TYPE(p_id IN NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM tb_procedure_validation
        WHERE PROCEDURE_TYPE_ID = p_id;

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20010, 'Erro: N�o � poss�vel deletar o tipo de procedimento, pois ele est� referenciado em valida��es de procedimento.');
            RETURN;
        END IF;

        DELETE FROM tb_procedure_type
        WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Erro: Nenhum tipo de procedimento encontrado para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Tipo de procedimento exclu�do com sucesso.');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN
                RAISE_APPLICATION_ERROR(-20011, 'Erro: N�o � poss�vel deletar o tipo de procedimento, pois ele est� referenciado em outra tabela.');
            ELSE
                RAISE;
            END IF;
    END DELETE_PROCEDURE_TYPE;
END procedure_type_pkg;




