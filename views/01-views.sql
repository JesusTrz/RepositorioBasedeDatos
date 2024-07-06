use Northwind
SELECT c.CategoryName as 'Nombre Categoria',
p.ProductName as 'Nombre Producto',
p.UnitPrice as 'Precio',
p.UnitsInStock as 'Existencias'
from 
Northwind.dbo.Categories AS c
inner join Northwind.dbo.Products as PARTIALon c.CategoryID = p.CategoryID