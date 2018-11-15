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

SELECT TOP 5 BirthDate -- Ordena en base a la cantidad de arriba solicitada, en este caso es cinco.
	FROM [HumanResources].[Employee]
		ORDER BY BirthDate DESC

SELECT DISTINCT JobTitle -- Esta funcion te muestra los repetidos dentro de una tabla.
	FROM HumanResources.Employee

SELECT DISTINCT JobTitle, MaritalStatus
	FROM HumanResources.Employee
		WHERE MaritalStatus <> 'M'

/** EJERCICIO 5 | Manipulaciòn de text **/

-- Funciones que vamos a ver: LEN, LEFT, RIGHT, SUBSTRING, REPLACE
-- Los numeros entre comillas o no, para SQL son siempre INT, si lo planteas como string, convierte el tipo al correr a INT
-- El simbolo mas(+) es el concatenador de SQL.

LEN (nombre) -- posiciones que ocupa en el campo(devuelve un INT).
LEFT (nombre, 3) -- trae los primeros tres caracteres.
RIGHT (nombre, 3) -- trae los ultimos tres caracteres.
SUBSTRING (nombre, 1, 3) --posicion inicial, cuantos caracteres debe correrse.

SELECT JobTitle, LEFT() -- 1 Funcion SIEMPRE DEVUELVE UN SOLO VALOR. 
	FROM HumanResources.Employee
