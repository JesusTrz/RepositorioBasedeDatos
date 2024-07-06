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

-- Funciones de Agregado, Group by, Having
/*
	sum
	count (*)
	count (campo)
	avg()
	max()
	min()
*/

--Selecciona el numero total de ordenes realizadas
select COUNT(*) as 'Total de Ordenes' from Orders
SELECT COUNT(ShipRegion) as 'Total de ordenes' from Orders
SELECT*FROM Orders

--Selecciona el numero de paises a los que les he enviado ordenes
SELECT COUNT(distinct ShipCountry) as 'Total de Envios a Paises' from Orders

-- Seleccionar el total de ordenes enviadas a franvia entre 1996 y 1998

SELECT COUNT(*) as 'Numero de Ordenes' from Orders
WHERE ShipCountry = 'Mexico'
and YEAR(ShippedDate) BETWEEN '1996' and '1998'

-- Seleccionar el precio min de los productos

select * from Products

select MIN(UnitPrice) from Products

-- Seleccionar el precio max de los productos

select max(UnitPrice) from Products

-- Seleccionar el nombre del producto y el precio de aquel que sea el mas caro
SELECT top 1 ProductName, UnitPrice from Products
ORDER BY UnitPrice desc

--seleccionar el monto total de todas las ordenes
SELECT (UnitPrice * Quantity) as 'Total de Ventas 'from[Order Details]
select*from [Order Details]

--	Seleccionar el total de ventas realizadas a los productos que no tienen descuento
select SUM(UnitPrice*Quantity) as 'Descuento' 
FROM [Order Details]
WHERE not Discount <> 0

-- seleccionar el promedio de ventas para los productos singaporean hokkien fried mee y mozzarella di giovani
SELECT*FROM Products
SELECT AVG(UnitPrice * Quantity) as 'Total de Ventas' FROM [Order Details]
where ProductID in (72,42)

SELECT AVG(UnitPrice * Quantity) as 'Total de Ventas' FROM [Order Details]
where ProductID = 71 or ProductID = 42

--seleccionar el total de ventas para el cliente Chop-suey Chinese de 1996 a 1998

-- Joins

--seleccionar los datos de las rablas categorias y de productos
SELECT *
from Categories as c
INNER JOIN Products as p 
on c.CategoryID = p.CategoryID

SELECT c.CategoryName as 'Nombre de la Categoria', 
p.ProductName as 'Nombre del Producto', 
p.UnitPrice as 'Precio Unitario', 
p.UnitsInStock as 'Existencia', 
(p.UnitPrice*UnitsInStock) as 'Precio Inventario'
from Categories as c
INNER JOIN Products as p 
on c.CategoryID = p.CategoryID

--seleccionar los productos de la categoria beverages

select*FROM Categories

SELECT c.CategoryName as 'Nombre de la Categoria', 
p.ProductName as 'Nombre del Producto', 
p.UnitPrice as 'Precio Unitario', 
p.UnitsInStock as 'Existencia', 
(p.UnitPrice*UnitsInStock) as 'Precio Inventario'
from Categories as c
INNER JOIN Products as p 
on c.CategoryID = p.CategoryID
WHERE c.CategoryName = 'Beverages'
and p.UnitPrice > 20

--Consultas avanzadas
--Seleccionar cuantos productos tiene cada categoria

select * FROM Products

select CategoryID, COUNT(*) FROM Products

SELECT categoryid from products

SELECT * FROM Products

select CategoryID, COUNT(*) 
FROM Products
GROUP BY categoryid

select c.Categoryname, COUNT(*) as 'Numero de productos'
FROM categories as C
inner join products as p
on c.categoryid=p.CategoryID
group by CategoryName;

-- Seleccionar para mostrar todos los productos juntos con sus categorias y sus precios
select p.productname , c.Categoryname, p.UnitPrice ,COUNT(*) as 'Numero de productos'
FROM categories as C
inner join products as p
on c.categoryid=p.CategoryID
group by CategoryName,productname,UnitPrice;

-- Consultar para mostrar los nombre de los productos y los nombres de sus proveedores
SELECT p.productname, s.CompanyName
from products as p 
inner join suppliers as s
on s.supplierid=p.supplierid
GROUP BY productname, companyname

