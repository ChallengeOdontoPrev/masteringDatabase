INSERT INTO tb_procedure_status (name, description)
VALUES ('PENDENTE', 'O procedimento foi criado, mas ainda não foi iniciado.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('AGUARDANDO IMAGENS', 'O procedimento foi iniciado, mas as imagens ainda não foram enviadas.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('VALIDADO', 'O procedimento foi validado com sucesso, todas as informações estão corretas.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('CANCELADO', 'O procedimento foi cancelado, não será concluído.');

// PY
INSERT INTO tb_procedure_status (name, description)
VALUES ('EM ANDAMENTO', 'O procedimento está em andamento, com o dentista realizando a consulta.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('FINALIZADO', 'O procedimento foi concluído com sucesso e todas as etapas foram executadas.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('REVISÃO NECESSÁRIA', 'O procedimento requer revisão adicional antes de ser considerado completo.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('REJEITADO', 'O procedimento foi rejeitado devido a informações ou condições inadequadas.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('AGUARDANDO APROVAÇÃO', 'O procedimento está aguardando a aprovação de um responsável antes de prosseguir.');

INSERT INTO tb_procedure_status (name, description)
VALUES ('EM ESPERA', 'O procedimento está em espera por alguma ação externa ou informação adicional.');


// PROCEDURE TYPE

INSERT INTO tb_procedure_type (name, description)
VALUES ('Instalação de Aparelho Ortodôntico', 'Procedimento de aplicação de aparelho ortodôntico para correção dos dentes.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Remoção de Aparelho Ortodôntico', 'Procedimento de retirada do aparelho ortodôntico após finalização do tratamento.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Restauração Dentária', 'Procedimento de reparo de dentes danificados ou cariados com material restaurador.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Extração de Dentes', 'Procedimento de remoção de um ou mais dentes.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Remoção de Cárie', 'Procedimento de limpeza e retirada de tecido dentário deteriorado por cáries.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Remoção de Tártaro', 'Procedimento de limpeza dos dentes para remoção de tártaro acumulado.');

// PY
INSERT INTO tb_procedure_type (name, description)
VALUES ('Clareamento Dental-', 'Procedimento estético para clarear dentes manchados ou escurecidos.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Tratamento de Canal-', 'Procedimento para tratar a polpa dentária infectada e preservar o dente.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Prótese Dentária-', 'Procedimento de colocação de próteses para substituir dentes ausentes.');

INSERT INTO tb_procedure_type (name, description)
VALUES ('Aplicação de Fluoreto-', 'Procedimento para aplicação de fluoreto nos dentes para prevenção de cáries.');

// tb_procedure_validation 
INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 121, 61);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 122, 62);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 123, 63);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 124, 64);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 121, 65);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 122, 66);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 123, 61);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 124, 62);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 121, 63);

INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID)
VALUES (NULL, NULL, 122, 64);

// tb_clinic

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Rua A, 123, São Paulo, SP', '12.345.678/0001-90', 'contato@clinicapaulista.com.br', 'Clínica Paulista', '(11) 1234-5678');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Avenida B, 456, Rio de Janeiro, RJ', '98.765.432/0001-01', 'contato@clinicario.com.br', 'Clínica Carioca', '(21) 2345-6789');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Rua C, 789, Belo Horizonte, MG', '34.567.890/0001-12', 'info@clinicabh.com.br', 'Clínica BH', '(31) 3456-7890');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Praça D, 321, Curitiba, PR', '56.789.012/0001-23', 'contato@clinicacuritiba.com.br', 'Clínica Curitiba', '(41) 4567-8901');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Rua E, 654, Porto Alegre, RS', '23.456.789/0001-34', 'contato@clinicapoa.com.br', 'Clínica POA', '(51) 5678-9012');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Avenida F, 987, Recife, PE', '87.654.321/0001-45', 'info@clinicarecife.com.br', 'Clínica Recife', '(81) 6789-0123');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Rua G, 135, Salvador, BA', '11.222.333/0001-56', 'contato@clinicassalvador.com.br', 'Clínica Salvador', '(71) 7890-1234');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Praça H, 246, Fortaleza, CE', '14.444.555/0001-67', 'info@clinicafortaleza.com.br', 'Clínica Fortaleza', '(85) 8901-2345');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Rua I, 369, Manaus, AM', '77.888.999/0001-78', 'contato@clinicamanaus.com.br', 'Clínica Manaus', '(92) 9012-3456');

INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE)
VALUES ('Avenida J, 159, Natal, RN', '00.111.222/0001-89', 'info@clinicarn.com.br', 'Clínica Natal', '(84) 0123-4567');

