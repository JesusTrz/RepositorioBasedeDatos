use [basededatosvetas140524]
use Northwind

select*from [Northwind].dbo.Customers;
go
select*from cliente;
go

-- Insertar en la tabla cliente

insert into cliente 
(rfc,curp,nombre,apellidop,apellidom)
values('jilh12830223x9x','FDOJ032012RMCYTAS7','Alfreds Futterkiste','Messi','Ronaldo')
--inserta varios clientes en unsa sola instruccion
insert into cliente 
(rfc,curp,nombre,apellidop,apellidom)
values
('jilh12843523x9x','SODJ034918USMCNTS3','Ana Trujillo Emparedados y helados','Skibidi','Sigma'),
('sdfhh12843523x9x','DAJSPO3215JDMCNTA8','Bs Beverages','pOMNI','Maynez'),
('jilh122345678x9x','ISLK037812HDJNTSA8','Benavidezz','Sheimbaum','Obrador')

go

--crea una tabla  a partir de una consulta
select top 0 
EmployeeID as 'empleadoid',
LastName as 'Apellido',
FirstName as 'Primer Nombre',
BirthDate as 'Cumplea�os',
HireDate as 'Fecha Contratacion',
[Address]as 'Direccion',
City as 'Ciudad',
Region ,PostalCode as CodigoPostal,
Country as 'pais'
into empleado2
from Northwind.dbo.Employees

go

--Altera una tabla para una Primary Key
alter table empleado2
add constraint pk_empleado2
primary key (empleadoid)

go
insert into empleado2 (empleadoid,Apellido,Primer Nombre,Cumplea�os,Fecha Contratacion,Direccion,Ciudad,Region,CodigoPostal,pais) 
select
EmployeeID as 'empleadoid',
LastName as 'Apellido',
FirstName as 'Primer Nombre',
BirthDate as 'Cumplea�os',
HireDate as 'Fecha Contratacion',
[Address]as 'Direccion',
City as 'Ciudad',
Region ,PostalCode as 'CodigoPostal',
Country as 'pais'
from Northwind.dbo.Employees
go

select * from empleado2
select * from cliente
select * from empleado

insert into empleado 
(nombre,apellidop,apellidom,rfc,curp,numeroexterno,calle,salario,numeronomina)
values
('Juan','Sigma','Moxx','AKS9AK9A90SA','DOSJ901029HMSNYAS7','23','Mandala',20500.9,12345),
('Yamilet','Mejia','Rangel','AJS9A233d0SA','YMRR901029SDOPRAS7',null,'Hambre',30000,45678),
('Alex','Hernandez','Sigma','AOS9A563d0DE','POLJ874527HCNYTCA9',null,'Isidro',20000,34092)
go


insert into ordencompra
values (getDate(),'2024-06-10',1,4),
	   (getDate(),'2024-07-11',4,5)

select * from producto

insert into producto (numcontrol,descripcion,precio,[status], existencia, proveedorID)
select ProductID,ProductName,UnitPrice,Discontinued,UnitsInStock,SupplierID 
from Northwind.dbo.Products

select * from ordencompra

select * from detallecompra
insert into detallecompra 
values (1, 3, 30,(select precio from producto where numcontrol =3))

update producto
set precio=20.2
where numcontrol =2

select * from producto
where numcontrol =3

-- Seleccionar las ordenes de compra realizadas al producto1 
select *,(cantidad*preciocompra) from detallecompra
where productoID=1

-- seleccionar el total a pagar de las ordenes que contienen el producto 1
select sum(cantidad * preciocompra) as 'total'
from detallecompra
where productoID = 1

select * from proveedor
select * from Northwind.dbo.Suppliers

insert into proveedor
select CompanyName,PostalCode,'calle de la soledad',City,2345 as cp,'www.prueba.com.mx' as 'paginaweb' 
from Northwind.dbo.Suppliers

delete from proveedor

insert into proveedor
select supplierId,CompanyName,PostalCode,'calle de la soledad',City,2345 as cp,'www.prueba.com.mx' as 'paginaweb' 
from Northwind.dbo.Suppliers

--selecciona la fecha actual del sistema
select GETDATE()

--Comando para reiniciar el Identity
DBCC CHECKIDENT (Tabla,RESEED,0)

------------------------------------------------------------------------------------------------------

