from datetime import datetime

import oracledb

# Configurações de conexão
username = 'rm552618'
password = '201104'
dsn = 'oracle.fiap.com.br:1521/orcl'

# Conectando ao banco de dados
connection = oracledb.connect(user=username, password=password, dsn=dsn)

# Cria um cursor para executar as consultas
cursor = connection.cursor()

# Exemplo de séries de inserts em diferentes tabelas
# Inserções separadas
inserts = [
    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Avenida B, 456, Rio de Janeiro, RJ', '58.765.432/0001-01', 'conerttato@clinicario.com.br', 'Clínica Carioca',
       '(21) 2345-6789')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Rua C, 789, Belo Horizonte, MG', '344567.890/0001-12', 'inferto@clinicabh.com.br', 'Clínica BH',
       '(31) 3456-7890')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Praça D, 321, Curitiba, PR', '56.789.612/0001-23', 'contatoert@clinicacuritiba.com.br', 'Clínica Curitiba',
       '(41) 4567-8901')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Rua E, 654, Porto Alegre, RS', '23.454.789/0001-34', 'contatoert@clinicapoa.com.br', 'Clínica POA',
       '(51) 5678-9012')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Avenida F, 987, Recife, PE', '87.654.521/0001-45', 'infoert@clinicarecife.com.br', 'Clínica Recife',
       '(81) 6789-0123')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Rua G, 135, Salvador, BA', '11.222.336/0001-56', 'contatotr@clinicassalvador.com.br', 'Clínica Salvador',
       '(71) 7890-1234')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Praça H, 246, Fortaleza, CE', '14.4447555/0001-67', 'infotr@clinicafortaleza.com.br', 'Clínica Fortaleza',
       '(85) 8901-2345')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Rua I, 369, Manaus, AM', '77.888.999/4001-78', 'contatotr@clinicamanaus.com.br', 'Clínica Manaus',
       '(92) 9012-3456')]),

    ("INSERT INTO tb_clinic (ADDRESS, CNPJ, EMAIL, NAME, PHONE) VALUES (:1, :2, :3, :4, :5)",
     [('Avenida J, 159, Natal, RN', '00.111.262/0001-89', 'infort@clinicarn.com.br', 'Clínica Natal',
       '(84) 0123-4567')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1990-01-15', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 1245656789,
       'Ana Souza', 'M3G-12.345.678')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1985-05-20', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 9876354321,
       'Carlos Silva', 'SP-23.456.7849')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1992-03-10', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 1122233445,
       'Mariana Costa', 'RJ-34.567.8590')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1988-07-25', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 2231344556,
       'Ricardo Almeida', 'PR-45.678.9071')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('2000-09-05', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 3344355667,
       'Juliana Pereira', 'RS-56.789.0012')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1975-11-30', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 4455566778,
       'Eduardo Lima', 'BA-67.890.1283')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1995-12-22', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 5566767889,
       'Fernanda Ribeiro', 'CE-78.901.2734')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1982-04-17', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 6677888990,
       'Roberto Santos', 'AM-89.012.3645')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1998-08-02', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 7788959001,
       'Camila Martins', 'DF-90.123.4556')]),

    ("INSERT INTO tb_patient (BIRTH_DATE, CREATED_AT, NUM_CARD, NAME, RG) VALUES (:1, :2, :3, :4, :5)",
     [(datetime.strptime('1993-06-11', '%Y-%m-%d'), datetime.strptime('2024-10-07', '%Y-%m-%d'), 8899300112,
       'Lucas Ferreira', 'SC-01.234.5467')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Instalação de Aparelho Ortodônticos',
       'Procedimento de aplicação de aparelho ortodôntico para correção dos dentes.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Remoção de Aparelho Ortodônticos',
       'Procedimento de retirada do aparelho ortodôntico após finalização do tratamento.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Restauração Dentári', 'Procedimento de reparo de dentes danificados ou cariados com material restaurador.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Extração de Dentess', 'Procedimento de remoção de um ou mais dentes.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Remoção de Cáries', 'Procedimento de limpeza e retirada de tecido dentário deteriorado por cáries.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Remoção de Tártaros', 'Procedimento de limpeza dos dentes para remoção de tártaro acumulado.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Clareamento Dentals', 'Procedimento estético para clarear dentes manchados ou escurecidos.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Tratamento de Canals', 'Procedimento para tratar a polpa dentária infectada e preservar o dente.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Prótese Dentárias', 'Procedimento de colocação de próteses para substituir dentes ausentes.')]),

    ("INSERT INTO tb_procedure_type (name, description) VALUES (:1, :2)",
     [('Aplicação de Fluoretos', 'Procedimento para aplicação de fluoreto nos dentes para prevenção de cáries.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('PENDENT', 'O procedimento foi criado, mas ainda não foi iniciado.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('AGUARDAND IMAGENS', 'O procedimento foi iniciado, mas as imagens ainda não foram enviadas.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('VALDADO', 'O procedimento foi validado com sucesso, todas as informações estão corretas.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('CANCELADOs', 'O procedimento foi cancelado, não será concluído.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('EM ANDAMENTOs', 'O procedimento está em andamento, com o dentista realizando a consulta.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('FINALIZADOs', 'O procedimento foi concluído com sucesso e todas as etapas foram executadas.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('REVISÃO NECESSÁRIAs', 'O procedimento requer revisão adicional antes de ser considerado completo.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('REJEITADOs', 'O procedimento foi rejeitado devido a informações ou condições inadequadas.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('AGUARDANDO APROVAÇÃOs', 'O procedimento está aguardando a aprovação de um responsável antes de prosseguir.')]),

    ("INSERT INTO tb_procedure_status (name, description) VALUES (:1, :2)",
     [('EM ESPERAa', 'O procedimento está em espera por alguma ação externa ou informação adicional.')]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 122, 62)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 123, 63)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 124, 64)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 121, 65)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 122, 66)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 123, 61)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 124, 62)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 121, 63)]),

    ("INSERT INTO tb_procedure_validation (IMG_URL_INITIAL, IMG_URL_FINAL, PROCEDURE_STATUS_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4)",
    [(None, None, 122, 64)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-01', '%Y-%m-%d'), None, 'atendent243e1@clinica.com', 'Maria Oliveira',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 161)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-02', '%Y-%m-%d'), None, 'atenden456te2@clinica.com', 'João Pereira',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 161)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-03', '%Y-%m-%d'), None, 'atend3ente3@clinica.com', 'Ana Santos',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 162)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-04', '%Y-%m-%d'), None, 'atendente44@clinica.com', 'Carlos Lima',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 162)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-05', '%Y-%m-%d'), None, 'atende34nte5@clinica.com', 'Fernanda Costa',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'ATENDENTE', 163)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-06', '%Y-%m-%d'), '123345', 'dent54ista1@clinica.com', 'Roberto Silva',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 161)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-07', '%Y-%m-%d'), '678490', 'denti23sta2@clinica.com', 'Juliana Rocha',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 162)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-08', '%Y-%m-%d'), '234546', 'denti23sta3@clinica.com', 'Ricardo Almeida',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 163)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-09', '%Y-%m-%d'), '789401', 'denti23sta4@clinica.com', 'Mariana Oliveira',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 161)]),

    (
    "INSERT INTO tb_user (CREATED_AT, CRO, EMAIL, NAME, PASSWORD, ROLE, CLINIC_ID) VALUES (:1, :2, :3, :4, :5, :6, :7)",
    [(datetime.strptime('2024-10-10', '%Y-%m-%d'), '345647', 'dent23ista5@clinica.com', 'Lucas Ferreira',
      '$2a$10$MO78Sd0fzvQrz.Gr7yIVVuj7oE5YnZ/y8nSYSoaS9L/MY/HtzjXeu', 'DENTISTA', 162)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-21', '%Y-%m-%d'),
      datetime.strptime('11:00', '%H:%M'),
      datetime.strptime('2024-10-12', '%Y-%m-%d'),
      149, 144, 163, 90, 66)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-22', '%Y-%m-%d'),
      datetime.strptime('09:00', '%H:%M'),
      datetime.strptime('2024-10-13', '%Y-%m-%d'),
      147, 141, 161, 91, 61)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-23', '%Y-%m-%d'),
      datetime.strptime('14:00', '%H:%M'),
      datetime.strptime('2024-10-14', '%Y-%m-%d'),
      148, 142, 162, 92, 62)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-24', '%Y-%m-%d'),
      datetime.strptime('13:30', '%H:%M'),
      datetime.strptime('2024-10-15', '%Y-%m-%d'),
      149, 143, 163, 93, 63)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-25', '%Y-%m-%d'),
      datetime.strptime('15:00', '%H:%M'),
      datetime.strptime('2024-10-16', '%Y-%m-%d'),
      147, 144, 161, 94, 64)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-26', '%Y-%m-%d'),
      datetime.strptime('16:30', '%H:%M'),
      datetime.strptime('2024-10-17', '%Y-%m-%d'),
      148, 141, 162, 95, 65)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-27', '%Y-%m-%d'),
      datetime.strptime('17:00', '%H:%M'),
      datetime.strptime('2024-10-18', '%Y-%m-%d'),
      149, 142, 163, 96, 66)]),

    (
    "INSERT INTO tb_appointment (DATE_APPOINTMENT, TIME_APPOINTMENT, CREATED_AT, PATIENT_ID, USER_ID, CLINIC_ID, PROCEDURE_VALIDATION_ID, PROCEDURE_TYPE_ID) VALUES (:1, :2, :3, :4, :5, :6, :7, :8)",
    [(datetime.strptime('2024-10-28', '%Y-%m-%d'),
      datetime.strptime('18:00', '%H:%M'),
      datetime.strptime('2024-10-19', '%Y-%m-%d'),
      147, 143, 161, 97, 61)])

]

try:
    # Itera sobre cada inserção e insere os dados
    for sql, params in inserts:
        cursor.executemany(sql, params)

    # Commit para salvar as alterações
    connection.commit()

    print("Dados inseridos com sucesso!")

except Exception as e:
    # Faz rollback em caso de erro
    connection.rollback()
    print("Erro ao inserir dados:", e)

finally:
    # Fecha o cursor e a conexão
    cursor.close()
    connection.close()
