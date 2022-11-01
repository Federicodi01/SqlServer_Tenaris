if object_id ('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  cantidad tinyint default 0,
  primary key (codigo)
);

go

insert into libros (titulo,autor,editorial,precio, cantidad) values
('El aleph','Borges','Emece',25, default),
('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100),
('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

select * from libros;

-- Mostramos s�lo los 12 primeros caracteres de los t�tulos de los libros y sus autores, empleando la funci�n "substring()":
select SUBSTRING(titulo,1,12) as titulo from libros;

-- Mostramos s�lo los 12 primeros caracteres de los t�tulos de los libros y sus autores, ahora empleando la funci�n "left()":
select LEFT(titulo, 12) as titulo, left(autor, 12) as autores from libros;

-- Mostramos los t�tulos de los libros y sus precios convirtiendo este �ltimo a cadena de caracteres con un solo decimal, empleando la funci�n "str":
select titulo, str(precio, 6, 1) as precio from libros;

-- Mostramos los t�tulos de los libros y sus precios convirtiendo este �ltimo a cadena de caracteres especificando un solo argumento:
select titulo, str(precio) from libros;

-- Mostramos los t�tulos, autores y editoriales de todos libros, al �ltimo campo lo queremos en may�sculas:
select titulo, autor, upper(editorial) from libros;