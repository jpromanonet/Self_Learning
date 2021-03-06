
/* MERGE RECUERDEN QUE ES UNA FORMA DE UNIFICAR UN UPDATE E INSERT POR 
SEPARADO EN UNA SOLA INSTRUCCION */
DROP TABLE TABLA1
DROP TABLE TABLA2
CREATE TABLE TABLA1 (ID INT, LETRA CHAR(1))

CREATE TABLE TABLA2 (ID INT, LETTER CHAR(1))


INSERT INTO TABLA1 
SELECT 1, 'F'
UNION SELECT 2, 'H'
UNION SELECT 3, 'L'
UNION SELECT 5, 'D'
UNION SELECT 6, 'W'
UNION SELECT 7, 'Z'

INSERT INTO TABLA2 
      SELECT 1, 'A'
UNION SELECT 2, 'T'
UNION SELECT 3, 'I'
UNION SELECT 4, '�'
UNION SELECT 5, 'L'
UNION SELECT 6, 'K'
UNION SELECT 7, 'Z'
UNION SELECT 8, 'Y'
UNION SELECT 9, 'O'


--MERGE <table_destino> AS TARGET
--USING <table_origen> AS SOURCE
--   ON <condicion_compara_llaves>
--[WHEN MATCHED THEN 
--    <accion cuando coinciden> ]
--[WHEN NOT MATCHED [BY TARGET] THEN 
--    <accion cuando no coinciden por destino> ]
--[WHEN NOT MATCHED BY SOURCE THEN 
--    <accion cuando no coinciden por origen> ];
 
MERGE TABLA1 AS TARGET
USING TABLA2 AS SOURCE
   ON (TARGET.ID = SOURCE.ID) 
WHEN MATCHED THEN 
   UPDATE SET TARGET.LETRA = SOURCE.LETTER
WHEN NOT MATCHED BY TARGET THEN 
	INSERT (ID, LETRA) 
	VALUES (SOURCE.ID, SOURCE.LETTER)
;


MERGE TABLA2 AS TARGET
USING TABLA1 AS SOURCE
   ON (TARGET.ID = SOURCE.ID) 
WHEN MATCHED THEN 
   UPDATE SET TARGET.LETTER = SOURCE.LETRA
WHEN NOT MATCHED BY TARGET THEN 
	INSERT (ID, LETTER) 
	VALUES (SOURCE.ID, SOURCE.LETRA)
;
	
SELECT * FROM TABLA1 ORDER BY 1

SELECT * FROM TABLA2 ORDER BY 1

DELETE D FROM TABLA2 D WHERE ID = 5 

















/***********************************************************************************************/
/*** VARIABLES                                                         **********************/
/***********************************************************************************************/

DECLARE @FECHA_HOY DATETIME
DECLARE @CONTADOR INT
DECLARE @MENSAJE VARCHAR(500)

SET @CONTADOR = 0
--SETEO EL VALOR
SET @MENSAJE = 'QUE DIA ES HOY?'

/* MUESTRO EL VALOR */
SELECT @MENSAJE 

WHILE @CONTADOR <=5
BEGIN
	SELECT @FECHA_HOY = CONVERT(DATE, GETDATE()-@CONTADOR, 112)

	SELECT @MENSAJE = CASE WHEN @FECHA_HOY = CONVERT(DATE, GETDATE(), 112) 
							THEN 'LA FECHA ES LA DE HOY'
					       WHEN @FECHA_HOY <> CONVERT(DATE, GETDATE(), 112) 
						   THEN 'LA FECHA ES DE HACE ' + CAST(@CONTADOR AS VARCHAR(2)) + ' DIA '
					  END	    

	SELECT * FROM TABLA1 WHERE ID = @CONTADOR 
--	SELECT @MENSAJE 
	SET @CONTADOR = @CONTADOR + 1      

END

/* VARIABLES DE SISTEMA: ESTAS VARIABLES SON CON DOBLE @ Y NO SE DECLARAN YA QUE SON DEL SISTEMA 
POR DEFAULT VIENEN INSTALADAS.
*/

SELECT @@ROWCOUNT  --CANTIDAD DE FILAS DE LA ULTIMA CONSULTA
SELECT @@SERVERNAME --NOMBRE DEL SERVIDOR  
SELECT @@VERSION --VERSION DEL SQL INSTALADO
SELECT @@CONNECTIONS --CANTIDAD DE CONNECIONES QUE SE INTETARON


