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
('Cervantes y el quijote','Borges','Paidos',null),
('Alicia en el pais de las maravillas','Lewis Carroll',null,19.90),
('Martin Fierro','Jose Hernandez','Emece',25.90),
('Antolog�a po�tica','Borges','Paidos' ,25.50),
('Java en 10 minutos','Mario Molina','Emece' ,45.80)

insert into libros (titulo,autor,precio) values
('Antolog�a po�tica','Borges',25.50),
('Java en 10 minutos','Mario Molina',45.80);

insert into libros (titulo,autor) values
('Martin Fierro','Jose Hernandez'),
('Aprenda PHP','Mario Molina');

select * from libros where editorial is null;

select * from libros where editorial is not null;