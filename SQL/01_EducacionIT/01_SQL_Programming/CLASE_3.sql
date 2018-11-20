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