/* VARIABLES DEL TIPO TABLA */
/* UTILIZAMOS EL MISMO EJEMPLO DE TABLA1 DE LA PARTE DE MERGE */

DECLARE @TABLA2 TABLE (ID INT IDENTITY(1, 1), VALOR1 INT, LETRA CHAR(1))


INSERT INTO @TABLA2
      SELECT 1, 'A'
UNION SELECT 2, 'T'
UNION SELECT 3, 'I'
UNION SELECT 4, '�'
UNION SELECT 5, 'L'
UNION SELECT 6, 'K'
UNION SELECT 7, 'Z'
UNION SELECT 8, 'Y'
UNION SELECT 9, 'O'


SELECT * FROM @TABLA2

UPDATE D SET LETRA = 'H' FROM @TABLA2 D WHERE ID BETWEEN 1 AND 4

SELECT 'UPDATE', * FROM @TABLA2

DELETE D FROM @TABLA2 D WHERE ID IN (8,9)

SELECT 'DELETE', * FROM @TABLA2




/***********************************************************************************************/
/*** FUNCIONES                                                         **********************/
/***********************************************************************************************/
/* FUNCIONES ESCALARES: PORQUE DEVUELVEN UN DATO QUE NO ES TABLA */

CREATE FUNCTION SUMA(@VALOR1 INT, @VALOR2 INT) RETURNS INT
AS
BEGIN
	RETURN @VALOR1 + @VALOR2
END 


CREATE FUNCTION Fn_GetProductName(@id INT) RETURNS varchar(100)
AS
BEGIN
	DECLARE @NAME VARCHAR(100)

	SELECT @NAME = NAME
	FROM [Production].[Product] P WHERE ProductID = @id 
	
	RETURN @NAME
END 


/*  FUNCIONES Y PROCEDIMIENTOS   */

SELECT .DBO.SUMA(10, 25), .DBO.SUMA(2658, 9964)


SELECT SafetyStockLevel, ReorderPoint 
	   ,.DBO.SUMA(SafetyStockLevel, ReorderPoint) AS Sumarizacion
	   ,.DBO.Fn_GetProductName(ProductID) AS 'NOMBRE PRODUCTO' 
	   --INTO #TEMP
FROM [Production].[Product] P

SELECT * FROM #TEMP

/*ACTUALIZO EL SIZE CON LA SUMA DE LOS 2 VALORES */
UPDATE P SET Size = .DBO.SUMA(SafetyStockLevel, ReorderPoint) 
--SELECT SafetyStockLevel, ReorderPoint, Size , .DBO.SUMA(SafetyStockLevel, ReorderPoint) 
FROM [Production].[Product] P


/* FUNCIONES TIPO TABLA: PORQUE DEVUELVEN UN DATO QUE ES TABLA */

CREATE FUNCTION SUMAR_EN_TABLA(@VALOR1 INT, @VALOR2 INT) 
	RETURNS @RESULT TABLE (ID INT IDENTITY(1, 1), VALOR1 INT, VALOR2 INT, 
	                       RESULTADO INT)
AS
BEGIN

	INSERT INTO @RESULT (VALOR1, VALOR2, RESULTADO)
	SELECT @VALOR1, @VALOR2, @VALOR1 + @VALOR2


	RETURN 
END 


/*LLAMARLA SOLA */
SELECT * FROM .DBO.SUMAR_EN_TABLA (10, 22)
SELECT .DBO.SUMA(10, 25)

SELECT ProductID, SIZE, SafetyStockLevel, ReorderPoint, RESULTADO
FROM [Production].[Product] P
CROSS APPLY .DBO.SUMAR_EN_TABLA(SafetyStockLevel, ReorderPoint) 
ORDER BY ProductID


CREATE FUNCTION SUMAR_Y_MULTIPLICA(@VALOR1 INT, @VALOR2 INT) 
	RETURNS @RESULT TABLE (ID INT IDENTITY(1, 1), VALOR1 INT, VALOR2 INT, 
	                       RESULTADO INT)
AS
BEGIN

	INSERT INTO @RESULT (VALOR1, VALOR2, RESULTADO)
			SELECT @VALOR1, @VALOR2, @VALOR1 + @VALOR2
	UNION  SELECT @VALOR1, @VALOR2, @VALOR1 * @VALOR2


	RETURN 
