
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




/************************************************************************************************************/
/* cursor con begin transaction Commit cada 50 registros*/
/************************************************************************************************************/


DECLARE @CONTADOR INT
DECLARE @Prod_ID int -- Product ID
DECLARE @ListPrice money-- Product ID
DECLARE @TotalListPrice money-- Product ID

set @TotalListPrice = 0
set @CONTADOR = 1

DECLARE ProductCursor cursor for 
SELECT distinct ProductID, ListPrice
FROM [Production].[Product] nolock 
order by 1
 
OPEN ProductCursor  
FETCH NEXT FROM ProductCursor INTO @CONTADOR, @ListPrice 

WHILE @@FETCH_STATUS = 0  
BEGIN  

	 begin transaction
			select @iva = iva from impuestos
		 update p set ListPrice = ListPrice*@iva from [Production].[Product] P where ProductID = @CONTADOR

--		 update s set cant_stock = cant_stock - @cantidad from stock s where ProductID = @CONTADOR
--		exec 	sp
		set @TotalListPrice = @TotalListPrice + @ListPrice

	  if @CONTADOR < 500000	
	     set @CONTADOR = @CONTADOR + 1 
       else 
		  begin	
			commit
			set @CONTADOR = 1 
	      end
		   
      FETCH NEXT FROM ProductCursor INTO @CONTADOR, @ListPrice  
END 

CLOSE ProductCursor  
DEALLOCATE ProductCursor 


/************************************************************************************************************/
/* begin transaction Commit  begin transaccion Rollback */
/************************************************************************************************************/

Create table #temp (id int identity(1,1), nombre varchar(5))
Create table #LogErrors (idError int identity(1,1), MsgError varchar(8000), ErrorCode int, errorProcess varchar (255))
alter table #LogErrors add CampoValor varchar(500)


Declare @Nombre varchar(50) 
set @Nombre ='marta Gonzalex'	

begin transaction
	begin try
--		insert into #temp (nombre) select 'fede'
		insert into #temp (nombre) select @Nombre
    end try

	begin catch
		rollback
		--insert into #LogErrors (MsgError, ErrorCode, errorProcess, CampoValor)
		select ERROR_MESSAGE() error_Messeage,ERROR_NUMBER() ErroNum, 'Nuevo Cliente'
		       , 'Nombre = ' + @Nombre, ERROR_SEVERITY() as severidad, ERROR_PROCEDURE() Procedimiento

	end catch

commit

select * from #LogErrors 

INSERT INTO [dbo].[PROCESS_LOG_STATUS]([PROCESS_NAME],[PROCESS_STEP],[PARAMETERS],[STATUS],[TIMESTAMP])
SELECT /*nombre Proceso*/ @SP_NAME, 
/*paso */ 'INSERT TABLE TEMP #TMP_CAMPANIA_AGNT_CALC'
/* variables de ejecucion*/	,' @COMPANYID: ' + ISNULL(@COMPANY_ID, '0') + ' || @DAY_FROM: ' + CAST(@DAY_FROM AS VARCHAR(30))+ '|| @DAY_TO: ' +CAST(@DAY_TO AS VARCHAR(30))
/*codigo de error*/	, @ERROR_VAR
/*fecha hora de error*/	, GETDATE()


select * from #temp

/****************************************************************************************/

------------------------------------------------------------------------------------------------
-- TRIGGER
------------------------------------------------------------------------------------------------
-- 11) CREAR UNA TABLA TEMPORAL LLAMADA #HISTORICOPRECIOS CON LAS COLUMNAS PRODUCTID, 
-- PRECIOANTERIOR PRECIONUEVO.


CREATE TABLE #HistoricoPrecios
(
	[ProductoOfertaID]		INT
	,[PrecioAnterior]		MONEY
	,[PrecioNuevo]			MONEY
	,DATEMODIFIED      DATETIME
)
GO


--12)CREAR UN TRIGGER SOBRE LA TABLA PRODUCTION.PRODUCT LLAMADO TR_ACTUALIZAPRECIOS DÓNDE ACTUALICE 
--   LA TABLA #HISTORICOPRECIOS CON EL ID DEL PRODUCTO Y LOS CAMBIOS DE PRECIO.
IF OBJECT_ID ( '[Production].[TR_ActualizaPrecios]', 'TR' ) IS NOT NULL 
    DROP TRIGGER [Production].[TR_ActualizaPrecios];
GO

CREATE TRIGGER [nombre trigger] 
ON [NOMBRE TABLA] 
--AFTER UPDATE
BEFORE INSERT AS


ALTER TRIGGER [Production].[TR_ActualizaPrecios] 
ON [Production].[Product]
AFTER UPDATE AS
BEGIN
	
		--SELECT 'INSERTED', *, USER, SUSER_SNAME() FROM inserted
		  
		--SELECT 'DELETED', * FROM deleted
		
		--UPDATE #HistoricoPrecios
		--SET [PrecioNuevo]=I.[ListPrice], [PrecioAnterior]= D.[ListPrice]
		--FROM 
		--	#HistoricoPrecios hp
		--	INNER JOIN inserted I
		--	ON I.[ProductID]=hp.[ProductoOfertaID]
		--	INNER JOIN deleted D
		--	ON I.[ProductID]=D.[ProductID]
		--WHERE hp.[ProductoOfertaID]=I.[ProductID]
			

			INSERT INTO #HistoricoPrecios
			SELECT I.[ProductID], D.[ListPrice], I.[ListPrice], GETDATE()
			FROM inserted I
			INNER JOIN DELETED D
			ON I.[ProductID]=D.[ProductID]

