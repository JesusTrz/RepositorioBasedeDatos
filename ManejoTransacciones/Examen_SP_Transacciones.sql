use Northwind


/*
Actuzalizar lo precios de los productos y guardarlos en una tabla de históricos
Id	IdProductoModificado	PrecioAnterior	PrecioNuevo	FechadeModificacion

*/
go

select * from Products
select*from Orders
select*from [Order Details]

GO 
--------------------------------------------------------------------------------------------------------
create or alter proc spu_Elimina_Venta
    @OrderID INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Consultar los detalles del pedido
    SELECT * FROM [Order Details] WHERE OrderID = @OrderID;

    -- Actualizar stock de productos
    UPDATE Products
    SET UnitsInStock = UnitsInStock + od.Quantity
    FROM [Order Details] od
    WHERE od.OrderID = @OrderID AND od.ProductID = Products.ProductID;

    -- Eliminar detalles del pedido
    DELETE FROM [Order Details]
    WHERE OrderID = @OrderID;

    -- Eliminar el pedido
    DELETE FROM Orders
    WHERE OrderID = @OrderID;
END

exec spu_Elimina_Venta @OrderID = '10251';