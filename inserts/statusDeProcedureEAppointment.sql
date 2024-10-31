INSERT INTO tb_procedure_status (name, description) VALUES ('Aguardando Valida��o', 'Procedimento registrado, aguardando in�cio da an�lise.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Em An�lise de Valida��o', 'Processo de verifica��o das imagens e dados do procedimento iniciado.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Aprovado sem Irregularidades', 'Procedimento validado com sucesso, sem irregularidades.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Suspeita de Fraude', 'Ind�cios de poss�vel fraude detectados, como imagens inconsistentes.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Fraude Confirmada', 'Procedimento confirmado como fraudulento.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Inconclusivo', 'Dados insuficientes para valida��o conclusiva; pode exigir mais informa��es.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Rean�lise Solicitada', 'Nova an�lise solicitada para revis�o do status, seja por pedido do dentista ou da operadora.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Agendada', 'Consulta agendada, aguardando confirma��o.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Confirmada', 'Consulta confirmada pelo dentista e/ou paciente.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Em Atendimento', 'Consulta em andamento no consult�rio.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Conclu�da', 'Consulta finalizada com sucesso.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Cancelada', 'Consulta cancelada pelo paciente ou pela cl�nica.');
INSERT INTO tb_procedure_status (name, description) VALUES ('N�o Compareceu', 'Paciente n�o compareceu � consulta.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Reagendada', 'Consulta foi reagendada para outra data.');

COMMIT;

select * from tb_procedure_status;