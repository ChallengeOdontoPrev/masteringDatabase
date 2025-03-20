INSERT INTO tb_procedure_status (name, description) VALUES ('Em Analise para Validacao', 'Processo de verificacao das imagens e dados do procedimento iniciado.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Aprovado sem Irregularidades', 'Procedimento validado com sucesso, sem irregularidades.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Reanalise Solicitada', 'Nova analise solicitada para revisao do status, seja por pedido do dentista ou da operadora.');

INSERT INTO tb_procedure_type (name, description, class_initial, class_final) VALUES ('Instalação de Aparelho Ortodôntico', 'Procedimento de aplicação de aparelho ortodôntico para correção dos dentes.', 'SEM_APARELHO', 'APARELHO');
INSERT INTO tb_procedure_type (name, description, class_initial, class_final) VALUES ('Remoção de Aparelho Ortodôntico', 'Procedimento de retirada do aparelho ortodôntico após finalização do tratamento.', 'APARELHO', 'SEM_APARELHO');

INSERT INTO tb_address (CITY, NUM, STATE, STREET, ZIP_CODE) VALUES ('Belo Horizonte', '789', 'MG', 'Rua C', '34567-890');
INSERT INTO tb_address (CITY, NUM, STATE, STREET, ZIP_CODE) VALUES ('Curitiba', '101', 'PR', 'Avenida D', '45678-901');
INSERT INTO tb_address (CITY, NUM, STATE, STREET, ZIP_CODE) VALUES ('Porto Alegre', '202', 'RS', 'Travessa E', '56789-012');
INSERT INTO tb_address (CITY, NUM, STATE, STREET, ZIP_CODE) VALUES ('Porto Alegre', '250', 'RS', 'Travessa O', '34522-012');
INSERT INTO tb_address (CITY, NUM, STATE, STREET, ZIP_CODE) VALUES ('Salvador', '303', 'BA', 'Largo F', '67890-123');


INSERT INTO tb_clinic (NAME, CNPJ, PHONE, EMAIL, ADDRESS_ID) VALUES ('Clínica Saúde BH', '23.456.789/0001-01', '(31) 2345-6789', 'saude_bh@gmail.com', 3);
INSERT INTO tb_clinic (NAME, CNPJ, PHONE, EMAIL, ADDRESS_ID) VALUES ('Clínica Curitibana', '34.567.890/0001-12', '(41) 3456-7890', 'curitibana@gmail.com', 4);
INSERT INTO tb_clinic (NAME, CNPJ, PHONE, EMAIL, ADDRESS_ID) VALUES ('Clínica Gaúcha', '45.678.901/0001-23', '(51) 4567-8901', 'gaucha@gmail.com', 1);
INSERT INTO tb_clinic (NAME, CNPJ, PHONE, EMAIL, ADDRESS_ID) VALUES ('Clínica Baiana', '56.789.012/0001-34', '(71) 5678-9012', 'baiana@gmail.com', 2);
INSERT INTO tb_clinic (NAME, CNPJ, PHONE, EMAIL, ADDRESS_ID) VALUES ('Clínica Paulista', '56.783.012/0001-34', '(71) 2678-9012', 'Paulista@gmail.com', 5);


INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (TO_DATE('1975-08-10', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '123123123', 'Bruna Oliveira', 'RJ-34.567.890');
INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (TO_DATE('2002-12-22', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '321321321', 'Diego Santos', 'SP-45.678.901');
INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (TO_DATE('1988-04-05', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '456456456', 'Fernando Ribeiro', 'MG-56.789.012');
INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (TO_DATE('1995-09-13', 'YYYY-MM-DD'), TO_DATE('2024-10-07', 'YYYY-MM-DD'), '654654654', 'Juliana Martins', 'RS-67.890.123');

COMMIT;