if object_id('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2)
);

go

insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
insert into libros values('El aleph','Borges','Emece',10.00);
insert into libros values('Ilusiones','Richard Bach','Planeta',15.00);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
insert into libros values('Martin Fierro','Jose Hernandez','Planeta',20.00);
insert into libros values('Martin Fierro','Jose Hernandez','Emece',30.00);
insert into libros values('Uno','Richard Bach','Planeta',10.00);

select * from libros;

-- Obtenemos el t�tulo, precio de un libro espec�fico y la diferencia entre su precio y el m�ximo valor:
select titulo, precio, precio-(select max(precio) from libros) as diferencia from libros;

-- Mostramos el t�tulo y precio del libro m�s costoso:
select titulo, precio from libros where precio=(select max(precio) from libros);

-- Actualizamos el precio del libro con m�ximo valor:
update libros set precio=45 where precio=(select max(precio) from libros);

-- Eliminamos los libros con precio menor:
delete from libros where precio=(select min(precio) from libros);