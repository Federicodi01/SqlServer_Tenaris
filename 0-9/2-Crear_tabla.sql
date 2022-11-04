CREATE TABLE usuarios 
(
nombre varchar(50),
clave varchar(10),
);

exec sp_tables @table_owner='dbo';

exec sp_columns usuarios;

DROP TABLE usuarios;
