if object_id('Libros') is not null drop table libros;

create table libros
(
  titulo varchar(30),
  autor varchar(20),
  editorial varchar(15)
);

go

insert into libros (titulo,autor,editorial) values 
('El aleph','Borges','Emece');

select * from libros; --mostramos los registros de libros
 
/*mostramos títulos y
nombres de los autores*/
select titulo, autor from libros;