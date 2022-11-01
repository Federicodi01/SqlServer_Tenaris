if object_id('libros') is not null drop table libros;

create table libros(
  codigo smallint identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15),
  precio smallmoney,
  cantidad tinyint
);

go

-- Si ingresamos una cadena en el campo "cantidad" (lo convierte a valor numérico)
insert into libros (titulo,autor,editorial,precio,cantidad) values
('Uno','Richard Bach','Planeta',50.30,'100');

select * from libros;