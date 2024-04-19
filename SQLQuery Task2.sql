--Joins
-- 1)
select e.FirstName, e.LastName from Employee e 
INNER JOIN Orders o on e.EmployeeID = o.EmployeeID
where o.OrderDate >= '1996-08-15' and o.OrderDate <= '1997-08-15';

-- 2)
select distinct(e.EmployeeID) from Employee e 
INNER JOIN Orders o on e.EmployeeID = o.EmployeeID
where o.OrderDate < '1996-10-16';

--3)
select Count(p.ProductID) as ProductsCount from Products p
Inner JOIN OrderDetails od on p.ProductID = od.ProductID
Inner JOIN orders o on o.OrderID = od.OrderID
where o.OrderDate >= '1997-01-13' and o.OrderDate <= '1997-04-16';

-- 4)
select  Sum(distinct od.Quantity) as TotalQuantity from OrderDetails od 
Inner JOIN Orders o on o.OrderID = od.OrderID
Inner JOIN Employee e on e.EmployeeID = o.EmployeeID 
where e.FirstName like 'Anne' AND e.LastName like 'Dodsworth'
AND o.OrderDate >= '1997-01-13' and o.OrderDate <= '1997-04-16';

-- 5)
select Count(*) as OrdersCount from Orders o 
Inner JOIN Employee e on e.EmployeeID = o.EmployeeID
where e.FirstName like 'Robert' AND e.LastName Like 'King';

-- 6) 
select Count(Distinct(p.ProductID)) as ProductCount from Products p 
Inner JOIN OrderDetails d on d.ProductID = p.ProductID
Inner JOIN Orders o on o.OrderID = d.OrderID
Inner JOIN Employee e on e.EmployeeID = o.EmployeeID
where e.FirstName like 'Robert' AND e.LastName Like 'King'
AND o.OrderDate >='1996-08-15' and o.OrderDate <= '1997-08-15';

-- 7)
select e.EmployeeID, e.FirstName+e.LastName as FullName,e.HomePhone from Employee e
Inner JOIN Orders o on o.EmployeeID = e.EmployeeID
where o.OrderDate >= '1997-01-13' And o.OrderDate <= '1997-04-16';

-- 8)
select Top 1 p.ProductID, p.ProductName, Count(od.ProductID) as NoOfOrders from OrderDetails od
Inner JOIN Products p on od.ProductID = p.ProductID
Group BY p.ProductID, p.ProductName 
Order BY Count(od.ProductID) Desc;

-- 9)
select Top 5 p.ProductID, p.ProductName, Count(od.ProductID) as ProductCount from Products p
Inner JOIN OrderDetails od on od.ProductID = p.ProductID
Group BY p.ProductID, p.ProductName
Order BY Count(od.ProductID) Asc;

-- 10)
select distinct((od.UnitPrice*od.Quantity)-(od.UnitPrice*od.Quantity*od.Discount)) as TotalPrice from OrderDetails od 
Inner JOIN Orders o on o.OrderID = od.OrderID
Inner JOIN Employee e on e.EmployeeID = o.EmployeeID
where e.FirstName like 'Laura' and e.LastName like 'Callahan'
AND o.OrderDate = '1997-01-13';

-- 11)
select Count(distinct(e.EmployeeID)) as EmployeesCount from Employee e
Inner Join Orders o on o.EmployeeID = e.EmployeeID
Inner JOIN OrderDetails od on od.OrderID = o.OrderID
Inner JOIN Products p on p.ProductID = od.ProductID
where p.ProductName IN ('Gorgonzola Telino', 'Gnocchi di nonna Alice', 'Raclette Courdavault', 'Camembert Pierrot')
and o.OrderDate >= '1997-01-01' and o.OrderDate <= '1997-02-01';

-- 12)
select Distinct(e.FirstName + e.LastName) as FullName from Employee e
Inner Join Orders o on o.EmployeeID = e.EmployeeID
Inner JOIN OrderDetails od on od.OrderID = o.OrderID
Inner JOIN Products p on p.ProductID = od.ProductID
where p.ProductName = 'Tofu' and o.OrderDate >= '1997-01-13' and o.OrderDate <= '1997-01-30';

-- 13)
select Distinct e.EmployeeID, e.FirstName + ' ' + e.LastName AS FullName,
DATEDIFF(year, e.BirthDate, GETDATE()) AS AgeYears,
DATEDIFF(month, e.BirthDate, GETDATE()) AS AgeMonths,
DATEDIFF(Day, e.BirthDate, GETDATE()) AS AgeDays FROM Employee e
Inner JOIN Orders o ON e.EmployeeID = o.EmployeeID
where MONTH(o.OrderDate) = 8;

-- 14) 
select sh.CompanyName, Count(*) as NoOfOrders from Orders o
Inner JOIN Shippers sh on sh.ShipperID = o.ShipperID
Group By sh.CompanyName;

