SET SERVEROUTPUT ON;

// esse bloco lista todos os usu�rios e suas cl�nicas associadas, garantindo
// que todas as cl�nicas sejam exibidas, mesmo que n�o tenham usu�rios
// vinculados, substituindo valores nulos por mensagens padr�o.
DECLARE
    CURSOR c_users IS
        SELECT 
            u.id AS user_id,
            u.name AS user_name,
            c.name AS clinic_name
        FROM 
            tb_user u
        RIGHT JOIN 
            tb_clinic c ON u.clinic_id = c.id;

    v_user_id       NUMBER;
    v_user_name     VARCHAR2(255);
    v_clinic_name   VARCHAR2(255);

BEGIN
    FOR rec IN c_users LOOP
        v_user_id := rec.user_id;
        v_user_name := rec.user_name;
        v_clinic_name := NVL(rec.clinic_name, 'No Clinic');

    DBMS_OUTPUT.PUT_LINE('User ID: ' || NVL(TO_CHAR(v_user_id), 'Without ID') ||  -- Converte para texto, se nulo exibe 'No ID'
                             ', User Name: ' || NVL(v_user_name, 'Without Name') ||  -- Mensagem padr�o para nome
                             ', Clinic: ' || NVL(v_clinic_name, 'Without Clinic'));  -- Mensagem padr�o para cl�nica
    END LOOP;
END;



       


