
/* procesos batch y Cursores */

/* procesar cada Product ID y al campo size le vamos a multiplicar el precio con iva
del ListPrice */

--DECLARE @CONTADOR INT
DECLARE @MAX_REC INT
DECLARE @ProductID INT


SELECT * INTO #TMP_RESULTADO FROM [Production].[Product] P

--SELECT * FROM [Production].[Product] P where ProductID = 10

ALTER TABLE #TMP_RESULTADO ADD ID_INDETIFIER INT IDENTITY(1,1)

SELECT @MAX_REC = MAX(ProductID) FROM [Production].[Product] P

--select * from #TMP_RESULTADO

SET @CONTADOR = 1      

WHILE @CONTADOR <=@MAX_REC
BEGIN
		--recuerden que aca puede ir lo que quieran

     update p set ListPrice = ListPrice*1.21 from [Production].[Product] P where ProductID = @CONTADOR

	SET @CONTADOR = @CONTADOR + 1      

END



/************************************************************************************************************/
/* cursor */
/************************************************************************************************************/


DECLARE @CONTADOR INT
DECLARE @Prod_ID int -- Product ID
DECLARE @ListPrice money-- Product ID
DECLARE @TotalListPrice money-- Product ID

set @TotalListPrice = 0

DECLARE ProductCursor cursor for 
SELECT distinct ProductID, ListPrice
FROM [Production].[Product] nolock 
order by 1
 
OPEN ProductCursor  
FETCH NEXT FROM ProductCursor INTO @CONTADOR, @ListPrice 

WHILE @@FETCH_STATUS = 0  
BEGIN  
     update p set ListPrice = ListPrice*1.21 from [Production].[Product] P where ProductID = @CONTADOR

	 set @TotalListPrice = @TotalListPrice + @ListPrice

      FETCH NEXT FROM ProductCursor INTO @CONTADOR, @ListPrice  
END 

CLOSE ProductCursor  
DEALLOCATE ProductCursor 

select @ListPrice 

