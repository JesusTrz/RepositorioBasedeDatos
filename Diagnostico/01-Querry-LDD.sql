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