END

-- COMPROBACION
SELECT [ListPrice] FROM [Production].[Product] WHERE [ProductID]=1

UPDATE [Production].[Product]
	SET [ListPrice]=875
WHERE ProductID=1

967 500
500 2000
2000 875

SELECT [ListPrice] FROM [Production].[Product] WHERE [ProductID]=1
SELECT * FROM #HistoricoPrecios 



--13) ADAPTAR EL TRIGGER DEL PUNTO ANTERIOR DONDE VALIDE QUE EL PRECIO NO PUEDA SER NEGATIVO.
GO
ALTER TRIGGER [Production].[TR_ActualizaPrecios] 
ON [Production].[Product]
INSTEAD OF UPDATE AS
BEGIN
			IF (SELECT [ListPrice] FROM inserted) > 0
			BEGIN 
				
					UPDATE [Production].[Product]
						SET [ListPrice]=D.[ListPrice]
					FROM 
							[Production].[Product] PP
							
							INNER JOIN deleted D
							ON PP.[ProductID]=D.[ProductID]

					WHERE PP.[ProductID]=D.[ProductID]

					UPDATE #HistoricoPrecios
					SET [PrecioNuevo]=I.[ListPrice], [PrecioAnterior]= D.[ListPrice]
					FROM 
						#HistoricoPrecios	 PO
						INNER JOIN inserted I
						ON I.[ProductID]=PO.[ProductoOfertaID]

						INNER JOIN deleted D
						ON I.[ProductID]=D.[ProductID]
					WHERE PO.[ProductoOfertaID]=I.[ProductID]
			END
			
END


-- COMPROBACION
SELECT [ListPrice] FROM [Production].[Product] WHERE [ProductID]=1

UPDATE [Production].[Product]
	SET [ListPrice]=-1
WHERE ProductID=1;

SELECT [ListPrice] FROM [Production].[Product] WHERE [ProductID]=1
SELECT * FROM #HistoricoPrecios WHERE [ProductoOfertaID]=1


/**/

create table DailyIncome(VendorId nvarchar(10), IncomeDay nvarchar(10), IncomeAmount int)


--drop table DailyIncome


 
 

insert into DailyIncome values ('SPIKE', 'FRI', 100)


insert into DailyIncome values ('SPIKE', 'MON', 300)


insert into DailyIncome values ('FREDS', 'SUN', 400)


insert into DailyIncome values ('SPIKE', 'WED', 500)


insert into DailyIncome values ('SPIKE', 'TUE', 200)


insert into DailyIncome values ('JOHNS', 'WED', 900)


insert into DailyIncome values ('SPIKE', 'FRI', 100)


insert into DailyIncome values ('JOHNS', 'MON', 300)


insert into DailyIncome values ('SPIKE', 'SUN', 400)


insert into DailyIncome values ('JOHNS', 'FRI', 300)


insert into DailyIncome values ('FREDS', 'TUE', 500)


insert into DailyIncome values ('FREDS', 'TUE', 200)


insert into DailyIncome values ('SPIKE', 'MON', 900)


insert into DailyIncome values ('FREDS', 'FRI', 900)


insert into DailyIncome values ('FREDS', 'MON', 500)


insert into DailyIncome values ('JOHNS', 'SUN', 600)


insert into DailyIncome values ('SPIKE', 'FRI', 300)


insert into DailyIncome values ('SPIKE', 'WED', 500)


insert into DailyIncome values ('SPIKE', 'FRI', 300)


insert into DailyIncome values ('JOHNS', 'THU', 800)


insert into DailyIncome values ('JOHNS', 'SAT', 800)


insert into DailyIncome values ('SPIKE', 'TUE', 100)


insert into DailyIncome values ('SPIKE', 'THU', 300)


insert into DailyIncome values ('FREDS', 'WED', 500)


insert into DailyIncome values ('SPIKE', 'SAT', 100)


insert into DailyIncome values ('FREDS', 'SAT', 500)


insert into DailyIncome values ('FREDS', 'THU', 800)


insert into DailyIncome values ('JOHNS', 'TUE', 600)

select * from DailyIncome
pivot (sum (IncomeAmount) for IncomeDay in ([MON],[TUE],[WED],[THU],[FRI],[SAT],[SUN])) as AvgIncomePerDay




select  SalesOrderId, CarrierTrackingNumber
        , (10 + ROW_NUMBER() OVER (PARTITION BY SalesOrderId, CarrierTrackingNumber ORDER by SalesOrderId)) as Internal
--		,(-1 + ROW_NUMBER() OVER (PARTITION BY SalesOrderId, CarrierTrackingNumber ORDER BY CONVERT(date, i.Inicio,112))) as Internal,
 from [Sales].[SalesOrderDetail]