-- Seleccionar las ordenes de compra mostrando los nombres de los productos y sus importes 
SELECT od.ORDERid as 'Numero de orden',
p.ProductName as 'Nombre del producto',
(od.quantity * od.UnitPrice) as 'Importe'
FROM [order details] as od
inner join products as p
on od.productid=p.productid
WHERE (od.quantity * od.UnitPrice) <= 15000
order by 'Importe' desc
-- Mostrar las ordenes de compra y los empleados que las realizaron 
SELECT o.ORDErid as 'Numero de orden',
CONCAT(e.firstname,' ',e.lastname) as 'Nombre completo'
from orders as o
inner join employees as e
on o.EmployeeID=e.EmployeeID
where year(orderdate) in (1996,1999)
-- Seleccionar las ordenes mostrando los clientes a las que se les hicieron las cantidades vendidas y los nombres de los productos ¨
select * from Customers 


--Ejercicio 1: Obtener el nombre del cliente y el nombre del empleado del representante de ventas de cada pedido.
SELECT o.OrderID as 'Numero de orden',
o.OrderDate as 'Fecha de Orden',
c.CompanyName as 'Nombre del Cliente',
CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del Empleado'
FROM
Employees as e
INNER JOIN
Orders AS O
on e.EmployeeID = o.EmployeeID
INNER JOIN 
Customers as c 
on o.CustomerID = c.CustomerID;
--Ejercicio 2: Mostrar el nombre del producto, el nombre del proveedor y el precio unitario de cada producto.
SELECT p.ProductName as 'Nombre del Producto',
s.CompanyName as 'Nombre del Proveedor',
p.UnitPrice as 'Precio'
FROM Products as p
INNER JOIN Suppliers as s
on p.SupplierID=s.SupplierID;

select P.ProductName,S.CompanyName, P.UnitPrice
from(
	SELECT SupplierID,ProductName,UnitPrice FROM Products
) as P
INNER JOIN (
	SELECT SupplierID, CompanyName FROM Suppliers
)AS s
on P.SupplierID=S.SupplierID;

--Ejercicio 3: Listar el nombre del cliente, el ID del pedido y la fecha del pedido para cada pedido.
SELECT c.CompanyName as 'Nombre del Cliente',
c.CustomerID as 'Numero de orden',
o.OrderDate as 'Fecha Pedido',
YEAR(o.OrderDate) as 'Año de Compra',
MONTH(o.OrderDate) as 'Mes de Compra',
DAY(o.OrderDate) as 'Dia de Compra'
FROM Customers as c
INNER JOIN Orders as o
on c.CustomerID=o.CustomerID;

GO

SELECT o.OrderID as 'Numero de orden',
c.CompanyName as 'Nombre del Cliente',
o.OrderDate as 'Fecha de Orden',
YEAR(o.OrderDate) as 'Año de Compra',
MONTH(o.OrderDate) as 'Mes de Compra',
DAY(o.OrderDate) as 'Dia de Compra'
FROM (
	select CustomerID, CompanyName from Customers
) as c
INNER JOIN
( SELECT CustomerID, OrderID, OrderDate from Orders ) as o
on c.CustomerID = o.CustomerID

--Ejercicio 4: Obtener el nombre del empleado, el título del cargo y el departamento del empleado para cada empleado.
SELECT CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del Empleado',
e.Title as 'Cargo', t.TerritoryDescription as 'Territorio'
FROM EmployeeTerritories as et
INNER JOIN Employees as e
on et.EmployeeID = e.EmployeeID
INNER JOIN Territories as t
ON t.TerritoryID=et.TerritoryID;

SELECT CONCAT(e.FirstName, ' ', e.LastName) as 'Nombre del Empleado',
e.Title as 'Cargo', t.TerritoryDescription as 'Territorio'
FROM (
	select TerritoryID, EmployeeID from EmployeeTerritories
	) as et
INNER JOIN (
	select EmployeeID, FirstName, LastName, Title from Employees
	) as e
on et.EmployeeID = e.EmployeeID
INNER JOIN (
	select TerritoryID, TerritoryDescription from Territories
	) as t
