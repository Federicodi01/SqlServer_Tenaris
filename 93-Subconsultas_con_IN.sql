if object_id('libros') is not null drop table libros;
if object_id('editoriales') is not null drop table editoriales;

create table editoriales
(
  codigo tinyint identity,
  nombre varchar(30),
  primary key (codigo)
);
 
create table libros 
(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  codigoeditorial tinyint,
  primary key(codigo),
 constraint FK_libros_editorial
   foreign key (codigoeditorial)
   references editoriales(codigo)
   on update cascade,
);

go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Paidos');
insert into editoriales values('Siglo XXI');

insert into libros values('Uno','Richard Bach',1);
insert into libros values('Ilusiones','Richard Bach',1);
insert into libros values('Aprenda PHP','Mario Molina',4);
insert into libros values('El aleph','Borges',2);
insert into libros values('Puente al infinito','Richard Bach',2);

-- Queremos conocer el nombre de las editoriales que han publicado
select nombre from editoriales where codigo in (select codigoeditorial from libros where autor='Richard Bach');

-- Probamos la subconsulta separada de la consulta exterior para verificar que retorna una lista de valores de un solo campo:
select codigoeditorial from libros where autor='Richard Bach';

-- Podemos reemplazar por un "join" la primera consulta:
select distinct nombre from editoriales as e join libros on codigoeditorial=e.codigo where autor='Richard Bach';

-- También podemos buscar las editoriales que no han publicado libros de "Richard Bach":
select nombre from editoriales where codigo not in (select codigoeditorial from libros where autor='Richard Bach');