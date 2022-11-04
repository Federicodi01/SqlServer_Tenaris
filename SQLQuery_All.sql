         -- 1) Crear Base de Datos
Create database SqlTenatis_practica
go

use sqltenaris_practica 
go



         -- 2) Crear una tabla (create table - sp_tables - sp_columns - drop table)
create table usuarios (
nombre varchar(50),
clave varchar(10)
)

exec sp_tables @table_owner='dbo';

exec sp_columns usuarios;



         -- 3) Insertar y recuperar registros de una tabla (insert into - select)
insert into usuarios values ('Carlos', 'Clave 1');
insert into usuarios (clave, nombre) values ('Clave2', 'Pedro');
insert into usuarios (nombre) values ('Federico');

select * from usuarios;



         -- 4) Tipos de datos b�sicos
/*
- Varchar: Cadena de texto. Se llama y se declara la cantida maxima de caracteres que almacenar� (varchar(30))
- Int: Numeros enteros entre -2000000000 a 2000000000 aprox.
- Float: Numeros decimales. Se llama y se declara cantidad maxima de numeros, y cantidad de decimales (float(6,2))
*/



         -- 5) Recuperar algunos campos (select)
-- borramos la tabla libros si ya existe
if object_id('libros') is not null drop table libros;

-- creamos la tabla libros
create table libros(
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio float,
  cantidad integer
);

-- llamamos al procedimiento almacenado sp_columns para conocer los campos de la tabla libros
exec sp_columns libros;

-- insertamos varias filas en la tabla libros
insert into libros (titulo,autor,editorial,precio,cantidad)
  values ('El aleph','Borges','Emece',25.50,100),
         ('Alicia en el pais de las maravillas','Lewis Carroll','Atlantida',10,200),
		 ('Matematica estas ahi','Paenza','Siglo XXI',18.8,200);

-- recuperamos todas los datos de la tabla libros
select * from libros;

-- recuperamos solo el titulo, autor y editorial de la tabla libros
select titulo, autor, editorial from libros;



         -- 6) Recuperar algunos registros (where)
-- borramos la tabla usuarios si ya existe
if object_id('usuarios') is not null drop table usuarios;

-- creamos la tabla usuarios
create table usuarios (
  nombre varchar(30),
  clave varchar(10)
);

-- insertamos varias filas en la tabla usuarios
insert into usuarios (nombre, clave)
  values ('Marcelo','Boca');
insert into usuarios (nombre, clave)
  values ('JuanPerez','Juancito');
insert into usuarios (nombre, clave)
  values ('Susana','River');
insert into usuarios (nombre, clave)
  values ('Luis','River');

-- Recuperamos el usuario cuyo nombre es "Leonardo"
select * from usuarios where nombre='Leonardo';

-- Recuperamos el nombre de los usuarios cuya clave es "River"
select nombre from usuarios where clave='River';



         -- 7) Operadores relacionales
/*
=	igual
<>	distinto
>	mayor
<	menor
>=	mayor o igual
<=	menor o igual

Usos: */
select * from usuarios where nombre<>'Marcelo';

select * from libros where precio>20;



         -- 8) Borrar registros (delete)
-- Eliminamos el registro cuyo nombre de usuario es "Marcelo"
delete from usuarios where nombre='Marcelo';
select * from usuarios;

-- Eliminemos todos los registros
delete from usuarios;
select * from usuarios;



         -- 9) Actualizar registros (update)
-- Actualizamos la contrase�a de todos los registros
update usuarios set clave='Barcelona';
select * from usuarios;

-- Actualizamos la contrase�a de quien se llame 'Marcelo'
update usuarios set clave='Boca' where nombre='Marcelo';
select * from usuarios;

-- Actualizamos nombre y contrase�a de quien se llame 'Marcelo'
update usuarios set nombre='Marcelo Perez', clave='River' where nombre='Marcelo';
select * from usuarios;



         -- 10) Comentarios
/*
- Con "--", se comenta lo que resta de la linea.
- Con "/**/" Se comenta todo lo que hay entre los asteriscos, sin importar los saltos de linea que haya.
*/



         -- 11) Valores null (is null)

if object_id('libros') is not null
   drop table libros;

create table libros(
  titulo varchar(30) not null,
  autor varchar(30) not null,
  editorial varchar(15) null,
  precio float
);

go

exec sp_columns libros;

-- Agregamos un registro a la tabla con valor nulo para el campo "precio":
insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',null);

select * from libros;

-- Vamos a ingresar un registro con cadena vac�a para el campo "editorial":
insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','',18.50);

select * from libros;

-- Ingresamos otro registro, ahora cargamos una cadena vac�a en el campo "titulo":
insert into libros (titulo,autor,editorial,precio)
  values('','Richard Bach','Planeta',22);
  
select * from libros;

-- Recuperemos los registros que contengan el valor "null" en el campo "editorial":
select * from libros
  where editorial is null;

-- Recuperemos los registros que contengan el valor "" en el campo "editorial":
select * from libros
  where editorial='';



         -- 12) Clave primaria
if object_id('usuarios') is not null
  drop table usuarios;

create table usuarios(
  nombre varchar(20),
  clave varchar(10),
  primary key(nombre)
);

go

exec sp_columns usuarios;

insert into usuarios (nombre, clave)
  values ('juanperez','Boca');
insert into usuarios (nombre, clave)
  values ('raulgarcia','River');

--  Intentamos ingresar un valor de clave primaria existente (GENERA ERROR):
insert into usuarios (nombre, clave)
  values ('juanperez','payaso');

-- Intentamos ingresar el valor "null" en el campo clave primaria (GENERA ERROR):
insert into usuarios (nombre, clave)
  values (null,'payaso');

-- Intentemos actualizar el nombre de un usuario colocando un nombre existente (GENERA ERROR):
update usuarios set nombre='juanperez'
  where nombre='raulgarcia';



         -- 13) Campo con atributo Identity
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity(2,10),
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15),
  precio float
);

go

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',23);
insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','Planeta',18);
insert into libros (titulo,autor,editorial,precio)
  values('Aprenda PHP','Mario Molina','Siglo XXI',45.60);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de maravillas','Lewis Carroll','Paidos',15.50);

select * from libros;

exec sp_columns libros;

-- NO SE PUEDE INGRESAR EL CODIGO MANUALMENTE, TAMPOCO SE PUEDE MODIFICAR.

-- Eliminemos el �ltimo registro:
delete from libros
  where autor='Lewis Carroll';

-- Ingresamos un quinto registro (En el campo c�digo se guard� el valor secuencial sin considerar que el valor "32" ya no existe):
insert into libros (titulo, autor, editorial, precio)
  values('Martin Fierro','Jose Hernandez','Paidos',25); 

select * from libros;



         -- 15) Truncate table
-- Eliminamos la tabla libros, luego insertamos registros, y consultamos sus datos (Codigo continua con el valor secuencial correspondiente):
delete from libros;

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',23);
insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','Planeta',18);

select * from libros;

-- Utilizando TRUNCATE se reinicia la tabla, y todos sus valores vuelven a 0.
truncate table libros;

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',23);
insert into libros (titulo,autor,editorial,precio)
  values('Uno','Richard Bach','Planeta',18);

select * from libros;



         -- 16) Otros tipos de datos en SQL Server
/*
- Texto: char, nchar, varchar, nvarchar, text y ntext.
- N�meros: tinyint, smallint y bigint.
- Fechas y horas: datetime y smalldatetime.

Existen otros tipos de datos que analizaremos en secciones pr�ximas.
*/



         -- 17) Tipo de dato (texto)
/*
- Varchar(x): define una cadena de caracteres de longitud variable en la cual determinamos el m�ximo de caracteres con el argumento "x" que va entre par�ntesis.
  Si se omite el argumento coloca 1 por defecto. Su rango va de 1 a 8000 caracteres.
- Char(x): define una cadena de longitud fija determinada por el argumento "x". Si se omite el argumento coloca 1 por defecto. Su rango es de 1 a 8000 caracteres.
  Si la longitud es invariable, es conveniente utilizar el tipo char; caso contrario, el tipo varchar. Ocupa tantos bytes como se definen con el argumento "x".
  "char" viene de character, que significa caracter en ingl�s.
- Text: guarda datos binarios de longitud variable, puede contener hasta 2000000000 caracteres. No admite argumento para especificar su longitud.
- nvarchar(x): es similar a "varchar", excepto que permite almacenar caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
- nchar(x): es similar a "char" excpeto que acepta caracteres Unicode, su rango va de 0 a 4000 caracteres porque se emplean 2 bytes por cada caracter.
- Ntext: es similar a "text" excepto que permite almacenar caracteres Unicode, puede contener hasta 1000000000 caracteres. No admite argumento para especificar su longitud.
*/



         -- 18) Tipo de dato (num�rico)
/*
TIPO 1: 
- integer o int: su rango es de -2000000000 a 2000000000 aprox.
- smallint: Puede contener hasta 5 digitos. Su rango va desde �32000 hasta 32000 aprox.
- tinyint: Puede almacenar valores entre 0 y 255.
- bigint: De �9000000000000000000 hasta 9000000000000000000 aprox.

TIPO 2: 
- decimal o numeric (t,d): Pueden tener hasta 38 digitos, guarda un valor exacto. El primer argumento indica el total de d�gitos y el segundo, la cantidad de decimales.

TIPO 3: 
- float: De 1.79E+308 hasta 1.79E+38. Guarda valores aproximados.
- real: Desde 3.40E+308 hasta 3.40E+38. Guarda valores aproximados.

TIPO 4: 
- money: Puede tener hasta 19 digitos y s�lo 4 de ellos puede ir luego del separador decimal; entre �900000000000000.5808 aprox y 900000000000000.5807.
- smallmoney: Entre �200000.3648 y 200000.3647 aprox.
*/



         -- 19) Tipo de dato (fecha y hora)
/*
- datetime: puede almacenar valores desde 01 de enero de 1753 hasta 31 de diciembre de 9999.
- smalldatetime: el rango va de 01 de enero de 1900 hasta 06 de junio de 2079.

Las fechas se ingresan entre comillas simples. Para almacenar valores de tipo fecha se permiten como separadores "/", "-" y ".".

SQL Server reconoce varios formatos de entrada de datos de tipo fecha. Para establecer el orden de las partes de una fecha (dia, mes y a�o) empleamos "set dateformat". Estos son los formatos:
-mdy: 4/15/96 (mes y d�a con 1 � 2 d�gitos y a�o con 2 � 4 d�gitos),
-myd: 4/96/15,
-dmy: 15/4/1996
-dym: 15/96/4,
-ydm: 96/15/4,
-ydm: 1996/15/4,

El formato por defecto es "mdy".

Para ingresar una fecha con formato "d�a-mes-a�o", tipeamos:
 set dateformat dmy;

Todos los valores de tipo "datetime" se muestran en formato "a�o-mes-d�a hora:minuto:segundo .milisegundos", independientemente del formato de ingreso que hayamos seteado.

Podemos ingresar una fecha, sin hora, en tal caso la hora se guarda como "00:00:00". Por ejemplo, si ingresamos '25-12-01' (a�o de 2 d�gitos), lo mostrar� as�: '2001-12-25 00:00:00.000'.

Podemos ingresar una hora sin fecha, en tal caso, coloca la fecha "1900-01-01". Por ejemplo, si ingresamos '10:15', mostrar� '1900-01-01 10:15.000'.
*/



         -- 20) Ingresar algunos campos (insert into)
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(15)
);

go

-- Si ingresamos valores para todos los campos, podemos omitir la lista de campos:
insert into libros
  values ('Uno','Richard Bach','Planeta');

-- Podemos ingresar valores para algunos de los campos:
insert into libros (titulo, autor)
  values ('El aleph','Borges');

-- No podemos omitir el valor para un campo declarado "not null", como el campo "titulo" (GENERA ERROR):
insert into libros (autor,editorial)
  values ('Lewis Carroll','Planeta');

select * from libros;



         -- 21) Valores por defecto (default)
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) not null default 'Desconocido', 
  editorial varchar(20),
  precio decimal(5,2),
  cantidad tinyint default 0
);

go

-- Ingresamos un registro omitiendo los valores para el campo "autor" y "cantidad":
insert into libros (titulo,editorial,precio)
  values('Java en 10 minutos','Paidos',50.40);

select * from libros;

-- Si ingresamos un registro sin valor para el campo "precio", que admite valores nulos, se ingresar� "null" en ese campo:
insert into libros (titulo,editorial)
  values('Aprenda PHP','Siglo XXI');

select * from libros;

-- Podemos emplear "default" para dar el valor por defecto a algunos campos:
insert into libros (titulo,autor,precio,cantidad)
  values ('El gato con botas',default,default,100);

select * from libros;

-- Como todos los campos de "libros" tienen valores predeterminados, podemos tipear:
insert into libros default values;

select * from libros;



         -- 22) Columnas calculadas (operadores aritm�ticos y de concatenaci�n)
if object_id ('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  cantidad tinyint default 0,
  primary key (codigo)
);

go

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25);
insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

-- Queremos saber el monto total en dinero de cada libro: 
select titulo, precio,cantidad, precio*cantidad as 'Total $'
  from libros;

-- Conocer el precio de cada libro con un 10% de descuento:
select titulo,precio, precio-(precio*0.1) as 'Precio con 10% off'
  from libros;

-- Actualizar los precios con un 10% de descuento:
update libros set precio=precio-(precio*0.1);

select * from libros;

-- Queremos una columna con el t�tulo, el autor y la editorial de cada libro:
select titulo+' - '+autor+' - '+editorial as Datos
  from libros;



         -- 23) Columnas calculadas (operadores aritm�ticos y de concatenaci�n)
/*
Para reemplazar el nombre de un campo por otro, se coloca la palabra clave "as" seguido del texto del encabezado.
Si el alias consta de una sola cadena las comillas no son necesarias, pero si contiene m�s de una palabra, es necesario colocarla entre comillas simples:
*/
 select titulo as 'T�tulo del libro',autor,precio
  from libros;



         -- 24) Funciones
