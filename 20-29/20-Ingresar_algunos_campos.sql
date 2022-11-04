if OBJECT_ID('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15)
);

go

-- Si ingresamos valores para todos los campos, podemos omitir la lista de campos:
insert into libros values
('Uno','Richard Bach','Planeta');

select * from libros;

-- Podemos ingresar valores para algunos de los campos:

insert into libros (titulo, autor) values 
('El aleph','Borges');

-- No podemos omitir el valor para un campo declarado "not null", como el campo "titulo" (GENERA ERROR):
insert into libros (autor,editorial) values 
('Lewis Carroll','Planeta');