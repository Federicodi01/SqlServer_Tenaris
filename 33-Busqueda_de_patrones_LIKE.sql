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
('Aprenda PHP','Mario Molina','Nuevo siglo',56.50);

select * from libros;

-- Recuperamos todos los libros que contengan en el campo "autor" la cadena "Borges":
select * from libros where autor like '%Borges%';

-- Seleccionamos los libros cuyos títulos comienzan con la letra "M":
select * from libros where titulo like 'M%';

-- Seleccionamos todos los títulos que NO comienzan con "M":
select * from libros where titulo not like 'M%';

-- Si queremos ver los libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt":
select * from libros where autor like '%Carrol_'; 

-- Buscamos los libros cuya editorial comienza con las letras entre la "P" y la "S":
select * from libros where editorial like '[p-s]%'

-- Seleccionamos los libros cuya editorial NO comienza con las letras "P" ni "N":
select * from libros where editorial like '[^pn]%'

-- Recuperamos todos los libros cuyo precio se encuentra entre 10.00 y 19.99:
select * from libros where precio like '1_.%';

-- Recuperamos los libros que NO incluyen centavos en sus precios:
select * from libros where precio like '%.00'