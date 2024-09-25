-- Carga de Dados para a tabela Clientes
INSERT INTO Clientes (Nome, Email, DataCadastro)
VALUES 
('João Silva', 'joao.silva@gmail.com', '2023-01-15'),
('Maria Souza', 'maria.souza@hotmail.com', '2023-03-20'),
('Carlos Pereira', 'carlos.pereira@yahoo.com', '2023-04-18'),
('Ana Costa', 'ana.costa@empresa.com', '2023-06-01');

-- Carga de Dados para a tabela Produtos
INSERT INTO Produtos (Nome, Preco, Estoque)
VALUES 
('Notebook', 3500.00, 15),
('Mouse', 50.00, 200),
('Teclado', 120.00, 150),
('Monitor', 900.00, 30),
('Impressora', 600.00, 25),
('Adaptador', 20.00, 100),
('Hub USB', 30.00, 80),
('Cabo HDMI', 15.00, 120),
('Caixa de Som', 80.00, 50),
('Webcam', 100.00, 40);

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

-- Carga de Dados para a tabela Fornecedores
INSERT INTO Fornecedores (Nome, Contato)
VALUES 
('Fornecedor A', 'contato@fornecedora.com'),
('Fornecedor B', 'contato@fornecedorb.com'),
('Fornecedor C', 'contato@fornecedorc.com');

-- Carga de Dados para a tabela EstoqueMovimentacao
-- Simula movimentações de estoque para produtos
INSERT INTO EstoqueMovimentacao (ProdutoID, TipoMovimentacao, Quantidade, DataMovimentacao)
VALUES 
(1, 'Entrada', 10, '2024-09-01'),  -- Entrada de 10 Notebooks
(2, 'Saída', 50, '2024-09-02'),    -- Saída de 50 Mouses
(3, 'Entrada', 20, '2024-09-03'),  -- Entrada de 20 Teclados
(4, 'Saída', 10, '2024-09-04'),    -- Saída de 10 Monitores
(5, 'Entrada', 5, '2024-09-05');   -- Entrada de 5 Impressoras
