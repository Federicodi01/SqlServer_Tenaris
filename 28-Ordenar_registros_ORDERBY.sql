if object_id ('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  primary key (codigo)
);

go

insert into libros (titulo,autor,editorial,precio) values
('El aleph','Borges','Emece',25.33),
('Java en 10 minutos','Mario Molina','Siglo XXI',50.65),
('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.95),
('Alicia en el pais de las maravillas','Lewis Carroll','Planeta',15);

-- Recuperamos los registros ordenados por el título:
select * from libros order by titulo;

-- Ordenamos los registros por el campo "precio", referenciando el campo por su posición en la lista de selección:
select titulo, autor, precio from libros order by 3;

-- Los ordenamos por "editorial", de mayor a menor empleando "desc":
select * from libros order by editorial desc;

-- Ordenamos por dos campos:
select * from libros order by titulo, editorial;

-- Ordenamos en distintos sentidos:
select * from libros order by titulo desc, editorial asc;

-- Ordenamos por un campo que no se lista en la selección:
select titulo, autor from libros order by precio asc;

-- Ordenamos por un valor calculado:
select titulo, autor, editorial, precio, precio-(precio*0.1) as 'Precio con DTO' from libros order by 4 asc;