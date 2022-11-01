create table agenda
(
  nombre varchar(30),
  domicilio varchar(30),
  telefono varchar(11)
);

go

insert into agenda values
('Juan Perez','Avellaneda 908','4252525'),
('Marta Lopez','Sucre 34','4556688'),
('Carlos Garcia','Sarmiento 1258',null);

select * from agenda;

select nombre as 'Nombre y Apellido', domicilio, telefono from agenda;