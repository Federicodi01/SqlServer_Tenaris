if OBJECT_ID('usuarios') is not null drop table usuarios;

create table usuarios
(
  nombre varchar(20),
  clave varchar(10),
  primary key(nombre)
);

go

exec sp_columns usuarios;

insert into usuarios (nombre, clave) values 
('juanperez','Boca'),
('raulgarcia','River');

update usuarios set nombre = 'juanperez' where nombre='raulgarcia'; -- Da error ya que no es posible hacer esto

select * from usuarios


