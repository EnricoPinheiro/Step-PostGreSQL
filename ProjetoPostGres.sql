=== Banco de Dados - Projeto Canil ===

--- Criação das Tabelas ---

CREATE TABLE cachorros (
cod_cad INTEGER,
nome text,
genero text,
raca text
);

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

CREATE TABLE adocao (
id_cliente INTEGER,
cod_cad INTEGER,
status VARCHAR(30),
data DATE,
CONSTRAINT adocao_pk PRIMARY KEY(id_cliente, cod_cad),
CONSTRAINT adocao_cod_cad_fk FOREIGN KEY (cod_cad) REFERENCES cachorros(cod_cad),
CONSTRAINT adocao_id_cliente_fk FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

--- Alterações das tabelas --- 

ALTER TABLE cachorros ADD CONSTRAINT cachorros_pk PRIMARY KEY(cod_cad);

--- Populando as tabelas --- 

INSERT INTO clientes(id_cliente , nome, email, cpf, endereco, cidade, estado, data_aniversario)VALUES
(1,'Pedro','motta@hotmail.com','12345678911','Rua A , 10','Rio de Janeiro','RJ','1971-10-03');
INSERT INTO clientes(id_cliente , nome, email, cpf, endereco, cidade, estado, data_aniversario)VALUES
(2,'Erick','erick@hotmail.com','12345678912','Rua A , 10','Rio de Janeiro','RJ','1971-10-03');

INSERT INTO cachorros(cod_cad , nome, genero, raca)VALUES
(1,'Rex','Macho', 'Pitbull');
INSERT INTO cachorros(cod_cad , nome, genero, raca)VALUES
(2,'Tobby','Macho','Poddle');

