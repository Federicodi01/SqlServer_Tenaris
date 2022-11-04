if object_id ('libros') is not null drop table libros;

create table libros
(
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  edicion datetime,
  precio decimal(6,2)
);

go

set dateformat ymd;

insert into libros values
('El aleph','Borges','Emece','1980/10/10',25.33),
('Java en 10 minutos','Mario Molina','Siglo XXI','2000/05/05',50.65),
('Alicia en el pais de las maravillas','Lewis Carroll','Emece','2000/08/09',19.95),
('Aprenda PHP','Mario Molina','Siglo XXI','2000/02/04',45);

-- Mostramos el t�tulo del libro y el a�o de edici�n:
select titulo, datepart(year, edicion) as 'A�o de edici�n' from libros;

-- Mostramos el t�tulo del libro y el nombre del mes de edici�n:
select titulo, datepart(month, edicion) as 'Mes de edici�n' from libros;

-- Mostramos el t�tulo del libro y los a�os que tienen de editados:
select titulo, datediff(year, edicion, getdate()) as 'Editado hace (a�os)' from libros;

-- Muestre los t�tulos de los libros que se editaron el d�a 9, de cualquier mes de cualquier a�o:
select titulo from libros where day(edicion)=9;