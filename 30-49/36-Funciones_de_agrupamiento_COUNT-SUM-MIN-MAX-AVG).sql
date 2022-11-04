if object_id('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30) default 'Desconocido',
  editorial varchar(15),
  precio decimal(5,2),
  cantidad tinyint,
  primary key(codigo)
);

go

insert into libros values
('El aleph','Borges','Planeta',15,null),
('Martin Fierro','Jose Hernandez','Emece',22.20,200),
('Antologia poetica','J.L. Borges','Planeta',null,150),
('Aprenda PHP','Mario Molina','Emece',18.20,null),
('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100),
('Manual de PHP', 'J.C. Paez', 'Siglo XXI',31.80,120),
('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90),
('Harry Potter y la camara secreta','J.K. Rowling','Emece',46.00,100);

insert into libros (titulo,autor,cantidad) values
('Alicia en el pais de las maravillas','Lewis Carroll',220),
('PHP de la A a la Z',default,0);

select * from libros;

-- Cantidad total de libros, sumamos las cantidades de cada uno:
select sum(cantidad) as 'Cantidad de libros' from libros; 

-- Para conocer cuántos libros tenemos de la editorial "Emece":
select sum(cantidad) as 'Cantidad de libros' from libros where editorial='Emece';

-- Queremos saber cuál es el libro más costoso:
select max(precio) as PrecioMAX from libros;

-- Para conocer el precio mínimo de los libros de "Rowling":
select min(precio) as PrecioMIN from libros where autor like '%Rowling%';

-- Queremos saber el promedio del precio de los libros referentes a "PHP":
select avg(precio) from libros where titulo like '%PHP%';