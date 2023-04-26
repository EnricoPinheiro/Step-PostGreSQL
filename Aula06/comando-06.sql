


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



