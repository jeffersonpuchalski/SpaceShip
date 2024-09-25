-- CLEAN DATABASE IF EXISTS
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'EcommerceDB')
BEGIN
    ALTER DATABASE EcommerceDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE EcommerceDB;
END
GO

-- Conteúdo do script.sql
CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO

-- Criação de Tabelas e Carga de Dados
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100),
    Email NVARCHAR(100),
    DataCadastro DATE
);

CREATE TABLE Fornecedores (
    FornecedorID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100),
    Contato NVARCHAR(100)
);

CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY IDENTITY(1,1),
    FornecedorID INT FOREIGN KEY REFERENCES Fornecedores(FornecedorID),
    Nome NVARCHAR(100),
    Preco DECIMAL(10, 2),
    Estoque INT
);

CREATE TABLE ProdutosCaros (
    ProdutosCaros INT PRIMARY KEY,
    ProdutoID INT,
    Nome NVARCHAR(100),
    Preco DECIMAL(10, 2)
);


CREATE TABLE Pedidos (
    PedidoID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT FOREIGN KEY REFERENCES Clientes(ClienteID),
    DataPedido DATE,
    Status NVARCHAR(50)
);

CREATE TABLE PedidoDetalhes (
    PedidoDetalheID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT FOREIGN KEY REFERENCES Pedidos(PedidoID),
    ProdutoID INT FOREIGN KEY REFERENCES Produtos(ProdutoID),
    Quantidade INT,
    PrecoUnitario DECIMAL(10, 2)
);

CREATE TABLE Pagamentos (
    PagamentoID INT PRIMARY KEY IDENTITY(1,1),
    PedidoID INT FOREIGN KEY REFERENCES Pedidos(PedidoID),
    Valor DECIMAL(10, 2),
    DataPagamento DATE,
    MetodoPagamento NVARCHAR(50)
);

CREATE TABLE EstoqueMovimentacao (
    MovimentacaoID INT PRIMARY KEY IDENTITY(1,1),
    ProdutoID INT FOREIGN KEY REFERENCES Produtos(ProdutoID),
    TipoMovimentacao NVARCHAR(50),  -- Entrada ou Saída
    Quantidade INT,
    DataMovimentacao DATE
);
GO

-- Criacao da Tabelas de produtos caros.
CREATE TABLE ProdutosCaros (
   ProdutosCaros INT PRIMARY KEY IDENTITY(1,1),
   ProdutoID INT FOREIGN KEY REFERENCES Produtos(ProdutoID),
   Nome NVARCHAR(100),
   Preco DECIMAL(10, 2)
);
GO


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
GO


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
GO

-- Exemplo de criação de índice
CREATE INDEX idx_Produtos_Preco
ON Produtos (Preco);
GO


-- Carga de Dados para a tabela Clientes
INSERT INTO Clientes (Nome, Email, DataCadastro)
VALUES 
('João Silva', 'joao.silva@gmail.com', '2023-01-15'),
('Maria Souza', 'maria.souza@hotmail.com', '2023-03-20'),
('Carlos Pereira', 'carlos.pereira@yahoo.com', '2023-04-18'),
('Ana Costa', 'ana.costa@empresa.com', '2023-06-01');

-- Carga de Dados para a tabela Fornecedores
INSERT INTO Fornecedores (Nome, Contato)
VALUES 
('Fornecedor A', 'contato@fornecedora.com'),
('Fornecedor B', 'contato@fornecedorb.com'),
('Fornecedor C', 'contato@fornecedorc.com');

-- Carga de Dados para a tabela Produtos
INSERT INTO Produtos (FornecedorID, Nome, Preco, Estoque)
VALUES 
(2,'Notebook', 3500.00, 15),
(2,'Mouse', 50.00, 200),
(1,'Teclado', 120.00, 150),
(3,'Monitor', 900.00, 30),
(1,'Impressora', 600.00, 25);

-- Carga de Dados para a tabela Pedidos
INSERT INTO Pedidos (ClienteID, DataPedido, Status)
VALUES 
(1, '2024-09-20', 'Em andamento'),
(2, '2024-09-21', 'Concluído'),
(3, '2024-09-22', 'Cancelado'),
(4, '2024-09-23', 'Em andamento');

-- Carga de Dados para a tabela PedidoDetalhes
INSERT INTO PedidoDetalhes (PedidoID, ProdutoID, Quantidade, PrecoUnitario)
VALUES 
(1, 1, 1, 3500.00),  -- Pedido 1: 1 Notebook
(1, 2, 2, 50.00),    -- Pedido 1: 2 Mouses
(2, 3, 1, 120.00),   -- Pedido 2: 1 Teclado
(2, 4, 2, 900.00),   -- Pedido 2: 2 Monitores
(3, 5, 1, 600.00);   -- Pedido 3: 1 Impressora

-- Carga de Dados para a tabela Pagamentos
INSERT INTO Pagamentos (PedidoID, Valor, DataPagamento, MetodoPagamento)
VALUES 
(1, 3600.00, '2024-09-20', 'Cartão de Crédito'),
(2, 1920.00, '2024-09-21', 'Boleto Bancário'),
(3, 600.00, '2024-09-22', 'Pix');

-- Carga de Dados para a tabela EstoqueMovimentacao
-- Simula movimentações de estoque para produtos
INSERT INTO EstoqueMovimentacao (ProdutoID, TipoMovimentacao, Quantidade, DataMovimentacao)
VALUES 
(1, 'Entrada', 10, '2024-09-01'),  -- Entrada de 10 Notebooks
(2, 'Saída', 50, '2024-09-02'),    -- Saída de 50 Mouses
(3, 'Entrada', 20, '2024-09-03'),  -- Entrada de 20 Teclados
(4, 'Saída', 10, '2024-09-04'),    -- Saída de 10 Monitores
(5, 'Entrada', 5, '2024-09-05');   -- Entrada de 5 Impressoras
