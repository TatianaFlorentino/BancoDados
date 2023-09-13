
-- b. selecionar vendas em um mês específico (por exemplo, SETEMBRO de 2023):

SELECT * FROM relacional.Vendas
WHERE data_venda BETWEEN '2023-09-01' AND '2023-09-30';

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

