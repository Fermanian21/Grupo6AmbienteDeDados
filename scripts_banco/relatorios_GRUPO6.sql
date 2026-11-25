USE loja_cenario6;

-- ==========================================================
-- 1. Vendas por Estado (Último Mês - últimos 30 dias)
-- ==========================================================
SELECT
    e.estado                                      AS estado,
    SUM(iv.quantidade)                            AS total_unidades_vendidas,
    SUM(iv.quantidade * iv.preco_unitario_venda)  AS valor_total_vendido
FROM venda v
JOIN endereco_cliente e ON e.id_endereco = v.id_endereco
JOIN item_venda iv      ON iv.id_venda   = v.id_venda
WHERE v.data_venda >= CURDATE() - INTERVAL 30 DAY
GROUP BY e.estado
ORDER BY valor_total_vendido DESC;

-- ==========================================================
-- 2. Melhores Clientes e Ticket Médio (Último Ano - 12 meses)
-- ==========================================================
SELECT
    c.nome                                                       AS nome_cliente,
    SUM(iv.quantidade * iv.preco_unitario_venda)                 AS valor_total_gasto,
    ROUND(SUM(iv.quantidade * iv.preco_unitario_venda)
          / COUNT(DISTINCT v.id_venda), 2)                       AS ticket_medio
FROM cliente c
JOIN venda v       ON v.id_cliente = c.id_cliente
JOIN item_venda iv ON iv.id_venda  = v.id_venda
WHERE v.data_venda >= CURDATE() - INTERVAL 12 MONTH
GROUP BY c.id_cliente, c.nome
ORDER BY valor_total_gasto DESC
LIMIT 10;

-- ==========================================================
-- 3. Produtos Mais Vendidos por Tipo
-- ==========================================================
SELECT
    p.tipo                                   AS tipo_produto,
    p.nome                                   AS nome_produto,
    SUM(iv.quantidade)                       AS total_unidades_vendidas,
    ROUND(AVG(iv.preco_unitario_venda), 2)   AS preco_medio_venda
FROM produto p
JOIN item_venda iv ON iv.id_produto = p.id_produto
GROUP BY p.tipo, p.id_produto, p.nome
ORDER BY p.tipo, total_unidades_vendidas DESC;

-- ==========================================================
-- 4. Rentabilidade de Produtos (Custo vs. Venda)
--    LEFT JOIN: inclui produtos ainda sem venda (valores NULL)
-- ==========================================================
SELECT
    p.nome                                                        AS nome_produto,
    p.valor_custo                                                 AS custo_aquisicao,
    ROUND(AVG(iv.preco_unitario_venda), 2)                        AS valor_medio_vendido,
    ROUND(AVG(iv.preco_unitario_venda) - p.valor_custo, 2)        AS lucro_medio_unidade,
    ROUND((AVG(iv.preco_unitario_venda) - p.valor_custo)
          / AVG(iv.preco_unitario_venda) * 100, 2)                AS margem_lucro_pct
FROM produto p
LEFT JOIN item_venda iv ON iv.id_produto = p.id_produto
GROUP BY p.id_produto, p.nome, p.valor_custo
ORDER BY margem_lucro_pct DESC;

-- ==========================================================
-- 5. Alerta de Estoque Baixo (SKUs Críticos)
--    Fornecedor principal = de quem mais se comprou (unidades) o item
-- ==========================================================
SELECT
    p.nome                    AS nome_produto,
    p.qtd_estoque             AS estoque_atual,
    p.qtd_minima_alvo         AS estoque_minimo,
    (SELECT MAX(c.data_compra)
       FROM item_compra ic
       JOIN compra c ON c.id_compra = ic.id_compra
      WHERE ic.id_produto = p.id_produto)          AS data_ultima_compra,
    (SELECT f.nome
       FROM item_compra ic
       JOIN compra c     ON c.id_compra     = ic.id_compra
       JOIN fornecedor f ON f.id_fornecedor = c.id_fornecedor
      WHERE ic.id_produto = p.id_produto
      GROUP BY f.id_fornecedor, f.nome
      ORDER BY SUM(ic.quantidade) DESC, f.nome
      LIMIT 1)                                     AS fornecedor_principal,
    CASE WHEN p.qtd_estoque = 0 THEN 'ESGOTADO'
         ELSE 'ABAIXO DO MÍNIMO' END                AS situacao
FROM produto p
WHERE p.qtd_estoque < p.qtd_minima_alvo
ORDER BY (p.qtd_minima_alvo - p.qtd_estoque) DESC;

-- ==========================================================
-- 6. Desempenho de Fornecedores (Custo e Prazo)
--    Prazo calculado só sobre compras já recebidas
-- ==========================================================
SELECT
    f.nome                                                    AS nome_fornecedor,
    ROUND(AVG(ic.valor_unitario_custo), 2)                    AS custo_medio,
    ROUND(AVG(DATEDIFF(c.data_recebimento, c.data_compra)), 1) AS tempo_medio_entrega_dias
FROM fornecedor f
JOIN compra c       ON c.id_fornecedor = f.id_fornecedor
JOIN item_compra ic ON ic.id_compra    = c.id_compra
GROUP BY f.id_fornecedor, f.nome
ORDER BY tempo_medio_entrega_dias;
