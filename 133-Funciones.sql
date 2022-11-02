/*
SQL Server ofrece varios tipos de funciones para realizar distintas operaciones. Hemos visto y empleado varias de ellas.

Se pueden emplear las funciones del sistema en cualquier lugar en el que se permita una expresi�n en una sentencia "select".

Las funciones pueden clasificarse en:

- deterministicas: siempre retornan el mismo resultado si se las invoca enviando el mismo valor de entrada. Todas las funciones de agregado y string son deterministicas, excepto "charindex" y "patindex".

- no deterministicas: pueden retornar distintos resultados cada vez que se invocan con el mismo valor de entrada. 
Las siguientes son algunas de las funciones no deterministicas: getdate, datename, textptr, textvalid, rand. Todas las funciones de configuraci�n, cursor, meta data, seguridad y estad�sticas del sistema son no deterministicas.

SQL Server provee muchas funciones y adem�s permite que el usuario pueda definir sus propias funciones.

Sabemos que una funci�n es un conjunto de sentencias que operan como una unidad l�gica, una rutina que retorna un valor. Una funci�n tiene un nombre, acepta par�metros de entrada y retorna un valor escalar o una tabla.

Los par�metros de entrada pueden ser de cualquier tipo, excepto timestamp, cursor y table.

Las funciones definidas por el usuario no permiten par�metros de salida.

No todas las sentencias SQL son v�lidas dentro de una funci�n. NO es posible emplear en ellas funciones no deterministicas (como getdate()) ni sentencias de modificaci�n o actualizaci�n de tablas o vistas. 
Si podemos emplear sentencias de asignaci�n, de control de flujo (if), de modificaci�n y eliminaci�n de variables locales.

SQL Server admite 3 tipos de funciones definidas por el usuario clasificadas seg�n el valor retornado:

1) escalares: retornan un valor escalar;

2) de tabla de varias instrucciones (retornan una tabla) y

3) de tabla en l�nea (retornan una tabla).

Las funciones definidas por el usuario se crean con la instrucci�n "create function" y se eliminan con "drop function".
*/