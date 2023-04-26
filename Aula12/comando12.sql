

====== Chave Primaria e chave estrangeira ======
A chava primaria indica que a coluna , ou grupo de colunas, pode ser utilizado 
como identificador único das linhas da tabela. Para gerar uma consistencia de dados.

CREATE TABLE produtos (
cod_prod INTEGER PRIMARY KEY,
nome text,
preco NUMERIC
);

INSERT INTO produtos (cod_prod,nome,preco)VALUES(1,'Bicicleta',2000.00);
INSERT INTO produtos (cod_prod,nome,preco)VALUES(2,'Camisa',200.00);

--duplicate key value violates unique constraint "produtos_pk"
DELETE FROM produtos WHERE cod_prod = 1;

===== CONECIMENTO SOBRE ALTER TABLE E ADD CONSTRAINT ============
ALTER TABLE produtos ADD CONSTRAINT produtos_pk PRIMARY KEY(cod_prod);--adicionamos uma chava primaria

============= CRIAÇÃO DA TABELA CLIENTES ================

CREATE TABLE clientes (
id_cliente INTEGER PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
email VARCHAR(150) NOT NULL UNIQUE,
cpf VARCHAR(11) NOT NULL UNIQUE,
endereco VARCHAR(200),
cidade VARCHAR(100),
estado VARCHAR(2),
data_aniversario DATE
);

SELECT * FROM clientes;

INSERT INTO clientes(id_cliente , nome, email, cpf, endereco, cidade, estado, data_aniversario)VALUES
(1,'Pedro','motta@hotmail.com','12345678911','Rua A , 10','Rio de Janeiro','RJ','1971-10-03');
INSERT INTO clientes(id_cliente , nome, email, cpf, endereco, cidade, estado, data_aniversario)VALUES
(2,'Erick','erick@hotmail.com','12345678912','Rua A , 10','Rio de Janeiro','RJ','1971-10-03');

-- duplicate key value violates unique constraint "clientes_email_key"

============= CRIAÇÃO DA TABELA PEDIDOS  one to Many =================
CREATE TABLE pedidos (
cod_pedido INTEGER PRIMARY KEY,
cliente_id INTEGER,
status VARCHAR(30),
data DATE,
endereco_entrega VARCHAR(200)
);

INSERT INTO pedidos(cod_pedido,cliente_id,status, data, endereco_entrega)VALUES
(1, 1,'Pendente','2022-03-20','Rua D, 150');

INSERT INTO pedidos(cod_pedido,cliente_id,status, data, endereco_entrega)VALUES
(2, 2,'Pendente','2022-02-10','Rua c, 100');

SELECT * FROM pedidos;

DELETE FROM pedidos WHERE cod_pedido = 1;

========= ADD CONSTRAINT DA FK DA TABELA CLIENTES =======================
ALTER TABLE pedidos ADD CONSTRAINT pedidos_cliente_id_fk FOREIGN KEY(cliente_id) REFERENCES clientes(id_cliente);

--garante a conscistencia de dados -> Duas validações tanto na remoção e na inserção
================== chave estrangeira ========
Sabemos que a chave estrangeira não permite a criação de pedidos não relacionados com algum produto. 
Porém, o que acontece se um produto for removido após a criação de um pedido fazendo referência a este produto? 
A linguagem SQL permite tratar esta situação também. Intuitivamente temos algumas opções: 
 
cliente tem um pedido -> um pra um -> one to Many
pedidos tem varios itens -> Many ToMany -> tabela intermediaria que faz referencia a outras tabelas.

================= CRIAÇÃO DA TABELA ITENS PEDIDOS Many ToMany ================

CREATE TABLE itens_pedidos (
cod_prod INTEGER REFERENCES produtos,
cod_pedido INTEGER REFERENCES pedidos,
quantidade INTEGER,
--PRIMARY KEY (cod_prod, cod_pedido)
CONSTRAINT itens_pedidos_pk PRIMARY KEY(cod_prod, cod_pedido),
CONSTRAINT itens_cod_pedidos_fk FOREIGN KEY (cod_pedido) REFERENCES  pedidos(cod_pedido),
CONSTRAINT itens_pedidos_cod_prod_fk FOREIGN KEY (cod_prod) REFERENCES  produtos(cod_prod)
);

INSERT into itens_pedidos(cod_prod, cod_pedido, quantidade)VALUES(1,2,60)


====== Relacionamento ======= Tipo de banco de dados utilizado Relacional ===

Um-Para-Um (One-to-One)
Um-Para-Muitos (One-to-Many)
Muitos-Para-Muitos (Many-to-Many)

=====================================

inserir na tabela produtos duas colunas :
categoria, descrição

UPDATE produtos SET descricao = 'Pente masculino para todo tipo de cabelos' ;

UPDATE table_name SET column1; 

ALTER TABLE produtos RENAME COLUMN <nome_da_coluna_a_ser_alterada> TO <nome_da_nova_coluna>;


========== Filtros registros produtos ==========

