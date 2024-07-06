-- crear base de datos para demostrar el uso del Left Join
create database PruebaJoins;
use PruebaJoins;

-- Crear la tabla Categorias

create table categoria(
    categoriaid int not null identity (1,1),
    nombre VARCHAR (50) not null default 'No Categoria',
    CONSTRAINT pk_categoria
    PRIMARY KEY (categoriaid)
);

--Crear la tabla producto
create table producto(
    productoid int not null identity (1,1), 
    nombre varchar(50) not null,
    existencia int not null,
    precio money not null,
    categoriaid int,
    CONSTRAINT pk_producto
    primary key(productoid),
    CONSTRAINT unico_nombre
    UNIQUE(nombre),
    CONSTRAINT fk_producto_categoria
    FOREIGN KEY (categoriaid)
    REFERENCES categoria(categoriaid)
);

DROP TABLE producto

--agregar registros a la tabla catgeorias
insert into categoria(nombre)
VALUES ('LB'),
       ('LACTEOS'),
       ('ROPA'),
       ('BEBIDAS'),
       ('CARNES FRIAS');

--Agregar registros a la tabla producto
select*from categoria

insert into producto (nombre, existencia, precio, categoriaid)
VALUES('REFRIGERADOR', 3,10000.0,1),
      ('ESTUFA', 3, 900.04, 1),
      ('CREMA', 2, 10.5, 2),
      ('YOGURT', 3, 13.45, 2);

SELECT*FROM producto

select*
from producto as p
inner join  categoria as c 
on p.categoriaid = c.categoriaid;
--consulta utilizando un left joint
select*
from categoria as c
left join  producto as p 
on p.categoriaid = c.categoriaid;

--seleccionar todas las cetegorias que no tienenn asignado productos

select*
from categoria as c
left join  producto as p 
on p.categoriaid = c.categoriaid
where p.productoid is not null;


select c.categoriaid, c.nombre
from categoria as c
left join  producto as p 
on p.categoriaid = c.categoriaid
where p.productoid is not null;

select*
from producto as c
RIGHT join  categoria as p
on p.categoriaid = c.categoriaid;

select*
from producto as c
FULL join  categoria as p
on p.categoriaid = c.categoriaid;

--consulta utilizando un right joint
select*
from producto as p
RIGHT join  categoria as c
on p.categoriaid = c.categoriaid;

--CREAR UNA BD LLAMADA EJERCICIO JOIN 
--CREAR TABLA EMPLEADOS TOMANDO COMO BASE LA TABLA EMPLOYEES DE NORTHWIND(NO TOMAR TODOS TODOS LOS CAMPOS)
--LLENAR LA TABLA CON UNA CONMSULTA A LA TABLA EMPLOYEES
--AGREGAR NUEVOS DATOS A LA TAB LA EMPLEADOS POR LO MENOS DOS
--ACTUALIZAR LA TABLA EMPLEDOS CON LOS NUEVOS REGISTROS, LA CUAL SE LLENARAN EN UNA NUEVA TABLA LLAMADA dim_productos


create database EJERCICIOJOIN;
use EJERCICIOJOIN;
------
select*from northwind.dbo.employees;

select top 0 employeeid as 'empleadoid',
CONCAT (firstname, ' ', lastname) as 'NombreCompleto',
title as 'Titulo',
hiredate as 'Fechacontratacion'
into EJERCICIOJOIN.dbo.empleados
from northwind.dbo.employees;
------
insert into EJERCICIOJOIN.dbo.empleados (NombreCompleto,Titulo,Fechacontratacion)
select
    CONCAT(firstname, ' ',lastname) as 'NombrenCompleto',
    title as 'titulo',
    hiredate as 'Fechacontratacion'
from northwind.dbo.employees;

select top 0 *
into EJERCICIOJOIN.dbo.dimempleados
from EJERCICIOJOIN.dbo.empleados

SELECT*FROM dimempleados

