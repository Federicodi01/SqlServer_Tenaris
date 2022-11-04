if object_id('libros') is not null drop table libros;

create table libros
(
  titulo varchar(30),
  editorial varchar(15),
  edicion datetime,
  precio decimal(6,2)
);

go

insert into libros (titulo,editorial,precio)
  values ('El aleph','Emece',25.50);

exec sp_columns libros;

-- Agregamos el campo "cantidad" a la tabla "libros", de tipo tinyint, que acepta valores nulos:
alter table libros add cantidad tinyint;

-- Agregamos un campo "codigo" a la tabla "libros", de tipo int con el atributo "identity":
alter table libros add codigo int identity;

-- Intentamos agregar un campo llamado "autor" de tipo varchar(30) que NO acepte valores nulos (GENERA ERROR):
alter table libros add autor varchar(30) not null;

-- Agregar un campo llamado "autor" de tipo varchar(20) pero con un valor por defecto: 
alter table libros add autor varchar(20) default 'Desconocido';

-- Eliminamos el campo "precio" de la tabla "libros":
alter table libros drop column precio;

-- Intentamos eliminar un campo con restricciones (GENERA ERROR) :
alter table libros drop column autor;

-- Eliminamos varios campos en una sola sentencia:
alter table libros drop column editorial, edicion;