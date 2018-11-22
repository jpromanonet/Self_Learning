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

--

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

--

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

/** Ejercicio 2 | INDEX(Indices) **/

CREATE INDEX IDX_PRODUCT_PRODUCT_NUMBER
	ON Production.Product (ProductNumber)

SELECT *
	FROM Production.Product PP 
		WITH (INDEX = IDX_PRODUCT_PRODUCT_NUMBER)

--

CREATE INDEX IDX_PRODUCT_PRODUCT_NUMBER_2
	ON Production.Product (ProductNumber)

DECLARE @PD_NUM AS VARCHAR(25)

SET @PD_NUM = 'BA-8327'

SELECT *
	FROM Production.Product PP 
		WITH (INDEX = IDX_PRODUCT_PRODUCT_NUMBER_2)
			WHERE ProductNumber = @PD_NUM

--NOTA: La diferencia entre un indice comun y un indice cluster es que el indice guarda el sector entero del HDD y 
--el indice cluster guarda la posiciòn exacta en el HDD.

--

DROP INDEX IDX_PRODUCT_PRODUCT_NUMBER_2
	ON Production.Product

--