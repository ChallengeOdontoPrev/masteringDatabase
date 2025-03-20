DROP TABLE tb_appointment CASCADE CONSTRAINTS;
DROP TABLE tb_address CASCADE CONSTRAINTS;
DROP TABLE tb_clinic CASCADE CONSTRAINTS;
DROP TABLE tb_user CASCADE CONSTRAINTS;
DROP TABLE tb_patient CASCADE CONSTRAINTS;
DROP TABLE tb_procedure_status CASCADE CONSTRAINTS;
DROP TABLE tb_procedure_type CASCADE CONSTRAINTS;
DROP TABLE tb_procedure_validation CASCADE CONSTRAINTS;
DROP TABLE tb_user CASCADE CONSTRAINTS;

CREATE TABLE tb_address (
    id       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    street   VARCHAR2(255 CHAR) NOT NULL,
    num      VARCHAR2(255 CHAR) NOT NULL,
    city     VARCHAR2(255 CHAR) NOT NULL,
    state    VARCHAR2(255 CHAR) NOT NULL,
    zip_code VARCHAR2(255 CHAR) NOT NULL
);

CREATE TABLE tb_appointment (
    id                      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    date_appointment        DATE NOT NULL,
    time_appointment        VARCHAR2(255 CHAR) NOT NULL,
    created_at              TIMESTAMP NOT NULL,
    user_id                 NUMBER NOT NULL,
    clinic_id               NUMBER NOT NULL,
    patient_id              NUMBER NOT NULL,
    procedure_type_id       NUMBER NOT NULL,
    procedure_validation_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX tb_appointment__idx ON
    tb_appointment (
        procedure_validation_id
    ASC );

CREATE TABLE tb_clinic (
    id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cnpj    VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    email   VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    name       VARCHAR2(255 CHAR) NOT NULL,
    phone      VARCHAR2(255 CHAR) NOT NULL,
    address_id NUMBER NOT NULL
);

CREATE UNIQUE INDEX tb_clinic__idx ON
    tb_clinic (
        address_id
    ASC );

CREATE TABLE tb_patient (
    id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    birth_date DATE NOT NULL,
    created_at DATE NOT NULL,
    num_card   NUMBER NOT NULL UNIQUE,
    name       VARCHAR2(255 CHAR) NOT NULL,
    rg         VARCHAR2(255 CHAR) NOT NULL UNIQUE
);

CREATE TABLE tb_procedure_status (
    id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    description VARCHAR2(255 CHAR) NOT NULL
);

CREATE TABLE tb_procedure_type (
    id          NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name        VARCHAR2(255 CHAR) NOT NULL UNIQUE,
    description VARCHAR2(255 CHAR) NOT NULL,
    class_initial       VARCHAR2(255 CHAR) NOT NULL,
    class_final       VARCHAR2(255 CHAR) NOT NULL
);

CREATE TABLE tb_procedure_validation (
    id                  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    img_url_initial     VARCHAR2(255 CHAR),
    img_url_final       VARCHAR2(255 CHAR),
    class_initial       VARCHAR2(255 CHAR),
    class_final       VARCHAR2(255 CHAR),
    procedure_type_id   NUMBER NOT NULL,
    procedure_status_id NUMBER NOT NULL
);

CREATE TABLE tb_user (
    id         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    created_at DATE NOT NULL,
    cro        VARCHAR2(255 CHAR),
    email      VARCHAR2(255 CHAR) NOT NULL,
    name       VARCHAR2(255 CHAR) NOT NULL,
    password   VARCHAR2(255 CHAR) NOT NULL,
    role       VARCHAR2(255 CHAR) NOT NULL,
    birth_date DATE NOT NULL,
    rg         VARCHAR2(255 CHAR) NOT NULL,
    clinic_id  NUMBER NOT NULL
);

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appointment_tb_clinic_fk FOREIGN KEY ( clinic_id )
        REFERENCES tb_clinic ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appointment_tb_patient_fk FOREIGN KEY ( patient_id )
        REFERENCES tb_patient ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appoint_tb_proc_type_fk FOREIGN KEY ( procedure_type_id )
        REFERENCES tb_procedure_type ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appoint_tb_proc_valid_fk FOREIGN KEY ( procedure_validation_id )
        REFERENCES tb_procedure_validation ( id );

ALTER TABLE tb_appointment
    ADD CONSTRAINT tb_appointment_tb_user_fk FOREIGN KEY ( user_id )
        REFERENCES tb_user ( id );

ALTER TABLE tb_clinic
    ADD CONSTRAINT tb_clinic_tb_address_fk FOREIGN KEY ( address_id )
        REFERENCES tb_address ( id );
 
ALTER TABLE tb_procedure_validation
    ADD CONSTRAINT tb_proc_valid_tb_proc_sts_fk FOREIGN KEY ( procedure_status_id )
        REFERENCES tb_procedure_status ( id );

ALTER TABLE tb_procedure_validation
    ADD CONSTRAINT tb_proc_valid_tb_proc_type_fk FOREIGN KEY ( procedure_type_id )
        REFERENCES tb_procedure_type ( id );

ALTER TABLE tb_user
    ADD CONSTRAINT tb_user_tb_clinic_fk FOREIGN KEY ( clinic_id )
        REFERENCES tb_clinic ( id );
