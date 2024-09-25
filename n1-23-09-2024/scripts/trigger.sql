-- Exemplo de Trigger para auditoria de atualizações de estoque
CREATE TRIGGER trg_AfterUpdateEstoque
ON Produtos
AFTER UPDATE
AS
BEGIN
    INSERT INTO EstoqueMovimentacao (ProdutoID, TipoMovimentacao, Quantidade, DataMovimentacao)
    SELECT i.ProdutoID, 'Atualização', i.Estoque, GETDATE()
    FROM inserted i;
END;
