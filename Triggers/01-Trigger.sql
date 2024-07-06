-- Sintaxis del Triger

/*
CREATE TRIGGER nombre_trigger
ON nombre_tabla
AFTER insert, delete, update
AS
	BEGIN
	---codigo
	END
*/
create database pruebatrigersg3
go

create table tabla1(
id int not null primary key,
nombre varchar(50) not null
);

go

--Triggers

--Trigger que verifica el evento que se ejecuto
									--Insertar/Insert--
create trigger tg_verificar_insercion
on tabla1
after insert 
as
begin
	print 'Se Ejecuto el evento insert en la tabla1'
	end;


insert into tabla1
values(1, 'Nombre1')

									--Eliminar/Delete--
create or alter trigger tg_verificar_delete
on tabla1
after delete 
as
begin
	print 'Se Ejecuto el evento delete en la tabla1'
	end;

delete tabla1
where id=1

insert into tabla1
values(1, 'Nombre1')


									--Actualizar/Update--
create or alter trigger tg_verificar_update
on tabla1
after update 
as
begin
	print 'Se Ejecuto el evento update en la tabla1'
	end;

update tabla1
set nombre = 'Nombre Nuevo'
where id = 1;

									--Eliminar Triggers
drop trigger tg_verificar_insercion
drop trigger tg_verificar_delete
drop trigger tg_verificar_update


create trigger verificar_contenido_inserted
on tabla1
after insert
as
begin
--Ver los datos de la tabla inserted
select*from inserted;
end

insert into tabla1
values(2,'Nombre2')

insert into tabla1
values(3,'Nombre3')

insert into tabla1
values(4,'Nombre4'), (5,'Nombre5')

select*from tabla1


					--Usar NorthWind

use Northwind

create or alter trigger verificar_inserted_categories
on categories
after insert
as
begin
select categoryid, categoryname, [description] from inserted;
end

insert into Categories (CategoryName, Description)
values ('CategoriaNueva','Prueba Triggers')


create or alter trigger verificar_update_categories
on categories
after update
as
begin
select categoryid, categoryname, [description] from inserted;
select categoryid, categoryname, [description] from deleted;
end

select*from Categories
go

--Cancelar Update
begin transaction
rollback

update Categories
set CategoryName = 'CategoriaOtra',
	[Description] = 'Esta bien'
	where CategoryID=9


	drop trigger verificar_update_categories
	drop trigger verificar_inserted_categories

create or alter trigger verificar_inserted_deleted
on categories
after insert, update, delete
as
begin
	if exists(select 1 from inserted) and not exists(select 1 from deleted)
	begin
		print ('Existen Datos en la Tabla inserted, se realizo un insert')	
	end

	if exists(select 1 from deleted) and not exists (select 1 from inserted)
	begin
		print ('Existen Datos en la Tabla deleted, se realizo un deleted')	
end
end;

delete Categories
where CategoryName = 'Categoria10'

insert into Categories (CategoryName, [Description])
values ('Categoria10', 'Pinpon')


create or alter trigger verificar_inserted_deleted
on categories
after insert, update, delete
as
begin
	if exists(select 1 from inserted) and not exists(select 1 from deleted)
	begin
		print ('Existen Datos en la Tabla inserted, se realizo un insert')	
	end

	else if exists(select 1 from deleted) and 
	exists (select 1 from inserted)
	begin
		print ('Existen Datos en las dos Tabla, se realizo un update')	
end
end;

update Categories
set CategoryName ='Categoria1123'


/*
Crea un Trigger en la BD pruebaTriggerG3, para la tabla empleados
este trigger debe evitar que e inserten o modifiquen salario mayores
a 50000
*/

use pruebatrigersg3
go
create table empleado(
	id int not null primary key,
	nombre varchar(50) not null,
	salario money not null
)

create or alter trigger verificar_salario
on empleado
after insert, update
as
begin
if exists(select 1 from inserted) and 
not exists(select 1 from deleted)
	begin
		Declare @salarioNuevo money
		set @salarioNuevo = (select salario from inserted)
		if @salarioNuevo > 50000
		begin
		raiserror('El Salario es mayor a 50000 y no esta permitido', 16,1)
		rollback transaction;
	end
end
end
