/*
"go" es un signo de finalización de un lote de sentencias SQL. No es una sentencia, es un comando. El lote de sentencias está compuesto por todas las sentencias antes de "go" o todas las sentencias entre dos "go".

Las siguientes sentencias no pueden ejecutarse en el mismo lote: create rule, create default,create view, create procedure, create trigger. Cada una de ellas necesita ejecutarse separándolas con "go". Por ejemplo:
 create table....
 go
 create rule...
 go

Recuerde que si coloca "go" no debe incluir el "punto y coma" (;) al finalizar una instrucción.
*/