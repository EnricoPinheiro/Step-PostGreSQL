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

ALTER TABLE produtos ADD CONSTRAINT produtos_pk PRIMARY KEY(cod_prod);--adicionamos uma chava primaria

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

ALTER TABLE pedidos ADD CONSTRAINT pedidos_cliente_id_fk FOREIGN KEY(cliente_id) REFERENCES clientes(id_cliente);

--garante a conscistencia de dados -> Duas validações tanto na remoção e na inserção
================== chave estrangeira ========
Sabemos que a chave estrangeira não permite a criação de pedidos não relacionados com algum produto. 
Porém, o que acontece se um produto for removido após a criação de um pedido fazendo referência a este produto? 
A linguagem SQL permite tratar esta situação também. Intuitivamente temos algumas opções: 
 
cliente tem um pedido -> um pra um -> one to one
pedidos tem varios itens -> Many ToMany -> tabela intermediaria que faz referencia a outras tabelas.

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

SELECT * FROM produtos WHERE categoria = 'Eletrodomestico';-- bucou pela categoria
SELECT * FROM produtos WHERE nome = 'Bicicleta';-- buscou pela categoria
SELECT nome,categoria FROM produtos;-- apenas as colunas
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