--Fechas
select*from Orders
WHERE
(ShippedDate >= '1996-04-30' and ShippedDate <= '1998-04-30')
and EmployeeID in (5,3,1)

select*from Orders
WHERE
(ShippedDate >= '1996-04-30' and ShippedDate <= '1998-04-30')
and (EmployeeID = 5 or EmployeeID = 3 or EmployeeID = 1)

select*from Orders
WHERE
(ShippedDate BETWEEN '1996-04-30' and '1998-04-30')
and EmployeeID in (5,3,1)

--Seleccionar solo los años de las ordenes de copra
SELECT year(OrderDate) as año FROM Orders;

--selecciona todas las ordenes de compra para 1996
SELECT OrderID as 'Numero Orden',
OrderDate as 'Fecha Orden',
year(OrderDate)as año FROM Orders
where OrderDate BETWEEN '1996-01-31' and '1996-12-31'

SELECT OrderID as 'Numero Orden',
OrderDate as 'Fecha Orden',
year(OrderDate)as año FROM Orders
where YEAR(OrderDate)='1996'

--Seleccionar todas las ordenes de compra mostrando el numero de orden,fecha de orden, año, mes y dai de 1996 y 1998
SELECT OrderID as 'Numero Orden', OrderDate as 'Fecha Orden',
year(OrderDate)as año, MONTH(OrderDate) as 'Mes',
DAY(OrderDate) as 'Día'
from Orders
where YEAR(OrderDate) = '1996' or YEAR(OrderDate) = '1998'

SELECT OrderID as 'Numero Orden', OrderDate as 'Fecha Orden',
year(OrderDate)as año, MONTH(OrderDate) as 'Mes',
DAY(OrderDate) as 'Día'
from Orders
where YEAR(OrderDate) in ('1996','1998')

-- Seleccionar todos los apellidos de los empleados que comiencen con D
SELECT * FROM Employees
WHERE LastName LIKE 'D%'

-- Seleccionar todos los apellidos de los empleados que comiencen con D
SELECT * FROM Employees
WHERE LastName LIKE 'Da%'

-- Seleccionar todos los apellidos de los empleados que termine con a
SELECT * FROM Employees
WHERE LastName LIKE '%a'

--seleccionar todos los empleados que su apellido contenga la letra a
SELECT * FROM Employees
WHERE LastName LIKE '%a%'

--seleccionar todos los empleados que su apellido no contenga la letra a
SELECT * FROM Employees
WHERE LastName NOT LIKE '%a%'

--seleccionar todos los empleados que contengan en su apellido cualquier letra y una i
SELECT * FROM Employees
WHERE LastName LIKE '%_i%'

--seleccionar todos los empleados donde su nombre contenga 3 caracteres antes la palabra li, depues un caracter y finalmente la letra d
SELECT * FROM Employees
WHERE LastName LIKE '%__li_g%'

--seleccionar los apellidos de los empleados que comiencen con d o con l
SELECT * FROM Employees
WHERE LastName LIKE 'd%' or LastName LIKE 'l%'

SELECT * FROM Employees
WHERE LastName LIKE '[DL]%'

--seleccionar todos los empleados con su apellido comiencen con una h o a
SELECT * FROM Employees
WHERE LastName LIKE '[AH]%'

--seleccionar todos los empleados con su apellido contengan una D o L
SELECT * FROM Employees
WHERE LastName LIKE '%[DL]%'

--SELECCIONAR TODOS LO EMPLEADOS EN DONDE SU APELLIDO CONTENGA LA LETRAS ENTRE LA A Y F
SELECT * FROM Employees
WHERE LastName LIKE '%[A-F]%'

--SELECCIONA CUANTOS EMPLEADOS EN SU APELLIDO CONTIENE LAS LETRAS A Y LA F
SELECT COUNT(*) as 'Total de Empleados' FROM Employees
WHERE LastName LIKE '%[A-F]%'

-- SELECCIONAR TODOS LOS EMPLEADOS EN DONDE SUS APELLIDOS COMIENCEN CON CB
SELECT * FROM Employees
WHERE LastName LIKE '[CB]%'
-- SELECCIONAR TODOS LOS EMPLEADOS EN DONDE SUS APELLIDOS TERMINEN CON CB
SELECT * FROM Employees
WHERE LastName LIKE '[^CB]%'

