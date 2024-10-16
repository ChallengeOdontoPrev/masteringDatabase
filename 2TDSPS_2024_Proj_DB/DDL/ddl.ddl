DROP TABLE tb_appointment CASCADE CONSTRAINTS;
DROP TABLE tb_clinic CASCADE CONSTRAINTS;
DROP TABLE tb_patient CASCADE CONSTRAINTS;
DROP TABLE tb_procedure_status CASCADE CONSTRAINTS;
DROP TABLE tb_procedure_type CASCADE CONSTRAINTS;
DROP TABLE tb_procedure_validation CASCADE CONSTRAINTS;
DROP TABLE tb_user CASCADE CONSTRAINTS;

-- SEQUENCE para tables
CREATE SEQUENCE seq_tb_appointment START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_clinic START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_patient START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_procedure_status START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_procedure_type START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_procedure_validation START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_tb_user START WITH 1 INCREMENT BY 1;

CREATE TABLE tb_appointment (
    id                         NUMBER(19) NOT NULL,
    date_appointment           DATE NOT NULL,
    time_appointment           TIMESTAMP NOT NULL,
    created_at                 TIMESTAMP NOT NULL,
    patient_id              NUMBER(19) NOT NULL,
    user_id                 NUMBER(19) NOT NULL,
    clinic_id               NUMBER(19) NOT NULL,
    procedure_validation_id NUMBER(19) NOT NULL,
    procedure_type_id       NUMBER NOT NULL
);

CREATE UNIQUE INDEX tb_appointment__idx ON
    tb_appointment (
        procedure_validation_id
    ASC );

ALTER TABLE tb_appointment ADD CONSTRAINT tb_appointment_pk PRIMARY KEY ( id );

CREATE TABLE tb_clinic (
    id      NUMBER(19) NOT NULL,
    address VARCHAR2(255 CHAR) NOT NULL,
    cnpj    VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    email   VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    name    VARCHAR2(255 CHAR) NOT NULL,
    phone   VARCHAR2(255 CHAR) NOT NULL
);

ALTER TABLE tb_clinic ADD CONSTRAINT tb_clinic_pk PRIMARY KEY ( id );

CREATE TABLE tb_patient (
    id         NUMBER(19) NOT NULL,
    birth_date DATE NOT NULL,
    created_at TIMESTAMP NOT NULL,
    num_card   NUMBER(19) NOT NULL UNIQUE,
    name       VARCHAR2(255 CHAR) NOT NULL,
    rg         VARCHAR2(255 CHAR) NOT NULL UNIQUE
);

ALTER TABLE tb_patient ADD CONSTRAINT tb_patient_pk PRIMARY KEY ( id );

CREATE TABLE tb_procedure_status (
    id          NUMBER NOT NULL,
    name        VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    description CLOB NOT NULL
);

ALTER TABLE tb_procedure_status ADD CONSTRAINT tb_procedure_status_pk PRIMARY KEY ( id );

CREATE TABLE tb_procedure_type (
    id          NUMBER NOT NULL,
    name        VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    description CLOB NOT NULL
);

ALTER TABLE tb_procedure_type ADD CONSTRAINT tb_procedure_type_pk PRIMARY KEY ( id );

CREATE TABLE tb_procedure_validation (
    id                     NUMBER(19) NOT NULL,
    img_url_initial        VARCHAR2(255 CHAR),
    img_url_final          VARCHAR2(255 CHAR),
    procedure_status_id NUMBER NOT NULL,
    procedure_type_id   NUMBER NOT NULL
);

ALTER TABLE tb_procedure_validation ADD CONSTRAINT tb_procedure_validation_pk PRIMARY KEY ( id );

CREATE TABLE tb_user (
    id           NUMBER(19) NOT NULL,
    created_at   DATE NOT NULL,
    cro          VARCHAR2(255 CHAR) UNIQUE,
    email        VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    name         VARCHAR2(255 CHAR) NOT NULL,
    password     VARCHAR2(255 CHAR) NOT NULL,
    role         VARCHAR2(255 CHAR) NOT NULL,
    clinic_id NUMBER(19) NOT NULL
);

ALTER TABLE tb_user ADD CONSTRAINT tb_user_pk PRIMARY KEY ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appoint_tb_proc_type_fk FOREIGN KEY ( procedure_type_id )
        REFERENCES tb_procedure_type ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appoint_tb_proc_valid_fk FOREIGN KEY ( procedure_validation_id )
        REFERENCES tb_procedure_validation ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appointment_tb_clinic_fk FOREIGN KEY ( clinic_id )
        REFERENCES tb_clinic ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appointment_tb_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES tb_patient ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appointment_tb_user_fk FOREIGN KEY ( user_id )
        REFERENCES tb_user ( id );

ALTER TABLE tb_procedure_validation
    ADD CONSTRAINT tb_proc_valid_tb_proc_sts_fk FOREIGN KEY ( procedure_status_id )
        REFERENCES tb_procedure_status ( id );

ALTER TABLE tb_procedure_validation
    ADD CONSTRAINT tb_proc_valid_tb_proc_type_fk FOREIGN KEY ( procedure_type_id )
        REFERENCES tb_procedure_type ( id );

ALTER TABLE tb_user
    ADD CONSTRAINT tb_user_tb_clinic_fk FOREIGN KEY ( clinic_id )
        REFERENCES tb_clinic ( id );
        
-- Trigger para tables
CREATE OR REPLACE TRIGGER trg_tb_appointment
BEFORE INSERT ON tb_appointment
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
  SELECT seq_tb_appointment.NEXTVAL INTO :NEW.id FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_tb_clinic
BEFORE INSERT ON tb_clinic
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
  SELECT seq_tb_clinic.NEXTVAL INTO :NEW.id FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_tb_patient
BEFORE INSERT ON tb_patient
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
  SELECT seq_tb_patient.NEXTVAL INTO :NEW.id FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_tb_procedure_status
BEFORE INSERT ON tb_procedure_status
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
  SELECT seq_tb_procedure_status.NEXTVAL INTO :NEW.id FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_tb_procedure_type
BEFORE INSERT ON tb_procedure_type
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
  SELECT seq_tb_procedure_type.NEXTVAL INTO :NEW.id FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_tb_procedure_validation
BEFORE INSERT ON tb_procedure_validation
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
  SELECT seq_tb_procedure_validation.NEXTVAL INTO :NEW.id FROM dual;
END;
/
CREATE OR REPLACE TRIGGER trg_tb_user
BEFORE INSERT ON tb_user
FOR EACH ROW
WHEN (NEW.id IS NULL)
BEGIN
  SELECT seq_tb_user.NEXTVAL INTO :NEW.id FROM dual;
END;
/