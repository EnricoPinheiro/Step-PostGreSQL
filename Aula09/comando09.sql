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

ALTER TABLE produtos ADD CONSTRAINT produtos_pk PRIMARY KEY(cod_prod);

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


