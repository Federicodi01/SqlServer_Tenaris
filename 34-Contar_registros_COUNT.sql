if object_id ('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  primary key(codigo)
);

go

insert into libros values
('El aleph','Borges','Emece',15.90),
('Antología poética','J. L. Borges','Planeta',null),
('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90),
('Matematica estas ahi','Paenza','Siglo XXI',15),
('Martin Fierro','Jose Hernandez',default,40),
('Aprenda PHP','Mario Molina','Nuevo siglo',null),
('Uno','Richard Bach','Planeta',20);

-- Averiguemos la cantidad de libros usando la función "count()":
select count(*) as 'Cantidad de libros' from libros;

-- Contamos los libros de editorial "Planeta":
select count(*) from libros where editorial='Planeta';

-- Contamos los registros que tienen precio (sin tener en cuenta los que tienen valor nulo):
select count(precio) as 'Libros con precio' from libros;
