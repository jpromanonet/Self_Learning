/** EJERCICIO 1 | Creacion tabla. **/
 
 CREATE TABLE  -- TRANSACT SQL
		Personas 
			(id INT IDENTITY,
			Nombre CHAR(50),
			Apellido VARCHAR(50),
			Fecha_Nacimiento DATE)

SELECT * -- SQL ANSI
	FROM Personas

/** EJERCICIO 2 | INSERT INTO **/

INSERT INTO Personas(Nombre, Apellido, Fecha_Nacimiento)
	VALUES ('Jose','Gomez','1950-06-05')

-- SET IDENTITY_INSERT Personas OFF

/** EJERCICIO 3 | Agregar un campo a la tabla **/

ALTER TABLE Personas ADD DNI INT 