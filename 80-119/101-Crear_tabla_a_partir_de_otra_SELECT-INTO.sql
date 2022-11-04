if object_id('libros')is not null drop table libros;
if object_id('editoriales')is not null drop table editoriales;

create table libros
( 
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo)
); 

go

insert into libros values('Uno','Richard Bach','Planeta',15);
insert into libros values('El aleph','Borges','Emece',25);
insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45);
insert into libros values('Ilusiones','Richard Bach','Planeta',14);
insert into libros values('Java en 10 minutos','Mario Molina','Nuevo siglo',50);

-- Creamos una tabla llamada "editoriales" que contenga los nombres de las editoriales:
select distinct editorial into editoriales from libros;

-- Veamos la nueva tabla:
select * from editoriales;

-- Necesitamos una nueva tabla llamada "librosporeditorial" que contenga la cantidad de libros de cada editorial. Primero eliminamos la tabla, si existe:
if OBJECT_ID('cantidadporeditorial') is not null drop table cantidadporeditorial;

-- Creamos la nueva tabla:
select editorial as nombre, count(*) as cantidad into cantidadporeditorial from libros group by editorial;

select * from cantidadporeditorial;

-- Queremos una tabla llamada "ofertas4" que contenga los mismos campos que "libros" y guarde los 4 libros más económicos. Primero eliminamos, si existe, la tabla "ofertas4":
if OBJECT_ID('ofertas4') is not null drop table ofertas4;

-- Creamos "ofertas4" e insertamos la consulta de "libros":
select top 4 * into ofertas4 from libros order by precio asc;

select * from ofertas4;

-- Agregamos una columna a la tabla "editoriales" que contiene la ciudad en la cual está la casa central de cada editorial:
alter table editoriales add ciudad varchar(30);

-- Actualizamos dicho campo:
update editoriales set ciudad='Cordoba' where editorial='Planeta';
update editoriales set ciudad='Cordoba' where editorial='Emece';
update editoriales set ciudad='Buenos Aires' where editorial='Nuevo siglo';

