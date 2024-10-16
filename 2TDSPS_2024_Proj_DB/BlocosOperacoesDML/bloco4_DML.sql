select * from tb_patient;

SET SERVEROUTPUT ON;

DECLARE
    v_num_card NUMBER := 2345678; 
    v_new_name VARCHAR2(255) := 'João Pereira';
    v_new_rg VARCHAR2(255) := '347891236';
BEGIN
    UPDATE tb_patient
    SET name = v_new_name,
        rg = v_new_rg
    WHERE num_card = v_num_card;

    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Paciente atualizado com sucesso.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum paciente encontrado com o número do cartão: ' || v_num_card);
    END IF;
END;

COMMIT;
