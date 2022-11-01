if object_id('usuarios') is not null drop table usuarios;

create table usuarios (
  nombre varchar(30),
  clave varchar(10)
);

GO

exec sp_columns usuarios;

insert into usuarios (nombre, clave) values 
('Marcelo','Boca'),
('JuanPerez','Juancito'),
('Susana','River'),
('Luis','River');

select * from usuarios;

select * from usuarios where nombre='Leonardo';

select * from usuarios where clave='River';

select nombre from usuarios where clave='Boca';