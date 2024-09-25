-- Exemplo de IF dentro de um procedimento armazenado
CREATE PROCEDURE AtualizarEstoque @ProdutoID INT, @Quantidade INT
AS
BEGIN
    IF (@Quantidade > 0)
    BEGIN
        UPDATE Produtos
        SET Estoque = Estoque + @Quantidade
        WHERE ProdutoID = @ProdutoID;
    END
    ELSE
    BEGIN
        PRINT 'Quantidade inválida!';
    END
END;

