SELECT user, host FROM mysql.user;

/**criacao de usuario de aplicacao para acessar a TechStore, **/
CREATE USER 'aplicativo'@'localhost' IDENTIFIED BY 'aplicativo123';

/**criacao de schema para agrupar as tabelas do banco de TechStore, **/
CREATE SCHEMA relacional;

/**permissão usuario de aplicacao para shema  TechStore, **/
GRANT SELECT, INSERT, UPDATE, DELETE ON relacional.* TO 'aplicativo'@'localhost';

/**criacao de permissões de acesso  TechStore, **/
GRANT SELECT, INSERT, UPDATE, DELETE ON relacional.* TO 'aplicativo'@'localhost';

-- Crie um banco de dados separado para a TechStore
CREATE DATABASE TechStoreDB;

-- Use o banco de dados recém-criado
USE TechStoreDB;

-- Agora, crie todas as tabelas para a TechStore dentro deste banco de dados 

/**A tabela "Clientes" armazena informações sobre os clientes da TechStore, incluindo nome, endereço, 
e-mail e número de telefone.**/

-- Criação da tabela Clientes
CREATE TABLE relacional.Clientes (
    ID_Cliente INT PRIMARY KEY,
    Nome_Cliente VARCHAR(255),
    Endereco VARCHAR(255),
    Email VARCHAR(255),
    Numero_Telefone VARCHAR(15)
);

-- Criação da tabela Produtos - A tabela "Produtos" contém detalhes sobre os produtos disponíveis na loja, como nome, descrição, preço e categoria.
CREATE TABLE relacional.Produtos (
    ID_Produto INT PRIMARY KEY,
    Nome_Produto VARCHAR(255),
    Descricao TEXT,
    Preco DECIMAL(10, 2),
    Categoria VARCHAR(50)
);

-- Criação da tabela Estoque - A tabela "Estoque" registra a quantidade disponível de cada produto em estoque, relacionada à tabela de produtos por meio do ID do Produto.

CREATE TABLE relacional.Estoque (
    ID_Estoque INT PRIMARY KEY,
    ID_Produto INT,
    Quantidade_Em_Estoque INT,
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

-- Criação da tabela Vendas - A tabela "Vendas" registra informações sobre as vendas realizadas, 
-- incluindo a data da venda, o cliente associado (por meio do ID do cliente) e o produto vendido (por meio do ID do produto). A quantidade vendida também é registrada.

CREATE TABLE relacional.Vendas (
    ID_Venda INT PRIMARY KEY,
    Data_Venda DATE,
    ID_Cliente INT,
    ID_Produto INT,
    Quantidade_Vendida INT,
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

-- Criação da tabela Pedidos
CREATE TABLE relacional.Pedidos (
    ID_Pedido INT PRIMARY KEY,
    Data_Pedido DATE,
    ID_Cliente INT,
    Status_Pedido VARCHAR(20),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)

);

-- Criação da tabela Categorias de Produtos
CREATE TABLE relacional.Categorias_Produtos (
    ID_Categoria INT PRIMARY KEY,
    Nome_Categoria VARCHAR(50)
);

-- Criação da tabela Avaliacoes de Produtos
CREATE TABLE relacional.Avaliacoes_Produtos (
    ID_Avaliacao INT PRIMARY KEY,
    ID_Produto INT,
    Comentario TEXT,
    Classificacao INT,
    Data_Avaliacao DATE,
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

-- Criação da tabela Funcionarios
CREATE TABLE relacional.Funcionarios (
    ID_Funcionario INT PRIMARY KEY,
    Nome_Funcionario VARCHAR(255),
    Cargo VARCHAR(50),
    Contato VARCHAR(255)
);

-- Criação da tabela Registros de Pagamentos
CREATE TABLE relacional.Registros_Pagamentos (
    ID_Pagamento INT PRIMARY KEY,
    ID_Pedido INT,
    Metodo_Pagamento VARCHAR(50),
    Valor_Pagamento DECIMAL(10, 2),
    Data_Pagamento DATE,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido)
);



select * from relacional.estados;


-- Criação da tabela Enderecos_Entrega
CREATE TABLE relacional.Enderecos_Entrega (
    ID_Endereco_Entrega INT PRIMARY KEY,
    ID_Cliente INT,
    Rua VARCHAR(255),
    Cidade VARCHAR(50),
    Estado VARCHAR(50),
    CEP VARCHAR(10),
    FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente),
    FOREIGN KEY (ID_Cidade) REFERENCES Cidades(ID_Cidade)
);


