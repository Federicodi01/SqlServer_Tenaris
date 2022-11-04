if OBJECT_ID('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(30),
  autor varchar(20),
  editorial varchar(15),
  precio float
);

go

insert into libros (titulo,autor,editorial,precio) values 
('El aleph','Borges','Emece',25.60),
('Uno','Richard Bach','Planeta',18);

select * from libros;

truncate table libros;

insert into libros (titulo,autor,editorial,precio) values 
('El aleph','Borges','Emece',25.60),
('Uno','Richard Bach','Planeta',18);

delete from libros;

insert into libros (titulo,autor,editorial,precio) values 
('El aleph','Borges','Emece',25.60),
('Uno','Richard Bach','Planeta',18);
