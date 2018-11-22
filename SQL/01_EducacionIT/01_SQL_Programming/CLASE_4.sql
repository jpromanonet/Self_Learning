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

SELECT color,
	'Gama_de_Colores' =
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
					GROUP BY Color

INSERT color,
	'Gama_de_Colores' =
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
					GROUP BY Color
						INTO #TablaColor

-- NOTA: SIEMPRE resuelve las operaciones logicas del 'FROM' hacia abajo y luego resuelve las operaciones del dataset en 'SELECT'

/** Ejercicio 2 | INDEX **/

CREATE INDEX IDX_PRODUCT_PRODUCT_NUMBER
	ON Production.Product (ProductNumber)