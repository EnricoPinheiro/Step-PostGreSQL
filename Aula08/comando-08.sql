
se for desejado aumentar o preço de todos os produtos em 10% pode ser utilizado:  
UPDATE produtos SET preco = preco * 1.10; 


============= Tipos de dado ===================

Nome : bigint               descrição : inteiro de 8 bytes
Nome : bigserial            descrição : inteiro de 8 bytes com auto-incremento -> inseri a numeração automaticamente
Nome : bit                  descrição : cadeia de bits de comprimento fixo
Nome : bit varying          descrição : cadeia de bits de comprimento variavel
Nome : boolean              descrição : booleano lógico(verdadeiro\falso)
Nome : box                  descrição : caixa retangular no plano
Nome : bytea                descrição : dados binários("matriz de bytes")
Nome : character varying    descrição : cadeia de caracteres de comprimento variável 
Nome : character            descrição : cadeia de caracteres de comprimento fixo 
Nome : cidr                 descrição : endereço de rede IPv4 ou IPv6
Nome : date                 descrição : data de calendário (ano, mês, dia)
Nome : double precision     descrição : número de ponto flutuante de precisão dupla _ precisão de 15 dígitos decimais
Nome : inet                 descrição : endereço hospedeiro IPv4 ou IPv6
Nome : money                descrição : quantia monetária
Nome : real                 descrição : número de ponto flutuante de precisão simples - precisão de 6 dígitos decimais 
Nome : smallint             descrição : inteiro de dois bytes com sinal _ -32768 a +32767 
Nome : serial               descrição : inteiro de quatro bytes com auto-incremento _ 1 a 2147483647 
Nome : text                 descrição : cadeia de caracter de comrimento variavel
Nome : time                 descrição : hora do dia
Nome : time  with time zone descrição : hora do dia, incluindo a zona horária
Nome : timestamp            descrição : data e hora
Nome : integer              descrição : número - -2147483648 a +2147483647 
Nome : decimal              descrição : sem limite
Nome : numeric              descrição : sem limite


=========== Tipo inteiros =======
Os tipos smallint, integer e bigint armazenam números inteiros, ou seja, 
números sem a parte fracionária, com faixas diferentes. 
A tentativa de armazenar um valor fora da faixa permitida resulta em erro. 

O tipo integer é a escolha usual, porque oferece o melhor equilíbrio entre faixa de valores, 
tamanho de armazenamento e desempenho. Geralmente o tipo smallint só é utilizado 
quando o espaço em disco está muito escasso. O tipo bigint somente deve ser usado 
quando a faixa de valores de integer não for suficiente, porque este último é bem mais rápido

O tipo bigint pode não funcionar de modo correto em todas as plataformas, 
porque depende de suporte no compilador para inteiros de oito bytes. 
Nas máquinas sem este suporte, o bigint age do mesmo modo que o integer (mas ainda ocupa oito bytes de armazenamento). 
Entretanto, não é de nosso conhecimento nenhuma plataforma razoável onde este caso se aplique. 

O padrão SQL somente especifica os tipos inteiros integer (ou int) e smallint. 
O tipo bigint, e os nomes de tipo int2, int4 e int8 são extensões, 
também compartilhadas por vários outros sistemas de banco de dados SQL


=======  Números com precisão arbitrária  =================

O tipo numeric pode armazenar números com precisão de até 1.000 dígitos e realizar cálculos exatos. 
É recomendado, especialmente, para armazenar quantias monetárias e outras quantidades onde se requeira exatidão.
Entretanto, a aritmética em valores do tipo numeric é muito lenta se comparada com os tipos inteiros, 
ou com os tipos de ponto flutuante.

======================== utilização de letras acentuadas em nomes de tabelas ========================
drop TABLE AÇÃO;
drop TABLE ação;
drop TABLE "AÇÃO";

CREATE TABLE "AÇÃO"(
cod_ação int,
nome_ação text
);

\dt "ação"
aÇÃo não foi convertida em minúsculo por causa do idioma C

SELECT name, setting FROM pg_settings WHERE name LIKE 'lc%';


=================== Restrição de não-nulo =================

Uma restição de não-nulo simplesmente que uma coluna não pode assumir o valor nulo.

CREATE TABLE produtos {
cod_prod INTEGER NOT NULL, -- valor na coluna obrigatoria
nome     text    NOT NULL,
preco    NUMERIC
);

A restrição de não-nulo é sempre escrita como restrição de coluna.  


 













