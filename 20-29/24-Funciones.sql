/*
Una función es un conjunto de sentencias que operan como una unidad lógica.

Una función tiene un nombre, retorna un parámetro de salida y opcionalmente acepta parámetros de entrada. Las funciones de SQL Server no pueden ser modificadas, las funciones definidas por el usuario si.

SQL Server ofrece varios tipos de funciones para realizar distintas operaciones. Se pueden clasificar de la siguiente manera:

1) de agregado: realizan operaciones que combinan varios valores y retornan un único valor. Son "count", "sum", "min" y "max".

2) escalares: toman un solo valor y retornan un único valor. Pueden agruparse de la siguiente manera:

- de configuración: retornan información referida a la configuración.
Ejemplo:
select @@version;
retorna la fecha, versión y tipo de procesador de SQL Server.

- de cursores: retornan información sobre el estado de un cursor.

- de fecha y hora: operan con valores "datetime" y "smalldatetime". Reciben un parámetro de tipo fecha y hora y retornan un valor de cadena, numérico o de fecha y hora.

- matemáticas: realizan operaciones numéricas, geométricas y trigonométricas.

- de metadatos: informan sobre las bases de datos y los objetos.

- de seguridad: devuelven información referente a usuarios y funciones.

- de cadena: operan con valores "char", "varchar", "nchar", "nvarchar", "binary" y "varbinary" y devuelven un valor de cadena o numérico.

- del sistema: informan sobre opciones, objetos y configuraciones del sistema. Ejemplo:

select user_name();
- estadísticas del sistema: retornan información referente al rendimiento del sistema.

- texto e imagen: realizan operaciones con valor de entrada de tipo text o image y retornan información referente al mismo.

3) de conjuntos de filas: retornan conjuntos de registros.

Se pueden emplear las funciones del sistema en cualquier lugar en el que se permita una expresión en una sentencia "select".

Estudiaremos algunas de ellas.
*/