-- 15) 
select sh.CompanyName, Count(*) as NoOfProducts from Orders o
Inner JOIN Shippers sh on sh.ShipperID = o.ShipperID
Inner Join OrderDetails od on od.OrderID = o.OrderID
Group By sh.CompanyName;

-- 16) 
select Top 1 o.ShipperID, sh.CompanyName, Count(*) as NoOfOrders from Orders o
Inner JOIN Shippers sh on sh.ShipperID = o.ShipperID
Group By o.ShipperID, sh.CompanyName
Order By Count(*) Desc;

-- 17)
select Top 1 sh.CompanyName, Count(*) as NoOfProducts from Orders o
Inner JOIN Shippers sh on sh.ShipperID = o.ShipperID
Inner JOIN OrderDetails od on od.OrderID = o.OrderID
where o.OrderDate between '1996-07-10' and '1998-08-20'
Group By sh.CompanyName
Order By Count(*) Desc;

-- 18)
select e.EmployeeID, e.FirstName+' '+e.LastName as FullName from Employee e
LEFT JOIN Orders o on o.EmployeeID = e.EmployeeID and o.OrderDate = '1997-04-04'
where o.OrderID IS NULL;

-- 19)
select count(DISTINCT od.ProductID) as NoOfProducts from Orders o
Inner JOIN Employee e on e.EmployeeID = o.EmployeeID
Inner JOin OrderDetails od on od.OrderID = o.OrderID
where e.FirstName = 'Steven' AND e.LastName = 'Buchanan';

-- 20)
select count(Distinct (o.OrderID)) as NoOfOrders from Orders o
Inner Join Employee e on e.EmployeeID = o.EmployeeID
Inner Join Shippers sh on sh.ShipperID = o.ShipperID
where e.FirstName = 'Michael' and e.LastName = 'Suyama'
and sh.CompanyName = 'Federal Shipping';

-- 21)
select Count(od.OrderId) as NoOfOrders from OrderDetails od 
Inner Join Products p on p.ProductID = od.ProductID
Inner Join Suppliers s on s.SupplierID = p.SupplierID
where s.Country IN ('UK', 'Germany');

-- 22)
select Sum((od.UnitPrice * od.Quantity) - (od.UnitPrice* od.Quantity*od.Discount)) as ExoticLiquidsAmt from Suppliers s
Inner JOIN Products p on p.SupplierID = s.SupplierID
Inner JOIN OrderDetails od on od.ProductID = p.ProductID
Inner Join Orders o on o.OrderID = od.OrderID
where s.CompanyName='Exotic Liquids' 
AND o.OrderDate >= '1997-01-01' AND o.OrderDate < '1997-02-01';

-- 23)
select distinct o.OrderDate AS NoOrderDates from Orders o 
where o.OrderDate >= '1997-01-01' AND o.OrderDate <= '1997-01-31'
AND o.OrderDate NOT IN (
select o.OrderDate from Orders o
Inner JOIN OrderDetails od on od.OrderID = o.OrderID
Inner JOIN Products p on p.ProductID = od.ProductID
Inner JOIN Suppliers s on s.SupplierID = p.SupplierID
where s.CompanyName = 'Tokyo Traders');

-- 24)
select distinct e.FirstName+' '+e.LastName as FullName, o.OrderID from Employee e
Inner Join Orders o on o.EmployeeID = e.EmployeeID
where Month(o.OrderDate) = 5
and o.OrderID NOT IN(
select o.OrderID from Orders o
Inner JOIN OrderDetails od on od.OrderID = o.OrderID
Inner JOIN Products p on p.ProductID = od.ProductID
Inner JOIN Suppliers s on s.SupplierID = p.SupplierID
where s.CompanyName = 'Ma Maison');

--25) 
select Top 1 sh.ShipperID, sh.CompanyName, Count(od.ProductID) as NoOfProducts  from Shippers sh
Inner Join Orders o on o.ShipperID = sh.ShipperID
Inner JOin OrderDetails od on od.OrderID = o.OrderID
where o.OrderDate >= '1997-09-01' and o.OrderDate < '1997-11-01'
group By sh.ShipperID,sh.CompanyName
order By Count(*) Asc;

-- 26)
select p.ProductId from Products p
where p.ProductID NOT IN(
select distinct od.ProductID from OrderDetails od
Inner Join Orders o on o.OrderID = od.OrderID
where Month(o.ShippedDate) = 8 and Year(o.ShippedDate) = 1997)
order by p.ProductID Asc;

-- 27) 
select p.ProductID, p.ProductName, e.EmployeeID, e.FirstName+' '+e.LastName as FullName from Products p
Cross Join Employee e 
where NOT Exists(
select * from orders o 
Inner Join OrderDetails od on od.OrderID = o.OrderID
where o.EmployeeID = e.EmployeeID and od.ProductID = p.ProductID);

-- 28)
select top 1 sh.ShipperID, Count(o.OrderID) as OrdersCount from Shippers sh
Inner JOin Orders o on o.ShipperID = sh.ShipperID
where Month(o.OrderDate) in (4,5,6) 
and year(o.OrderDate) in (1996, 1997)
Group by sh.ShipperID
order by Count(o.OrderID) Desc;

