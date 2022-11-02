if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  primary key(codigo)
);

go

insert into libros
  values('El aleph','Borges','Planeta');
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece');
insert into libros
  values('Martin Fierro','Jose Hernandez','Planeta');
insert into libros
  values('Antologia poetica','Borges','Planeta');
insert into libros
  values('Aprenda PHP','Mario Molina','Emece');
insert into libros
  values('Aprenda PHP','Lopez','Emece');
insert into libros
  values('Manual de PHP', 'J. Paez', null);
insert into libros
  values('Cervantes y el quijote',null,'Paidos');
insert into libros
  values('Harry Potter y la piedra filosofal','J.K. Rowling','Emece');
insert into libros
  values('Harry Potter y la camara secreta','J.K. Rowling','Emece');
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos');
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta');
insert into libros
  values('PHP de la A a la Z',null,null);
insert into libros
  values('Uno','Richard Bach','Planeta');

-- Para obtener la lista de autores sin repetici�n
select distinct autor from libros;

-- Para obtener la lista de autores conocidos, es decir, no incluyendo "null" en la lista:
select distinct autor from libros where autor is not null;

-- Contamos los distintos autores
select count(distinct autor) from libros;

-- Nombres de las editoriales sin repetir:
select distinct editorial from libros where editorial is not null;

--  Cantidad de editoriales distintas:
select count(distinct editorial) from libros;

-- Distintos autores de la editorial "Planeta":
select distinct autor from libros where editorial='Planeta';

-- Distintos autores que tiene cada editorial empleando "group by":
select editorial, count(distinct autor) from libros group by editorial;

-- Mostramos los t�tulos y editoriales de los libros sin repetir t�tulos ni editoriales:
select distinct titulo, editorial from libros order by titulo;