/*
SQL Server ofrece varios tipos de funciones para realizar distintas operaciones. Se pueden clasificar de la siguiente manera: 
TIPO 1:
- de agregado: realizan operaciones que combinan varios valores y retornan un �nico valor. Son "count", "sum", "min" y "max".

TIPO 2: 
- escalares: toman un solo valor y retornan un �nico valor. Pueden agruparse de la siguiente manera:
. de configuraci�n: retornan informaci�n referida a la configuraci�n (select @@version).
. de cursores: retornan informaci�n sobre el estado de un cursor.
. de fecha y hora: operan con valores "datetime" y "smalldatetime". Reciben un par�metro de tipo fecha y hora y retornan un valor de cadena, num�rico o de fecha y hora.
. matem�ticas: realizan operaciones num�ricas, geom�tricas y trigonom�tricas.
. de metadatos: informan sobre las bases de datos y los objetos.
. de seguridad: devuelven informaci�n referente a usuarios y funciones.
. de cadena: operan con valores "char", "varchar", "nchar", "nvarchar", "binary" y "varbinary" y devuelven un valor de cadena o num�rico.
. del sistema: informan sobre opciones, objetos y configuraciones del sistema (select user_name()).
. estad�sticas del sistema: retornan informaci�n referente al rendimiento del sistema.
. texto e imagen: realizan operaciones con valor de entrada de tipo text o image y retornan informaci�n referente al mismo.

TIPO 3: 
- de conjuntos de filas: retornan conjuntos de registros.
*/



         -- 25) Funciones para el manejo de cadenas
/*
Microsoft SQL Server tiene algunas funciones para trabajar con cadenas de caracteres. Estas son algunas:
- substring(cadena,inicio,longitud): devuelve una parte de la cadena especificada como primer argumento, 
  empezando desde la posici�n especificada por el segundo argumento y de tantos caracteres de longitud como indica el tercer argumento.
- str(numero,longitud,cantidaddecimales): convierte n�meros a caracteres; 
  el primer par�metro indica el valor num�rico a convertir, el segundo la longitud del resultado (debe ser mayor o igual a la parte entera del n�mero m�s el signo si lo tuviese) y el tercero, la cantidad de decimales. 
  El segundo y tercer argumento son opcionales y deben ser positivos. String significa cadena en ingl�s.
- stuff(cadena1,inicio,cantidad,cadena2): inserta la cadena enviada como cuarto argumento, 
  en la posici�n indicada en el segundo argumento, reemplazando la cantidad de caracteres indicada por el tercer argumento en la cadena que es primer par�metro. Stuff significa rellenar en ingl�s.
- len(cadena): retorna la longitud de la cadena enviada como argumento. "len" viene de length, que significa longitud en ingl�s.
- char(x): retorna un caracter en c�digo ASCII del entero enviado como argumento.
- left(cadena,longitud): retorna la cantidad (longitud) de caracteres de la cadena comenzando desde la izquierda, primer caracter.
- right(cadena,longitud): retorna la cantidad (longitud) de caracteres de la cadena comenzando desde la derecha, �ltimo caracter.
- lower(cadena): retornan la cadena con todos los caracteres en min�sculas. lower significa reducir en ingl�s.
- upper(cadena): retornan la cadena con todos los caracteres en may�sculas.
- ltrim(cadena): retorna la cadena con los espacios de la izquierda eliminados.
- rtrim(cadena): retorna la cadena con los espacios de la derecha eliminados.
- replace(cadena,cadenareemplazo,cadenareemplazar): retorna la cadena con todas las ocurrencias de la subcadena reemplazo por la subcadena a reemplazar.
- reverse(cadena): devuelve la cadena invirtiendo el order de los caracteres.
- patindex(patron,cadena): devuelve la posici�n de comienzo (de la primera ocurrencia) del patr�n especificado en la cadena enviada como segundo argumento. Si no la encuentra retorna 0.
- charindex(subcadena,cadena,inicio): devuelve la posici�n donde comienza la subcadena en la cadena, comenzando la b�squeda desde la posici�n indicada por "inicio". 
  Si el tercer argumento no se coloca, la b�squeda se inicia desde 0. Si no la encuentra, retorna 0.
- replicate(cadena,cantidad): repite una cadena la cantidad de veces especificada.
- space(cantidad): retorna una cadena de espacios de longitud indicada por "cantidad", que debe ser un valor positivo.

EJEMPLOS: 
*/
if object_id ('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  cantidad tinyint default 0,
  primary key (codigo)
);

go

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25);
insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);

-- Mostramos s�lo los 12 primeros caracteres de los t�tulos de los libros y sus autores, empleando la funci�n "substring()":
select substring(titulo,1,12) as titulo
  from libros;

-- Mostramos s�lo los 12 primeros caracteres de los t�tulos de los libros y sus autores, ahora empleando la funci�n "left()":
select right(titulo,12) as titulo
  from libros;



         -- 26) Funciones matem�ticas
/*
Microsoft SQL Server tiene algunas funciones para trabajar con n�meros. Aqu� presentamos algunas.
- abs(x): retorna el valor absoluto del argumento "x".
- ceiling(x): redondea hacia arriba el argumento "x".
- floor(x): redondea hacia abajo el argumento "x".
- power(x,y): retorna el valor de "x" elevado a la "y" potencia.
- round(numero,longitud): retorna un n�mero redondeado a la longitud especificada. "longitud" debe ser tinyint, smallint o int. 
  Si "longitud" es positivo, el n�mero de decimales es redondeado seg�n "longitud"; si es negativo, el n�mero es redondeado desde la parte entera seg�n el valor de "longitud".
- sign(x): si el argumento es un valor positivo devuelve 1;-1 si es negativo y si es 0, 0.
- square(x): retorna el cuadrado del argumento.
- srqt(x): devuelve la raiz cuadrada del valor enviado como argumento.

EJEMPLO: 
*/
-- Vamos a mostrar los precios de los libros redondeando el valor hacia abajo y hacia arriba:
select titulo,autor,precio,
  floor(precio) as abajo,
  ceiling(precio) as arriba
  from libros;



         -- 27) Funciones para el uso de fechas y horas
/*
Microsoft SQL Server ofrece algunas funciones para trabajar con fechas y horas. Estas son algunas:
- getdate(): retorna la fecha y hora actuales.
- datepart(partedefecha,fecha): retorna la parte espec�fica de una fecha, el a�o, trimestre, d�a, hora, etc.
- datename(partedefecha,fecha): retorna el nombre de una parte espec�fica de una fecha. Los valores para "partedefecha" pueden ser los mismos que se explicaron anteriormente.
- dateadd(partedelafecha,numero,fecha): agrega un intervalo a la fecha especificada, es decir, retorna una fecha adicionando a la fecha enviada como tercer argumento, 
  el intervalo de tiempo indicado por el primer par�metro, tantas veces como lo indica el segundo par�metro. 
  Los valores para el primer argumento pueden ser: year (a�o), quarter (cuarto), month (mes), day (dia), week (semana), hour (hora), minute (minuto), second (segundo) y millisecond (milisegundo).
- datediff(partedelafecha,fecha1,fecha2): calcula el intervalo de tiempo (seg�n el primer argumento) entre las 2 fechas. El resultado es un valor entero que corresponde a fecha2-fecha1. 
  Los valores de "partedelafecha) pueden ser los mismos que se especificaron anteriormente.
- day(fecha): retorna el d�a de la fecha especificada.
- month(fecha): retorna el mes de la fecha especificada.
- year(fecha): retorna el a�o de la fecha especificada.

EJEMPLOS: 
*/
if object_id ('libros') is not null
  drop table libros;

create table libros(
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  edicion datetime,
  precio decimal(6,2)
);

go

set dateformat ymd;

insert into libros 
  values('El aleph','Borges','Emece','1980/10/10',25.33);
insert into libros 
  values('Java en 10 minutos','Mario Molina','Siglo XXI','2000/05/05',50.65);
insert into libros 
values('Alicia en el pais de las maravillas','Lewis Carroll','Emece','2000/08/09',19.95);
insert into libros 
  values('Aprenda PHP','Mario Molina','Siglo XXI','2000/02/04',45);

-- Mostramos el t�tulo del libro y el a�o de edici�n:
select titulo, datepart (year,edicion) from libros;

-- Mostramos el t�tulo del libro y el nombre del mes de edici�n:
select titulo, datename (month,edicion) from libros;

-- Mostramos el t�tulo del libro y los a�os que tienen de editados:
select titulo, datediff(year,edicion,getdate()) from libros;

-- Muestre los t�tulos de los libros que se editaron el d�a 9, de cualquier mes de cualquier a�o:
 select titulo, edicion from libros
  where datepart(day,edicion)=9;



         -- 28) Ordenar registros (order by)
if object_id ('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  primary key (codigo)
);

go

insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25.33);
insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.65);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.95);
insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta',15);

-- Recuperamos los registros ordenados por el t�tulo:
select * from libros
 order by titulo; 

-- Recuperamos los registros ordenados por el t�tulo de manera desacendente:
select * from libros
 order by titulo desc; 

-- Ordenamos por dos campos:
 select * from libros
  order by titulo,editorial;

-- Ordenamos por un campo que no se lista en la selecci�n:
 select titulo, autor
  from libros
  order by precio;

-- Ordenamos por un valor calculado:
 select titulo, autor, editorial,
        precio+(precio*0.1) as 'precio con descuento'
   from libros
   order by 4;



         -- 29) Operadores l�gicos ( and - or - not)
/*
Hasta el momento, hemos aprendido a establecer una condici�n con "where" utilizando operadores relacionales. Podemos establecer m�s de una condici�n con la cl�usula "where", para ello aprenderemos los operadores l�gicos.
Son los siguientes:
- and, significa "y",
- or, significa "y/o",
- not, significa "no", invierte el resultado
- (), par�ntesis

EJEMPLOS: 
*/
if object_id ('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
);

go

insert into libros
  values('El aleph','Borges','Emece',15.90);
insert into libros
  values('Antolog�a po�tica','Borges','Planeta',39.50);
insert into libros
  values('Java en 10 minutos','Mario Molina','Planeta',50.50);
insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90);
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',25.90);
insert into libros
  values('Martin Fierro','Jose Hernandez','Paidos',16.80);
insert into libros
  values('Aprenda PHP','Mario Molina','Emece',19.50);
insert into libros
  values('Cervantes y el quijote','Borges','Paidos',18.40);

-- Recuperamos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20 pesos:
select * from libros
  where autor='Borges' and precio<=20;

-- Seleccionamos los libros cuyo autor es "Borges" y/o cuya editorial es "Planeta":
select * from libros
  where autor='Borges' or editorial='Planeta';

-- Recuperamos los libros cuya editorial NO es "Planeta":
 select * from libros
  where not editorial='Planeta';

-- Veamos c�mo el uso de par�ntesis hace que SQL Server eval�e en forma diferente ciertas consultas aparentemente iguales:
-- CASO 1: 
 select * from libros
  where (autor='Borges') or (editorial='Paidos' and precio<20);

-- CASO 2: 
 select * from libros
  where (autor='Borges' or editorial='Paidos') and (precio<20);



         -- 30) Otros operadores relacionales (is null)
/*
Existen otro operador relacional "is null".
Se emplea el operador "is null" para recuperar los registros en los cuales est� almacenado el valor "null" en un campo espec�fico:

 select * from libros
  where editorial is null;

Para obtener los registros que no contiene "null", se puede emplear "is not null", esto mostrar� los registros con valores conocidos.
Siempre que sea posible, emplee condiciones de b�squeda positivas ("is null"), evite las negativas ("is not null") porque con ellas se eval�an todos los registros y esto hace m�s lenta la recuperaci�n de los datos.
*/



         -- 31) Otros operadores relacionales (between)
/*
"between" significa "entre". Trabaja con intervalo de valores.
Este operador se puede emplear con tipos de datos num�ricos y money (en tales casos incluyen los valores m�nimo y m�ximo) y tipos de datos fecha y hora (incluye s�lo el valor m�nimo).
No tiene en cuenta los valores "null".
Si agregamos el operador "not" antes de "between" el resultado se invierte, es decir, se recuperan los registros que est�n fuera del intervalo especificado. 
EJEMPLOS: 
*/
-- ANTES: 
 select * from libros
  where precio>=20 and
  precio<=40;

-- AHORA: 
-- Entre: 
 select * from libros
  where precio between 20 and 40;

-- Antes y despues de: 
 select *from libros
  where precio not between 20 and 35;



         -- 32) Otros operadores relacionales (in)
/*
Se utiliza "in" para averiguar si el valor de un campo est� incluido en una lista de valores especificada.
En la siguiente sentencia usamos "in" para averiguar si el valor del campo autor est� incluido en la lista de valores especificada (en este caso, 2 cadenas).

EJEMPLOS: 
*/
-- Para recuperar los libros cuyo autor sea 'Paenza' o 'Borges':
-- ANTES: 
select *from libros
  where autor='Borges' or autor='Paenza';

-- AHORA: 
select * from libros
  where autor in('Borges','Paenza');

-- Para recuperar los libros cuyo autor NO sea 'Paenza' o 'Borges':
-- ANTES: 
select * from libros
  where autor<>'Borges' and
  autor<>'Paenza';

-- AHORA: 
select * from libros
  where autor not in ('Borges','Paenza');



         -- 33) B�squeda de patrones (like - not like)
