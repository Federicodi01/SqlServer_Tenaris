if OBJECT_ID('usuarios') is not null drop table usuarios;

create table usuarios
(
  nombre varchar(30),
  clave varchar(10)
);

go

insert into usuarios (nombre,clave) values
('Marcelo','River'),
('Susana','chapita'),
('CarlosFuentes','Boca'),
('FedericoLopez','Boca');

select * from usuarios;

delete from usuarios where nombre='Marcelo';

delete from usuarios where clave='Boca';

delete from usuarios;