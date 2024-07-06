-- CASE se puede utilizar en cualquier instrucción o
-- cláusula que permite una expresión válida.
-- Por ejemplo, puede utilizar CASE en instrucciones como
---SELECT, UPDATE, DELETE y SET,
--  y en cláusulas como <select_list>, IN, WHERE, ORDER BY y HAVING.


-- Sintaxis

-- Simple CASE expression:
-- CASE input_expression
--      WHEN when_expression THEN result_expression [ ...n ]
--      [ ELSE else_result_expression ]
-- END

-- -- Searched CASE expression:
-- CASE
--      WHEN Boolean_expression THEN result_expression [ ...n ]
--      [ ELSE else_result_expression ]
-- END


-- A. Uso de una instrucción SELECT con una expresión CASE sencilla

-- En una instrucción SELECT, una expresión CASE sencilla solo permite una
-- comprobación de igualdad; no se pueden hacer otras comparaciones.
-- En este ejemplo se utiliza la expresión CASE para cambiar la presentación de categorías
-- de línea de productos con el fin de hacerla más comprensible.

--CASE

use AdventureWorks2019

select*from Production.Product;



select ProductNumber,[name], ProductLine,
    CASE ProductLine
    WHEN 'R' THEN 'Road'
    WHEN 'M' THEN 'Mountain'
    WHEN 'T' THEN 'Touring'
    WHEN 'S' THEN 'Other sale items'
    ELSE 'Not for sale'
    END as [Category]
from Production.Product
where ProductLine in ('R', 'M');


create view v_reporte_producto
as
select ProductNumber,[name], ProductLine,
    CASE ProductLine
    WHEN 'R' THEN 'Road'
    WHEN 'M' THEN 'Mountain'
    WHEN 'T' THEN 'Touring'
    WHEN 'S' THEN 'Other sale items'
    ELSE 'Not for sale'
    END as [Category]
from Production.Product;

select*from v_reporte_producto

create view v_reporte_producto
as
select ProductNumber,[name], ProductLine,
    [Category]=CASE ProductLine
    WHEN 'R' THEN 'Road'
    WHEN 'M' THEN 'Mountain'
    WHEN 'T' THEN 'Touring'
    WHEN 'S' THEN 'Other sale items'
    ELSE 'Not for sale'
    END as
from Production.Product;

select ProductNumber as 'NumeroProducto', 
[name] as 'Nombre Producto',
[Category]=CASE ProductLine
    WHEN 'R' THEN 'Road'
    WHEN 'M' THEN 'Mountain'
    WHEN 'T' THEN 'Touring'
    WHEN 'S' THEN 'Other sale items'
    ELSE 'Not for sale'
    END, ListPrice as 'Precio',
    CASE 
        WHEN ListPrice=0.0 THEN 'Mfg item - not for resale'
        WHEN ListPrice < 50.0 THEN 'Under $50'
        WHEN ListPrice >=50.0 AND ListPrice <250.0 THEN 'Under $250'
        WHEN ListPrice >=250.0 AND ListPrice <1000 THEN 'Under $1000'
        ELSE 'Over $1000'
        END AS [PrieceRange]
from
Production.Product;

--ISNULL (Funcion)

select v.AccountNumber,v.Name,
ISNULL(.PurchasingWebServiceURL, 'NO URL') as 'Sitio Web'
FROM
[Purchasing].[Vendor] as v

--IIF

SELECT IIF(1=1, 'VERDADERO', 'FALSO') AS 'RESULTADO'
GO
SELECT IIF(LEN('SQL SERVER')=10, 'OK', 'NO OK') AS 'RESULTADO'

SELECT e.LoginID, e.JobTitle, e.Gender, IIF(e.Gender = 'M', 'HOMBRE', 'MUJER') as 'Genero'
FROM HumanResources.Employee As e


select OBJECT_ID(N'tempdb..#StudentsC1')

IF OBJECT_ID (N'tempdb..#StudentsC1') is not NULL
begin
    drop table #StudentsC1;
end

CREATE TABLE #StudentsC1(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);

INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(3,'Rogelio Rojas',0)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(4,'Mariana Rosas',1)
INSERT INTO #StudentsC1(StudentID, StudentName, StudentStatus) VALUES(5,'Roman Zavaleta',1)

select*from #StudentsC1

IF OBJECT_ID(N'tempdb..#StudentsC2') is not NULL
begin
drop table #StudentsC2
END


CREATE TABLE #StudentsC2(
    StudentID       INT
    ,StudentName    VARCHAR(50)
    ,StudentStatus  BIT
);


INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(1,'Axel Romero Rendón',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(2,'Sofía Mora Ríos',0)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(6,'Mario Gonzalez Pae',1)
INSERT INTO #StudentsC2(StudentID, StudentName, StudentStatus) VALUES(7,'Alberto García Morales',1)

select*from #StudentsC1
select*from #StudentsC2

insert into #StudentsC2
select s1.StudentID, s1.StudentName, s1.StudentStatus
from #StudentsC1 as s1
LEFT JOIN #StudentsC2 as s2
ON s1.StudentID=s2.StudentID
WHERE s2.StudentID is NULL

select COUNT(*) from #StudentsC2

select*from 
#StudentsC1 as s1
INNER JOIN 
#StudentsC2 as s2
on s1.StudentID = s2.StudentID

update s2
set 
s2.StudentName = s1.StudentName,
s2.StudentStatus = s1.StudentStatus
from
#StudentsC1 as s1
INNER JOIN 
#StudentsC2 as s2
on s1.StudentID = s2.StudentID