-- Crie a tabela Estados
CREATE TABLE Relacional.Estados (
    ID_Estado INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Estado VARCHAR(50) NOT NULL,
    Sigla_Estado VARCHAR(2) NOT NULL
);

-- Crie a tabela Cidades
CREATE TABLE Relacional.Cidades (
    ID_Cidade INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Cidade VARCHAR(255) NOT NULL,
    ID_Estado INT,
    FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado)
);

INSERT INTO Relacional.Estados (ID_Estado, Nome_Estado, Sigla_Estado)
VALUES (1, 'São Paulo', 'SP');

INSERT INTO Relacional.Cidades(ID_Cidade, Nome_Cidade, ID_Estado)
VALUES (1, 'São Paulo', 1);


-- Crie a tabela Enderecos_Entrega
CREATE TABLE Relacional.Enderecos_Entrega (
    ID_Endereco_Entrega INT AUTO_INCREMENT PRIMARY KEY,
    ID_Cliente INT,
    Rua VARCHAR(255),
    ID_Cidade INT,
    CEP VARCHAR(10),
    FOREIGN KEY (ID_Cidade) REFERENCES Cidades(ID_Cidade),
	FOREIGN KEY (ID_Cliente) REFERENCES Clientes(ID_Cliente)
    -- Outros campos relevantes
);

INSERT INTO Relacional.Enderecos_Entrega(ID_Endereco_Entrega, ID_Cliente, Rua, ID_Cidade, CEP)
VALUES (1, 1, 'Rua Pedro Alvares, 123', 1, '12367-190');

select * from relacional.Enderecos_Entrega;


-- Inserção de dados  na tabela Clientes
INSERT INTO relacional.Clientes (ID_Cliente, Nome_Cliente, Endereco, Email, Numero_Telefone)
VALUES
    (1, 'João Silva', '123 Rua Principal', 'joao@email.com', '(11) 1234-5678'),
    (2, 'Maria Santos', '456 Avenida Secundária', 'maria@email.com', '(22) 9876-5432');

-- Inserção de dados  na tabela Produtos
INSERT INTO relacional.Produtos (ID_Produto, Nome_Produto, Descricao, Preco, Categoria)
VALUES
    (1, 'Smartphone Modelo X', 'Um smartphone de última geração', 999.99, 'Eletrônicos'),
    (2, 'Notebook Ultrabook', 'Um poderoso notebook para trabalho e entretenimento', 1499.99, 'Computadores');

-- Inserção de dados  na tabela Estoque
INSERT INTO relacional.Estoque (ID_Estoque, ID_Produto, Quantidade_Em_Estoque)
VALUES
    (1, 1, 50),
    (2, 2, 20);

-- Inserção de dados  na tabela Vendas
INSERT INTO relacional.Vendas (ID_Venda, Data_Venda, ID_Cliente, ID_Produto, Quantidade_Vendida)
VALUES
    (1, '2023-09-13', 1, 1, 2),
    (2, '2023-09-14', 2, 1, 1),
    (3, '2023-09-14', 1, 2, 3);

-- Inserir um pedido
INSERT INTO relacional.Pedidos (ID_Pedido, Data_Pedido, ID_Cliente, Status_Pedido)
VALUES (1, '2023-09-13', 1, 'Em andamento');

-- Inserir outro pedido
INSERT INTO relacional.Pedidos (ID_Pedido, Data_Pedido, ID_Cliente, Status_Pedido)
VALUES (2, '2023-09-14', 2, 'Concluído');

-- Inserir categorias de produtos
INSERT INTO relacional.Categorias_Produtos (ID_Categoria, Nome_Categoria)
VALUES (1, 'Eletrônicos');

INSERT INTO relacional.Categorias_Produtos(ID_Categoria, Nome_Categoria)
VALUES (2, 'Roupas');

INSERT INTO relacional.Categorias_Produtos(ID_Categoria, Nome_Categoria)
VALUES (3, 'Esportes');
select * from relacional.Categorias_Produtos;

INSERT INTO relacional.Avaliacoes_Produtos (ID_Avaliacao, ID_Produto, Comentario, Classificacao, Data_Avaliacao)
VALUES (1, 1, 'Ótimo produto!', 5, '2023-09-13');

INSERT INTO relacional.Avaliacoes_Produtos (ID_Avaliacao, ID_Produto, Comentario, Classificacao, Data_Avaliacao)
VALUES (2, 1, 'Bom produto!', 3, '2023-09-13');

INSERT INTO relacional.Avaliacoes_Produtos (ID_Avaliacao, ID_Produto, Comentario, Classificacao, Data_Avaliacao)
VALUES (3, 1, 'Péssimo produto!', 1, '2023-09-13');


