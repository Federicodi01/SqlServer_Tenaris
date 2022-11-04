CREATE TABLE usuarios 
(
nombre varchar(50),
clave varchar(10),
);

INSERT INTO usuarios (nombre, clave) VALUES 
('Mariano','payaso'),
('Juan','River'),
('Luis','Boca');

SELECT * FROM usuarios;