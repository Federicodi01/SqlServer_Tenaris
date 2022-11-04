if object_id('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(5,2),
  cantidad tinyint,
  primary key(codigo)
);

go

insert into libros values
('El aleph','Borges','Planeta',35,null),
('Martin Fierro','Jose Hernandez','Emece',22.20,200),
('Martin Fierro','Jose Hernandez','Planeta',40,200),
('Antologia poetica','J.L. Borges','Planeta',null,150),
('Antologia poetica','J.L. Borges','Planeta',null,150),
('Manual de PHP', 'J.C. Paez', 'Siglo XXI',56,120),
('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100),
('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90),
('Harry Potter y la camara secreta','J.K. Rowling','Emece',null,100),
('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',42,80),
('PHP de la A a la Z',null,null,110,0),
('Uno','Richard Bach','Planeta',25,null);

select * from libros;

-- Cantidad de libros agrupados por editorial pero considerando sólo algunos grupos, los que devuelvan un valor mayor a 2:
select editorial, count(*) from libros group by editorial having count(*)>2;

-- Promedio de los precios de los libros agrupados por editorial, pero solamente de aquellos grupos cuyo promedio supere los 25 pesos:
select editorial, avg(precio) as Promedio from libros group by editorial having avg(precio)>25;

-- Cantidad de libros, sin considerar los que tienen precio nulo (where), agrupados por editorial (group by), sin considerar la editorial "Planeta" (having):
select editorial, count(*) from libros where precio is not null group by editorial having editorial<>'Planeta';

-- Promedio de los precios agrupados por editorial, de aquellas editoriales que tienen más de 2 libros:
select editorial, avg(precio) from libros group by editorial having count(*)>2;

-- Mayor valor de los libros agrupados y ordenados por editorial y seleccionamos las filas que tienen un valor menor a 100 y mayor a 30:
select editorial, max(precio) as mayor from libros group by editorial having max(precio)<100 and min(precio)>30 order by editorial; 