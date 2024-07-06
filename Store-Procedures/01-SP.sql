--1.- Correr las Variables (Declarar como se Asignan) -> Transact-SQL
DECLARE @x INT
SET @x=10
PRINT 'El Valor de X es: '+ CAST(@x as varchar)

IF @x>=0
BEGIN
PRINT 'El Numero es Positivo'
END
ELSE
BEGIN
PRINT 'El Numero es Negativo'
END

declare @i as INT
set @i =1
WHILE(@i<=10)
BEGIN
PRINT 'El Primer Valor es: '+CAST(@i as varchar)
set @i=@i+1
END

--Crear un SP (Store Procedures)

CREATE PROCEDURE procedure_cicle
as
BEGIN
    declare @i as INT
    set @i =1

WHILE(@i<=10)
    BEGIN
    PRINT 'El Primer Valor es: '+CAST(@i as varchar)
    set @i=@i+1
END
END;


declare @ii int = 1

while @ii <= 2
BEGIN
    exec procedure_cicle
    set @ii = @ii+1
END

--Realizar un sp que sume 2 numeros cualquiera y que imprima el resultado

drop PROCEDURE procedure_cicle


create PROCEDURE sp_suma1
AS
BEGIN
    declare @suma INT
    set @suma = 4 + 5

print'La suma es: '+ CAST(@suma as varchar)

end

execute sp_suma1



alter PROCEDURE sp_suma1
@n1 as int,
@n2 as int
AS
BEGIN
    declare @suma INT
    set @suma = @n1 + @n2

print'La suma es: '+ CAST(@suma as varchar)

end

execute sp_suma1 5, 6

--SP 
--Tarea realizar un sp que muestre todas las ventas realizadas por cliente para un año cualquiera

select c.CompanyName as 'Nombre del Cliente', 
Sum(od.Quantity * od.UnitPrice) as 'Total' 
from customers as c
INNER JOIN orders as o 
ON c.CustomerID = o.CustomerID
INNER JOIN [Order Details] as od
on od.OrderID = o.OrderID
where DATEPART(YEAR,o.OrderDate) = 1996
GROUP BY c.CompanyName;


CREATE OR ALTER PROC sp_ventasporcliente
   --Parametros
   @year as int 
AS   
BEGIN
   select c.CompanyName as 'Nombre del Cliente', 
    Sum(od.Quantity * od.UnitPrice) as 'Total' 
    from customers as c
    INNER JOIN orders as o 
    ON c.CustomerID = o.CustomerID
    INNER JOIN [Order Details] as od
    on od.OrderID = o.OrderID
    where DATEPART(YEAR,o.OrderDate) = @year
    GROUP BY c.CompanyName

END;

select*from order


--Ejecutar sp
EXEC sp_ventasporcliente 1997

execute sp_ventasporcliente 1996

exec sp_ventasporcliente @year = 1998

--Ecercicio1: Realizar un store procedure que muestre un reporte de ventas por cliente y producto(agrupado),de un rango de fecha.

select c.CompanyName as 'Nombre del Cliente', 
p.ProductName as 'Nombr del producto'
from customers as c
INNER JOIN Products as p
ON c.CustomerID = p.CategoryID
INNER JOIN [Order Details] as od
on od.OrderID = 
where DATEPART(YEAR,o.OrderDate) = 1996
GROUP BY c.CompanyName;

select * FROM Products


--Ejercicio2: Realizar un store procedure que inserte un cliente nuevo
CREATE OR ALTER PROC agregar_cliente
--Parametros de entrada
    @CustomerID nchar(5) ,
    @CompanyName nvarchar(40),
    @ContactName nvarchar(30) =  null,
    @ContactTitle nvarchar(30) =  null,
    @Address nvarchar(60) =  null,
    @City nvarchar(15) =  null,
    @Region nvarchar(15) =  null,
    @PostalCode nvarchar(10) =  null,
    @Country nvarchar(15) =  null,
    @Phone nvarchar(24) =  null,
    @Fax nvarchar(24) =  null