/*
Existe un operador relacional que se usa para realizar comparaciones exclusivamente de cadenas, "like" y "not like". "like" y "not like" son operadores de comparaci�n que se�alan igualdad o diferencia.
Podemos comparar trozos de cadenas de caracteres para realizar consultas. 
- El s�mbolo "%" (porcentaje) reemplaza cualquier cantidad de caracteres (incluyendo ning�n caracter). Es un caracter comod�n. 
- El gui�n bajo "_" reemplaza un caracter, es otro caracter comod�n.
- Otro caracter comod�n es [] reemplaza cualquier car�cter contenido en el conjunto especificado dentro de los corchetes.
. ... like '[a-cf-i]%': busca cadenas que comiencen con a,b,c,f,g,h o i;
. ... like '[-acfi]%': busca cadenas que comiencen con -,a,c,f o i;
. ... like 'A[_]9%': busca cadenas que comiencen con 'A_9';
. ... like 'A[nm]%': busca cadenas que comiencen con 'An' o 'Am'.
- El cuarto caracter comod�n es [^] reemplaza cualquier caracter NO presente en el conjunto especificado dentro de los corchetes.
- "like" se emplea con tipos de datos char, nchar, varchar, nvarchar o datetime. Si empleamos "like" con tipos de datos que no son caracteres, SQL Server convierte (si es posible) el tipo de dato a caracter.
- Para b�squedas de caracteres comodines como literales, debe incluirlo dentro de corchetes, por ejemplo, si busca:
. ... like '%[%]%': busca cadenas que contengan el signo '%';
.. .. like '%[_]%': busca cadenas que contengan el signo '_';
. ... like '%[[]%': busca cadenas que contengan el signo '[';
*/
SELECT * FROM LIBROS;
INSERT INTO LIBROS VALUES ('Antolog�a po�tica','J. L. Borges','Planeta',null)

-- Para recuperar todos los registros cuyo autor contenga la cadena "Borges" debemos tipear:
 select * from libros
  where autor like '%Borges%';

-- Para seleccionar todos los libros que comiencen con "M":
 select * from libros
  where titulo like 'M%';

-- Queremos ver los libros de "Lewis Carroll" pero no recordamos si se escribe "Carroll" o "Carrolt", entonces tipeamos esta condici�n:
 select * from libros
  where autor like '%Carrol_';

-- Para seleccionar los libros cuya editorial NO comienza con las letras "P" ni "N" tipeamos:
 select titulo,autor,editorial
  from libros
  where editorial like '[^PN]%';

-- Queremos buscar todos los libros cuyo precio se encuentre entre 10.00 y 19.99:
 select titulo,precio from libros
  where precio like '1_.%';

-- Queremos los libros que NO incluyen centavos en sus precios:
 select titulo,precio from libros
  where precio like '%.00';



         -- 34) Contar registros (count)
/*
La funci�n "count()" cuenta la cantidad de registros de una tabla, incluyendo los que tienen valor nulo.
Para contar los registros sin tener en cuenta los que tienen valor nulo, usamos la funci�n "count()" y en los par�ntesis colocamos el nombre del campo que necesitamos contar.

Note que "count(*)" retorna la cantidad de registros de una tabla (incluyendo los que tienen valor "null") mientras que "count(<nombreTabla>)" retorna la cantidad de registros en los cuales el campo "<nombreTabla>" no es nulo. 
No es lo mismo. "count(*)" cuenta registros, si en lugar de un asterisco colocamos como argumento el nombre de un campo, se contabilizan los registros cuyo valor en ese campo NO es nulo.

EJEMPLOS: 
*/
-- Averiguemos la cantidad de libros usando la funci�n "count()":
select count(*)
  from libros;

-- Contamos los libros de editorial "Planeta":
select count(*)
  from libros
  where editorial='Planeta';

-- Contamos los registros que tienen precio (sin tener en cuenta los que tienen valor nulo),
select count(precio)
  from libros;



         -- 36) Funciones de agrupamiento (count - sum - min - max - avg)
/*
Hemos visto que SQL Server tiene funciones que nos permiten contar registros, calcular sumas, promedios, obtener valores m�ximos y m�nimos, las funciones de agregado.
Ya hemos aprendido una de ellas, "count()", veamos otras.

- count: se puede emplear con cualquier tipo de dato.
. La funci�n "count()" cuenta la cantidad de registros de una tabla, incluyendo los que tienen valor nulo.

- min y max: con cualquier tipo de dato.
. Para averiguar el valor m�ximo o m�nimo de un campo usamos las funciones "max()" y "min()" respectivamente.

- sum y avg: s�lo en campos de tipo num�rico.
. La funci�n "sum()" retorna la suma de los valores que contiene el campo especificado.
. La funci�n "avg()" retorna el valor promedio de los valores del campo especificado.

Ahora podemos entender porque estas funciones se denominan "funciones de agrupamiento", porque operan sobre conjuntos de registros, no con datos individuales.
Todas las funciones de agregado, excepto "count(*)", excluye los valores nulos de los campos. "count(*)" cuenta todos los registros, incluidos los que contienen "null".

EJEMPLOS: 
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30) default 'Desconocido',
  editorial varchar(15),
  precio decimal(5,2),
  cantidad tinyint,
  primary key(codigo)
);

go

insert into libros
  values('El aleph','Borges','Planeta',15,null);
insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
insert into libros
  values('Antologia poetica','J.L. Borges','Planeta',null,150);
insert into libros
  values('Aprenda PHP','Mario Molina','Emece',18.20,null);
insert into libros
  values('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100);
insert into libros
  values('Manual de PHP', 'J.C. Paez', 'Siglo XXI',31.80,120);
insert into libros
  values('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
insert into libros
  values('Harry Potter y la camara secreta','J.K. Rowling','Emece',46.00,100);
insert into libros (titulo,autor,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll',220);
insert into libros (titulo,autor,cantidad)
  values('PHP de la A a la Z',default,0);

-- Cantidad total de libros, sumamos las cantidades de cada uno:
 select sum(cantidad)
  from libros;

-- Para conocer cu�ntos libros tenemos de la editorial "Emece":
 select sum(cantidad)
  from libros
  where editorial='Emece';

-- Queremos saber cu�l es el libro m�s costoso:
 select max(precio)
  from libros;

-- Para conocer el precio m�nimo de los libros de "Rowling":
 select min(precio)
  from libros
  where autor like '%Rowling%';

 -- Queremos saber el promedio del precio de los libros referentes a "PHP":
 select avg(precio)
  from libros
  where titulo like '%PHP%';



         -- 37) Agrupar registros (group by)
/*
Las funciones de agregado solas producen un valor de resumen para todos los registros de un campo. 
Podemos generar valores de resumen para un solo campo, combinando las funciones de agregado con la cl�usula "group by", que agrupa registros para consultas detalladas.
*/
-- Queremos saber la cantidad de libros de cada editorial, podemos tipear la siguiente sentencia:
-- Antes: 
 select count(*) from libros
  where editorial='Planeta';
 select count(*) from libros
  where editorial='Emece';
 select count(*) from libros
  where editorial='Paidos';
 select count(*) from libros
  where editorial=null;
 select count(*) from libros
  where editorial='Siglo XXI';

-- Ahora: 
 select editorial, count(*) as cantidad
  from libros
  group by editorial;

-- Para conocer el total en dinero de los libros agrupados por editorial:
 select editorial, sum(precio)
  from libros
  group by editorial;

-- Para saber el m�ximo y m�nimo valor de los libros agrupados por editorial:
 select editorial,
  max(precio) as mayor,
  min(precio) as menor
  from libros
  group by editorial;

-- Para calcular el promedio del valor de los libros agrupados por editorial:
 select editorial, avg(precio)
  from libros
  group by editorial;

-- Vamos a contar y agrupar por editorial considerando solamente los libros cuyo precio sea menor a 30 pesos:
 select editorial, count(*) as 'Precio menor a 30'
  from libros
  where precio<30
  group by editorial;

-- Vamos a contar y agrupar por editorial considerando solamente los libros cuyo precio sea menor a 30 pesos (incluyendo todos los valores de editorial, incluso los que devuelven cero o "null" en la columna de agregado):
 select editorial, count(*) as 'Precio menor a 30'
  from libros
  where precio<30
  group by all editorial;



         -- 38) Seleccionar grupos (having)
/*
As� como la cl�usula "where" permite seleccionar (o rechazar) registros individuales; la cl�usula "having" permite seleccionar (o rechazar) un grupo de registros.
Se utiliza "having", seguido de la condici�n de b�squeda, para seleccionar ciertas filas retornadas por la cl�usula "group by".

En algunos casos es posible confundir las cl�usulas "where" y "having". En algunos casos, ambas devuelven el mismo resultado, pero son diferentes. 
La primera, selecciona todos los registros rechazando los de <condicion> y luego los agrupa para contarlos. 
La segunda, selecciona todos los registros, los agrupa para contarlos y finalmente rechaza lo que cumplen <condicion>.

EJEMPLOS: 
*/

-- Si queremos saber la cantidad de libros agrupados por editorial pero considerando s�lo los que devuelvan un valor mayor a 2, usamos la siguiente instrucci�n:

 select editorial, count(*) from libros
  group by editorial
  having count(*)>2;

-- En la siguientes sentencias, ambas devuelven el mismo resultado, aunque operan diferente: 
-- CASO 1:
 select editorial, count(*) from libros
  where editorial<>'Planeta'
  group by editorial;

-- CASO 2: 
 select editorial, count(*) from libros
  group by editorial
  having editorial<>'Planeta';

-- Queremos la cantidad de libros, sin considerar los que tienen precio nulo, agrupados por editorial, sin considerar la editorial "Planeta":
 select editorial, count(*) from libros
  where precio is not null
  group by editorial
  having editorial<>'Planeta';

-- Para encontrar el mayor valor de los libros agrupados y ordenados por editorial y seleccionar las filas que tengan un valor menor a 100 y mayor a 30:
 select editorial, max(precio) as 'mayor'
  from libros
  group by editorial
  having min(precio)<100 and min(precio)>30
  order by editorial; 



         -- 43) Registros duplicados (distinct)
/*
Con la cl�usula "distinct" se especifica que los registros con ciertos datos duplicados sean obviadas en el resultado.

EJEMPLOS: 
*/
-- Para obtener la lista de autores sin repetici�n usamos:
 select distinct autor from libros;

-- Si s�lo queremos la lista de autores conocidos, es decir, no queremos incluir "null" en la lista, podemos utilizar la sentencia siguiente:
 select distinct autor from libros
  where autor is not null;

-- Para contar los distintos autores, sin considerar el valor "null" usamos:
 select count(distinct autor)
  from libros;

-- Queremos conocer los distintos autores de la editorial "Planeta":
 select distinct autor from libros
  where editorial='Planeta';

-- Para contar los diferentes autores por editorial:
 select editorial, count(distinct autor)
  from libros
  group by editorial;

-- Para mostrar los t�tulos y editoriales de los libros sin repetir t�tulos ni editoriales, usamos:
 select distinct titulo,editorial
  from libros
  order by titulo;



         -- 44) Cl�usula top
/*
La palabra clave "top" se emplea para obtener s�lo una cantidad limitada de registros, los primeros n registros de una consulta.
- Luego del "select" se coloca "top" seguido de un n�mero entero positivo y luego se contin�a con la consulta.

Cuando se combina con "order by" es posible emplear tambi�n la cl�usula "with ties". 
Esta cl�usula permite incluir en la selecci�n, todos los registros que tengan el mismo valor del campo por el que se ordena en la �ltima posici�n. Es decir, 
si el valor del campo por el cual se ordena el �ltimo registro retornado (el n�mero n) est� repetido en los siguientes registros (es decir, el n+1 tiene el mismo valor que n, y el n+2, etc.), lo incluye en la selecci�n.

EJEMPLOS:
*/
-- Solicitamos los t�tulos y autores de los 3 primeros libros, ordenados por autor.
 select top 3 titulo,autor 
  from libros
  order by autor;

-- Solicitamos el retorno de los primeros 3 registros; en caso que el registro n�mero 4 (y los posteriores), tengan el mismo valor en "autor" que el �ltimo registro retornado (n�mero 3), tambi�n aparecer�n en la selecci�n.
 select top 3 with ties
  * from libros
  order by autor;

-- Se recuperan la mitad de registros de la tabla 'libros'.
 select top 50 percent
  * from libros
  order by autor;



         -- 45) Clave primaria compuesta
/*
Necesitamos definir una clave primaria para una tabla con los datos descriptos arriba. No podemos usar solamente la patente porque un mismo auto puede ingresar m�s de una vez en el d�a a la playa; 
tampoco podemos usar la hora de entrada porque varios autos pueden ingresar a una misma hora. Tampoco sirven los otros campos.

Como ning�n campo, por si s�lo cumple con la condici�n para ser clave, es decir, debe identificar un solo registro, el valor no puede repetirse, debemos usar 2 campos.
Definimos una clave compuesta cuando ning�n campo por si solo cumple con la condici�n para ser clave.

En este ejemplo, un auto puede ingresar varias veces en un d�a a la playa, pero siempre ser� a distinta hora.
Usamos 2 campos como clave, la patente junto con la hora de llegada, as� identificamos un�vocamente cada registro.

Al ingresar los registros, SQL Server controla que los valores para los campos establecidos como clave primaria no est�n repetidos en la tabla; 
si estuviesen repetidos, muestra un mensaje y la inserci�n no se realiza. Lo mismo sucede si realizamos una actualizaci�n.

EJEMPLOS: 
*/
 create table vehiculos(
  patente char(6) not null,
  tipo char(1),--'a'=auto, 'm'=moto
  horallegada datetime,
  horasalida datetime,
  primary key(patente,horallegada)
 );



         -- 47) Restricci�n default
