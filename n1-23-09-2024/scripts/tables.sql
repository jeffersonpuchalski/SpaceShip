-- Criação de Tabelas
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100),
    Email NVARCHAR(100),
    DataCadastro DATE
);

CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100),
    Preco DECIMAL(10, 2),
    Estoque INT
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

CREATE TABLE Fornecedores (
    FornecedorID INT PRIMARY KEY IDENTITY(1,1),
    Nome NVARCHAR(100),
    Contato NVARCHAR(100)
);

CREATE TABLE EstoqueMovimentacao (
    MovimentacaoID INT PRIMARY KEY IDENTITY(1,1),
    ProdutoID INT FOREIGN KEY REFERENCES Produtos(ProdutoID),
    TipoMovimentacao NVARCHAR(50),  -- Entrada ou Saída
    Quantidade INT,
    DataMovimentacao DATE
);

CREATE TABLE ProdutosCaros (
    ProdutoID INT PRIMARY KEY,
    Nome NVARCHAR(100),
    Preco DECIMAL(10, 2)
);