ON t.TerritoryID=et.TerritoryID;
/*RETO: Seleccionar todas las ordenes mostrando el empleado que la realizo, al cliente al que se le vendio, 
el nombre de los productos, sus categorias, el precio que se vendio, las unidades vendidas y el importe de 
enero de 1997 a febrero de 1998*/
SELECT CONCAT(FirstName, ' ', LastName) as 'Empleado',
c.CompanyName as 'Cliente',
p.ProductName as 'Nombre del Producto',
ca.CategoryName as 'Categoria',
od.UnitPrice as 'precio',
od.Quantity as 'Cantidad',
(od.UnitPrice*od.Quantity) as 'Importe'
FROM Employees as e
INNER JOIN Orders as o
on e.EmployeeID=o.EmployeeID
INNER JOIN Customers as c
on o.CustomerID = c.CustomerID
INNER JOIN [Order Details] as od
on o.OrderID = od.OrderID
INNER JOIN Products as p
on p.ProductID = od.ProductID
INNER JOIN Categories as ca
on ca.CategoryID=p.CategoryID
WHERE o.OrderDate BETWEEN '1997-01-01' and '1998-02-28'
and ca.CategoryName in ('Beverages')
ORDER BY c.CompanyName

--Cuanto dinero he vendido de las categoria Beverages
select SUM(od.unitpro)
Categories as c
INNER join Products as p
on c.CategoryID = p.CategoryID
INNER join [Order Details] as od
on od.ProductID=p.ProductID
inner joint ORDER as o
where o.OrderDate BETWEEN '1997-01-01' and '1998-02-28'
and c.categoryname in 

--Ejercicio 5: Mostrar el nombre del proveedor, el nombre del contacto y el teléfono del contacto para cada proveedor.
select CompanyName, ContactName, Phone
from Suppliers

--Ejercicio 6: Listar el nombre del producto, la categoría del producto y el nombre del proveedor para cada producto.
select p.ProductName as 'NombreProducto', c.CategoryName as 'CategoriaProducto', s.CompanyName as 'NombreProveedor'
from Products as p
    inner join suppliers as s
    on p.SupplierID = s.SupplierID
    inner join categories as c
    on c.CategoryID = p.CategoryID;

--Ejercicio 7: Obtener el nombre del cliente, el ID del pedido, el nombre del producto y la cantidad del producto para cada detalle del pedido.
select c.CompanyName as 'NombreCliente', o.OrderID as 'IdPedido', p.ProductName as 'NombreProducto', od.Quantity as 'CantidadProducto'
from customers as c
    inner join orders as o
    on c.CustomerID = o.CustomerID
    inner join [Order Details] as od
    on o.OrderID = od.OrderID
    inner join Products as p
    on p.ProductID = od.ProductID


--Ejercicio 8: Obtener el nombre del empleado, el nombre del territorio y la región del territorio para cada empleado que tiene asignado un territorio.
select concat(e.FirstName, ' ', e.LastName) as 'NombreEmpleado', t.TerritoryDescription 'NombreTerritorio', r.RegionDescription as 'RegionTerritorio'
from Employees as e
    inner join EmployeeTerritories as et
    on e.EmployeeID = et.EmployeeID
    inner join Territories as t
    on t.TerritoryID = et.TerritoryID
    inner join region as r
    on r.RegionID = t.RegionID;

--Ejercicio 9: Mostrar el nombre del cliente, el nombre del transportista y el nombre del país del transportista para cada pedido enviado por un transportista.
select c.CompanyName as 'NombreCliente', sh.CompanyName as 'NombreTransportista', o.ShipCountry as 'PaísTransportista'
from Customers as c
    inner join Orders as o
    on c.CustomerID = o.CustomerID
    inner join Shippers as sh
    on sh.ShipperID = o.ShipVia;

--Ejercicio 10: Obtener el nombre del producto, el nombre de la categoría y la descripción de la categoría para cada producto que pertenece a una categoría.
select p.ProductName as 'NombreProducto', c.CategoryName as 'NombreCategoría', c.Description as 'DescripciónCategiría'
from Products as p
    inner join Categories as c
    on c.CategoryID = p.CategoryID;