/*
La restricci�n "default" especifica un valor por defecto para un campo cuando no se inserta expl�citamente en un comando "insert".
Por convenci�n, cuando demos el nombre a las restricciones "default" emplearemos un formato similar al que le da SQL Server: "DF_NOMBRETABLA_NOMBRECAMPO".
La restricci�n "default" acepta valores tomados de funciones del sistema, por ejemplo, podemos establecer que el valor por defecto de un campo de tipo datetime sea "getdate()".

Podemos ver informaci�n referente a las restriciones de una tabla con el procedimiento almacenado "sp_helpcontraint":
aparecen varias columnas con la siguiente informaci�n:
- constraint_type: el tipo de restricci�n y sobre qu� campo est� establecida (DEFAULT on column autor),
- constraint_name: el nombre de la restricci�n (DF_libros_autor),
- delete_action y update_action: no tienen valores para este tipo de restricci�n.
- status_enabled y status_for_replication: no tienen valores para este tipo de restricci�n.
- constraint_keys: el valor por defecto (Desconocido).

Entonces, la restricci�n "default" especifica un valor por defecto para un campo cuando no se inserta expl�citamente en un "insert", se puede establecer uno por campo y no se puede emplear junto con la propiedad "identity".

EJEMPLOS: 
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  editorial varchar(15),
  precio decimal(6,2)
);

go

insert into libros (titulo,editorial) values('Martin Fierro','Emece');
insert into libros (titulo,editorial) values('Aprenda PHP','Emece');

-- Veamos que SQL Server cre� autom�ticamente una restricci�n "default" para el campo "autor":
exec sp_helpconstraint libros;

drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(15),
  precio decimal(6,2)
);

go

-- Agregamos una restricci�n "default" empleando "alter table" para que almacene el valor "Desconocido" en el campo "autor":
alter table libros
  add constraint DF_libros_autor
  default 'Desconocido'
  for autor;

-- Veamos la restrici�n agregada anteriormente con el procedimiento almacenado "sp_helpcontraint":
exec sp_helpconstraint libros;



         -- 65) Trabajar con varias tablas (Join)
/*
Para evitar la repetici�n de datos y ocupar menos espacio, se separa la informaci�n en varias tablas. Cada tabla almacena parte de la informaci�n que necesitamos registrar.

Por ejemplo, los datos de nuestra tabla "libros" podr�an separarse en 2 tablas, una llamada "libros" y otra "editoriales" que guardar� la informaci�n de las editoriales.
En nuestra tabla "libros" haremos referencia a la editorial colocando un c�digo que la identifique.

De esta manera, evitamos almacenar tantas veces los nombres de las editoriales en la tabla "libros" y guardamos el nombre en la tabla "editoriales"; 
para indicar la editorial de cada libro agregamos un campo que hace referencia al c�digo de la editorial en la tabla "libros" y en "editoriales".

Cuando recuperamos los registros de libros, vemos que en el campo "codigoeditorial" aparece el c�digo, pero no sabemos el nombre de la editorial.
Para obtener los datos de cada libro, incluyendo el nombre de la editorial, necesitamos consultar ambas tablas, traer informaci�n de las dos.

Cuando obtenemos informaci�n de m�s de una tabla decimos que hacemos un "join" (combinaci�n).

Resumiendo: si distribuimos la informaci�n en varias tablas evitamos la redundancia de datos y ocupamos menos espacio f�sico en el disco. 
Un join es una operaci�n que relaciona dos o m�s tablas para obtener un resultado que incluya datos (campos y registros) de ambas; las tablas participantes se combinan seg�n los campos comunes a ambas tablas.

La sintaxis b�sica es la siguiente:
 select CAMPOS
  from TABLA1
  join TABLA2
  on CONDICIONdeCOMBINACION;

EJEMPLOS: 
*/
if OBJECT_ID('libros') is not null drop table libros;
if OBJECT_ID('editoriales') is not null drop table editoriales;

 create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30) not null default 'Desconocido',
  codigoeditorial tinyint not null,
  precio decimal(5,2),
  primary key (codigo)
 );

 create table editoriales(
  codigo tinyint identity,
  nombre varchar(20) not null,
  primary key(codigo)
 );

 go

insert into editoriales values('Planeta');
insert into editoriales values('Emece');
insert into editoriales values('Siglo XXI');

insert into libros values('El aleph','Borges',2,20);
insert into libros values('Martin Fierro','Jose Hernandez',1,30);
insert into libros values('Aprenda PHP','Mario Molina',3,50);
insert into libros values('Java en 10 minutos',default,3,45);

-- Recuperamos los datos de libros:
select * from libros;

-- Realizamos un join para obtener datos de ambas tablas (titulo, autor y nombre de la editorial):
select titulo autor, nombre from libros
join editoriales
on codigoeditorial=editoriales.codigo;

-- Mostramos el c�digo del libro, t�tulo, autor, nombre de la editorial y el precio realizando un join y empleando alias:
select l.codigo, l.titulo, l.autor, e.nombre, l.precio
from libros as l
join editoriales as e
on l.codigoeditorial=e.codigo;

-- Realizamos la misma consulta anterior agregando un "where" para obtener solamente los libros de la editorial "Siglo XXI":
select l.codigo, l.titulo, l.autor, e.nombre, l.precio
from libros as l 
join editoriales as e
on l.codigoeditorial=e.codigo
where e.nombre like '%Siglo XXI%';

-- Obtenemos t�tulo, autor y nombre de la editorial, esta vez ordenados por t�tulo:
select l.titulo, l.autor, e.nombre 
from libros as l
join editoriales as e
on l.codigoeditorial=e.codigo
order by titulo;



         -- 75) Clave for�nea
/*
Un campo que no es clave primaria en una tabla y sirve para enlazar sus valores con otra tabla en la cual es clave primaria se denomina clave for�nea, externa o ajena.

En el ejemplo de la librer�a en que utilizamos las tablas "libros" y "editoriales" con estos campos:
. libros: codigo (clave primaria), titulo, autor, codigoeditorial, precio y
. editoriales: codigo (clave primaria), nombre.

el campo "codigoeditorial" de "libros" es una clave for�nea, se emplea para enlazar la tabla "libros" con "editoriales" y es clave primaria en "editoriales" con el nombre "codigo".

Las claves for�neas y las claves primarias deben ser del mismo tipo para poder enlazarse. Si modificamos una, debemos modificar la otra para que los valores se correspondan.
Cuando alteramos una tabla, debemos tener cuidado con las claves for�neas. Si modificamos el tipo, longitud o atributos de una clave for�nea, �sta puede quedar inhabilitada para hacer los enlaces.

Entonces, una clave for�nea es un campo (o varios) empleados para enlazar datos de 2 tablas, para establecer un "join" con otra tabla en la cual es clave primaria.
*/



         -- 76) Restricciones (foreign key)
/*
Con la restricci�n "foreign key" se define un campo (o varios) cuyos valores coinciden con la clave primaria de la misma tabla o de otra, es decir, 
se define una referencia a un campo con una restricci�n "primary key" o "unique" de la misma tabla o de otra.

La integridad referencial asegura que se mantengan las referencias entre las claves primarias y las externas. 
Por ejemplo, controla que si se agrega un c�digo de editorial en la tabla "libros", tal c�digo exista en la tabla "editoriales".

Tambi�n controla que no pueda eliminarse un registro de una tabla ni modificar la clave primaria si una clave externa hace referencia al registro. 
Por ejemplo, que no se pueda eliminar o modificar un c�digo de "editoriales" si existen libros con dicho c�digo.

EJEMPLO: 
*/

-- Para agregar una restricci�n "foreign key" al campo "codigoeditorial" de "libros", tipeamos:
 alter table libros
 add constraint FK_libros_codigoeditorial
  foreign key (codigoeditorial)
  references editoriales(codigo);
-- En el ejemplo implementamos una restricci�n "foreign key" para asegurarnos que el c�digo de la editorial de la tabla "libros" ("codigoeditorial") est� asociada con un c�digo v�lido en la tabla "editoriales" ("codigo").

exec sp_helpconstraint libros;
exec sp_helpconstraint editoriales;



         -- 77) Restricciones foreign key en la misma tabla

/*
La restricci�n "foreign key", que define una referencia a un campo con una restricci�n "primary key" o "unique" se puede definir entre distintas tablas (como hemos aprendido) o dentro de la misma tabla.

Veamos un ejemplo en el cual definimos esta restricci�n dentro de la misma tabla:
Una mutual almacena los datos de sus afiliados en una tabla llamada "afiliados". 
Algunos afiliados inscriben a sus familiares. La tabla contiene un campo que hace referencia al afiliado que lo incorpor� a la mutual, del cual dependen.

La estructura de la tabla es la siguiente:
 create table afiliados(
  numero int identity not null,
  documento char(8) not null,
  nombre varchar(30),
  afiliadotitular int,
  primary key (documento),
  unique (numero)
 );

En caso que un afiliado no haya sido incorporado a la mutual por otro afiliado, el campo "afiliadotitular" almacenar� "null".
Establecemos una restricci�n "foreign key" para asegurarnos que el n�mero de afiliado que se ingrese en el campo "afiliadotitular" exista en la tabla "afiliados":
 alter table afiliados
  add constraint FK_afiliados_afiliadotitular
  foreign key (afiliadotitular)
  references afiliados (numero);

La sintaxis es la misma, excepto que la tabla se autoreferencia.
Luego de aplicar esta restricci�n, cada vez que se ingrese un valor en el campo "afiliadotitular", SQL Server controlar� que dicho n�mero exista en la tabla, si no existe, mostrar� un mensaje de error.
Si intentamos eliminar un afiliado que es titular de otros afiliados, no se podr� hacer, a menos que se haya especificado la acci�n en cascada (pr�ximo tema).
*/



         -- 82) Agregar y eliminar campos ( alter table - add - drop)
/*
El operador "union" combina el resultado de dos o m�s instrucciones "select" en un �nico resultado.

Se usa cuando los datos que se quieren obtener pertenecen a distintas tablas y no se puede acceder a ellos con una sola consulta.
Es necesario que las tablas referenciadas tengan tipos de datos similares, la misma cantidad de campos y el mismo orden de campos en la lista de selecci�n de cada consulta. 
No se incluyen las filas duplicadas en el resultado, a menos que coloque la opci�n "all".
Se deben especificar los nombres de los campos en la primera instrucci�n "select".
Puede emplear la cl�usula "order by".
Puede dividir una consulta compleja en varias consultas "select" y luego emplear el operador "union" para combinarlas.

EJEMPLOS: 
*/
if object_id('alumnos') is not null
  drop table alumnos;
if object_id('profesores') is not null
  drop table profesores;

create table profesores(
  documento varchar(8) not null,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(documento)
);
create table alumnos(
  documento varchar(8) not null,
  nombre varchar (30),
  domicilio varchar(30),
  primary key(documento)
);

go

insert into alumnos values('30000000','Juan Perez','Colon 123');
insert into alumnos values('30111111','Marta Morales','Caseros 222');
insert into alumnos values('30222222','Laura Torres','San Martin 987');
insert into alumnos values('30333333','Mariano Juarez','Avellaneda 34');
insert into alumnos values('23333333','Federico Lopez','Colon 987');
insert into profesores values('22222222','Susana Molina','Sucre 345');
insert into profesores values('23333333','Federico Lopez','Colon 987');

-- Nombre y domicilio de profesores y alumnos:
select nombre, domicilio from profesores
union
select nombre, domicilio from alumnos;

-- Mostrar las filas duplicadas de ambas tablas (existe un profesor que tambi�n est� presente en la tabla "alumnos"):
select nombre, domicilio from profesores
union all 
select nombre, domicilio from alumnos;

-- Ordenamos por domicilio:
select nombre, domicilio from profesores 
union all 
select nombre, domicilio from alumnos
order by domicilio;

-- agregar una columna extra a la consulta con el encabezado "condicion" en la que aparezca el literal "profesor" o "alumno" seg�n si la persona es uno u otro:
select nombre, domicilio, 'Profesor' as condicion from profesores 
union all 
select nombre, domicilio, 'Alumno' from alumnos
order by domicilio;



         -- 83) Agregar y eliminar campos ( alter table - add - drop)
/*
"alter table" permite modificar la estructura de una tabla.

EJEMPLOS: 
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  titulo varchar(30),
  editorial varchar(15),
  edicion datetime,
  precio decimal(6,2)
);

go

insert into libros (titulo,editorial,precio)
  values ('El aleph','Emece',25.50);

-- Agregamos el campo "cantidad" a la tabla "libros", de tipo tinyint, que acepta valores nulos:
alter table libros 
add cantidad tinyint null;

-- Agregamos un campo "codigo" a la tabla "libros", de tipo int con el atributo "identity":
alter table libros 
add codigo int identity;

-- Intentamos agregar un campo llamado "autor" de tipo varchar(30) que NO acepte valores nulos (GENERA ERROR):
alter table libros 
add autor varchar(30) not null;

-- Agregar un campo llamado "autor" de tipo varchar(20) pero con un valor por defecto: 
alter table libros 
add autor varchar(30) default 'Desconocido' not null;

-- Eliminamos el campo "precio" de la tabla "libros":
alter table libros 
drop column precio;

-- Eliminamos varios campos en una sola sentencia:
alter table libros
drop column codigo, edicion;

exec sp_columns libros;



         -- 84) Alterar campos (alter table - alter)
/*
Hemos visto que "alter table" permite modificar la estructura de una tabla. Tambi�n podemos utilizarla para modificar campos de una tabla.

La sintaxis b�sica para modificar un campo existente es la siguiente:

 alter table NOMBRETABLA
  alter column CAMPO NUEVADEFINICION;

EJEMPLOS: 
*/
-- Modificamos el campo "titulo" para que acepte una cadena m�s larga y no admita valores nulos:
alter table libros
alter column titulo varchar(50) not null;

exec sp_columns libros;
-- Eliminamos registro que tienen en el campo autor el valor null y realizamos la modificaci�n del campo:
delete from libros where autor is null;
alter table libros 
alter column autor varchar(30) not null;

-- Intentamos quitar el atributo "identity" del campo "codigo" y lo redefinimos como "smallint" (no se produce el cambio):
alter table libros 
alter column codigo smallint;



         -- 92) Subconsultas como expresi�n