// tb_patient

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1990-01-15', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '123456789', 'Ana Souza', 'MG-12.345.678');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1985-05-20', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '987654321', 'Carlos Silva', 'SP-23.456.789');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1992-03-10', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '112233445', 'Mariana Costa', 'RJ-34.567.890');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1988-07-25', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '223344556', 'Ricardo Almeida', 'PR-45.678.901');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('2000-09-05', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '334455667', 'Juliana Pereira', 'RS-56.789.012');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1975-11-30', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '445566778', 'Eduardo Lima', 'BA-67.890.123');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1995-12-22', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '556677889', 'Fernanda Ribeiro', 'CE-78.901.234');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1982-04-17', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '667788990', 'Roberto Santos', 'AM-89.012.345');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1998-08-02', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '778899001', 'Camila Martins', 'DF-90.123.456');

INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG)
VALUES (TO_DATE('1993-06-11', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '889900112', 'Lucas Ferreira', 'SC-01.234.567');

// tb_user

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-01', 'YYYY-MM-DD'), NULL, 'atendente1@clinica.com', 'Maria Oliveira', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 161);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-02', 'YYYY-MM-DD'), NULL, 'atendente2@clinica.com', 'João Pereira', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 161);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-03', 'YYYY-MM-DD'), NULL, 'atendente3@clinica.com', 'Ana Santos', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 162);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-04', 'YYYY-MM-DD'), NULL, 'atendente4@clinica.com', 'Carlos Lima', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 162);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-05', 'YYYY-MM-DD'), NULL, 'atendente5@clinica.com', 'Fernanda Costa', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 163);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-06', 'YYYY-MM-DD'), '12345', 'dentista1@clinica.com', 'Roberto Silva', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 161);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-07', 'YYYY-MM-DD'), '67890', 'dentista2@clinica.com', 'Juliana Rocha', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 162);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-08', 'YYYY-MM-DD'), '23456', 'dentista3@clinica.com', 'Ricardo Almeida', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 163);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-09', 'YYYY-MM-DD'), '78901', 'dentista4@clinica.com', 'Mariana Oliveira', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 161);

INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID)
VALUES (TO_DATE('2024-10-10', 'YYYY-MM-DD'), '34567', 'dentista5@clinica.com', 'Lucas Ferreira', '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 162);

// tb_appointment

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-19', 'YYYY-MM-DD'), TO_TIMESTAMP('18:00', 'HH24:MI'), TO_DATE('2024-10-10', 'YYYY-MM-DD'), 147, 142, 161, 88, 64);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-20', 'YYYY-MM-DD'), TO_TIMESTAMP('10:30', 'HH24:MI'), TO_DATE('2024-10-11', 'YYYY-MM-DD'), 148, 143, 162, 89, 65);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-21', 'YYYY-MM-DD'), TO_TIMESTAMP('11:00', 'HH24:MI'), TO_DATE('2024-10-12', 'YYYY-MM-DD'), 149, 144, 163, 90, 66);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-22', 'YYYY-MM-DD'), TO_TIMESTAMP('09:00', 'HH24:MI'), TO_DATE('2024-10-13', 'YYYY-MM-DD'), 147, 141, 161, 91, 61);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-23', 'YYYY-MM-DD'), TO_TIMESTAMP('14:00', 'HH24:MI'), TO_DATE('2024-10-14', 'YYYY-MM-DD'), 148, 142, 162, 92, 62);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-24', 'YYYY-MM-DD'), TO_TIMESTAMP('13:30', 'HH24:MI'), TO_DATE('2024-10-15', 'YYYY-MM-DD'), 149, 143, 163, 93, 63);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-25', 'YYYY-MM-DD'), TO_TIMESTAMP('15:00', 'HH24:MI'), TO_DATE('2024-10-16', 'YYYY-MM-DD'), 147, 144, 161, 94, 64);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-26', 'YYYY-MM-DD'), TO_TIMESTAMP('16:30', 'HH24:MI'), TO_DATE('2024-10-17', 'YYYY-MM-DD'), 148, 141, 162, 95, 65);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-27', 'YYYY-MM-DD'), TO_TIMESTAMP('17:00', 'HH24:MI'), TO_DATE('2024-10-18', 'YYYY-MM-DD'), 149, 142, 163, 96, 66);

INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID)
VALUES (TO_DATE('2024-10-28', 'YYYY-MM-DD'), TO_TIMESTAMP('18:00', 'HH24:MI'), TO_DATE('2024-10-19', 'YYYY-MM-DD'), 147, 143, 161, 97, 61);

COMMIT;

select * from tb_procedure_status;
select * from tb_procedure_type;
select * from tb_procedure_validation;
select * from tb_user;
select * from tb_appointment;
select * from tb_clinic;
select * from tb_patient;
