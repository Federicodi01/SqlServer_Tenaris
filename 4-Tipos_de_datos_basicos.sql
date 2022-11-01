create table libros
(
titulo varchar(80),
autor varchar(40),
editorial varchar(30),
precio float,
cantidad int
);

exec sp_columns libros;

exec sp_tables @table_owner='dbo';

INSERT INTO libros (titulo, autor, editorial, precio, cantidad) VALUES 
('El aleph', 'Borges', 'Emece', 25.50, 100),
('Matematica estas ahi', 'Paenza', 'Siglo XXI', 18.8, 200),
('Alicia en el pais de las maravillas', 'Lewis Carroll', 'Atlantida', 10, 200);

select * from libros;