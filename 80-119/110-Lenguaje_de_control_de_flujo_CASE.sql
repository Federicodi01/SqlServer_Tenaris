if object_id('alumnos') is not null drop table alumnos;

create table alumnos
(
  nombre varchar(40),
  nota tinyint,
    constraint CK_alunos_nota check (nota>=0 and nota<=10)
);

go

insert into alumnos values('Ana Acosta',8);
insert into alumnos values('Carlos Caseres',4);
insert into alumnos values('Federico Fuentes',2);
insert into alumnos values('Gaston Guzman',3);
insert into alumnos values('Hector Herrero',5);
insert into alumnos values('Luis Luna',10);
insert into alumnos values('Marcela Morales',7);
insert into alumnos values('Marcela Morales',null);

-- Queremos mostrar el nombre y nota de cada alumno y en una columna extra llamada "condicion" empleamos un case que testee la nota y muestre un mensaje diferente según la nota:
select nombre, nota, condicion= 
case 
  when nota<4 then 'Libre'
  when nota>=4 and nota<7 then 'Regular'
  when nota>=7 and nota<=10 then 'Promocionado'
else 
  'Sin nota'
end
from alumnos;

-- Vamos a agregar el campo "condicion" a la tabla:
alter table alumnos add condicion varchar(20);

select * from alumnos;

-- Recordemos que se puede emplear una expresión "case" en cualquier lugar en el que pueda utilizar una expresión. Queremos actualizar el campo "condicion" para guardar la condición de cada alumno según su nota:
update alumnos set condicion=
  case
   when nota<4 then 'libre'
   when nota between 4 and 7 then 'regular'
   when nota >7 then 'promocionado'
  end;

 -- Mostramos la cantidad de alumnos libres, regulares y aprobados y en una columna extra mostramos un mensaje, ordenamos por cantidad:
select condicion, count(*) as cantidad, resultado=
case condicion
  when 'libre' then 'repitentes'
  when 'regular' then 'rinden final'
  when 'promocionado' then 'no rinden final'
  else 'sin datos'
end
from alumnos order by cantidad;