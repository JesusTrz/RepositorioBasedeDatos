--Consultas Simples (Consultas a una sola tablas)
use Northwind;

--seleccionar todos los customers (Clientes)
select * from Customers

--Proyección 
select CustomerID,CompanyName,city,Country
from Customers

--selecciona 10 registros de los clientes
select top 10 CustomerID,CompanyName,city,Country
from Customers

--alias de columna 
-- coutry as pais
-- country pais
-- country 'pais'
-- country as 'pais'
-- country as 'Pais de las Maravillas'

select CustomerID as 'Numero de Cliente',CompanyName NombreEmpresa,city as 'Ciudad',Country as 'pais'
from Customers

--alias de tablas
select Customers.CustomerID,Customers.CompanyName,Customers.city,Customers.Country
from Customers

select c.CustomerID,c.CompanyName,c.city,c.Country
from Customers as c

--campo calculado
select *,(p.UnitPrice*p.UnitsInStock) as 'Costo de Inventario'
from Products as p

select ProductName as 'Nombre del Producto', 
UnitsInStock as Existencia,
UnitPrice as 'Precio Unitario',
(p.UnitPrice*p.UnitsInStock) as 'Costo de Inventario'
from Products as p

-- Filtrar Datos
-- Clausula, Where y Operadores relacionales
/*
< Menor que
> Mayor que
<= Menor o Igual
>= Mayor o Igual
<> Diferente
!= Diferente
= Igual a
*/
select * from  Customers
-- Seleccionar todos los clientes de Alemania
 select * 
 from Customers
 where Country='Germany'
 -- Seleccionar todos los productos que tengan un stock mayor a 20 mostrando el nombre del producto, precio y la existencia 
 select * from Products

 select p.ProductName as 'Nombre Producto', 
 p.UnitPrice as 'Precio Unico', 
 p.UnitsInStock as 'Existencia'
 from Products as p
 where p.UnitsInStock > 20
 order by 1 desc;

 select p.ProductName as 'Nombre Producto', 
 p.UnitPrice as 'Precio Unico', 
 p.UnitsInStock as 'Existencia'
 from Products as p
 where p.UnitsInStock > 20
 order by p.ProductName desc;

 -- Seleccionar todos los clientes ordenados de forma ascendente por pais y dentro del pais ordenados de forma descendente por ciudad

 select c.Country, c.City from Customers as c
 where c.country = 'Germany'
 order by c.Country, c.city desc

 --Elimina ñlos valores repetidos de una consulta

 -- seleccionar los paise de los clientes
 select distinct country
 from Customers
 order by 1 asc

 select count (country)
 from Customers


 --Selecciiona todos los productos donde el precio es mayor o igual a 18
 select * from Products as p
 where p.UnitPrice>=18.0

 select count(*) from Products as p
 where p.UnitPrice<>18.0

 select * from Products as p
 where p.UnitPrice<>18.0

 select * from Products as p
 where p.UnitPrice!=18.0

 -- Seleccionar todos los productos que tengan un precio entre 18 y 25 dolares
  select * from Products as p
 where p.UnitPrice between 18 and 25 --Betwwen es un rango

  -- Seleccionar todos los productos que no tengan un precio entre 18 y 25 dolares
 select * from Products as p
 where p.UnitPrice not between 18 and 25 -- Primer Metodo

 select * from Products as p
 where not (p.UnitPrice>=18 and p.UnitPrice<=25) -- Segundo Metdoo

 -- Seleccioanr todos los productos donde el precio sea mayor a 38 y su existencia sea mayor e igual a 22

 select * from 
 Products as p
 where p.UnitPrice>38 and UnitsInStock>=22

 -- Seleccionar todos los clienets de Alemania, Mexico y Francia
 select * from Customers as c
 where c.Country = 'Germany' or c.Country = 'Mexico' or c.Country = 'France'

 select * from Customers as c
 where c.Country in ('Germany','Mexico','France')

 -- Seleccionar todos los clientes que no tengasn region

 select * from Customers as c -- No tienen Región
 where c.Region is null

 select * from Customers as c -- Tienen Región
 where c.Region is not null

 -- Seleccionar todas las ordenes enviadas de julio de 1996 a abril de 1998 para los empleados Buchanan, Leverling y Davolo

 select*from orders as o
 where o.ShippedDate between '1996-07-01' and '1997-04-30'
 and o.EmployeeID in (5,3,1)

 select GETDATE()

 select * from Orders as o
 where not (o.ShippedDate>=1996-07 and o.ShippedDate<=1998-04)

