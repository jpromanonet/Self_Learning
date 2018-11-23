

SELECT CONVERT(date, So.ModifiedDate, 112) as SalesDate
	   ,So.ProductID  as ProductID 
	   ,P.Name as ProductoDesc
       ,Sum(OrderQty*UnitPrice) as PrecioTotal  
--SELECT So.*, '  ', p.*
FROM [Production].[Product] P
LEFT JOIN [Sales].[SalesOrderDetail] So
ON P.ProductID = So.ProductID
WHERE CONVERT(date, So.ModifiedDate, 112) IS NULL
group By CONVERT(date, So.ModifiedDate, 112), P.Name, So.ProductID



SELECT ISnull(color, 'NoConocido') as Color
,Gama_De_Colores =
		 CASE 
			WHEN COLOR in('Black', 'White')                                      THEN 'Puros'
			WHEN (COLOR = 'Silver' OR  COLOR = 'Silver/Black' OR COLOR = 'Grey') THEN 'Escala de Grises'
			WHEN COLOR = 'MULTI'                                                 THEN 'Paleta de Colores'
			WHEN COLOR = 'Blue'													 THEN 'RGB'
			WHEN COLOR = 'Red'													 THEN 'RGB'
			WHEN COLOR = 'Yellow'												 THEN 'RGB'
			ELSE 'Desconocido' 
		  END 
FROM [Production].[Product] P


SELECT Gama_De_Colores =
		 CASE 
			WHEN COLOR in('Black', 'White')                                      THEN 'Puros'
			WHEN (COLOR = 'Silver' OR  COLOR = 'Silver/Black' OR COLOR = 'Grey') THEN 'Escala de Grises'
			WHEN COLOR = 'MULTI'                                                 THEN 'Paleta de Colores'
			WHEN COLOR = 'Blue'													 THEN 'RGB'
			WHEN COLOR = 'Red'													 THEN 'RGB'
			WHEN COLOR = 'Yellow'												 THEN 'RGB'
			ELSE 'Desconocido' 
		  END, 
	count(*) as Cantidad	   
INTO #Tmp_EscalaColores
FROM [Production].[Product] P
GROUP BY CASE 
			WHEN COLOR in('Black', 'White')                                      THEN 'Puros'
			WHEN (COLOR = 'Silver' OR  COLOR = 'Silver/Black' OR COLOR = 'Grey') THEN 'Escala de Grises'
			WHEN COLOR = 'MULTI'                                                 THEN 'Paleta de Colores'
			WHEN COLOR = 'Blue'													 THEN 'RGB'
			WHEN COLOR = 'Red'													 THEN 'RGB'
			WHEN COLOR = 'Yellow'												 THEN 'RGB'
			ELSE 'Desconocido' 
		  END

SELECT * from #Tmp_EscalaColores

/* sentencia para Obligar al Motor a utilizar un indice  */

CREATE INDEX IDX_PRODUCT_PRODUCT_NUMBER ON [Production].[Product] (ProductNumber)

DECLARE @PD_NUM AS VARCHAR (25)

SET @PD_NUM = 'BA-8327'

select Name 
FROM [Production].[Product] P WITH (INDEX =IDX_PRODUCT_PRODUCT_NUMBER)
WHERE ProductNumber = @PD_NUM


DROP INDEX IDX_PRODUCT_PRODUCT_NUMBER ON [Production].[Product] 

/*******************************************************/
/* INSERT */
/*******************************************************/

IF OBJECT_ID('tempdb..##REPORTE_VENTAS') IS NOT NULL
    DROP TABLE #REPORTE_VENTAS

SELECT * 
INTO ##REPORTE_VENTAS
FROM V_ReporteVentas


IF OBJECT_ID('AdventureWorks2016CTP3..REPORTE_VENTAS') IS NOT NULL
    DROP TABLE REPORTE_VENTAS
	  
SELECT * 
INTO REPORTE_VENTAS
FROM V_ReporteVentas


/* FORMATO GENERICO*/
--INSERT INTO [NOMBRE_TABLA] ([CAMPO1], [CAMPO2], [CAMPON]) VALUES (([VALUE1], [VALUE2], [VALUEN]))

TRUNCATE TABLE REPORTE_VENTAS

/* ESTO LO PUEDO HACER PORQUE LAS ESTRUCTURAS SON IGUALES */
/* IGUALMENTE NO ES RECOMENDABLE PORQUE SI AGREGO UN CAMPO A LA ESTRUCTURA Y NO ES NULL SE ROMPE */
INSERT INTO REPORTE_VENTAS
SELECT * FROM V_ReporteVentas

/*  CHEQUEAR SE TIENE DATA*/
IF EXISTS(SELECT 1 FROM REPORTE_VENTAS) 
    SELECT 'HOLA' 

SELECT * FROM .SYS.tables WHERE NAME = 'REPORTE_VENTAS'  

	  
/*  CHEQUEAR EXISTENCIA */
IF OBJECT_ID('AdventureWorks2016CTP3..REPORTE_VENTAS') IS NOT NULL
    truncate TABLE REPORTE_VENTAS

 DROP TABLE REPORTE_VENTAS

IF EXISTS(SELECT 1 FROM .SYS.tables WHERE NAME = 'REPORTE_VENTAS') 
    SELECT 'HOLA' 
