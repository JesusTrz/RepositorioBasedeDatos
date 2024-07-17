--Store Procedures que visualice los resultados de cualquier tabla
--select*from[Tabla]
use Northwind

GO

create or alter proc spu_mostrar_datos
@tabla varchar(50)
as
begin
	declare @query nvarchar (50)
	set @query = 'Select * from ' + QUOTENAME (@tabla);
	exec (@query);

	--sp_executesql

	exec sp_executesql @query;
end;

GO

exec spu_mostrar_datos 'products';