/*
Una subconsulta puede reemplazar una expresi�n. Dicha subconsulta debe devolver un valor escalar (o una lista de valores de un campo).
Las subconsultas que retornan un solo valor escalar se utiliza con un operador de comparaci�n o en lugar de una expresi�n:

Las subconsultas que retornan un solo valor escalar se utiliza con un operador de comparaci�n o en lugar de una expresi�n:
 select CAMPOS
  from TABLA
  where CAMPO OPERADOR (SUBCONSULTA);

select CAMPO OPERADOR (SUBCONSULTA)
  from TABLA;

Para actualizar un registro empleando subconsulta la sintaxis b�sica es la siguiente:
 update TABLA set CAMPO=NUEVOVALOR
  where CAMPO= (SUBCONSULTA);

Para eliminar registros empleando subconsulta empleamos la siguiente sintaxis b�sica:
 delete from TABLA
  where CAMPO=(SUBCONSULTA);

EJEMPLOS: 
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2)
);

go

insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',20.00);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Plaza',35.00);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI',40.00);
insert into libros values('El aleph','Borges','Emece',10.00);
insert into libros values('Ilusiones','Richard Bach','Planeta',15.00);
insert into libros values('Java en 10 minutos','Mario Molina','Siglo XXI',50.00);
insert into libros values('Martin Fierro','Jose Hernandez','Planeta',20.00);
insert into libros values('Martin Fierro','Jose Hernandez','Emece',30.00);
insert into libros values('Uno','Richard Bach','Planeta',10.00);

-- Obtenemos el t�tulo, precio de un libro espec�fico y la diferencia entre su precio y el m�ximo valor:
select titulo, precio, precio-(select max(precio) from libros) as Diferencia from libros;
-- Mostramos el t�tulo y precio del libro m�s costoso:
select titulo, autor, precio 
from libros where 
precio=(select max(precio) from libros);

-- Actualizamos el precio del libro con m�ximo valor:
update libros set precio=50
where precio=(select max(precio) from libros);

-- Eliminamos los libros con precio menor:
delete from libros
where precio= (select min(precio) from libros);

         -- 93) Subconsultas con in
/*
Vimos que una subconsulta puede reemplazar una expresi�n. Dicha subconsulta debe devolver un valor escalar o una lista de valores de un campo; las subconsultas que retornan una lista de valores reemplazan a una expresi�n en una cl�usula "where" que contiene la palabra clave "in".

El resultado de una subconsulta con "in" (o "not in") es una lista. Luego que la subconsulta retorna resultados, la consulta exterior los usa.

La sintaxis b�sica es la siguiente:
 ...where EXPRESION in (SUBCONSULTA);

EJEMPLOS: 
*/
if object_id('libros') is not null
  drop table libros;
if object_id('editoriales') is not null
  drop table editoriales;

create table editoriales(
  codigo tinyint identity,
  nombre varchar(30),
  primary key (codigo)
);
 
create table libros (
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

-- Queremos conocer el nombre de las editoriales que han publicado libros del autor "Richard Bach":
select nombre from editoriales
where codigo in (select codigoeditorial from libros where autor='Richard Bach')

-- Probamos la subconsulta separada de la consulta exterior para verificar que retorna una lista de valores de un solo campo:
select codigoeditorial
  from libros
  where autor='Richard Bach';

-- Podemos reemplazar por un "join" la primera consulta:
select distinct nombre from editoriales as e
join libros 
on codigoeditorial=e.codigo
where autor='Richard Bach';

-- Tambi�n podemos buscar las editoriales que no han publicado libros de "Richard Bach":
-- MANERA 1: 
select nombre 
from editoriales
where codigo in (select codigoeditorial from libros where autor<>'Richard Bach');

-- MANERA 2: 
select distinct nombre 
from editoriales as e
join libros 
on e.codigo=codigoeditorial
where autor<>'Richard Bach';

         -- 101) Crear tabla a partir de otra (select - into)
/*
Podemos crear una tabla e insertar datos en ella en una sola sentencia consultando otra tabla (o varias) con esta sintaxis:
 select CAMPOSNUEVATABLA
  into NUEVATABLA
  from TABLA
  where CONDICION;

Es decir, se crea una nueva tabla y se inserta en ella el resultado de una consulta a otra tabla.
Los campos de la nueva tabla tienen el mismo nombre, tipo de dato y valores almacenados que los campos listados de la tabla consultada; si se quiere dar otro nombre a los campos de la nueva tabla se deben especificar alias.
Entonces, luego de la lista de selecci�n de campos de la tabla a consultar, se coloca "into" seguido del nombre de la nueva tabla y se sigue con la consulta.

Podemos emplear "group by", funciones de agrupamiento y "order by" en las consultas. Tambi�n podemos emplear "select... into" con combinaciones, para crear una tabla que contenga datos de 2 o m�s tablas.

EJEMPLOS: 
*/
if object_id('libros')is not null
  drop table libros;
if object_id('editoriales')is not null
  drop table editoriales;

create table libros( 
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo)
); 

go

insert into libros values('Uno','Richard Bach','Planeta',15);
insert into libros values('El aleph','Borges','Emece',25);
insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45);
insert into libros values('Ilusiones','Richard Bach','Planeta',14);
insert into libros values('Java en 10 minutos','Mario Molina','Nuevo siglo',50);

-- Creamos una tabla llamada "editoriales" que contenga los nombres de las editoriales:
select distinct editorial as nombre
into editoriales
from libros;
-- Necesitamos una nueva tabla llamada "librosporeditorial" que contenga la cantidad de libros de cada editorial:
select editorial as nombre, count(*) as cantidad
into librosporeditorial 
from libros 
group by editorial;

-- Queremos una tabla llamada "ofertas4" que contenga los mismos campos que "libros" y guarde los 4 libros m�s econ�micos:
select top 4 * 
into ofertas4
from libros
order by precio asc;

-- Agregamos una columna a la tabla "editoriales" que contiene la ciudad en la cual est� la casa central de cada editorial:
alter table editoriales 
add ciudad varchar(30);

-- Actualizamos dicho campo:
update editoriales set ciudad='Cordoba' where nombre='Planeta';
update editoriales set ciudad='Cordoba' where nombre='Emece';
update editoriales set ciudad='Buenos Aires' where nombre='Nuevo siglo';

-- Queremos una nueva tabla llamada "librosdecordoba" que contenga los t�tulos y autores de los libros de editoriales de Cordoba. En primer lugar, la eliminamos, si existe:
select titulo, autor 
into librosdecordoba
from libros 
join editoriales as e
on e.nombre=editorial
where ciudad='Cordoba';



         -- 102) go
/*
"go" es un signo de finalizaci�n de un lote de sentencias SQL. No es una sentencia, es un comando.
El lote de sentencias est� compuesto por todas las sentencias antes de "go" o todas las sentencias entre dos "go".

Las sentencias no deben ocupar la misma linea en la que est� "go".
Recuerde que si coloca "go" no debe incluir el "punto y coma" (;) al finalizar una instrucci�n.

Las siguientes sentencias no pueden ejecutarse en el mismo lote: create rule, create default,create view, create procedure, create trigger. Cada una de ellas necesita ejecutarse separ�ndolas con "go".
*/



         -- 103) Vistas
/*
Una vista es una alternativa para mostrar datos de varias tablas. Una vista es como una tabla virtual que almacena una consulta. Los datos accesibles a trav�s de la vista no est�n almacenados en la base de datos como un objeto.
Entonces, una vista almacena una consulta como un objeto para utilizarse posteriormente. Las tablas consultadas en una vista se llaman tablas base. En general, se puede dar un nombre a cualquier consulta y almacenarla como una vista.

Una vista suele llamarse tambi�n tabla virtual porque los resultados que retorna y la manera de referenciarlas es la misma que para una tabla.

Las vistas permiten:
- ocultar informaci�n: permitiendo el acceso a algunos datos y manteniendo oculto el resto de la informaci�n que no se incluye en la vista. 
  El usuario opera con los datos de una vista como si se tratara de una tabla, pudiendo modificar tales datos.
- simplificar la administraci�n de los permisos de usuario: 
  se pueden dar al usuario permisos para que solamente pueda acceder a los datos a trav�s de vistas, en lugar de concederle permisos para acceder a ciertos campos, as� se protegen las tablas base de cambios en su estructura.
- mejorar el rendimiento: se puede evitar tipear instrucciones repetidamente almacenando en una vista el resultado de una consulta compleja que incluya informaci�n de varias tablas.

Podemos crear vistas con: un subconjunto de registros y campos de una tabla; una uni�n de varias tablas; una combinaci�n de varias tablas; un resumen estad�stico de una tabla; un subconjunto de otra vista, combinaci�n de vistas y tablas.
Una vista se define usando un "select".
La sintaxis b�sica parcial para crear una vista es la siguiente:
 create view NOMBREVISTA as
  SENTENCIASSELECT
   from TABLA;

Otra sintaxis es la siguiente:
 create view NOMBREVISTA (NOMBRESDEENCABEZADOS)
  as
  SENTENCIASSELECT
   from TABLA;

El contenido de una vista se muestra con un "select":
 select *from NOMBREVISTA;

Podemos realizar consultas a una vista como si se tratara de una tabla:
 select seccion,count(*) as cantidad
  from vista_empleados
  group by seccion;

EJEMPLOS: 
*/
if object_id('empleados') is not null
  drop table empleados;
if object_id('secciones') is not null
  drop table secciones;

create table secciones(
  codigo tinyint identity,
  nombre varchar(20),
  sueldo decimal(5,2)
   constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
);

create table empleados(
  legajo int identity,
  documento char(8)
   constraint CK_empleados_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  seccion tinyint not null,
  cantidadhijos tinyint
   constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso datetime,
   constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo)
   on update cascade,
  constraint UQ_empleados_documento
   unique(documento)
);

go

insert into secciones values('Administracion',300);
insert into secciones values('Contadur�a',400);
insert into secciones values('Sistemas',500);

insert into empleados values('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10');
insert into empleados values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','1990-02-10');
insert into empleados values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998-07-12');
insert into empleados values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','1998-10-09');
insert into empleados values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000-05-09');

-- Creamos la vista "vista_empleados", que es resultado de una combinaci�n en la cual se muestran 5 campos:
GO
create view vista_empleados (nombre, sexo, seccion, cantidadhijos)
as 
select (e.nombre+' '+apellido), sexo, s.nombre, cantidadhijos 
from empleados as e 
join secciones as s
on e.seccion=s.codigo;
GO
-- Vemos la informaci�n de la vista:
select * from vista_empleados;

-- Realizamos una consulta a la vista como si se tratara de una tabla:
select seccion,count(*) as cantidad
  from vista_empleados
  group by seccion;

-- Eliminamos la vista "vista_empleados_ingreso" si existe:
if object_id('vista_empleados_ingreso') is not null
  drop view vista_empleados_ingreso;

-- Creamos otra vista de "empleados" denominada "vista_empleados_ingreso" que almacena la cantidad de empleados por a�o:
go
create view vista_empleados_ingreso (fecha, cantidad) as
select datepart(year, fechaingreso), count(*)
from empleados
group by datepart(year, fechaingreso);
go

-- Vemos la informaci�n de la vista creada:
select * from vista_empleados_ingreso;



         -- 104) Vistas (informaci�n)
/*
Las vistas son objetos, as� que para obtener informaci�n de ellos pueden usarse los siguientes procedimientos almacenados del sistema:

- "sp_help" sin par�metros nos muestra todos los objetos de la base de datos seleccionada, incluidas las vistas. En la columna "Object_type" aparece "view" si es una vista. 
  Si le enviamos como argumento el nombre de una vista, obtenemos la fecha de creaci�n, propietario, los campos y dem�s informaci�n.
- "sp_helptext" seguido del nombre de una vista nos muestra el texto que la define, excepto si ha sido encriptado.

Ejecutando "sp_depends" seguido del nombre de un objeto, obtenemos 2 resultados:
- nombre, tipo, campos, etc. de los objetos de los cuales depende el objeto nombrado y
- nombre y tipo de los objetos que dependen del objeto nombrado.

Si ejecutamos el procedimiento "sp_depends" seguido del nombre de una vista:
 exec sp_depends vista_empleados;
aparecen las tablas (y dem�s objetos) de las cuales depende la vista, es decir, las tablas referenciadas en la misma.

Si ejecutamos el procedimiento seguido del nombre de una tabla:
 exec sp_depends empleados;
aparecen los objetos que dependen de la tabla, vistas, restricciones, etc.

Tambi�n se puede consultar la tabla del sistema "sysobjects":
 select *from sysobjects;
Nos muestra nombre y varios datos de todos los objetos de la base de datos actual. La columna "xtype" indica el tipo de objeto, si es una vista, aparece 'V'.

Si queremos ver todas las vistas creadas por nosotros, podemos tipear:
 select *from sysobjects
  where xtype='V' and-- tipo vista
  name like 'vista%';--b�squeda con comod�n
*/



         -- 110) Lenguaje de control de flujo (case)
/*
La sentencia "case" compara 2 o m�s valores y devuelve un resultado.
La sintaxis es la siguiente:
 case VALORACOMPARAR
  when VALOR1 then RESULTADO1
  when VALOR2 then RESULTADO2
  ...
  else RESULTADO3
 end

Por cada valor hay un "when" y un "then"; si encuentra un valor coincidente en alg�n "when" ejecuta el "then" correspondiente a ese "when", si no encuentra ninguna coincidencia, se ejecuta el "else"; 
si no hay parte "else" retorna "null". Finalmente se coloca "end" para indicar que el "case" ha finalizado.

Podemos realizar comparaciones en cada "when". La sintaxis es la siguiente:
 case
  when VALORACOMPARAR OPERADOR VALOR1 then RESULTADO1
  when VALORACOMPARAR OPERADOR VALOR2 then RESULTADO2
  ...
  else RESULTADO3
 end

EJEMPLOS: 
*/
if object_id('alumnos') is not null
  drop table alumnos;

create table alumnos(
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


-- Queremos mostrar el nombre y nota de cada alumno y en una columna extra llamada "condicion" empleamos un case que testee la nota y muestre un mensaje diferente seg�n la nota:
select nombre, nota, condicion=
case
  when nota<4 then 'libre'
   when nota >=4 and nota<7 then 'regular'
   when nota>=7 then 'promocionado'
   else 'sin nota'
  end
 from alumnos;

-- Vamos a agregar el campo "condicion" a la tabla:
alter table alumnos 
add condicion varchar(20);

-- Recordemos que se puede emplear una expresi�n "case" en cualquier lugar en el que pueda utilizar una expresi�n. Queremos actualizar el campo "condicion" para guardar la condici�n de cada alumno seg�n su nota:
update alumnos set condicion=
case
  when nota<4 then 'libre'
   when nota >=4 and nota<7 then 'regular'
   when nota>=7 then 'promocionado'
   else 'sin nota'
  end;

-- Mostramos la cantidad de alumnos libres, regulares y aprobados y en una columna extra mostramos un mensaje, ordenamos por cantidad:
 select condicion, count(*) as cantidad,resultado=
 case condicion
    when 'libre' then 'repitentes'
    when 'regular' then 'rinden final'
    when 'promocionado' then 'no rinden final'
    else 'sin datos'
  end
  from alumnos
  group by condicion
  order by cantidad;



         -- 111) Lenguaje de control de flujo (if)
