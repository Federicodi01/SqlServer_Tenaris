/*
Una funci�n es un conjunto de sentencias que operan como una unidad l�gica.

Una funci�n tiene un nombre, retorna un par�metro de salida y opcionalmente acepta par�metros de entrada. Las funciones de SQL Server no pueden ser modificadas, las funciones definidas por el usuario si.

SQL Server ofrece varios tipos de funciones para realizar distintas operaciones. Se pueden clasificar de la siguiente manera:

1) de agregado: realizan operaciones que combinan varios valores y retornan un �nico valor. Son "count", "sum", "min" y "max".

2) escalares: toman un solo valor y retornan un �nico valor. Pueden agruparse de la siguiente manera:

- de configuraci�n: retornan informaci�n referida a la configuraci�n.
Ejemplo:
select @@version;
retorna la fecha, versi�n y tipo de procesador de SQL Server.

- de cursores: retornan informaci�n sobre el estado de un cursor.

- de fecha y hora: operan con valores "datetime" y "smalldatetime". Reciben un par�metro de tipo fecha y hora y retornan un valor de cadena, num�rico o de fecha y hora.

- matem�ticas: realizan operaciones num�ricas, geom�tricas y trigonom�tricas.

- de metadatos: informan sobre las bases de datos y los objetos.

- de seguridad: devuelven informaci�n referente a usuarios y funciones.

- de cadena: operan con valores "char", "varchar", "nchar", "nvarchar", "binary" y "varbinary" y devuelven un valor de cadena o num�rico.

- del sistema: informan sobre opciones, objetos y configuraciones del sistema. Ejemplo:

select user_name();
- estad�sticas del sistema: retornan informaci�n referente al rendimiento del sistema.

- texto e imagen: realizan operaciones con valor de entrada de tipo text o image y retornan informaci�n referente al mismo.

3) de conjuntos de filas: retornan conjuntos de registros.

Se pueden emplear las funciones del sistema en cualquier lugar en el que se permita una expresi�n en una sentencia "select".

Estudiaremos algunas de ellas.
*/