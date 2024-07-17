use Northwind

--Ejercico 1;
--Realizar una venta dentro de la base de datos 
--Northwind utilizanso transacciones y store procedures
Create or alter proc sp_Nueva_Venta

   @CustomerID nchar(5),
   @EmployeeID int,
   @OrderDate datetime,
   @RequiredDate datetime,
   @ShippedDate datetime,
   @ShipVia int,
   @Freight money =null,
   @ShipName nvarchar(40) = null,
   @ShipAddress nvarchar(60) =null,
   @ShipCity nvarchar(15)=null,
   @ShipRegion nvarchar(15 )= null,
   @ShipPostalCode nvarchar (15 )=null,
   @ShipCountry nvarchar(15)= null,
      @ProductID int,
      @UnitPrice money,
      @Quantity smallint,
      @Discount real
   as 
   begin
   
   begin transaction
       begin try
   --insertar tabla order
  INSERT INTO [dbo].[Orders]
  ([CustomerID]
           ,[EmployeeID]
           ,[OrderDate]
           ,[RequiredDate]
           ,[ShippedDate]
           ,[ShipVia]
           ,[Freight]
           ,[ShipName]
           ,[ShipAddress]
           ,[ShipCity]
           ,[ShipRegion]
           ,[ShipPostalCode]
           ,[ShipCountry])
     VALUES
           (@CustomerID, 
           @EmployeeID, 
           @OrderDate,
           @RequiredDate, 
           @ShippedDate, 
           @ShipVia,
           @Freight, 
           @ShipName, 
           @ShipAddress, 
           @ShipCity, 
           @ShipRegion, 
           @ShipPostalCode, 
           @ShipCountry);
		   --Obtener el id insertando de la orden
		   Declare @orderid int
		   set @orderid=SCOPE_IDENTITY();
	
	--insertar detalle de  orden el producto
	--Obtener el precio del producto a insertar 
	declare @precioVenta money

	select * from Orders
	--set @precioVenta(select UnitPrice from Products  where ProductID=3)
	Select  @precioVenta=UnitPrice from Products  where ProductID=@ProductID

	end try

	begin catch

	end catch
   end;
   go

   -- Insertar en la tabla OrderDetails
   
   insert into [dbo].[Order Details]
      ([OrderID]
      ,[ProductID]
      ,[UnitPrice]
      ,[Quantity]
      ,[Discount])
Values
	(
	@OrderID,
    @ProductID,
    @UnitPrice,
    @precioventa, 
    @Discount);

	--Actualizar la tabla productos el campo unitsinstock con la cantidad vendida+
	update Products
	set UnitsInStock = UnitsInStock = @Quantity
	where ProductID = @ProductID;

	end try
	begin catch
		declare @mensajeerror varchar (400)
		set @mensajeerror = ERROR_MESSAGE()
		print @mensajeerror
	end catch
	end;