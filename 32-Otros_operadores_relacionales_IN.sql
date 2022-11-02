if object_id ('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20),
  editorial varchar(20),
  precio decimal(6,2),
);

go

insert into libros values
('El aleph','Borges','Emece',15.90),
('Cervantes y el quijote','Borges','Paidos',null),
('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90),
('Matematica estas ahi','Paenza','Siglo XXI',15);


insert into libros (titulo,precio) values 
('Antología poética',32);

insert into libros (titulo,autor,precio) values
('Martin Fierro','Jose Hernandez',40),
('Aprenda PHP','Mario Molina',56.50);

select * from libros;

-- Reemplazamos una OR
select * from libros where autor in ('Borges','Paenza');

-- Reemplazamos una and
select * from libros where autor not in ('Borges','Paenza');
