if OBJECT_ID('libros') is not null drop table libros;

create table libros(
  titulo varchar(30),
  autor varchar(30),
  editorial varchar(15),
  precio float
);

go

sp_columns libros;

insert into libros (titulo,autor,editorial,precio) VALUES 
('El aleph','Borges','Emece',24.50),
('Martin Fierro','Jose Hernandez','Emece',16.00),
('Aprenda PHP','Mario Molina','Emece',35.40),
('Cervantes y el quijote','Borges','Paidos',50.90);

select * from libros;

select * from libros where autor<>'Borges';

select titulo, precio from libros where precio>20;

select * from libros where precio<=30;