SET SERVEROUTPUT ON;

select * from tb_procedure_type;

DECLARE
    v_procedure_type_id NUMBER := 62;
BEGIN
    DELETE FROM tb_procedure_type
    WHERE id = v_procedure_type_id;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Tipo de procedimento excluído com sucesso.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum tipo de procedimento encontrado com o ID: ' || v_procedure_type_id);
    END IF;
END;

COMMIT;