INSERT INTO relacional.Funcionarios (ID_Funcionario, Nome_Funcionario, Cargo, Contato)
VALUES (1, 'Joselito Silva', 'Atendente de Vendas', 'joao@email.com');

INSERT INTO relacional.Funcionarios (ID_Funcionario, Nome_Funcionario, Cargo, Contato)
VALUES (2, 'Carolina Santos', 'Gerente de Loja', 'maria@email.com');

-- Inserir registros de pagamentos
INSERT INTO relacional.Registros_Pagamentos (ID_Pagamento, ID_Pedido, Metodo_Pagamento, Valor_Pagamento, Data_Pagamento)
VALUES (1, 1, 'Cartão de Crédito', 100.00, '2023-09-13');

INSERT INTO relacional.Registros_Pagamentos (ID_Pagamento, ID_Pedido, Metodo_Pagamento, Valor_Pagamento, Data_Pagamento)
VALUES (2, 2, 'Pix', 75.50, '2023-09-14');

ALTER TABLE Enderecos_Entrega
ADD COLUMN ID_Estado INT,
ADD FOREIGN KEY (ID_Estado) REFERENCES Estados(ID_Estado);




INSERT INTO Enderecos_Entrega (ID_Enderecos_Entrega, ID_Cliente, Rua, Cidade, Estado, CEP)
VALUES (1, 1, 'Rua A, 123', 'São Paulo', 'SP', '12345-678');

INSERT INTO Enderecos_Entrega (ID_Enderecos_Entrega, ID_Cliente, Rua, Cidade, Estado, CEP)
VALUES (2, 2, 'Rua B, 456', 'Santos', 'SP', '98765-432');


SELECT * FROM relacional.Registros_Pagamentos;

select * from relacional.Vendas;

-- a. Listar todas as vendas realizadas em um determinado período de tempo:
SELECT * FROM relacional.Vendas as a WHERE a.Data_Venda BETWEEN '2023-09-01' AND '2023-09-30';

select * from relacional.Produtos;


CREATE TABLE relacional.Itens_Pedido (
    ID_Item INT AUTO_INCREMENT PRIMARY KEY,
    ID_Pedido INT,
    ID_Produto INT,
    Quantidade INT,
    FOREIGN KEY (ID_Pedido) REFERENCES Pedidos(ID_Pedido),
    FOREIGN KEY (ID_Produto) REFERENCES Produtos(ID_Produto)
);

DELETE FROM relacional.Itens_Pedido WHERE ID_Item = 1;

DELETE FROM relacional.Itens_Pedido WHERE ID_Item = 2;

INSERT INTO relacional.Itens_Pedido (ID_Item, ID_Pedido, ID_Produto,Quantidade )
VALUES(1, 1, 1, 2);

INSERT INTO relacional.Itens_Pedido (ID_Item, ID_Pedido, ID_Produto,Quantidade )
VALUES(2, 2, 2, 1);

select * from relacional.pedidos;

select * from relacional.produtos;

select * from relacional.Itens_Pedido;

select * from relacional.VENDAS;

-- b. Calcular o valor total de vendas em um mês específico (por exemplo, SETEMBRO de 2023):
SELECT SUM(preco * quantidade_vendida) AS total_vendas
FROM relacional.Vendas
JOIN relacional.Produtos ON Vendas.id_produto = Produtos.id_produto
WHERE EXTRACT(MONTH FROM data_venda) = 9 AND EXTRACT(YEAR FROM data_venda) = 2023;



-- c. Identificar os produtos mais vendidos em um determinado mês (por exemplo, setembro de 2023):
-- mostrar os produtos vendidos
SELECT
    P.ID_Produto,
    P.Nome_Produto,
    P.PRECO,
    SUM(V.Quantidade_Vendida) AS Total_Vendido
  
FROM
    RELACIONAL.Produtos P
JOIN
   RELACIONAL.Vendas V ON P.ID_Produto = V.ID_Produto
   WHERE EXTRACT(MONTH FROM Data_venda) = 9 AND EXTRACT(YEAR FROM Data_venda) = 2023
GROUP BY
    P.ID_Produto, P.Nome_Produto;
SELECT * FROM Relacional.Vendas

-- d. Encontrar os clientes que fizeram compras em um mês específico (por exemplo, janeiro de 2023):
SELECT DISTINCT Clientes.ID_cliente
FROM RELACIONAL.Vendas
JOIN RELACIONAL.Clientes ON Vendas.id_cliente = Clientes.id_cliente
WHERE EXTRACT(MONTH FROM data_venda) = 9 AND EXTRACT(YEAR FROM data_venda) = 2023;

