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

CREATE TABLE  -- TRANSACT SQL
	Personas2 
		(id INT IDENTITY,
		Nombre CHAR(50) NOT NULL,
		Apellido VARCHAR(50),
		Fecha_Nacimiento DATE NOT NULL)

INSERT INTO Personas2(Nombre, Apellido, Fecha_Nacimiento)
	VALUES ('Jose','Gomez','1950-06-05')

SELECT *
	FROM Personas2

ALTER TABLE Personas2 ADD Sexo CHAR(1)

UPDATE Personas2 
	SET Sexo = 'M'
	WHERE Nombre = 'Jose'
	
/** EJERCICIO 4 | Funciones **/

SELECT TOP 10 BusinessEntityID
	FROM [HumanResources].[Employee]
		--WHERE BirthDate > '2000-01-01'

SELECT TOP 5 BirthDate
	FROM [HumanResources].[Employee]
		ORDER BY BirthDate DESC