SELECT * FROM produtos WHERE categoria = 'Eletrodomestico';-- buscou pela categoria
SELECT * FROM produtos WHERE nome = 'Bicicleta';-- buscou pelo nome do produto
SELECT nome,categoria FROM produtos;-- apenas as colunas, que estão citadas
SELECT * FROM produtos WHERE cod_prod = 2;-- busca pelo id


SELECT * FROM produtos WHERE preco > 1000; --busca o preço maior que 100
SELECT * FROM produtos WHERE preco >= 1000; --busca o preço maior ou igual a 100
SELECT * FROM produtos WHERE preco >= 1000 and preco < 2000; -- preco entre 1000 e 2000
SELECT * FROM produtos ORDER BY preco asc;-- ordena pelo mais barato
SELECT * FROM produtos ORDER BY preco desc;-- ordena pelo mais caro


============== Filtros registros clientes ===================
SELECT * FROM clientes WHERE data_aniversario >= '1971-10-03' and data_aniversario <= '1977-06-15'; --Periodo
SELECT * FROM clientes WHERE data_aniversario >= '1971-01-01' and data_aniversario <= '1990-01-01';
SELECT * FROM clientes WHERE estado = 'SP' or estado = 'MG';
SELECT * FROM clientes ORDER BY id_cliente ;-- já está ordenado pela ordem crscente
SELECT * FROM clientes ORDER BY id_cliente asc;
SELECT * FROM clientes ORDER BY id_cliente desc;
SELECT * FROM clientes ORDER BY data_aniversario desc;-- do mais novo para o mais antigo
SELECT * FROM clientes ORDER BY data_aniversario ;-- do mais antigo para o mais novo


========================= Junção de tabelas inner join ================================

SELECT * FROM pedidos;


--retorna os pedidos correspondentes aos clientes que possuem pedidos.
SELECT * FROM pedidos p 
inner join clientes c on p.cliente_id = c.id_cliente;


-- retornar cod_pedido, nome e data
SELECT pe.cod_pedido, cl.nome , pe.data
FROM pedidos pe 
inner Join clientes cl on pe.cliente_id = cl.id_cliente;

======  renomear coluna =========
SELECT pe.cod_pedido, cl.nome as nome_cliente , pe.data
FROM pedidos pe 
inner Join clientes cl on pe.cliente_id = cl.id_cliente;

======= Junção de tabelas left join ======================
SELECT c.nome as nome_cliente , c.email, c.cidade, p.cod_pedido, p.data
FROM clientes c 
left Join pedidos p on c.id_cliente = p.cod_pedido;

======= Junção de tabelas right join ======================
SELECT c.nome as nome_cliente , c.email, c.cidade, p.cod_pedido, p.data
FROM pedidos p 
right Join clientes c on p.cod_pedido = c.id_cliente;

========= full join ==========
SELECT pe.cod_pedido, cl.nome as nome_cliente , pe.data
FROM pedidos pe 
full Join clientes cl on pe.cliente_id = cl.id_cliente;


========= self join ========================

SELECT c1.nome, c2.nome, c1.cidade
FROM clientes c1, clientes c2
WHERE c1.id_cliente <> c2.id_cliente
and c1.cidade = c2.cidade;

-- não é utilizado no dia dia


============  Junção de clientes, pedidos e produtos ========= 
SELECT * from itens_pedidos;

-- retorna apenas os pedidos relacionados a clientes, produtos e intens pedidos  
SELECT p.cod_pedido, p.data, c.nome, pr.nome as nome_produto, pr.preco
FROM pedidos p 
inner join clientes c on p.cliente_id = c.id_cliente
left join itens_pedidos ip on p.cod_pedido = ip.cod_prod
inner join produtos pr on ip.cod_prod = p.cod_pedido;

===========================  preco multiplicado pela quantidade =======================
SELECT p.cod_pedido, p.data, c.nome, pr.nome as nome_produto, pr.preco * ip.quantidade
FROM pedidos p 
inner join clientes c on p.cliente_id = c.id_cliente
left join itens_pedidos ip on p.cod_pedido = ip.cod_prod
inner join produtos pr on ip.cod_prod = p.cod_pedido;

====== renomear coluna total_protudos_preco ====================
SELECT p.cod_pedido, p.data, c.nome, pr.nome as nome_produto, pr.preco,(pr.preco * ip.quantidade) as total_protudos_preco
FROM pedidos p 
inner join clientes c on p.cliente_id = c.id_cliente
left join itens_pedidos ip on p.cod_pedido = ip.cod_prod
inner join produtos pr on ip.cod_prod = p.cod_pedido;

=================== sum =================== 

--- soma total de valores em stock 
SELECT sum(preco) from produtos;

---total de itens pedidos 
SELECT sum(quantidade) FROM itens_pedidos;

--retorna valores entre 500 e 1500
SELECT * from produtos
WHERE preco BETWEEN 500 and 1500;
--retorna pedidos entre datas

SELECT * from pedidos p
WHERE p.data BETWEEN '2022-02-01' and '2022-03-31';















