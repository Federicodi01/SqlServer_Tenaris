create table empleados
(
  nombre varchar(20),
  documento char(8),
  fechaingreso datetime
);

go

set dateformat dmy;

insert into empleados values
('Ana Gomez','22222222','12-01-1980'),
('Bernardo Huerta','23333333','15-03-81'),
('Carla Juarez','24444444','20/05/1983'),
('Daniel Lopez','25555555','2.5.1990');

select * from empleados

-- Mostramos los datos de los empleados cuya fecha de ingreso es anterior a '01-01-1985':
select * from empleados where fechaingreso<'01-01-1985';

-- Actualizamos el nombre a "Maria Carla Juarez' del empleado cuya fecha de ingreso es igual a '20/05/1983':
update empleados set nombre='Maria Carla Juarez' where fechaingreso='20/05/1983'

-- Borramos los empleados cuya fecha de ingreso es distinta a '20.5.83':
delete empleados where fechaingreso<>'20.5.83';