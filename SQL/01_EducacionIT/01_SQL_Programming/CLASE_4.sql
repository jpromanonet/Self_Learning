/** Ejercicio 1 | CASE **/

SELECT color,
	'Gama de Colores' =
		CASE
			WHEN color in('Black', 'White') 
				THEN 'Puros'
			WHEN (color = 'Silver'
					OR color = 'Grey' 
					OR color = 'Silver/Black') 
				THEN 'Escala de grises'
			WHEN color = 'Multi'
				THEN 'Paleta'	
			WHEN color = 'Blue' 
				THEN 'RGB'
			WHEN color = 'Red' 
				THEN 'RGB'
			WHEN color = 'Yellow' 
			THEN 'RGB'
		ELSE 
			'Desconocido'
		END
			FROM Production.Product PP
				WHERE color IS NOT NULL

SELECT 'Gama de Colores' =
		CASE
			WHEN color in('Black', 'White') 
				THEN 'Puros'
			WHEN (color = 'Silver'
					OR color = 'Grey' 
					OR color = 'Silver/Black') 
				THEN 'Escala de grises'
			WHEN color = 'Multi'
				THEN 'Paleta'	
			WHEN color = 'Blue' 
				THEN 'RGB'
			WHEN color = 'Red' 
				THEN 'RGB'
			WHEN color = 'Yellow' 
			THEN 'RGB'
		ELSE 
			'Desconocido'
		END,
		COUNT (*) AS Cantidad
			FROM Production.Product PP
				WHERE color IS NOT NULL
					GROUP BY color