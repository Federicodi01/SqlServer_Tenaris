if object_id('usuarios') is not null drop table usuarios;

create table usuarios
(
  nombre varchar(20),
  clave varchar(10)
);

go

insert into usuarios (nombre,clave) values
('Marcelo','River'),
('Susana','chapita'),
('Carlosfuentes','Boca'),
('Federicolopez','Boca');

select * from usuarios;

update usuarios set clave='RealMadrid';

update usuarios set clave='Boca' where nombre='Federicolopez'; 

update usuarios set clave='Payaso' where nombre='JuanaJuarez'; 

update usuarios set nombre='Marceloduarte', clave='Marce' where nombre='Marcelo';
