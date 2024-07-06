-- Funciones de fecha

-- seleccionar los años, dias, mes y cuatrimestre de las ordenes
SELECT GETDATE()
--funcion que devuelve alguna parte de una fecha
SELECT DATEPART (YEAR, '2024-06-06') as 'Año',
DATEPART (MONTH, '2024-06-06') as 'Mes',
DATEPART (QUARTER, '2024-06-06') as 'Trimestre',
DATEPART (WEEK, '2024-06-06') as 'Semana',
DATEPART (WEEKDAY, '2024-06-06') as 'Dia de la semana',
DATEPART (yy, '2024-06-06') as 'Año 2'
GO
SELECT DATEPART (YEAR, orderdate) as 'Año',
DATEPART (MONTH, orderdate) as 'Mes',
DATEPART (QUARTER, orderdate) as 'Trimestre',
DATEPART (WEEK, orderdate) as 'Semana',
DATEPART (WEEKDAY, orderdate) as 'Dia de la semana',
DATEPART (yy, orderdate) as 'Año 2'
from orders
GO
--funcion que regresa el nombre de un mes  o dia etc
SELEC DATENAME(MONTH, GETDATE()) AS mes
SET LANGUAGE spanish
SELECT DATENAME(MONTH, GETDATE() AS mes, DATENAME(WEEKDAY, GETDATE())) AS dia

SET LANGUAGE spanish
SELECT DATENAME (YEAR, orderdate) as 'Año',
DATENAME (MONTH, orderdate) as 'Mes',
DATENAME (QUARTER, orderdate) as 'Trimestre',
DATENAME (WEEK, orderdate) as 'Semana',
DATENAME (WEEKDAY, orderdate) as 'Dia de la semana',
DATENAME (yy, orderdate) as 'Año 2'
from orders
go
-- Funcion para obtener la diferencia entre años, meses, dias, etc
select DATEDIFF(year,'1983-04-06', GETDATE()) as 'Tiempo de vejez'

-- seleccionar el numero de dias transcurridos entre la fecha de pedidos y la fecha de entrega
select DATEDIFF(DAY, orderdate, ShippedDate) as 'Dias Transcurridos' from Orders

