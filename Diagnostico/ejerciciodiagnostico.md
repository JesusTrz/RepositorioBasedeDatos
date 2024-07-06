# Problematica
Una empresa encargada de las ventas de diferentes productos desea crear una base de datos que controles los proveedores, clientes, empleados, categorías de producto y órdenes de compra. Para los proveedores se necesita almacenar un numero de control, nombre de la empresa, dirección (numero, calle, colonia, estado), cp,teléfono, página web, teléfono de contacto o contactos del proveedor, nombre del contacto, email del contacto. Para los empleados se desea almacenar un numero de nómina, nombre completo del empleado, rfc, curp, salario (El salario máximo es de 65000), para las ordenes de compra se necesita almacenar la fecha de creación de la orden, el empleado que la realizo, al cliente que se le vende, la fecha de entrega y los diferentes productos que contiene. El producto debe almacenar un numero de control y una descripción única, status, existencia y un precio. La categoría debe tener un identificador y nombre único de categoría. La compra siempre debe tener un precio de venta que se obtiene del precio unitario del producto y una cantidad vendida.
# Diagrama Relacional
![Diagrama Relacional](./img/bdventas.png)

# Creacion BD con Lenguaje SQL - LDD
```sql
create database basededatosvetas140524;
use basededatosvetas140524;

create table cliente (
clienteID int not null identity (1,1),
rfc varchar (20) not null,
curp varchar (18) not null,
nombre varchar (50) not null,
apellidop varchar (50) not null,
apellidom varchar (50) not null,
constraint pk_cliente
primary key(clienteID),
constraint unico_rfc 
unique (rfc),
constraint unico_curp
unique (curp),
);

create table contacto_proveedor(
contactoID int not null identity (1,1),
proveedorID int not null,
nombres varchar (50) not null,
apellidop varchar (50) not null,
apellidom varchar (50) not null,
constraint pk_contactoproveedor
primary key (contactoID)
)

create table proveedor(
proveedorID int not null identity (1,1),
nombreEmpresa varchar (50) not null,
rfc varchar (20) not null,
calle varchar (30) not null,
colonia varchar (50) not null,
cp int not null,
paginaweb varchar (80),
constraint pk_proveedor
primary key (proveedorID),
constraint unico_nombreEmpresa
unique (nombreEmpresa),
constraint unico_rfc2
unique (rfc)
)
--------------------------------

alter table contacto_proveedor
add constraint fk_contactoproveedor_proveedor
foreign key (proveedorID)
references proveedor(proveedorID)

--------------------------------

create table empleado (
empleadoID int not null identity(1,1),
nombre varchar (50) not null,
apellidop varchar (50) not null,
apellidom varchar (50) not null,
rfc varchar (20) not null,
curp varchar (18) not null,
numeroexterno int,
calle varchar (50) not null,
salario money not null,
numeronomina int not null,
constraint pk_empleado
primary key (empleadoID),
constraint unico_rfc_empleado
unique (rfc),
constraint unico_curp_empleado
unique (curp),
constraint chk_salario
check(salario>=0.0 and salario<=100000),
--  check (salario between 0.1 and 100000)
constraint unico_nomina_empleado
unique (numeronomina)
)

create table telefonoproveedor(
telefonoID int not null,
proveedorID int not null,
numerotelefono varchar (15),
constraint pk_telefono_proveedor
primary key(telefonoID, proveedorID),
constraint fk_telefonoprov_proveedor
foreign key(proveedorID)
references proveedor (proveedorID)
on delete cascade
on update cascade
)

create table producto (
numcontrol int not null identity (1,1),
descripcion varchar (50) not null,
precio money not null,
[status] int not null, 
existencia int not null,
proveedorID int not null,
constraint pk_producto
primary key (numcontrol),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
--precio >=1 and <=2000000
check(precio between 1 and 200000),
constraint chk_status
-- satatus in (0,1)
check([status] =1 or [status] =0),
check (existencia>0),
constraint fk_producto_proveedor
foreign key (proveedorID)
references proveedor(proveedorID)
)

create table ordencompra(
numorden int not null identity (1,1),
fechacompra date not null,
fechaentrega date not null,
clienteID int not null,
empleadoID int not null,
constraint pk_ordencompra
primary key (numorden),
constraint fk_ordencompra_cliente
foreign key (clienteID)
references cliente (clienteID),
constraint fk_ordencompra_empleado
foreign key (empleadoID)
references empleado(empleadoID)
)


create table detallecompra(
productoID int not null,
numorden int not null,
cantidad int not null,
preciocompra money not null,
constraint pk_detalleCompra
primary key (productoID, numorden),
constraint fk_ordencompra_producto
foreign key (productoID)
references producto(numcontrol),
constraint fk_ordencompra_compra
foreign key (numorden)
references ordencompra(numorden)
)
```
# Llenar base de datos con Lenguaje SQL-LMD

```sql
use [basededatosvetas140524]

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
BirthDate as 'Cumpleaños',
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
insert into empleado2 (empleadoid,Apellido,Primer Nombre,Cumpleaños,Fecha Contratacion,Direccion,Ciudad,Region,CodigoPostal,pais) 
select
EmployeeID as 'empleadoid',
LastName as 'Apellido',
FirstName as 'Primer Nombre',
BirthDate as 'Cumpleaños',
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
```

# Consultas

 

 