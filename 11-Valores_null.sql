if OBJECT_ID('libros') is not null drop table libros;

create table libros
(
  titulo varchar(30) not null,
  autor varchar(30) not null,
  editorial varchar(15) null,
  precio float
);

go

exec sp_columns libros;

select * from libros;

insert into libros (titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',null),
('Alicia en el pais','Lewis Carroll',null,0),
('Uno','Richard Bach','',18.50),
('','Richard Bach','Planeta',22)

select * from libros where precio is null;

select * from libros where precio=0;

select * from libros where editorial is null;

select * from libros where editorial='';

select * from libros where precio is not null;