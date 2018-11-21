/** Ejercicio 1 | LIKE **/

SELECT *
	FROM HumanResources.Employee 
		WHERE JobTitle LIKE '%Manager' -- Culmina con manager.

SELECT CONVERT(DATE, BirthDate, 112), * -- Este excluye los valores.
	FROM HumanResources.Employee
		WHERE CONVERT(DATE, BirthDate, 112) >= '1950-01-01'
			AND CONVERT(DATE, BirthDate, 112) <= '1950-01-01'

			SELECT CONVERT(DATE, BirthDate, 112), * -- Este incluye los cvalores
	FROM HumanResources.Employee
		WHERE CONVERT(DATE, BirthDate, 112) BETWEEN '1950-01-01'
			AND '1950-01-01'

/** Ejercicio 2 | Operaciones matematicas **/

SELECT CONVERT(DATE, BirthDate, 112) AS DATE, Jobtitle, -- Este ejemplo NO funciona!
			SUM(VacationHours) AS HorasVacacionestotales,
			AVG(VacationHours) AS HorarasVacacionesPromedio,
			MIN(VacationHours) AS HorarasVacacionesPromedio,
			MAX(VacationHours) AS HorarasVacacionesPromedio
				FROM HumanResources.Employee

/** Ejercicio 3 | GROUP BY **/

SELECT CONVERT(DATE, BirthDate, 112) AS DATE, Jobtitle, -- Este ejemplo SI funciona! (usa este)
			SUM(VacationHours) AS HorasVacacionestotales,
			AVG(VacationHours) AS HorarasVacacionesPromedio,
			MIN(VacationHours) AS HorarasVacacionesPromedio,
			MAX(VacationHours) AS HorarasVacacionesPromedio
				FROM HumanResources.Employee
					GROUP BY CONVERT(date, BirthDate, 112), JobTitle
					HAVING SUM(VacationHours) > 20
					ORDER BY HorasVacacionesTotales

/** Ejercicio 4 | Creacion de Vistas **/

CREATE VIEW vw_VacacionesTotales -- NO tomes ne cuenta el subrayado en rojo, tampoco agregues ORDER BY
	AS

SELECT CONVERT(DATE, BirthDate, 112) AS DATE, Jobtitle, -- Este ejemplo SI funciona! (usa este)
			SUM(VacationHours) AS HorasVacacionestotales,
			AVG(VacationHours) AS HorarasVacacionesPromedio_AVG,
			MIN(VacationHours) AS HorarasVacacionesPromedio_MIN,
			MAX(VacationHours) AS HorarasVacacionesPromedio_MAX
				FROM HumanResources.Employee
					GROUP BY CONVERT(date, BirthDate, 112), JobTitle
					HAVING SUM(VacationHours) > 20

SELECT *
	FROM vw_VacacionesTotales

SELECT DATE, SUM(HorasVacacionestotales) FROM vw_VacacionesTotales
	ORDER BY DATE

DROP VIEW vw_VacacionesTotales

/** Ejercicio 5 | UNION **/

-- UNION permite unificar dos estructuras en una misma consulta.

SELECT CONVERT(DATE, BirthDate, 112) AS DATE, Jobtitle, -- Este ejemplo SI funciona! (usa este)
			SUM(VacationHours) AS HorasVacacionestotales,
			AVG(VacationHours) AS HorarasVacacionesPromedio_AVG,
			MIN(VacationHours) AS HorarasVacacionesPromedio_MIN,
			MAX(VacationHours) AS HorarasVacacionesPromedio_MAX
FROM HumanResources.Employee
	GROUP BY CONVERT(date, BirthDate, 112), JobTitle
		HAVING SUM(VacationHours) > 20
UNION
SELECT * 
	FROM vw_VacacionesTotales 

-- En UNION, NUNCA poner *, poner siempre los campos especificamente y mismo creando vistas.

/** Ejercicio 6 | JOIN **/

-- INNER JOIN (Intersecciòn entre las dos tablas, su orden no importa.)

SELECT *
	FROM Sales.vIndividualCustomer S
		INNER JOIN Sales.vSalesPerson SP1
			ON s.FirstName = SP1.FirstName
		INNER JOIN Sales.vSalesPerson SP2
			ON s.MiddleName = SP2.MiddleName
		INNER JOIN Sales.vSalesPerson SP3
			ON s.LastName = SP3.LastName

SELECT *
	FROM Sales.SalesOrderDetail So
		INNER JOIN Production.Product P
			ON So.ProductID = p.ProductID

-- LEFT JOIN (Se queda con TODA la tabla de la izquierda, el orden de las tablas SI IMPORTA.)

SELECT *
	FROM Sales.vIndividualCustomer S
		LEFT JOIN Sales.vSalesPerson SP1
			ON s.FirstName = SP1.FirstName

SELECT *
	FROM Sales.vIndividualCustomer S
		LEFT JOIN Sales.vSalesPerson SP1
			ON s.FirstName = SP1.FirstName
				WHERE s.AddressLine1 IS NOT NULL

-- RIGHT JOIN (Se queda con TODA la tabla de la izquierda, el orden de las tablas SI IMPORTA.)

SELECT *
	FROM Sales.vIndividualCustomer S
		RIGHT JOIN Sales.vSalesPerson SP1
			ON s.FirstName = SP1.FirstName

-- OUTER JOIN 

 

