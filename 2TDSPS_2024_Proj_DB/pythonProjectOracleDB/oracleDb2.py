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
     [('Rua A, 123, São Paulo, SP', '12.345.478/00301-90', 'cone4rttato@clinicapaulista.com.br', 'Clínica Paulista',
       '(11) 1234-5678')]),
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
