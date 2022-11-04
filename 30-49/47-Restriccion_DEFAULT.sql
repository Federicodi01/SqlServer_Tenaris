if object_id('libros') is not null drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  editorial varchar(15),
  precio decimal(6,2)
);

go

insert into libros (titulo,editorial) values('Martin Fierro','Emece');
insert into libros (titulo,editorial) values('Aprenda PHP','Emece');

select * from libros;

-- Veamos que SQL Server cre� autom�ticamente una restricci�n "default" para el campo "autor":
exec sp_helpconstraint libros;

drop table libros;

create table libros
(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(6,2)
);

go

insert into libros (titulo,editorial) values('Martin Fierro','Emece');
insert into libros (titulo,editorial) values('Aprenda PHP','Emece');

-- Agregamos una restricci�n "default" empleando "alter table" para que almacene el valor "Desconocido" en el campo "autor":
alter table libros add constraint DF_libros_autor default 'Desconocido' for autor;

-- Veamos la restrici�n agregada anteriormente con el procedimiento almacenado "sp_helpcontraint":
exec sp_helpconstraint libros;

-- Veamos c�mo se almacenaron los registros sin valor expl�cito para el campo con restricci�n "default":
select * from libros;

-- Agregamos otra restricci�n "default" para el campo "precio" para que almacene el valor 0 en dicho campo:
alter table libros add constraint DF_libros_precio default 0 for precio;
exec sp_helpconstraint libros;
