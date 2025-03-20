DROP TABLE tb_user_audit

-- TABELA DE AUDITORIA
CREATE TABLE tb_user_audit (
    audit_id         NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    operation        VARCHAR2(10), 
    address_id       NUMBER,       
    changed_by       VARCHAR2(255),
    change_timestamp TIMESTAMP    
);

-- TRIGGER
CREATE OR REPLACE TRIGGER trg_tb_user_audit
AFTER INSERT OR UPDATE OR DELETE ON tb_user
FOR EACH ROW
DECLARE
    v_operation VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_operation := 'INSERT';
    ELSIF UPDATING THEN
        v_operation := 'UPDATE';
    ELSIF DELETING THEN
        v_operation := 'DELETE';
    END IF;

    INSERT INTO tb_user_audit (operation, address_id, changed_by, change_timestamp)
    VALUES (
        v_operation,
        NVL(:NEW.id, :OLD.id), 
        SYS_CONTEXT('USERENV', 'SESSION_USER'), 
        SYSTIMESTAMP 
    );
END;

--- TESTES ---

select * from tb_user;

--CRIA��O
BEGIN
    user_pkg.INSERT_USER(
        p_cro => '12345',
        p_email => 'user@example.com',
        p_name => 'User Test',
        p_password => 'pass123',
        p_role => 'DENTISTA',
        p_birth_date => TO_DATE('1990-01-01', 'YYYY-MM-DD'),
        p_rg => '12345678',
        p_clinic_id => 1
    );
END;

--EXCEPTION
BEGIN
    user_pkg.INSERT_USER(
        p_cro => '12345',
        p_email => 'user@example.com',
        p_name => 'User Test',
        p_password => 'pass123',
        p_role => 'DENTISTA',
        p_birth_date => TO_DATE('2026-01-01', 'YYYY-MM-DD'),
        p_rg => '12345678',
        p_clinic_id => 1
    );
END;

BEGIN
    user_pkg.DELETE_USER(p_id => 1);
END;

--UPDATE
BEGIN
    user_pkg.UPDATE_USER(
        p_id => 4,
        p_cro => '54321',
        p_email => 'new_user@example.com',
        p_name => 'User Updated',
        p_password => 'newpass',
        p_role => 'user',
        p_birth_date => TO_DATE('1992-02-02', 'YYYY-MM-DD'),
        p_rg => '87654321'
    );
END;


--DELETE
BEGIN
    user_pkg.DELETE_USER(p_id => 4);
END;

--VALIDA��O AUDIT
SELECT * FROM tb_user_audit ORDER BY change_timestamp DESC;