/*
Existen palabras especiales que pertenecen al lenguaje de control de flujo que controlan la ejecuci�n de las sentencias, los bloques de sentencias y procedimientos almacenados.

Tales palabras son: begin... end, goto, if... else, return, waitfor, while, break y continue.
- "begin... end" encierran un bloque de sentencias para que sean tratados como unidad.
- "if... else": testean una condici�n; se emplean cuando un bloque de sentencias debe ser ejecutado si una condici�n se cumple y si no se cumple, se debe ejecutar otro bloque de sentencias diferente.
- "while": ejecuta repetidamente una instrucci�n siempre que la condici�n sea verdadera.
- "break" y "continue": controlan la operaci�n de las instrucciones incluidas en el bucle "while".

EJEMPLOS:
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  cantidad tinyint,
  primary key (codigo)
);

go

insert into libros values('Uno','Richard Bach','Planeta',15,100);
insert into libros values('El aleph','Borges','Emece',20,150);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',50,200);
insert into libros values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,0);
insert into libros values('Java en 10 minutos','Mario Molina','Emece',40,200);

-- Mostramos los t�tulos de los cuales no hay libros disponibles (cantidad=0); en caso que no haya, mostramos un mensaje:
if exists (select * from libros where cantidad=0)
(select titulo from libros where cantidad=0)
else 
(select 'No hay libros' as Error)

-- Hacemos un descuento del 10% a todos los libros de editorial "Emece"; si no hay, mostramos un mensaje:
if exists (select * from libros where editorial='Emece')
begin
update libros set precio=precio-(precio*0.1) where editorial='Emece'
select precio as 'Precio Actualizado' from libros where editorial='Emece'
end
else 
select 'No hay libros de Emece' as Error;

-- Eliminamos los libros de los cuales no hay stock (cantidad=0); si no hay, mostramos un mensaje:
if exists (select * from libros where cantidad=0)
delete libros where cantidad=0
else 
select Mensaje='No hay libros sin stock'



         -- 119) Procedimientos almacenados
/*
Un procedimiento almacenado es un conjunto de instrucciones a las que se les da un nombre, que se almacena en el servidor. Permiten encapsular tareas repetitivas.

SQL Server permite los siguientes tipos de procedimientos almacenados:
1) del sistema: est�n almacenados en la base de datos "master" y llevan el prefijo "sp_"; permiten recuperar informaci�n de las tablas del sistema y pueden ejecutarse en cualquier base de datos.
2) locales: los crea el usuario (pr�ximo tema).
3) temporales: pueden ser locales, cuyos nombres comienzan con un signo numeral (#), o globales, cuyos nombres comienzan con 2 signos numeral (##). 
   Los procedimientos almacenados temporales locales est�n disponibles en la sesi�n de un solo usuario y se eliminan autom�ticamente al finalizar la sesi�n; los globales est�n disponibles en las sesiones de todos los usuarios.
4) extendidos: se implementan como bibliotecas de v�nculos din�micos (DLL, Dynamic-Link Libraries), se ejecutan fuera del entorno de SQL Server. Generalmente llevan el prefijo "xp_". No los estudiaremos.

Un procedimiento almacenados puede hacer referencia a objetos que no existen al momento de crearlo. Los objetos deben existir cuando se ejecute el procedimiento almacenado.
Ventajas:
- comparten la l�gica de la aplicaci�n con las otras aplicaciones, con lo cual el acceso y las modificaciones de los datos se hacen en un solo sitio.
- permiten realizar todas las operaciones que los usuarios necesitan evitando que tengan acceso directo a las tablas.
- reducen el tr�fico de red; en vez de enviar muchas instrucciones, los usuarios realizan operaciones enviando una �nica instrucci�n, lo cual disminuye el n�mero de solicitudes entre el cliente y el servidor.
*/



         -- 120) Procedimientos almacenados (crear - ejecutar)
/*
Los procedimientos almacenados pueden hacer referencia a tablas, vistas, a funciones definidas por el usuario, a otros procedimientos almacenados y a tablas temporales.
Un procedimiento almacenado pueden incluir cualquier cantidad y tipo de instrucciones, excepto:
- create default, create procedure, create rule, create trigger y create view.

Si un procedimiento almacenado crea una tabla temporal, dicha tabla s�lo existe dentro del procedimiento y desaparece al finalizar el mismo. Lo mismo sucede con las variables.

Para crear un procedimiento almacenado empleamos la instrucci�n "create procedure".
La sintaxis b�sica parcial es:
 create procedure NOMBREPROCEDIMIENTO
  as INSTRUCCIONES;

Entonces, creamos un procedimiento almacenado colocando "create procedure" (o "create proc", que es la forma abreviada), luego el nombre del procedimiento y seguido de "as" las sentencias que definen el procedimiento.

Para ejecutar el procedimiento almacenado creado anteriormente tipeamos:
 exec pa_libros_limite_stock;

EJEMPLOS:
*/

-- Cuando realizamos un ejercicio nuevo, siempre realizamos las mismas tareas: eliminamos la tabla si existe, la creamos y luego ingresamos algunos registros. Podemos crear un procedimiento almacenado que contenga todas estas instrucciones:
if object_id('pa_crear_libros') is not null
  drop procedure pa_crear_libros;

go

-- Creamos el procedimiento:
create procedure pa_crear_libros 
 as
  if object_id('libros')is not null
   drop table libros
 
  create table libros(
   codigo int identity,
   titulo varchar(40),
   autor varchar(30),
   editorial varchar(20),
   precio decimal(5,2),
   cantidad smallint,
   primary key(codigo)
  )

  insert into libros values('Uno','Richard Bach','Planeta',15,5)
  insert into libros values('Ilusiones','Richard Bach','Planeta',18,50)
  insert into libros values('El aleph','Borges','Emece',25,9)
  insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,100)
  insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',12,50)
  insert into libros values('Java en 10 minutos','Mario Molina','Paidos',35,300);

go

-- Ejecutamos el procedimiento:
exec pa_crear_libros;

-- Veamos si ha creado la tabla:
select * from libros;

-- Ejecutamos el procedimiento almacenado del sistema "sp_help" y el nombre del procedimiento almacenado para verificar que existe el procedimiento creado recientemente:
exec sp_help pa_crear_libros;

-- Necesitamos un procedimiento almacenado que muestre los libros de los cuales hay menos de 10:
go
create proc pa_libros_limite_stock
as 
select * from libros
where cantidad<10;

-- Ejecutamos el procedimiento almacenado del sistema "sp_help" junto al nombre del procedimiento creado recientemente para verificar que existe:
exec sp_help pa_libros_limite_stock;

-- Lo ejecutamos:
exec pa_libros_limite_stock;

-- Modificamos alg�n registro y volvemos a ejecutar el procedimiento:
select * from libros;
update libros set cantidad=2 
where codigo=4;

         -- 122) Procedimientos almacenados (par�metros de entrada)
/*
Los procedimientos almacenados pueden recibir y devolver informaci�n; para ello se emplean par�metros, de entrada y salida, respectivamente.

Veamos los primeros. Los par�metros de entrada posibilitan pasar informaci�n a un procedimiento.
Para que un procedimiento almacenado admita par�metros de entrada se deben declarar variables como par�metros al crearlo. La sintaxis es:
 create proc NOMBREPROCEDIMIENTO
  @NOMBREPARAMETRO TIPO =VALORPORDEFECTO
  as SENTENCIAS; 

Los par�metros se definen luego del nombre del procedimiento, comenzando el nombre con un signo arroba (@). 
Los par�metros son locales al procedimiento, es decir, existen solamente dentro del mismo. Pueden declararse varios par�metros por procedimiento, se separan por comas.

Cuando el procedimiento es ejecutado, deben explicitarse valores para cada uno de los par�metros (en el orden que fueron definidos), a menos que se haya definido un valor por defecto, en tal caso, pueden omitirse. 
Pueden ser de cualquier tipo de dato (excepto cursor).

Luego de definir un par�metro y su tipo, opcionalmente, se puede especificar un valor por defecto; tal valor es el que asume el procedimiento al ser ejecutado si no recibe par�metros. 
Si no se coloca valor por defecto, un procedimiento definido con par�metros no puede ejecutarse sin valores para ellos. 
El valor por defecto puede ser "null" o una constante, tambi�n puede incluir comodines si el procedimiento emplea "like".

EJEMPLOS: 
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
);

go

insert into libros values ('Uno','Richard Bach','Planeta',15);
insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
insert into libros values ('El aleph','Borges','Emece',25);
insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values ('Puente al infinito','Bach Richard','Sudamericana',14);
insert into libros values ('Antolog�a','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Cervantes y el quijote','Borges- Casares','Planeta',34);

-- Eliminamos el procedimiento almacenado "pa_libros_autor" si existe:
if object_id('pa_libros_autor') is not null
  drop procedure pa_libros_autor;

-- Creamos el procedimiento para que reciba el nombre de un autor y muestre todos los libros del autor solicitado:
create procedure pa_libros_autor
  @autor varchar(30) 
 as
  select titulo, editorial,precio
   from libros
   where autor= @autor;

-- Ejecutamos el procedimiento:
exec pa_libros_autor 'Richard Bach';

-- Empleamos la otra sintaxis (por nombre) y pasamos otro valor:
exec pa_libros_autor @autor='Borges';

-- Eliminamos, si existe, el procedimiento "pa_libros_autor_editorial":
if object_id('pa_libros_autor_editorial') is not null
  drop procedure pa_libros_autor_editorial;

-- Creamos un procedimiento "pa_libros_autor_editorial" que recibe 2 par�metros, el nombre de un autor y el de una editorial:
create procedure pa_libros_autor_editorial
  @autor varchar(30),
  @editorial varchar(20) 
 as
  select titulo, precio
   from libros
   where autor= @autor and
   editorial=@editorial;

go

-- Ejecutamos el procedimiento enviando los par�metros por posici�n:
exec pa_libros_autor_editorial 'Richard Bach','Planeta';

-- Ejecutamos el procedimiento enviando otros valores y lo hacemos por nombre (Si ejecutamos el procedimiento omitiendo los par�metros, aparecer� un mensaje de error.):
exec pa_libros_autor_editorial @autor='Borges',@editorial='Emece';

-- Eliminamos, si existe, el procedimiento "pa_libros_autor_editorial2":
if object_id('pa_libros_autor_editorial2') is not null
  drop procedure pa_libros_autor_editorial2;

-- Creamos el procedimiento almacenado "pa_libros_autor_editorial2" que recibe los mismos par�metros, esta vez definimos valores por defecto para cada par�metro:
create procedure pa_libros_autor_editorial2
  @autor varchar(30)='Richard Bach',
  @editorial varchar(20)='Planeta' 
 as
  select titulo,autor,editorial,precio
   from libros
   where autor= @autor and
   editorial=@editorial;

go

-- Ejecutamos el procedimiento anterior sin enviarle valores para verificar que usa los valores por defecto (Muestra los libros de "Richard Bach" y editorial "Planeta" (valores por defecto)):
exec pa_libros_autor_editorial2;

-- Enviamos un solo par�metro al procedimiento (SQL Server asume que es el primero, y no hay registros cuyo autor sea "Planeta"):
exec pa_libros_autor_editorial2 'Planeta';

-- Especificamos el segundo par�metro, enviando par�metros por nombre:
exec pa_libros_autor_editorial2 @editorial='Planeta';

-- Ejecutamos el procedimiento enviando par�metros por nombre en distinto orden:
exec pa_libros_autor_editorial2 @editorial='Nuevo siglo',@autor='Paenza';

-- Definimos un procedimiento empleando patrones de b�squeda (antes verificamos si existe para eliminarlo):
if object_id('pa_libros_autor_editorial3') is not null
  drop procedure pa_libros_autor_editorial3;

go
 
 create proc pa_libros_autor_editorial3
  @autor varchar(30) = '%',
  @editorial varchar(30) = '%'
 as 
  select titulo,autor,editorial,precio
   from libros
   where autor like @autor and
   editorial like @editorial;

go

-- Ejecutamos el procedimiento enviando par�metro por posici�n, asume que es el primero:
exec pa_libros_autor_editorial3 'P%';

-- Ejecutamos el procedimiento especificando que el valor corresponde al segundo par�metro:
exec pa_libros_autor_editorial3 @editorial='P%';

-- La sentencia siguiente muestra lo mismo que la anterior:
exec pa_libros_autor_editorial3 default, 'P%';



         -- 123) Procedimientos almacenados (par�metros de salida)
/*
Dijimos que los procedimientos almacenados pueden devolver informaci�n; para ello se emplean par�metros de salida. El valor se retorna a quien realiz� la llamada con par�metros de salida. 
Para que un procedimiento almacenado devuelva un valor se debe declarar una variable con la palabra clave "output" al crear el procedimiento:
 create procedure NOMBREPROCEDIMIENTO
  @PARAMETROENTRADA TIPO =VALORPORDEFECTO,
  @PARAMETROSALIDA TIPO=VALORPORDEFECTO output
  as 
   SENTENCIAS
   select @PARAMETROSALIDA=SENTENCIAS;

Al ejecutarlo tambi�n debe emplearse "output":
Declaramos una variable para guardar el valor devuelto por el procedimiento; ejecutamos el procedimiento envi�ndole 2 valores y mostramos el resultado.
La instrucci�n que realiza la llamada al procedimiento debe contener un nombre de variable para almacenar el valor retornado.

EJEMPLOS: 
*/

-- Creamos un procedimiento almacenado al cual le enviamos 2 n�meros decimales y retorna el promedio:
go

