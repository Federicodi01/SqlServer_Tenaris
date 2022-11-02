if OBJECT_ID('libros') is not null drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
);

go

select * from libros;

insert into libros values
('El aleph','Borges','Emece',15.90),
('Cervantes y el quijote','Borges','Paidos',null),
('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90),
('Martin Fierro','Jose Hernandez','Emece',25.90);

insert into libros (titulo,autor,precio) values
('Antología poética','Borges',32),
('Java en 10 minutos','Mario Molina',45.80),
('Martin Fierro','Jose Hernandez',40),
('Aprenda PHP','Mario Molina',56.50);

-- Recuperamos los registros cuyo precio esté entre 20 y 40 empleando "between":
select * from libros where precio between 20 and 40;

-- Para seleccionar los libros cuyo precio NO esté entre un intervalo de valores antecedemos "not" al "between":
select * from libros where precio not between 20 and 40;