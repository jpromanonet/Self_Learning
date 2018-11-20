/** Ejercicio 1 | LIKE **/

SELECT *
	FROM HumanResources.Employee 
		WHERE JobTitle LIKE '%Manager' -- Culmina con manager.

SELECT CONVERT(DATE, BirthDate, 112), * -- Este excluye los valores.
	FROM HumanResources.Employee
		WHERE CONVERT(DATE, BirthDate, 112) >= '1950-01-01'
			AND CONVERT(DATE, BirthDate, 112) <= '1950-01-01'

			SELECT CONVERT(DATE, BirthDate, 112), * -- Este excluj
	FROM HumanResources.Employee
		WHERE CONVERT(DATE, BirthDate, 112) BETWEEN '1950-01-01'
			AND '1950-01-01'