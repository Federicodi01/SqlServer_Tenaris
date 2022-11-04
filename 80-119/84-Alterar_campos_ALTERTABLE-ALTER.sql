if object_id('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(30),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(6,2) not null default 0
);

go

insert into libros
  values('El aleph','Borges','Planeta',20);
insert into libros
  values('Java en 10 minutos',null,'Siglo XXI',30);
insert into libros
  values('Uno','Richard Bach','Planeta',15);
insert into libros
  values('Martin Fierro','Jose Hernandez',null,30);
insert into libros
  values('Aprenda PHP','Mario Molina','Emece',25);

-- Modificamos el campo "titulo" para que acepte una cadena más larga y no admita valores nulos:
alter table libros alter column titulo varchar (40) not null;

exec sp_columns libros;

-- Eliminamos registro que tienen en el campo autor el valor null y realizamos la modificación del campo:
delete from libros where autor is null;
alter table libros alter column autor varchar(30) not null;

-- Intentamos quitar el atributo "identity" del campo "codigo" y lo redefinimos como "smallint" (NO PRODUCE EL CAMBIO):
alter table libros alter column codigo smallint;

