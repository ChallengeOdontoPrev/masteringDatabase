SET SERVEROUTPUT ON;

// Recupera informa��es sobre usu�rios e suas respectivas cl�nicas, utilizando
// um LEFT JOIN para incluir todos os usu�rios, mesmo aqueles sem uma cl�nica
// associada. O resultado mostra o ID do usu�rio, nome e o nome da
// cl�nica (ou "No Clinic" se n�o houver).

DECLARE
    CURSOR c_users IS
        SELECT 
            u.id AS user_id,
            u.name AS user_name,
            c.name AS clinic_name
        FROM 
            tb_user u
        LEFT JOIN 
            tb_clinic c ON u.clinic_id = c.id;

    v_user_id       NUMBER;
    v_user_name     VARCHAR2(255);
    v_clinic_name   VARCHAR2(255);

BEGIN
    FOR rec IN c_users LOOP
        v_user_id := rec.user_id;
        v_user_name := rec.user_name;
        v_clinic_name := NVL(rec.clinic_name, 'No Clinic');

        DBMS_OUTPUT.PUT_LINE('User ID: ' || v_user_id || 
                             ', User Name: ' || v_user_name || 
                             ', Clinic: ' || v_clinic_name);
    END LOOP;
END;