AS
BEGIN
    INSERT INTO [dbo].[Customers]
           ([CustomerID]
           ,[CompanyName]
           ,[ContactName]
           ,[ContactTitle]
           ,[Address]
           ,[City]
           ,[Region]
           ,[PostalCode]
           ,[Country]
           ,[Phone]
           ,[Fax])
     VALUES (@CustomerID
           ,@CompanyName
           ,@ContactName
           ,@ContactTitle
           ,@Address
           ,@city
           ,@Region
           ,@PostalCode
           ,@Country
           ,@Phone
           ,@Fax)
END;
GO

select * from Customers

--Agrega el cliente
begin TRANSACTION
exec agregar_cliente
    @CustomerID = 'GTIG3' ,
    @CompanyName = 'Patito de Huele',
    @ContactName = 'Edith campos',
    @ContactTitle = 'Tutora',
    @Address = 'calle del infierno',
    @City = 'Tula',
    @Region = 'Sur',
    @PostalCode = '42800',
    @Country = 'Mexico',
    @Phone = '33-345678'

--Seleccionamos nuestro cliente que agregamos recientemente
select * from Customers
where CustomerID = 'GTIG3'

-- Store Procedures (Parametros de Salida)
--																					Ejemplo 1
-- Crear un SP que calcule el area de un circulo

create or alter procedure sp_calcular_area_circulo
@radio float, --Parametro de Entrada
@area float output --Parametro de Salida
AS
begin
	set @area = PI() * @radio * @radio
	end;
go


DECLARE @resultado float
exec sp_calcular_area_circulo @radio = 22.3, @area = @resultado output

print 'El valor del area es: '+cast(@resultado as varchar);
go

--																					Ejemplo 2

create or alter proc sp_obtener_informacion_empleados
@employeeid int = -1,
@apellido nvarchar (20) output,
@nombre as nvarchar (10) output
as
begin

IF @employeeid <> -1
begin
	select @nombre=FirstName, @apellido=lastName from Employees
	where EmployeeID = @employeeid
end
else
begin
	print ('El Valor del Empleado no es Valido')
end
end

-- Execute

/*Con @employeeid
Resultado: 
El Nombre es: Nancy
El Apellido es: Davolio
*/
declare @firstname as nvarchar(10),
@lastname nvarchar (20)
exec sp_obtener_informacion_empleados @employeeid =1, 
@nombre = @firstname output, 
@apellido = @lastname output

print ('El Nombre es: '+@firstname)
print ('El Apellido es: '+@lastname)

/*Sin @employeeid
Resultado: El Valor del Empleado no es Valido*/ 
declare @firstname as nvarchar(10),
@lastname nvarchar (20)
exec sp_obtener_informacion_empleados
@nombre = @firstname output, 
@apellido = @lastname output

print ('El Nombre es: '+@firstname)
print ('El Apellido es: '+@lastname)

/*Obtener el nombre de un empleado dado
	- Verificar si el employeeid introducido existe
*/

create or alter proc sp_obtener_informacion_empleado2
@employeeid int = -1,
@apellido nvarchar(20) output,
@nombre as nvarchar(10) output
AS
begin

   DECLARE @existe int
   set @existe=(select count(*) from Employees where EmployeeID =@employeeid)
   -- select @existe = count(*) from Employees where EmployeeID =@employeeid
   

   IF @existe > 0
   begin
    Select @nombre = FirstName, @apellido=lastname
    from Employees
    where EmployeeID = @employeeid
   end
   else
   begin
   if @existe = 0
   begin
      print 'El id del empleado no existe'
   end
  end
end

-------------------------------------------------------------

declare @firstname as nvarchar(10),
@lastname nvarchar(20)

exec sp_obtener_informacion_empleado2
@nombre=@firstname output, @apellido = @lastname output

print ('El nombre es: ' + @firstname)
print ('El apellido es: ' + @lastname)


/*
Realizar un SP que guarde en una variable de salida el total de compras que
ha realizado un clientedado en un rango de fechas
*/

CREATE OR ALTER proc sp_obtener_ventas_por_cliente
@customerid nchar(5),
@fechainicial date,
@fechafinal date,
@total decimal (10,2) output
as

select @total = sum (od.UnitPrice * od.Quantity)
from [Order Details] as od
inner join orders as o
on od.OrderID = o.OrderID
where CustomerID=@customerid and
o.OrderDate between @fechainicial AND @fechafinal;
end

