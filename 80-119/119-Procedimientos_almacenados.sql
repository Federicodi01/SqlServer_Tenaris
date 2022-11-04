/*
SQL Server permite los siguientes tipos de procedimientos almacenados:

1) del sistema: est�n almacenados en la base de datos "master" y llevan el prefijo "sp_"; permiten recuperar informaci�n de las tablas del sistema y pueden ejecutarse en cualquier base de datos.

2) locales: los crea el usuario (pr�ximo tema).

3) temporales: pueden ser locales, cuyos nombres comienzan con un signo numeral (#), o globales, cuyos nombres comienzan con 2 signos numeral (##). 
Los procedimientos almacenados temporales locales est�n disponibles en la sesi�n de un solo usuario y se eliminan autom�ticamente al finalizar la sesi�n; los globales est�n disponibles en las sesiones de todos los usuarios.

4) extendidos: se implementan como bibliotecas de v�nculos din�micos (DLL, Dynamic-Link Libraries), se ejecutan fuera del entorno de SQL Server. Generalmente llevan el prefijo "xp_". No los estudiaremos.

Al crear un procedimiento almacenado, las instrucciones que contiene se analizan para verificar si son correctas sint�cticamente. 
Si no se detectan errores, SQL Server guarda el nombre del procedimiento almacenado en la tabla del sistema "sysobjects" y su contenido en la tabla del sistema "syscomments" en la base de datos activa. 
Si se encuentra alg�n error, no se crea.

Un procedimiento almacenados puede hacer referencia a objetos que no existen al momento de crearlo. Los objetos deben existir cuando se ejecute el procedimiento almacenado.

Ventajas:

- comparten la l�gica de la aplicaci�n con las otras aplicaciones, con lo cual el acceso y las modificaciones de los datos se hacen en un solo sitio.

- permiten realizar todas las operaciones que los usuarios necesitan evitando que tengan acceso directo a las tablas.

- reducen el tr�fico de red; en vez de enviar muchas instrucciones, los usuarios realizan operaciones enviando una �nica instrucci�n, lo cual disminuye el n�mero de solicitudes entre el cliente y el servidor.
*/