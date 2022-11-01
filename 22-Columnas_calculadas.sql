if object_id ('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  cantidad tinyint default 0,
  primary key (codigo)
);

go

select * from libros;

insert into libros (titulo,autor,editorial,precio,cantidad) values
('El aleph','Borges','Emece',25,25),
('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100),
('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

-- Queremos saber el monto total en dinero de cada libro: 
select titulo, precio, cantidad, precio*cantidad from libros;

-- Conocer el precio de cada libro con un 10% de descuento:
select titulo, precio, precio-(precio*0.1) from libros;

-- Actualizar los precios con un 10% de descuento:
update libros set precio=precio-(precio*0.1);

-- Queremos una columna con el título, el autor y la editorial de cada libro:
select titulo+' - '+autor+' - '+editorial from libros;