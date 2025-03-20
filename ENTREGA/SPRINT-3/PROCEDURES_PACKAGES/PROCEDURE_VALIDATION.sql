SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE procedure_validation_pkg AS
    FUNCTION valida_img_url(p_img_url IN VARCHAR2) RETURN BOOLEAN;
    FUNCTION valida_id(p_id IN NUMBER) RETURN BOOLEAN;

    PROCEDURE INSERT_PROCEDURE_VALIDATION(
        p_img_url_initial IN VARCHAR2,
        p_img_url_final IN VARCHAR2,
        p_procedure_type_id IN NUMBER,
        p_procedure_status_id IN NUMBER,
        p_procedure_validation_id OUT NUMBER
    );

    PROCEDURE READ_PROCEDURE_VALIDATION(p_id IN NUMBER);

    PROCEDURE UPDATE_PROCEDURE_VALIDATION(
        p_id IN NUMBER,
        p_img_url_initial IN VARCHAR2,
        p_img_url_final IN VARCHAR2,
        p_procedure_type_id IN NUMBER,
        p_procedure_status_id IN NUMBER
    );

    PROCEDURE DELETE_PROCEDURE_VALIDATION(p_id IN NUMBER);
END procedure_validation_pkg;

CREATE OR REPLACE PACKAGE BODY procedure_validation_pkg AS
    FUNCTION valida_img_url(p_img_url IN VARCHAR2) RETURN BOOLEAN IS
    BEGIN
        IF p_img_url IS NULL OR TRIM(p_img_url) = '' THEN
            RETURN FALSE;
        ELSIF NOT REGEXP_LIKE(p_img_url, '^https?://.+') THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END valida_img_url;

    FUNCTION valida_id(p_id IN NUMBER) RETURN BOOLEAN IS
    BEGIN
        IF p_id IS NULL OR p_id <= 0 THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END valida_id;

    PROCEDURE INSERT_PROCEDURE_VALIDATION(
        p_img_url_initial IN VARCHAR2,
        p_img_url_final IN VARCHAR2,
        p_procedure_type_id IN NUMBER,
        p_procedure_status_id IN NUMBER,
        p_procedure_validation_id OUT NUMBER
    ) IS
        v_exists_type NUMBER;
        v_exists_status NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_exists_type FROM tb_procedure_type WHERE ID = p_procedure_type_id;
        SELECT COUNT(*) INTO v_exists_status FROM tb_procedure_status WHERE ID = p_procedure_status_id;

        IF NOT valida_img_url(p_img_url_initial) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: URL da imagem inicial no formato inválido. A inserção não foi realizada.');
        ELSIF NOT valida_img_url(p_img_url_final) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro: URL da imagem final no formato inválido. A inserção não foi realizada.');
        ELSIF NOT valida_id(p_procedure_type_id) THEN
            RAISE_APPLICATION_ERROR(-20003, 'Erro: Tipo de procedimento inválido. A inserção não foi realizada.');
        ELSIF v_exists_type = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Erro: O tipo de procedimento com ID ' || p_procedure_type_id || ' não existe.');
        ELSIF NOT valida_id(p_procedure_status_id) THEN
            RAISE_APPLICATION_ERROR(-20005, 'Erro: Status de procedimento inválido. A inserção não foi realizada.');
        ELSIF v_exists_status = 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Erro: O status de procedimento com ID ' || p_procedure_status_id || ' não existe.');
        ELSE
            INSERT INTO tb_procedure_validation(IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_TYPE_ID, PROCEDURE_STATUS_ID)
            VALUES (p_img_url_initial, p_img_url_final, p_procedure_type_id, p_procedure_status_id)
            RETURNING ID INTO p_procedure_validation_id;
            DBMS_OUTPUT.PUT_LINE('Validação de procedimento inserida com sucesso.');
        END IF;
    END INSERT_PROCEDURE_VALIDATION;

    PROCEDURE READ_PROCEDURE_VALIDATION(p_id IN NUMBER) IS
        v_img_url_initial tb_procedure_validation.IMG_URL_INITIAL%TYPE;
        v_img_url_final tb_procedure_validation.IMG_URL_FINAL%TYPE;
        v_procedure_type_id tb_procedure_validation.PROCEDURE_TYPE_ID%TYPE;
        v_procedure_status_id tb_procedure_validation.PROCEDURE_STATUS_ID%TYPE;
    BEGIN
        SELECT IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_TYPE_ID, PROCEDURE_STATUS_ID
        INTO v_img_url_initial, v_img_url_final, v_procedure_type_id, v_procedure_status_id
        FROM tb_procedure_validation
        WHERE ID = p_id;

        DBMS_OUTPUT.PUT_LINE('Imagem Inicial: ' || v_img_url_initial);
        DBMS_OUTPUT.PUT_LINE('Imagem Final: ' || v_img_url_final);
        DBMS_OUTPUT.PUT_LINE('Tipo de Procedimento ID: ' || v_procedure_type_id);
        DBMS_OUTPUT.PUT_LINE('Status de Procedimento ID: ' || v_procedure_status_id);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Erro: Nenhuma validação de procedimento encontrada para o ID informado.');
    END READ_PROCEDURE_VALIDATION;

    PROCEDURE UPDATE_PROCEDURE_VALIDATION(
        p_id IN NUMBER,
        p_img_url_initial IN VARCHAR2,
        p_img_url_final IN VARCHAR2,
        p_procedure_type_id IN NUMBER,
        p_procedure_status_id IN NUMBER
    ) IS
        v_exists_type NUMBER;
        v_exists_status NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_exists_type FROM tb_procedure_type WHERE ID = p_procedure_type_id;
        SELECT COUNT(*) INTO v_exists_status FROM tb_procedure_status WHERE ID = p_procedure_status_id;

        IF NOT valida_img_url(p_img_url_initial) THEN
            RAISE_APPLICATION_ERROR(-20001, 'Erro: URL da imagem inicial no formato inválido. A atualização não foi realizada.');
        ELSIF NOT valida_img_url(p_img_url_final) THEN
            RAISE_APPLICATION_ERROR(-20002, 'Erro: URL da imagem final no formato inválido. A atualização não foi realizada.');
        ELSIF v_exists_type = 0 THEN
            RAISE_APPLICATION_ERROR(-20003, 'Erro: O tipo de procedimento com ID ' || p_procedure_type_id || ' não existe.');
        ELSIF v_exists_status = 0 THEN
            RAISE_APPLICATION_ERROR(-20004, 'Erro: O status de procedimento com ID ' || p_procedure_status_id || ' não existe.');
        ELSE
            UPDATE tb_procedure_validation
            SET IMG_URL_INITIAL = p_img_url_initial,
                IMG_URL_FINAL = p_img_url_final,
                PROCEDURE_TYPE_ID = p_procedure_type_id,
                PROCEDURE_STATUS_ID = p_procedure_status_id
            WHERE ID = p_id;

            IF SQL%ROWCOUNT = 0 THEN
                RAISE_APPLICATION_ERROR(-20005, 'Erro: Nenhuma validação de procedimento encontrada para o ID informado.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Validação de procedimento atualizada com sucesso.');
            END IF;
        END IF;
    END UPDATE_PROCEDURE_VALIDATION;

    PROCEDURE DELETE_PROCEDURE_VALIDATION(p_id IN NUMBER) IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_count FROM tb_appointment WHERE PROCEDURE_VALIDATION_ID = p_id;

        IF v_count > 0 THEN
            RAISE_APPLICATION_ERROR(-20012, 'Erro: Não é possível deletar a validação de procedimento, pois ela está referenciada em agendamentos.');
            RETURN;
        END IF;

        DELETE FROM tb_procedure_validation WHERE ID = p_id;

        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20006, 'Erro: Nenhuma validação de procedimento encontrada para o ID informado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Validação de procedimento excluída com sucesso.');
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            IF SQLCODE = -2292 THEN
                RAISE_APPLICATION_ERROR(-20013, 'Erro: Não é possível deletar a validação de procedimento, pois ela está referenciada em outra tabela.');
            ELSE
                RAISE;
            END IF;
    END DELETE_PROCEDURE_VALIDATION;
END procedure_validation_pkg;






