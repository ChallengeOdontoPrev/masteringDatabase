INSERT INTO tb_procedure_status (name, description) VALUES ('Aguardando Validação', 'Procedimento registrado, aguardando início da análise.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Em Análise de Validação', 'Processo de verificação das imagens e dados do procedimento iniciado.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Aprovado sem Irregularidades', 'Procedimento validado com sucesso, sem irregularidades.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Suspeita de Fraude', 'Indícios de possível fraude detectados, como imagens inconsistentes.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Fraude Confirmada', 'Procedimento confirmado como fraudulento.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Inconclusivo', 'Dados insuficientes para validação conclusiva; pode exigir mais informações.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Reanálise Solicitada', 'Nova análise solicitada para revisão do status, seja por pedido do dentista ou da operadora.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Agendada', 'Consulta agendada, aguardando confirmação.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Confirmada', 'Consulta confirmada pelo dentista e/ou paciente.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Em Atendimento', 'Consulta em andamento no consultório.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Concluída', 'Consulta finalizada com sucesso.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Cancelada', 'Consulta cancelada pelo paciente ou pela clínica.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Não Compareceu', 'Paciente não compareceu à consulta.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Reagendada', 'Consulta foi reagendada para outra data.');

COMMIT;

select * from tb_procedure_status;