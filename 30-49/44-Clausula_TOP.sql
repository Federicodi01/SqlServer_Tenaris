if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(20),
  editorial varchar(20)
);

go

insert into libros values ('Uno','Richard Bach','Planeta');
insert into libros values ('El aleph','Borges','Emece');
insert into libros values ('Alicia en el pais...','Carroll','Planeta');
insert into libros values ('Aprenda PHP','Mario Molina','Siglo XXI');
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI');
insert into libros values ('Java desde cero','Mario Molina','Emece');
insert into libros values ('Ilusiones','Richard Bach','Planeta');

-- Obtenemos todos los datos de los primeros 2 libros de la tabla:
select top 2 * from libros;

-- Mostramos los títulos y autores de los 3 primeros libros ordenados por autor:
select top 3 titulo, autor from libros order by autor;

-- Realizamos la misma consulta anterior pero empleamos la cláusula "with ties":
select top 3 with ties titulo, autor from libros order by autor;

-- El 50% de los registros de la tabla libros:
select top 50 percent * from libros;

