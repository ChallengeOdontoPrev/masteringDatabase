-- PROCEDURE VALIDATION
INSERT INTO tb_procedure_status (name, description) VALUES ('Em Analise para Validacao', 'Processo de verificacao das imagens e dados do procedimento iniciado.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Aprovado sem Irregularidades', 'Procedimento validado com sucesso, sem irregularidades.');
INSERT INTO tb_procedure_status (name, description) VALUES ('Reanalise Solicitada', 'Nova analise solicitada para revisao do status, seja por pedido do dentista ou da operadora.');
COMMIT;