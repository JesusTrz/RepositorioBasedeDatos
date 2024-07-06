create database repasojoins;
use repasojoins;
create table proveedor(
    provid int not null IDENTITY(1,1),
    nombre varchar(50) not null ,
    limite_credito money not null,
    CONSTRAINT pk_proveedor 
    PRIMARY key (provid)

);

create table producto(
    prodid int not null IDENTITY(1,1),
    nombre VARCHAR(100)not null,
    existencia int not null,
    precio money not null,
    proveedor int,
    CONSTRAINT pk_producto
    PRIMARY key(prodid),
    CONSTRAINT fk_producto_proveedor 
    FOREIGN key (proveedor)
    REFERENCES proveedor (provid)
);
insert into proveedor(nombre,limite_credito)
VALUES ('Proveedor1','100000'),
('Proveedor2','200000'),
('Proveedor3','300000'),
('Proveedor4','400000'),
('Proveedor5','500000');

INSERT into producto(nombre,existencia,precio,proveedor)
VALUES ('Producto1',34,45.6,1),
('Producto2',34,45.6,2),
('Producto3',34,45.6,3),
('Producto4',34,45.6,4);

SELECT * FROM proveedor;
select *FROM producto;

-- Consultas Inner Join
--Seleccionar todos los productos que tienen preoveedor 

select pr.nombre as 'Nombre Producto',pr.precio as 'Precio',
pr.existencia as 'Existencia', p.nombre as 'Proveedor'
from proveedor as p 
INNER JOIN
producto as pr 
on p.provid = pr.proveedor;

-- Consulta Left Join
-- Mostrar todos los proveedores y sus respectivos productos
select pr.nombre as 'Nombre Producto',pr.precio as 'Precio',
pr.existencia as 'Existencia', p.nombre as 'Proveedor'
from proveedor as p 
FULL JOIN
producto as pr 
on p.provid = pr.proveedor;
--cambiar nombre
update proveedor
set nombre = 'Provedor6'
where provid=5;

update proveedor
set nombre = 'Provedor5'
where provid=5;

insert into proveedor (nombre,limite_credito)
values ('proveedor6',4500);

DELETE from proveedor 
where  provid= 7;

insert into producto
VALUES('productos', 78.8,22, null)

select p.provid as 'Numero de Proveedor', p.nombre as 'Proveedor', pr.prodid
from proveedor as [p] 
LEFT JOIN
producto as [pr]
on p.provid = pr.proveedor
WHERE pr.prodid is null;

--Seleccionar todos los productos que no tienen proveedor
select pr.nombre, pr.precio, pr.Existencia
from proveedor as [p] 
RIGHT JOIN
producto as [pr]
on p.provid = pr.proveedor
WHERE pr.prodid is null;