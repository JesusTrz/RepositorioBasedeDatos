/*Realiza un SP que permita visualizar lo vendido a los clientes
mostrando el nombre del cliente y el año variable*/

SELECT*FROM customers
SELECT*FROM Orders
SELECT*FROM Products
SELECT*FROM [Order Details]

CREATE PROCEDURE sp_ventas_por_cliente_y_anio
    @anio INT
AS
BEGIN
    SELECT 
        c.ContactName,
        YEAR(o.OrderDate) AS anio,
        --SUM(o.monto) AS total_ventas
    FROM customers as c
    INNER JOIN 
        orders as o 
        ON c.EmployyeID = o.EmployyeID
    WHERE 
        YEAR(o.OrderDate) = @anio
    GROUP BY 
        c.ContactName, YEAR(o.OrderDate)
    ORDER BY 
        c.ContactName;
END;

