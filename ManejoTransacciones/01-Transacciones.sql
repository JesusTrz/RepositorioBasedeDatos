--Las transacciones son fundamentales para asegurar la consistencia y la integridad de los datos
--Transaccion:Una unidad de trabajo que se ecuta de manera completamente exitosa o no se ejecuta en lo absoluto
--Beggin Transaccion: Inicia una nueva Transaccion
-- Commit Transaccion: Confirma los cambios realizados durante la transaccion
use Northwind

select*from Categories

begin transaction

insert into Categories (CategoryName, Description)
values ('Categoria11','Los Remediales')

commit transaction --Confirmar Transaccion

rollback transaction --Cancelar Transaccion