create procedure pa_promedio
  @n1 decimal(4,2),
  @n2 decimal(4,2),
  @resultado decimal(4,2) output
  as 
   select @resultado=(@n1+@n2)/2;

go

-- Lo ejecutamos enviando diferentes valores:
declare @variable decimal(4,2)
exec pa_promedio 5,6, @variable output
select @variable

exec pa_promedio 5.3,4.7, @variable output
select @variable

exec pa_promedio 9,10, @variable output
select @variable;

-- Trabajamos con la tabla "libros" de una librer�a. Eliminamos la tabla si existe y la creamos nuevamente:
if object_id('libros') is not null
  drop table libros;

go

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
);

go

insert into libros values ('Uno','Richard Bach','Planeta',15);
insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
insert into libros values ('El aleph','Borges','Emece',25);
insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values ('Puente al infinito','Richard Bach','Sudamericana',14);
insert into libros values ('Antolog�a','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Antolog�a','Borges','Planeta',34);

-- Eliminamos el procedimiento almacenado "pa_autor_sumaypromedio", si existe:
if object_id('pa_autor_sumaypromedio') is not null
  drop proc pa_autor_sumaypromedio;

-- Creamos un procedimiento almacenado que muestre los t�tulos, editorial y precio de los libros de un determinado autor (enviado como par�metro de entrada)
-- y nos retorne la suma y el promedio de los precios de todos los libros del autor enviado:
create procedure pa_autor_sumaypromedio
  @autor varchar(30)='%',
  @suma decimal(6,2) output,
  @promedio decimal(6,2) output
  as 
   select titulo,editorial,precio
   from libros
   where autor like @autor
  select @suma=sum(precio)
   from libros
   where autor like @autor
  select @promedio=avg(precio)
   from libros
   where autor like @autor;

go

-- Ejecutamos el procedimiento enviando distintos valores:
declare @s decimal(6,2), @p decimal(6,2)
exec pa_autor_sumaypromedio 'Richard Bach', @s output, @p output
select @s as total, @p as promedio

exec pa_autor_sumaypromedio 'Borges', @s output, @p output
select @s as total, @p as promedio

exec pa_autor_sumaypromedio 'Mario Molina', @s output, @p output
select @s as total, @p as promedio;

go

-- Ejecutamos el procedimiento sin pasar el par�metro para autor. Recuerde que en estos casos debemos colocar los nombres de las variables.
declare @s decimal(6,2), @p decimal(6,2)
exec pa_autor_sumaypromedio @suma=@s output,@promedio= @p output
select @s as total, @p as promedio;



         -- 124) Procedimientos almacenados (return)
/*
La instrucci�n "return" sale de una consulta o procedimiento y todas las instrucciones posteriores no son ejecutadas.
Un procedimiento puede retornar un valor de estado para indicar si se ha ejecutado correctamente o no.

Para ver el resultado, debemos declarar una variable en la cual se almacene el valor devuelto por el procedimiento; 
luego, ejecutar el procedimiento asign�ndole el valor devuelto a la variable, finalmente mostramos el contenido de la variable:

EJEMPLOS:
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
);

go

insert into libros values ('Uno','Richard Bach','Planeta',15);
insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
insert into libros values ('El aleph','Borges','Emece',25);
insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
insert into libros values ('Puente al infinito','Richard Bach','Sudamericana',14);
insert into libros values ('Antolog�a','J. L. Borges','Paidos',24);
insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
insert into libros values ('Antolog�a','Borges','Planeta',34);

-- Eliminamos el procedimiento llamado "pa_libros_autor", si existe:
if object_id('pa_libros_autor') is not null
  drop procedure pa_libros_autor;

-- Creamos un procedimiento que muestre todos los libros de un autor determinado que se ingresa como par�metro. Si no se ingresa un valor, o se ingresa "null", se muestra un mensaje y se sale del procedimiento:
create procedure pa_libros_autor
  @autor varchar(30)=null
 as 
 if @autor is null
 begin 
  select 'Debe indicar un autor'
  return
 end
 select titulo from  libros where autor = @autor;

go

-- Ejecutamos el procedimiento con par�metro:
exec pa_libros_autor 'Borges';

-- Ejecutamos el procedimiento sin par�metro:
exec pa_libros_autor;

-- Eliminamos el procedimiento "pa_libros_ingreso", si existe:
if object_id('pa_libros_ingreso') is not null
  drop procedure pa_libros_ingreso;

-- Creamos un procedimiento almacenado que ingresa registros en la tabla "libros". Los par�metros correspondientes al t�tulo y autor DEBEN ingresarse con un valor distinto de "null", los dem�s son opcionales. 
-- El procedimiento retorna "1" si la inserci�n se realiza (si se ingresan valores para t�tulo y autor) y "0", en caso que t�tulo o autor sean nulos:
create procedure pa_libros_ingreso
  @titulo varchar(40)=null,
  @autor varchar(30)=null,
  @editorial varchar(20)=null,
  @precio decimal(5,2)=null
 as 
 if (@titulo is null) or (@autor is null)
  return 0
 else 
 begin
  insert into libros values (@titulo,@autor,@editorial,@precio)
  return 1
 end;

go

-- Declaramos una variable en la cual almacenaremos el valor devuelto, ejecutamos el procedimiento enviando los dos par�metros obligatorios y vemos el contenido de la variable:
declare @retorno int
exec @retorno=pa_libros_ingreso 'Alicia en el pais...','Lewis Carroll'
select 'Ingreso realizado' = @retorno;

select * from libros;

-- Ejecutamos los mismos pasos, pero esta vez no enviamos valores al procedimiento (El procedimiento retorn� "0", lo cual indica que el registro no fue ingresado.):
declare @retorno int
exec @retorno=pa_libros_ingreso
select 'Ingreso realizado' = @retorno;

select * from libros;

go

-- Empleamos un "if" para controlar el valor de la variable de retorno. Enviando al procedimiento valores para los par�metros obligatorios:
declare @retorno int
exec @retorno=pa_libros_ingreso 'El gato con botas','An�nimo'
if @retorno=1 select 'Registro ingresado'
 else select 'Registro no ingresado porque faltan datos';

select * from libros;

go

declare @retorno int
exec @retorno=pa_libros_ingreso
if @retorno=1 select 'Registro ingresado'
 else select 'Registro no ingresado porque faltan datos';

select * from libros;



         -- 132) Tablas temporales
/*
Las tablas temporales son visibles solamente en la sesi�n actual.
Las tablas temporales se eliminan autom�ticamente al acabar la sesi�n o la funci�n o procedimiento almacenado en el cual fueron definidas. Se pueden eliminar con "drop table".

Pueden ser locales (son visibles s�lo en la sesi�n actual) o globales (visibles por todas las sesiones).

Para crear tablas temporales locales se emplea la misma sintaxis que para crear cualquier tabla, excepto que se coloca un signo numeral (#) precediendo el nombre.
 create table #NOMBRE(
  CAMPO DEFINICION,
  ...
 );

Para referenciarla en otras consultas, se debe incluir el numeral(#), que es parte del nombre. Por ejemplo:
 insert into #libros default values;
 select *from #libros;

Una tabla temporal no puede tener una restricci�n "foreign key" ni ser indexada, tampoco puede ser referenciada por una vista.

Para crear tablas temporales globales se emplea la misma sintaxis que para crear cualquier tabla, excepto que se coloca un signo numeral doble (##) precediendo el nombre.
 create table ##NOMBRE(
  CAMPO DEFINICION,
  ...
 );
El (o los) numerales son parte del nombre. As� que puede crearse una tabla permanente llamada "libros", otra tabla temporal local llamada "#libros" y una tercera tabla temporal global denominada "##libros".

EJEMPLOS: 
*/
 create table #usuarios(
  nombre varchar(30),
  clave varchar(10)
  primary key(nombre)
);

insert into #usuarios (nombre, clave) values ('Mariano','payaso');
select * from #usuarios;



         -- 133) Funciones
/*
Las funciones pueden clasificarse en:
- deterministicas: siempre retornan el mismo resultado si se las invoca enviando el mismo valor de entrada. Todas las funciones de agregado y string son deterministicas, excepto "charindex" y "patindex".
- no deterministicas: pueden retornar distintos resultados cada vez que se invocan con el mismo valor de entrada. Las siguientes son algunas de las funciones no deterministicas: getdate, datename, textptr, textvalid, rand. 
Todas las funciones de configuraci�n, cursor, meta data, seguridad y estad�sticas del sistema son no deterministicas.

Las funciones definidas por el usuario no permiten par�metros de salida.

No todas las sentencias SQL son v�lidas dentro de una funci�n. NO es posible emplear en ellas funciones no deterministicas (como getdate()) ni sentencias de modificaci�n o actualizaci�n de tablas o vistas. 
Si podemos emplear sentencias de asignaci�n, de control de flujo (if), de modificaci�n y eliminaci�n de variables locales.

SQL Server admite 3 tipos de funciones definidas por el usuario clasificadas seg�n el valor retornado:
1) escalares: retornan un valor escalar;
2) de tabla de varias instrucciones (retornan una tabla) y
3) de tabla en l�nea (retornan una tabla).

Las funciones definidas por el usuario se crean con la instrucci�n "create function" y se eliminan con "drop function".
*/



         -- 135) Funciones escalares (crear y llamar)
/*
Una funci�n escalar retorna un �nico valor. Como todas las funciones, se crean con la instrucci�n "create function". La sintaxis b�sica es:
 create function NOMBRE
 (@PARAMETRO TIPO=VALORPORDEFECTO)
  returns TIPO
  begin
   INSTRUCCIONES
   return VALOR
  end;

Luego del nombre se colocan (opcionalmente) los par�metros de entrada con su tipo.
La cl�usula "returns" indica el tipo de dato retornado.

El cuerpo de la funci�n, se define en un bloque "begin...end" que contiene las instrucciones que retornan el valor. El tipo del valor retornado puede ser de cualquier tipo, excepto text, ntext, image, cursor o timestamp.

Entonces, luego de "create function" y el nombre de la funci�n, se deben especificar los par�metros de entrada con sus tipos de datos (entre par�ntesis), 
el tipo de dato que retorna luego de "returns", luego de "as" comienza el bloque "begin...end" dentro del cual se encuentran las instrucciones de procesamiento y el valor retornado luego de "return".

No olvide que cuando invocamos funciones que tienen definidos par�metros de entrada DEBEMOS suministrar SIEMPRE un valor para �l.
Podemos colocar un valor por defecto al par�metro, pero al invocar la funci�n, para que tome el valor por defecto DEBEMOS especificar "default".

EJEMPLOS: 
*/
set language us_english; 

if object_id('empleados') is not null
  drop table empleados;

create table empleados(
  documento char(8) not null,
  nombre varchar(30),
  fechaingreso datetime,
  mail varchar(50),
  telefono varchar(12)
);

go

set dateformat ymd;

insert into empleados values('22222222', 'Ana Acosta','1985/10/10','anaacosta@gmail.com','4556677');
insert into empleados values('23333333', 'Bernardo Bustos', '1986/02/15',null,'4558877');
insert into empleados values('24444444', 'Carlos Caseros','1999/12/02',null,null);
insert into empleados values('25555555', 'Diana Dominguez',null,null,'4252525');

-- Creamos una funci�n a la cual le enviamos una fecha (de tipo varchar), en el cuerpo de la funci�n se analiza si el dato enviado corresponde a una fecha, 
-- si es as�, se almacena en una variable el mes (en espa�ol) y se le concatenan el d�a y el a�o y se retorna esa cadena; en caso que el valor enviado no corresponda a una fecha, la funci�n retorna la cadena 'Fecha inv�lida':
create function f_fechaCadena
 (@fecha varchar(25))
  returns varchar(25)
  as
  begin
    declare @nombre varchar(25)
    set @nombre='Fecha inv�lida'   
    if (isdate(@fecha)=1)
    begin
      set @fecha=cast(@fecha as datetime)
      set @nombre=
      case datename(month,@fecha)
       when 'January' then 'Enero'
       when 'February' then 'Febrero'
       when 'March' then 'Marzo'
       when 'April' then 'Abril'
       when 'May' then 'Mayo'
       when 'June' then 'Junio'
       when 'July' then 'Julio'
       when 'August' then 'Agosto'
       when 'September' then 'Setiembre'
       when 'October' then 'Octubre'
       when 'November' then 'Noviembre'
       when 'December' then 'Diciembre'
      end--case
      set @nombre=rtrim(cast(datepart(day,@fecha) as char(2)))+' de '+@nombre
      set @nombre=@nombre+' de '+ rtrim(cast(datepart(year,@fecha)as char(4)))
    end--si es una fecha v�lida
    return @nombre
 end;


-- Recuperamos los registros de "empleados", mostrando el nombre y la fecha de ingreso empleando la funci�n creada anteriormente:
select nombre, dbo.f_fechaCadena(fechaingreso) as ingreso from empleados;

-- Empleamos la funci�n en otro contexto:
select dbo.f_fechaCadena(getdate());



         -- 136) Funciones de tabla de varias instrucciones
/*
Las funciones que retornan una tabla pueden emplearse en lugar de un "from" de una consulta.
Este tipo de funci�n es similar a un procedimiento almacenado; la diferencia es que la tabla retornada por la funci�n puede ser referenciada en el "from" de una consulta, pero el resultado de un procedimiento almacenado no.
Tambi�n es similar a una vista; pero en las vistas solamente podemos emplear "select", mientras que en funciones definidas por el usuario podemos incluir sentencias como "if", llamadas a funciones, procedimientos, etc.

Sintaxis:
 create function NOMBREFUNCION
 (@PARAMETRO TIPO)
 returns @NOMBRETABLARETORNO table-- nombre de la tabla
 --formato de la tabla
 (CAMPO1 TIPO,
  CAMPO2 TIPO,
  CAMPO3 TIPO
 )
 as
 begin
   insert @NOMBRETABLARETORNO
    select CAMPOS
     from TABLA
     where campo OPERADOR @PARAMETRO
   RETURN
 end

La cl�usula "returns" define un nombre de variable local para la tabla que retornar�, el tipo de datos a retornar (que es "table") y el formato de la misma (campos y tipos).
El cuerpo de la funci�n se define tambi�n en un bloque "begin... end", el cual contiene las instrucciones que insertan filas en la variable (tabla que ser� retornada) definida en "returns". 
"return" indica que las filas insertadas en la variable son retornadas; no puede ser un argumento.

Las funciones que retornan una tabla pueden llamarse sin especificar propietario:

EJEMPLOS:
*/
if object_id('libros') is not null
  drop table libros; 

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2)
);

