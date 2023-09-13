--a. Identificar os clientes que fizeram compras nos últimos três meses:
SELECT DISTINCT Clientes.nome_cliente
FROM relacional.Vendas
JOIN relacional.Clientes ON Vendas.id_cliente = Clientes.id_cliente
WHERE data_venda >= DATE_SUB(CURRENT_DATE(), INTERVAL 3 MONTH);


-- b. Encontrar os clientes que não fizeram compras nos últimos seis meses:
SELECT DISTINCT Clientes.nome_cliente
FROM relacional.Clientes
LEFT JOIN relacional.Vendas ON Clientes.id_cliente = Vendas.id_cliente
WHERE Vendas.id_venda IS NULL OR data_venda < DATE_SUB(CURRENT_DATE(), INTERVAL 6 MONTH);

-- c. Calcular a quantidade total de compras feitas por cada cliente:

SELECT Clientes.nome_cliente, SUM(Vendas.quantidade_vendida) AS total_compras
FROM relacional.Vendas
JOIN relacional.Clientes ON Vendas.id_cliente = Clientes.id_cliente
GROUP BY Clientes.nome_cliente;

-- d. Listar os clientes com base no número de compras feitas (clientes frequentes):
SELECT Clientes.nome_cliente, COUNT(Vendas.id_venda) AS numero_compras
FROM relacional.Vendas
JOIN relacional.Clientes ON Vendas.id_cliente = Clientes.id_cliente
GROUP BY Clientes.nome_cliente
ORDER BY numero_compras DESC;
