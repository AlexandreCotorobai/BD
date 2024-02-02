-- g)

-- SELECT DISTINCT pub_name
-- FROM (SELECT p.pub_id, pub_name
--     FROM publishers p
--     JOIN titles t ON p.pub_id = t.pub_id
--     WHERE t.type = 'business')
--     AS suby;

-- k)

-- SELECT au_fname as 'First name', au_lname as 'Last name'
-- FROM authors, titles, titleauthor
-- WHERE authors.au_id = titleauthor.au_id and titles.title_id = titleauthor.title_id
-- GROUP BY au_lname, au_fname HAVING count(DISTINCT titles.type) > 1;


-- p) Obter uma lista que incluía o número de vendas de um título (ytd_sales), o seu nome,
-- o nome de cada autor, o valor da faturação de cada autor e o valor da faturação
-- relativa à editora;

-- SELECT titles.title, titles.ytd_sales, authors.au_fname, authors.au_lname,     
--     SUM(sales.qty * titles.price * titleauthor.royaltyper / 100.0) AS author_revenue,
--     SUM(sales.qty * titles.price * (1 - titleauthor.royaltyper / 100.0)) AS publisher_revenue 
-- FROM titles 
-- INNER JOIN titleauthor ON titles.title_id = titleauthor.title_id 
-- INNER JOIN authors ON titleauthor.au_id = authors.au_id 
-- INNER JOIN sales ON titles.title_id = sales.title_id
-- INNER JOIN publishers ON titles.pub_id = publishers.pub_id

-- GROUP BY titles.title, titles.ytd_sales, authors.au_fname, authors.au_lname;


-- q) Lista de lojas que venderam pelo menos um exemplar de todos os livros;

-- SELECT stores.stor_name
-- FROM stores
-- LEFT JOIN sales ON stores.stor_id = sales.stor_id
-- LEFT JOIN titles ON sales.title_id = titles.title_id
-- GROUP BY stores.stor_name
-- HAVING COUNT(DISTINCT titles.title_id) = (SELECT COUNT(*) FROM titles);



------r)

-- SELECT stores.stor_name, SUM(sales.qty) AS total_sales
-- FROM stores
-- JOIN sales ON stores.stor_id = sales.stor_id
-- GROUP BY stores.stor_name
-- HAVING SUM(sales.qty) > (SELECT AVG(total_sales) FROM 
-- (SELECT SUM(s.qty) AS total_sales FROM sales s GROUP BY s.stor_id) AS store_sales);


--- s) Nome dos títulos que nunca foram vendidos na loja “Bookbeat”;
-- SELECT titles.title
-- FROM titles
-- LEFT JOIN sales ON titles.title_id = sales.title_id AND sales.stor_id = 'Bookbeat'
-- -- WHERE sales.stor_id IS NULL;
-- GROUP BY titles.title;


-- t) Para cada editora, a lista de todas as lojas que nunca 
--    venderam títulos dessa editora;

-- SELECT DISTINCT publishers.pub_name, stores.stor_name
-- FROM publishers, stores, titles
-- WHERE publishers.pub_id = titles.pub_id
-- AND stores.stor_id NOT IN (
--   SELECT sales.stor_id
--   FROM sales
--   WHERE sales.title_id IN (
--     SELECT title_id
--     FROM titles
--     WHERE titles.pub_id = publishers.pub_id
--   )
-- )


