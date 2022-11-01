if OBJECT_ID('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15),
  precio float
);

go

insert into libros (titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',23);

select * from libros;

insert into libros (titulo,autor,editorial,precio) values
('Uno','Richard Bach','Planeta',18),
('Aprenda PHP','Mario Molina','Siglo XXI',45.60),
('Alicia en el pais de maravillas','Lewis Carroll','Paidos',15.50);

exec sp_columns libros;	

delete libros where autor='Lewis Carroll';

insert into libros (titulo,autor,editorial,precio) values
('Martin Fierro','Jose Hernandez','Paidos',25);