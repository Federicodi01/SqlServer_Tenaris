if OBJECT_ID('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) not null default 'Desconocido', 
  editorial varchar(20),
  precio decimal(5,2),
  cantidad tinyint default 0
);

go

exec sp_columns libros;

select * from libros;

-- Ingresamos un registro omitiendo los valores para el campo "autor" y "cantidad":
insert into libros (titulo,editorial,precio) values 
('Java en 10 minutos','Paidos',50.40);

-- Si ingresamos un registro sin valor para el campo "precio", que admite valores nulos, se ingresará "null" en ese campo:
insert into libros (titulo,editorial) values 
('Aprenda PHP','Siglo XXI');

-- Podemos emplear "default" para dar el valor por defecto a algunos campos:
insert into libros (titulo,autor,precio,cantidad) values 
('El gato con botas',default,default,100);

-- Como todos los campos de "libros" tienen valores predeterminados, podemos tipear:
insert into libros default values;

-- Podemos ingresar el valor "null" en el campo "cantidad":
insert into libros (titulo,autor,cantidad) values 
('Alicia en el pais de las maravillas','Lewis Carroll',null);