END 


/*LLAMARLA SOLA */
SELECT * FROM .DBO.SUMAR_Y_MULTIPLICA (10, 22)

/*RECUERDEN QUE HICIMOS ALTER FUNCTION DESDE LA FUNCION --> BOTON DERECHO MODIFY*/

--ALTER FUNCTION [dbo].[SUMAR_Y_MULTIPLICA](@VALOR1 INT, @VALOR2 INT) 
--	RETURNS @RESULT TABLE (ID INT IDENTITY(1, 1), RESULTADO INT, OPERACION VARCHAR(50))
--AS
--BEGIN

--	INSERT INTO @RESULT (RESULTADO, OPERACION)
--			SELECT @VALOR1 + @VALOR2, 'SUMA'
--	UNION  SELECT @VALOR1 * @VALOR2, 'MULTIPLICACION'


--	RETURN 
--END 


SELECT * FROM .DBO.SUMAR_Y_MULTIPLICA (10, 22)

SELECT ProductID, SIZE, SafetyStockLevel, ReorderPoint, RESULTADO--, OPERACION 
FROM [Production].[Product] P
CROSS APPLY .DBO.SUMAR_Y_MULTIPLICA(SafetyStockLevel, ReorderPoint) 
ORDER BY ProductID

/*****************************************************************************************/
/* STORED PROCEDURES */
/*****************************************************************************************/


alter  PROCEDURE P_SUMA_VALORES @VALOR1 INT, @VALOR2 INT
AS
BEGIN

	SELECT @VALOR1 + @VALOR2 

END

create PROCEDURE P_SUMA_VALORES_Param_Output @VALOR1 INT, @VALOR2 INT, @resultado int output
AS
BEGIN

	SELECT @resultado = @VALOR1 + @VALOR2 

END

/* NO SE PUEDE HACER NIGUNA DE ESTAS 2 OPERACIONES

SELECT .DBO.P_SUMA_VALORES(10, 25), .DBO.P_SUMA_VALORES(2658, 9964)

SELECT SafetyStockLevel, ReorderPoint 
	   ,.DBO.P_SUMA_VALORES(SafetyStockLevel, ReorderPoint) AS Sumarizacion
FROM [Production].[Product] P
*/

/* FORMA CORRECTA */
EXEC P_SUMA_VALORES @VALOR1=10, @VALOR2=2

declare @result int

EXEC P_SUMA_VALORES_Param_Output  @resultado = @result output, @VALOR1=10, @VALOR2=2

EXEC P_SUMA_VALORES_Param_Output  10, 2, @result output
EXEC P_SUMA_VALORES_Param_Output  2, 10, @result output
select @result

/* ESTE SP NO RETORNA NADA NI RECIBE VALORES */

alter PROCEDURE P_UDPATE_DISCONTINUED_DATE
AS
BEGIN

	UPDATE P SET DiscontinuedDate = CASE WHEN SellEndDate IS NULL THEN GETDATE()-5
										 WHEN  SellEndDate IS NOT NULL THEN DATEADD(DD, 1, SellStartDate)
									END		
	--select *
	FROM [Production].[Product] P
	where ProductID between 1 and 500
	/* agrego este filtro para probar el @@rowcount */		

	select @@ROWCOUNT

END


SELECT DiscontinuedDate, SellEndDate, SellStartDate FROM [Production].[Product] P

exec .dbo.P_MostrarData

exec P_UDPATE_DISCONTINUED_DATE

select @@ROWCOUNT

create procedure .dbo.P_MostrarData
as
begin
	SELECT ProductID, SIZE, SafetyStockLevel, ReorderPoint, RESULTADO--, OPERACION 
	FROM [Production].[Product] P
	CROSS APPLY .DBO.SUMAR_Y_MULTIPLICA(SafetyStockLevel, ReorderPoint) 
	ORDER BY ProductID
end 


/******************************************************************/
/* creamos una tabla con la estructura de lo que devuelve el SP 
.dbo.P_MostrarData para poder guardar los resultados dentro de esta tabla */
/******************************************************************/

create table Resultado_SP
(productid int
,size nvarchar(5)
,SafetyStockLevel smallint
,ReorderPoint	 smallint
,result int 
,valor1 varchar (15)
,Fecha_Ejecucion datetime
)

select * from Resultado_SP


INSERT INTO Resultado_SP exec .dbo.P_MostrarData
