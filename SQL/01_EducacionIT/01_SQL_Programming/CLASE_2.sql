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
	VALUES ('Juan','Van Ryle','1994-01-17')

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

/** EJERCICIO 5 | Manipulaciòn de texto **/

-- Funciones que vamos a ver: LEN, LEFT, RIGHT, SUBSTRING, REPLACE
-- Los numeros entre comillas o no, para SQL son siempre INT, si lo planteas como string, convierte el tipo al correr a INT
-- El simbolo mas(+) es el concatenador de SQL.

LEN (nombre) -- posiciones que ocupa en el campo(devuelve un INT).
LEFT (nombre, 3) -- trae los primeros tres caracteres.
RIGHT (nombre, 3) -- trae los ultimos tres caracteres.
SUBSTRING (nombre, 1, 3) --posicion inicial, cuantos caracteres debe correrse.

SELECT JobTitle, LEFT(JobTitle, 3) AS Izquierda -- 1 Funcion SIEMPRE DEVUELVE UN SOLO VALOR. 
	FROM HumanResources.Employee
		WHERE LEFT(JobTitle, 3) = 'Chi'

SELECT JobTitle, LEFT(JobTitle, 3) AS 'Funcion Izquierda'  
	FROM HumanResources.Employee

SELECT JobTitle, 'X' + JobTitle + '		' + 'X', 'Funcion Derecha' = RIGHT(JobTitle, 3)  -- Concatenacion
	FROM HumanResources.Employee

SELECT RTRIM(LTRIM(JobTitle)), 'Funcion Derecha' = RIGHT(JobTitle, 3)  
	FROM HumanResources.Employee

-- El motor de SQL ejecuta de abajo hacia arriba las consultas, el SELECT, es lo ultimo que se ejecuta.

SELECT RTRIM(LTRIM(JobTitle)), 
	'Funcion Derecha' = RIGHT(JobTitle, 3), 
	SUBSTRING(JobTitle, 2, 6) AS 'Substring'
		FROM HumanResources.Employee
			WHERE LEN(JobTitle) >= 20

SELECT JobTitle, 
	LEFT(JobTitle, 3) AS 'Funcion Izquierda',
	REPLACE(JobTitle, 'Database Administrator', 'Iron Man') AS 'Avenger' -- Nombre de la columna, valor del campo, valor futuro.
		FROM HumanResources.Employee
		WHERE JobTitle LIKE '%Database%'

SELECT RTRIM(LTRIM(JobTitle)) AS Puesto, 
	CHARINDEX ('admin', JobTitle, 1) AS Contador
		FROM HumanResources.Employee
			WHERE LEN(JobTitle) >= 20
				ORDER BY Contador DESC

/** EJERCICIO 6 | Funciones de fecha **/

SELECT GETDATE() -- Trae la hora del servidor en donde esta la DB, si es localhost, trae la hora de la PC local, sino el servidor donde corra.

-- Calcular edad de una persona.

SELECT *,
	DATEDIFF(YYYY, Fecha_Nacimiento, GETDATE()) AS Edad,
	DATEPART(MM, GETDATE()) AS Mes
	FROM Personas

SELECT *,
	DATEPART(MM, GETDATE()) AS Mes
	FROM Personas

/** EJERCICIO 7 | Funciones de conversion **/

-- CAST Siempre te devuelve texto 
-- (CAST CONVERT) https://docs.microsoft.com/en-us/sql/t-sql/functions/cast-and-convert-transact-sql?view=sql-server-2017
-- CONVERT te permite dar un formato parciular.

SELECT GETDATE() AS FECHA_NUMERO,
	 CAST(GETDATE() AS VARCHAR(25)) AS FECHA_TEXTO -- Que convierta el getdate en texto de 25 caracteres de largo.