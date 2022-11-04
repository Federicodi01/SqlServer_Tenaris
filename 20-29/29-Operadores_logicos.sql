if object_id ('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
);

go

insert into libros values
('El aleph','Borges','Emece',15.90),
('Antología poética','Borges','Planeta',39.50),
('Java en 10 minutos','Mario Molina','Planeta',50.50),
('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90),
('Martin Fierro','Jose Hernandez','Emece',25.90),
('Martin Fierro','Jose Hernandez','Paidos',16.80),
('Aprenda PHP','Mario Molina','Emece',19.50),
('Cervantes y el quijote','Borges','Paidos',18.40);

select * from libros;

-- Recuperamos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20 pesos:
select * from libros where autor='Borges' AND precio<=20;

-- Seleccionamos los libros cuyo autor es "Borges" y/o cuya editorial es "Planeta":
select * from libros where autor='Borges' OR editorial='Planeta';

-- Recuperamos los libros cuya editorial NO es "Planeta":
select * from libros where NOT editorial='Planeta'; 

-- Veamos cómo el uso de paréntesis hace que SQL Server evalúe en forma diferente ciertas consultas aparentemente iguales:
-- Caso 1: 
select * from libros where (autor='Borges') or (editorial='Paidos' and precio<20);
-- Caso 2: 
select * from libros where (autor='Borges' or editorial='Paidos') and (precio<20);