--29) 
select top 1 s.Country from Suppliers s 
Inner Join Products p on p.SupplierID = s.SupplierID
Inner Join OrderDetails od on od.ProductID = P.ProductID
Inner JOin Orders o ON o.OrderID = od.OrderID
where year(o.OrderDate)=1997
GROUP BY s.Country
order by Count(p.ProductID) DESC;

--30)
select Avg(DateDiff(day, o.OrderDate, o.ShippedDate)) as AvgNoOfDays from Orders o
where o.ShippedDate IS Not NULL;

--31) 
select Top 1 sh.ShipperID, sh.CompanyName, avg(DateDiff(day, o.OrderDate, o.ShippedDate)) from Shippers sh
Inner JOin Orders o on o.ShipperID = sh.ShipperID
where o.ShippedDate IS NOT NUll
group by sh.ShipperID, sh.CompanyName
order by avg(DateDiff(day, o.OrderDate, o.ShippedDate)) asc;

--32)
select top 1 o.OrderID, e.FirstName+' '+e.LastName as FullName, Count(p.ProductID) as NoOfProducts, 
DateDiff(day, o.OrderDate, o.ShippedDate) as DaysToShip, sh.CompanyName from Orders o
Inner Join Employee e on e.EmployeeID = o.EmployeeID
Inner JOin OrderDetails od on od.OrderID = o.OrderID
Inner JOin Products p on od.ProductID = p.ProductID
Inner Join Shippers sh on sh.ShipperID = o.ShipperID
where ShippedDate is NOT NULL
group by o.OrderID, e.FirstName, e.LastName, p.ProductID,o.OrderDate, o.ShippedDate,sh.CompanyName
order by DateDiff(day, o.OrderDate, o.ShippedDate) desc;

--UNIONS
-- 1)
select * from 
(
	select top 1 o.OrderID, e.FirstName+' '+e.LastName as FullName, Count(p.ProductID) as NoOfProducts, 
	DateDiff(day, o.OrderDate, o.ShippedDate) as DaysToShip, sh.CompanyName, '1' as Result from Orders o
	Inner Join Employee e on e.EmployeeID = o.EmployeeID
	Inner JOin OrderDetails od on od.OrderID = o.OrderID
	Inner JOin Products p on od.ProductID = p.ProductID
	Inner Join Shippers sh on sh.ShipperID = o.ShipperID
	where ShippedDate is NOT NULL
	group by o.OrderID,e.FirstName, e.LastName,sh.CompanyName,o.OrderDate,o.ShippedDate
	order by DaysToShip asc
	Union All
	select top 1 o.OrderID, e.FirstName+' '+e.LastName as FullName, Count(p.ProductID) as NoOfProducts, 
	DateDiff(day, o.OrderDate, o.ShippedDate) as DaysToShip, sh.CompanyName, '2' as Result from Orders o
	Inner Join Employee e on e.EmployeeID = o.EmployeeID
	Inner JOin OrderDetails od on od.OrderID = o.OrderID
	Inner JOin Products p on od.ProductID = p.ProductID
	Inner Join Shippers sh on sh.ShipperID = o.ShipperID
	where ShippedDate is NOT NULL
	group by o.OrderID,e.FirstName, e.LastName,sh.CompanyName,o.OrderDate,o.ShippedDate
	order by DaysToShip desc
) as output;

-- 2)
select * from 
(
	select top 1 p.ProductID, p.ProductName, p.UnitPrice,'1' as Result from Products p
	Inner JOin OrderDetails od on od.ProductID = p.ProductID
	Inner Join Orders o on o.OrderID = od.OrderID
	where year(o.OrderDate) = 1997 and month(o.OrderDate) = 10 and day(o.OrderDate) between 8 and 14
	group by p.ProductID, p.ProductName, p.UnitPrice
	order by p.UnitPrice asc
	UNION 
	select top 1 p.ProductID, p.ProductName, p.UnitPrice, '2' as Result from Products p
	Inner JOin OrderDetails od on od.ProductID = p.ProductID
	Inner Join Orders o on o.OrderID = od.OrderID
	where year(o.OrderDate) = 1997 and month(o.OrderDate) = 10 and day(o.OrderDate) between 8 and 14
	group by p.ProductID, p.ProductName, p.UnitPrice
	order by p.UnitPrice desc
) as output;

--CASE
-- 1)
select distinct sh.ShipperID, e.EmployeeID,
case
	when sh.ShipperID = 1 then 'Shipping Federal'
	when sh.ShipperID = 2 then 'Express Speedy'
	when sh.ShipperID = 3 then 'United Package'
	else sh.CompanyName
end as ShipperName
from Shippers sh
Inner Join Orders o on o.ShipperID = sh.ShipperID
Inner JOin Employee e on e.EmployeeID = o.EmployeeID
where e.EmployeeID in (1,3,5,7);
