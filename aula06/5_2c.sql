USE geststocks

-- a)
-- π fornecedor.nif, fornecedor.nome (σ encomenda.numero=null (π nif,nome fornecedor⟕ (nif=fornecedor) π numero,fornecedor encomenda))

-- SELECT fornecedor.nif, fornecedor.nome
-- FROM fornecedor
-- LEFT JOIN encomenda ON fornecedor.nif = encomenda.fornecedor
-- WHERE encomenda.numero IS NULL

-- b)
-- γ codProd; avg(unidades)->TotalUnidades item

-- SELECT item.codProd, AVG(item.unidades) AS TotalUnidades
-- FROM item
-- GROUP BY item.codProd

-- c)
-- X = γ numEnc; count(codProd) -> totalProdutos item
-- γ avg(totalProdutos) -> AvgProd X~

-- SELECT AVG(Cast(X.totalProdutos AS FLOAT)) AS AvgProd
-- FROM (SELECT item.numEnc, COUNT(item.codProd) AS totalProdutos
--     FROM item
--     GROUP BY item.numEnc) AS X

-- d)
-- x = (π codigo,nome,unidades produto ⟕ codigo=codProd item) ⟕ numEnc=numero encomenda ⟕ encomenda.fornecedor=nif fornecedor
-- γ produto.nome,fornecedor.nome; sum(item.unidades)->TotalUnidades (x)

SELECT produto.nome, fornecedor.nome, SUM(item.unidades) AS TotalUnidades
FROM produto
INNER JOIN item ON produto.codigo = item.codProd
INNER JOIN encomenda ON item.numEnc = encomenda.numero
INNER JOIN fornecedor ON encomenda.fornecedor = fornecedor.nif
GROUP BY produto.nome, fornecedor.nome