go

insert into libros values('Uno','Richard Bach','Planeta',15);
insert into libros values('Ilusiones','Richard Bach','Planeta',10);
insert into libros values('El aleph','Borges','Emece',25);
insert into libros values('Aprenda PHP','Mario Molina','Siglo XXI',55);
insert into libros values('Alicia en el pais','Lewis Carroll','Paidos',35);
insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',25);

-- Creamos la funci�n "f_ofertas" que reciba un par�metro correspondiente a un precio y nos retorne una tabla con c�digo, t�tulo, autor y precio de todos los libros cuyo precio sea inferior al par�metro:
create function f_ofertas
 (@minimo decimal(6,2)
 )
 returns @ofertas table-- nombre de la tabla
 --formato de la tabla
 (codigo int,
  titulo varchar(40),
  autor varchar(30),
  precio decimal(6,2)
 )
 as
 begin
   insert @ofertas
    select codigo,titulo,autor,precio
    from libros
    where precio<@minimo
   return
 end;

go

--Llamamos a la funci�n como si fuera una tabla, recuerde que podemos omitir el nombre del propietario:
select * from f_ofertas(30);

-- Realizamos un join entre "libros" y la tabla retornada por la funci�n "f_ofertas" y mostramos todos los campos de "libros". Incluimos una condici�n para el autor:
select l.titulo,l.autor,l.editorial
  from libros as l
  join dbo.f_ofertas(25) as o
  on l.codigo=o.codigo
  where l.autor='Richard Bach';

-- La siguiente consulta nos retorna algunos campos de la tabla retornada por "f_ofertas" y algunos registros que cumplen con la condici�n "where":
select titulo,precio from f_ofertas(40)
  where autor like '%B%';

-- Eliminamos la funci�n "f_listadolibros" si existe":
if object_id('f_listadolibros') is not null
  drop function f_listadolibros; 

-- Creamos otra funci�n que retorna una tabla:
create function f_listadolibros
 (@opcion varchar(10)
 )
 returns @listado table
 (titulo varchar(40),
 detalles varchar(60)
 )
 as 
 begin
  if @opcion not in ('autor','editorial')
    set @opcion='autor'
  if @opcion='editorial'
   insert @listado 
    select titulo,
   (editorial+'-'+autor) from libros
   order by 2
  else
    if @opcion='autor'
     insert @listado
     select titulo,
     (autor+'-'+editorial) from libros  
     order by 2
  return
end;

go

-- Llamamos a la funci�n enviando el valor "autor":
select * from dbo.f_listadolibros('autor');

-- Llamamos a la funci�n enviando el valor "editorial":
select * from dbo.f_listadolibros('editorial');

-- Llamamos a la funci�n enviando un valor inv�lido:
select * from dbo.f_listadolibros('precio');



         -- 141) Disparadores (triggers)
/*
Un "trigger" (disparador o desencadenador) es un tipo de procedimiento almacenado que se ejecuta cuando se intenta modificar los datos de una tabla (o vista).
Se definen para una tabla (o vista) espec�fica.
Se crean para conservar la integridad referencial y la coherencia entre los datos entre distintas tablas.

Si se intenta modificar (agregar, actualizar o eliminar) datos de una tabla en la que se defini� un disparador para alguna de estas acciones (inserci�n, actualizaci�n y eliminaci�n), 
el disparador se ejecuta (se dispara) en forma autom�tica.
Un trigger se asocia a un evento (inserci�n, actualizaci�n o borrado) sobre una tabla.

La diferencia con los procedimientos almacenados del sistema es que los triggers:
- no pueden ser invocados directamente; al intentar modificar los datos de una tabla para la que se ha definido un disparador, el disparador se ejecuta autom�ticamente.
- no reciben y retornan par�metros.
- son apropiados para mantener la integridad de los datos, no para obtener resultados de consultas.

Los disparadores, a diferencia de las restricciones "check", pueden hacer referencia a campos de otras tablas. 
Por ejemplo, puede crearse un trigger de inserci�n en la tabla "ventas" que compruebe el campo "stock" de un art�culo en la tabla "articulos"; 
el disparador controlar�a que, cuando el valor de "stock" sea menor a la cantidad que se intenta vender, la inserci�n del nuevo registro en "ventas" no se realice.

Los triggers se crean con la instrucci�n "create trigger". Esta instrucci�n especifica la tabla en la que se define el disparador, los eventos para los que se ejecuta y las instrucciones que contiene.
Sintaxis b�sica:
 create trigger NOMBREDISPARADOR
  on NOMBRETABLA
  for EVENTO- insert, update o delete
 as 
  SENTENCIAS

Analizamos la sintaxis:
- "create trigger" junto al nombre del disparador.
- "on" seguido del nombre de la tabla o vista para la cual se establece el trigger.
- luego de "for", se indica la acci�n (evento, el tipo de modificaci�n) sobre la tabla o vista que activar� el trigger. 
  Puede ser "insert", "update" o "delete". Debe colocarse al menos UNA acci�n, si se coloca m�s de una, deben separarse con comas.
- luego de "as" viene el cuerpo del trigger, se especifican las condiciones y acciones del disparador; es decir, 
  las condiciones que determinan cuando un intento de inserci�n, actualizaci�n o borrado provoca las acciones que el trigger realizar�.
*/



         -- 142) Disparador de inserci�n (insert trigger)
/*
Podemos crear un disparador para que se ejecute siempre que una instrucci�n "insert" ingrese datos en una tabla.
Sintaxis b�sica:
 create trigger NOMBREDISPARADOR
  on NOMBRETABLA
  for insert
 as 
   SENTENCIAS

Cuando se activa un disparador "insert", los registros se agregan a la tabla del disparador y a una tabla denominada "inserted". 
La tabla "inserted" es una tabla virtual que contiene una copia de los registros insertados; tiene una estructura similar a la tabla en que se define el disparador, es decir, la tabla en que se intenta la acci�n. 
La tabla "inserted" guarda los valores nuevos de los registros. Dentro del trigger se puede acceder a esta tabla virtual "inserted" que contiene todos los registros insertados.

"rollback transaction" es la sentencia que deshace la transacci�n, es decir, borra todas las modificaciones que se produjeron en la �ltima transacci�n restableciendo todo al estado anterior.

"raiserror" muestra un mensaje de error personalizado.

Para identificar f�cilmente los disparadores de otros objetos se recomienda usar un prefijo y darles el nombre de la tabla para la cual se crean junto al tipo de acci�n.

EJEMPLOS: 
*/
if object_id('ventas') is not null
  drop table ventas;
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  precio decimal(6,2), 
  stock int,
  constraint PK_libros primary key(codigo)
);

create table ventas(
  numero int identity,
  fecha datetime,
  codigolibro int not null,
  precio decimal (6,2),
  cantidad int,
  constraint PK_ventas primary key(numero),
  constraint FK_ventas_codigolibro
   foreign key (codigolibro) references libros(codigo)
);

go

insert into libros values('Uno','Richard Bach',15,100);
insert into libros values('Ilusiones','Richard Bach',18,50);
insert into libros values('El aleph','Borges',25,200);
insert into libros values('Aprenda PHP','Mario Molina',45,200);

go

-- Creamos un disparador para que se ejecute cada vez que una instrucci�n "insert" ingrese datos en "ventas"; el mismo controlar� que haya stock en "libros" y actualizar� el campo "stock":
go
create trigger DIS_ventas_insertar
  on ventas
  for insert
  as
   declare @stock int
   select @stock= stock from libros
		 join inserted
		 on inserted.codigolibro=libros.codigo
		 where libros.codigo=inserted.codigolibro
  if (@stock>=(select cantidad from inserted))
    update libros set stock=stock-inserted.cantidad
     from libros
     join inserted
     on inserted.codigolibro=libros.codigo
     where codigo=inserted.codigolibro
  else
  begin
    raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
    rollback transaction
  end

go

set dateformat ymd;

-- Ingresamos un registro en "ventas":
insert into ventas values('2018/04/01',1,15,1);
-- Al ejecutar la sentencia de inserci�n anterior, se dispar� el trigger, el registro se agreg� a la tabla del disparador ("ventas") y disminuy� el valor del campo "stock" de "libros".

-- Verifiquemos que el disparador se ejecut� consultando la tabla "ventas" y "libros":
select * from ventas;
select * from libros where codigo=1;

-- Ingresamos un registro en "ventas", solicitando una cantidad superior al stock (El disparador se ejecuta y muestra un mensaje, la inserci�n no se realiz� porque la cantidad solicitada supera el stock.):
 insert into ventas values('2018/04/01',2,18,100);

-- Finalmente probaremos ingresar una venta con un c�digo de libro inexistente (El trigger no lleg� a ejecutarse, porque la comprobaci�n de restricciones 
-- (que se ejecuta antes que el disparador) detect� que la infracci�n a la "foreign key"):
 insert into ventas values('2018/04/01',5,18,1);



         -- 144) Disparador de actualizaci�n (update trigger)
/*
Podemos crear un disparador para que se ejecute siempre que una instrucci�n "update" actualice los datos de una tabla.
Sintaxis b�sica:
 create trigger NOMBREDISPARADOR
  on NOMBRETABLA
  for update
 as 
   SENTENCIAS

Cuando se ejecuta una instrucci�n "update" en una tabla que tiene definido un disparador, los registros originales (antes de ser actualizados) se mueven a la tabla virtual "deleted" y los registros actualizados 
(con los nuevos valores) se copian a la tabla virtual "inserted". Dentro del trigger se puede acceder a estas tablas.

En el cuerpo de un trigger se puede emplear la funci�n "update(campo)" que recibe un campo y retorna verdadero si el evento involucra actualizaciones (o inserciones) en ese campo; en caso contrario retorna "false".

Empleamos "if update()", as�, cuando el disparador detecte una actualizaci�n en tal campo, realizar� las acciones apropiadas (mostrar un mensaje y deshacer la actualizaci�n); 
en caso que se actualice otro campo, el disparador se activa, pero permite la transacci�n.

EJEMPLOS:
*/
if object_id('libros') is not null
  drop table libros;

create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2), 
  stock int,
  constraint PK_libros primary key(codigo)
);

go

insert into libros values('Uno','Richard Bach','Planeta',15,100);
insert into libros values('Alicia en el pais...','Lewis Carroll','Planeta',18,50);
insert into libros values('El aleph','Borges','Emece',25,200);
insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,200);

go

-- Creamos un disparador para evitar que se modifiquen los datos de la tabla "libros":
create trigger DIS_libros_actualizar
  on libros
  for update
  as
    raiserror('Los datos de la tabla "libros" no pueden modificarse', 10, 1)
    rollback transaction;

-- Intentamos realizar alguna actualizaci�n en "libros":
update libros set titulo='Alicia en el pais de las maravillas' where codigo=2;
-- El disparador se activ�, mostr� un mensaje y deshizo la actualizaci�n.

-- Eliminamos el disparador creado anteriormente:
drop trigger DIS_libros_actualizar;

-- Creamos un disparador que evite que se actualice el campo "precio" de la tabla "libros":
go
create trigger DIS_libros_actualizar_precio
  on libros
  for update
  as
   if update(precio)
   begin
    raiserror('El precio de un libro no puede modificarse.', 10, 1)
    rollback transaction
   end;

go

-- Veamos qu� sucede si intentamos actualizar el precio de un libro:
update libros set precio=30 where codigo=2;
-- El disparador se activa, muestra un mensaje y deshace la transacci�n.


-- Veamos qu� sucede al actualizar el campo "titulo":
update libros set titulo='Alicia en el pais de las maravillas' where codigo=2;
-- El disparador se activa y realiza la transacci�n

-- Lo verificamos consultando la tabla:
select * from libros;

-- Eliminamos el disparador creado anteriormente:
drop trigger DIS_libros_actualizar_precio;

-- Creamos un disparador de actualizaci�n que muestra el valor anterior y nuevo valor de los registros actualizados. El trigger debe controlar que la actualizaci�n se realice en los 
-- campos "titulo", "autor" y "editorial" y no en los dem�s campos (precio y stock)); si se modifican los campos permitidos y ninguno de los no permitidos, mostrar� los antiguos
-- y nuevos valores consultando las tablas "deleted" e "inserted", en caso que se actualice un campo no permitido, el disparador muestra un mensaje y deshace la transacci�n:
create trigger DIS_libros_actualizar2
  on libros
  for update
  as
   if (update(titulo) or update(autor) or update(editorial)) and
    not (update(precio) or update(stock))
   begin
    select (d.titulo+'-'+ d.autor+'-'+d.editorial) as 'registro anterior',
    (i.titulo+'-'+ i.autor+'-'+i.editorial) as 'registro actualizado'
     from deleted as d
     join inserted as i
     on d.codigo=i.codigo
   end
   else
   begin
    raiserror('El precio y stock no pueden modificarse. La actualizaci�n no se realiz�.', 10, 1)
    rollback transaction
   end;

go

-- Veamos qu� sucede si modificamos campos permitidos:
update libros set editorial='Paidos', autor='Desconocido' where codigo>3;
-- El trigger se dispara y muestra los registros modificados, los valores antes y despu�s de la transacci�n.

-- Veamos qu� sucede si en la sentencia "update" intentamos modificar alg�n campo no permitido:
update libros set editorial='Paidos', precio=30 where codigo>3;
-- El trigger se dispara y muestra el mensaje de error, la transacci�n no se realiz�.

-- Intentamos modificar el c�digo de un libro:
update libros set codigo=9 where codigo>=3; 
-- El disparador no llega a dispararse porque SQL Server muestra un mensaje de error ya que el campo "codigo", por ser "identity", no puede modificarse.