-- Função IIF
SELECT Nome, IIF(Estoque > 0, 'Em estoque', 'Indisponível') AS StatusEstoque
FROM Produtos;

-- Exemplo de CASE
SELECT Nome, Preco,
    CASE 
        WHEN Preco > 100 THEN 'Caro'
        WHEN Preco BETWEEN 50 AND 100 THEN 'Moderado'
        ELSE 'Barato'
    END AS CategoriaPreco
FROM Produtos;


-- While products are expensive put in table with all descriptions. Break when product is cheat and continue when product is not expensive
DECLARE @Preco DECIMAL(10, 2);
DECLARE @Nome NVARCHAR(100);
DECLARE @ProdutoID INT;

DECLARE produtos_cursor CURSOR FOR
SELECT ProdutoID, Nome, Preco
FROM Produtos;

OPEN produtos_cursor;
FETCH NEXT FROM produtos_cursor INTO @ProdutoID, @Nome, @Preco;

WHILE @@FETCH_STATUS = 0
BEGIN
    IF @Preco > 100
    BEGIN
        INSERT INTO ProdutosCaros (ProdutoID, Nome, Preco)
        VALUES (@ProdutoID, @Nome, @Preco);
        BREAK;
    END
    ELSE
    BEGIN
        FETCH NEXT FROM produtos_cursor INTO @ProdutoID, @Nome, @Preco;
    END
END
