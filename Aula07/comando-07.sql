


CREATE TABLE produtos (
cod_prod INTEGER,
nome text,
preco NUMERIC DEFAULT 9.99

);

INSERT INTO produtos(cod_prod,nome,preco)VALUES(1,'Queijo',DEFAULT);
INSERT INTO produtos(nome,preco,cod_prod)VALUES('Pão',7.70,2);

UPDATE produtos SET preco = preco * 1.10; /**/

ALTER TABLE produtos ALTER COLUMN preco SET DEFAULT 8.50;

10.9890

========/*deletei o produto cujo o valor é igual a 10.9890*/======

DELETE FROM produtos WHERE preco = 10.9890; /*deletei o produto cujo o valor é igual a 10.9890*/

postgres=# DELETE FROM produtos WHERE preco = 10.9890;
DELETE 1
postgres=# select * from produtos;
 cod_prod | nome | preco
----------+------+--------
        2 | Pão  | 8.4700
(1 row)



CREATE TABLE produtos (
cod_prod INTEGER PRIMARY KEY ,
nome text not null,
preco NUMERIC DEFAULT 9.99

);
=============== inserir a chave primaria =================
1 - tropar a tabela produtos
2 - alterar a coluna cod_prod para chave primaria
3 - add a coluna descricao
4 - inserir dados na tabela

ALTER TABLE produtos ADD PRIMARY KEY (cod_prod);/*comando para atualizar a coluna cod_prod */

ALTER TABLE produtos ADD COLUMN descricao text, ALTER COLUMN descricao SET NOT NULL;

=========== passo para adicionar restrição a uma coluna =======
1 - deletar o conteudo da tabela produtos -> DELETE from produtos;
2 - deletar a coluna descricao -> ALTER TABLE produtos DROP COLUMN descricao ;
3 - add a coluna descricao com restricao not null -> ALTER TABLE produtos ADD COLUMN descricao text, ALTER COLUMN descricao SET NOT NULL;
4 - inserir dados na tabela -> INSERT INTO produtos(nome,preco,cod_prod,descricao)VALUES('Vinho',63.70,1, 'vinho tinto seco' );



postgres=# \d produtos;
               Table "public.produtos"
  Column   |  Type   | Collation | Nullable | Default
-----------+---------+-----------+----------+---------
 cod_prod  | integer |           | not null |
 nome      | text    |           |          |
 preco     | numeric |           |          | 9.99
 descricao | text    |           | not null |
Indexes:
    "produtos_pkey" PRIMARY KEY, btree (cod_prod)

INSERT INTO produtos(nome,preco,cod_prod,descricao)VALUES('Vinho',63.70,1, 'vinho tinto seco' );

ALTER TABLE produtos DROP COLUMN descricao ;

DELETE from produtos;


==================== AULA DB 07 ========================

CREATE TABLE produtos (
cod_prod INTEGER,
nome text,
preco NUMERIC CHECK(preco > 0) -- A restrição de verificação é formada pela palavra chave CHECK seguida por uma expressão entre parênteses.

);

DROP TABLE produtos ;-- não é obrogatório
ALTER TABLE produtos ADD CONSTRAINT check_preco_positivo CHECK(preco > 0);

CREATE TABLE produtos (
cod_prod INTEGER,
nome text,
preco NUMERIC CONSTRAINT check_preco_positivo CHECK (preco > 0) -- Portanto especificar o nome da restrição dever ser utilizado  a palavra chave CONSTRAINT

);

A expressão da restrição de verificação deve envolver a coluna sendo restringida, 
senão não fará muito sentido. Também pode ser atribuído um nome individual 
para a restrição. Isto torna mais clara a mensagem de erro, 
e permite fazer referência à restrição quando se desejar alterá-la. 

ALTER TABLE produtos ADD CONSTRAINT check_preco_com_desconto CHECK(preco_com_desconto > 0);

-- precisa existri a coluna preco com desconto
CREATE TABLE produtos (
cod_prod INTEGER,
nome text,
preco NUMERIC CHECK(preco > 0), -- Portanto especificar o nome da restrição dever ser utilizado  a palavra chave CONSTRAINT
preco_com_desconto NUMERIC CHECK (preco_com_desconto > 0),
CHECK (preco > preco_com_desconto)
);
SELECT * FROM produtos;


ALTER TABLE produtos ADD CONSTRAINTS preco_com_desconto CHECK (preco_com_desconto > 0);

CREATE TABLE produtos (
cod_prod INTEGER,
nome text,
preco NUMERIC CHECK(preco > 0),
preco_com_desconto NUMERIC CHECK(preco_com_desconto > 0) -- A restrição de verificação é formada pela palavra chave CHECK seguida por uma expressão entre parênteses.
);

============= tabela com restrição =========

CREATE TABLE produtos (
cod_prod INTEGER,
nome text,
preco NUMERIC CHECK(preco > 0), -- Portanto especificar o nome da restrição dever ser utilizado  a palavra chave CONSTRAINT
preco_com_desconto NUMERIC CHECK (preco_com_desconto > 0),
CHECK (preco > preco_com_desconto)
);

 WHERE data > '1994-11-28'; 

inserir na tabela produtos uma coluna com descrição do produto.
inserir na tabela produtos uma coluna com validade do produto.

INSERT INTO produtos VALUES(01,'Pente', 20.00, 18.00);
INSERT INTO produtos VALUES(02,'Camisa', 30.00, 28.00);
INSERT INTO produtos VALUES(02,'Bermuda', 18.00, 28.00);
ALTER TABLE produtos ADD CONSTRAINTS preco_com_desconto CHECK (preco_com_desconto > 1);



======== Restição de unicidade ===== 
 -- A restrição de inicidade garante que os dados contidos na coluna, 
 --ou grupo de colunas, é unico em ralçao a toas as outras linhas da tabela

CREATE TABLE produtos (
cod_prod INTEGER UNIQUE;
nome text,
preco NUMERIC

);

CREATE TABLE produtos (
cod_prod INTEGER ,
nome text,
preco NUMERIC
UNIQUE(cod_prod)

);

CREATE TABLE produtos (
a INTEGER ,
b INTEGER,
c INTEGER,
UNIQUE(a, b)

);


















