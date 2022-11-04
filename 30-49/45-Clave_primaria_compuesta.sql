if object_id('vehiculos') is not null drop table vehiculos;

create table vehiculos
(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime,
  horasalida datetime,
  primary key(patente,horallegada)
);

go

insert into vehiculos values('AIC124','a','8:05','12:30');
insert into vehiculos values('CAA258','a','8:05',null);
insert into vehiculos values('DSE367','m','8:30','18:00');
insert into vehiculos values('FGT458','a','9:00',null);
insert into vehiculos values('AIC124','a','16:00',null);
insert into vehiculos values('LOI587','m','18:05','19:55');

select * from vehiculos;

-- Si intentamos ingresar un registro con clave primaria repetida (GENERA ERROR):
insert into vehiculos values('LOI587','m','18:05',null);


-- Si ingresamos un registro repitiendo el valor de uno de los campos que forman parte de la clave, si lo acepta:
insert into vehiculos values('LOI587','m','21:30',null);

-- Si intentamos actualizar un registro repitiendo la clave primaria (GENERA ERROR):
update vehiculos set horallegada='8:05' where patente='AIC124' and horallegada='16:00';

-- Recordemos que los campos que forman parte de la clave primaria no aceptan valores nulos, aunque no se haya aclarado en la definición de la tabla (GENERA ERROR):
insert into vehiculos values('HUO690','m',null,null);

-- mostramos la estructura de la tabla (los campos que forman parte de la clave primaria (patente y horallegada) tienen "NO" en la columna "IS_NULLABLE", es decir, no admiten valores nulos.):
exec sp_columns vehiculos;

