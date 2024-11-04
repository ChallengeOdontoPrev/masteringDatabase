SET SERVEROUTPUT ON;

// esse bloco lista todos os usuários e suas clínicas associadas, garantindo
// que todas as clínicas sejam exibidas, mesmo que não tenham usuários
// vinculados, substituindo valores nulos por mensagens padrão.
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
                             ', User Name: ' || NVL(v_user_name, 'Without Name') ||  -- Mensagem padrão para nome
                             ', Clinic: ' || NVL(v_clinic_name, 'Without Clinic'));  -- Mensagem padrão para clínica
    END LOOP;
END;



       