ELSE 
	BEGIN
		SELECT 'NO HAY TABLA'
	END


	  
INSERT INTO [dbo].[REPORTE_VENTAS]([PrecioTotal], [ProductID],[ProductoDesc], [SalesDate])
SELECT PrecioTotal, ProductID ,ProductoDesc,SalesDate
FROM V_ReporteVentas

select count(0) from [dbo].[REPORTE_VENTAS]  -- 26878


INSERT INTO [dbo].[REPORTE_VENTAS]([PrecioTotal], [ProductID],[ProductoDesc], [SalesDate])
SELECT PrecioTotal, ProductID ,ProductoDesc
FROM V_ReporteVentas


/* PARA PODER HACER EL INSERT DE DEBAJO TENGO QUE AGREGAR LOS 2 NUEVOS CAMPOS QUE COLOQUE EN EL SELECT
PARA ESO EJECUTO LA INSTRUCCION DDL  ALTER TABLE 

SINO SE LE AGREGA QUE NO ACEPTE NULLS POR DEFAULT ACEPTA NULLS
SI ALGUNA COLUMNA NO PERMITE NULLS NO SE PUEDE AGREAR ESA COLUMNA (OSEA HACER EL ALTER TABLE) SIN BORRAR TODOS LOS DATOS 
*/

ALTER TABLE [dbo].[REPORTE_VENTAS] ADD ProductCat VARCHAR(25)   /* ACEPTA NULOS */
SELECT * FROM [dbo].[REPORTE_VENTAS] 

TRUNCATE TABLE [dbo].[REPORTE_VENTAS] 

ALTER TABLE [dbo].[REPORTE_VENTAS] ADD Gama_De_Colores CHAR(25) NOT NULL  /* NO ACEPTA NULOS */



INSERT INTO [dbo].[REPORTE_VENTAS]([PrecioTotal], [ProductID],[ProductoDesc], [SalesDate], ProductCat, Gama_De_Colores )
SELECT  Sum(OrderQty*UnitPrice) as PrecioTotal
	   ,So.ProductID  as ProductID 
	   ,P.Name as ProductoDesc
	   ,CONVERT(date, So.ModifiedDate, 112) as SalesDate
	   ,ProductCat = case 
				        when So.ProductID >=0 and So.ProductID <= 500 then '0 a 500'
						when So.ProductID >500  then 'Mayor a 500'               END
       , CASE 
			WHEN COLOR in('Black', 'White')                                      THEN 'Puros'
			WHEN (COLOR = 'Silver' OR  COLOR = 'Silver/Black' OR COLOR = 'Grey') THEN 'Escala de Grises'
			WHEN COLOR = 'MULTI'                                                 THEN 'Paleta de Colores'
			WHEN COLOR = 'Blue'													 THEN 'RGB'
			WHEN COLOR = 'Red'													 THEN 'RGB'
			WHEN COLOR = 'Yellow'												 THEN 'RGB'
			ELSE 'Desconocido' 
		  END AS Gama_De_Colores
FROM [Sales].[SalesOrderDetail] So
INNER JOIN [Production].[Product] P
ON So.ProductID = P.ProductID
group By CONVERT(date, So.ModifiedDate, 112), P.Name, So.ProductID,
	    CASE 
			WHEN COLOR in('Black', 'White')                                      THEN 'Puros'
			WHEN (COLOR = 'Silver' OR  COLOR = 'Silver/Black' OR COLOR = 'Grey') THEN 'Escala de Grises'
			WHEN COLOR = 'MULTI'                                                 THEN 'Paleta de Colores'
			WHEN COLOR = 'Blue'													 THEN 'RGB'
			WHEN COLOR = 'Red'													 THEN 'RGB'
			WHEN COLOR = 'Yellow'												 THEN 'RGB'
			ELSE 'Desconocido' 
		  END 


/*  IN Y EXISTS  */

SELECT * FROM [Sales].[SalesOrderDetail] So
WHERE ProductID IN (707,708,709,710,711)



SELECT * FROM [Sales].[SalesOrderDetail] So
WHERE ProductID in (SELECT ProductID FROM  [Production].[Product] P
				WHERE Color IN ('Black', 'White')  )
/* ESTOS 2 SON IGUALES*/
select so.*
FROM [Sales].[SalesOrderDetail] So
INNER JOIN [Production].[Product] P
ON So.ProductID = P.ProductID
WHERE Color IN ('Black', 'White')

/*EN EL CASO DE NEGARLO NO SON IGUALES */
SELECT * FROM [Sales].[SalesOrderDetail] So
WHERE ProductID NOT in (SELECT ProductID FROM  [Production].[Product] P
				WHERE Color IN ('Black', 'White')  )


select * 
from [Production].[Product] P
where SUBSTRING(ProductNumber,1,2) in ('FW','AR')



SELECT * FROM [Sales].[SalesOrderDetail] So
WHERE EXISTS (SELECT 1 FROM [Production].[Product] P
				WHERE P.ProductID = So.ProductID
				AND Color IN ('Black', 'White')  )



SELECT * FROM [Sales].[SalesOrderDetail] So
WHERE NOT EXISTS (SELECT 1 FROM [Production].[Product] P
				WHERE P.ProductID = So.ProductID
				AND Color IN ('Black', 'White')  )


