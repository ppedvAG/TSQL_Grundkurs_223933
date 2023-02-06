USE Northwind;

--Tabellen haben Abh�ngigkeiten zueinander in Form von IDs

--Prim�rschl�ssel (PK -> Primary Key)
----Existiert generell in jeder Tabelle (nicht erzwungen)
----Datens�tze eindeutig identifizieren
----Jeder Datensatz muss einen eindeutigen Schl�ssel haben (keine Duplikate)
----Jeder Datensatz muss einen Schl�ssel haben (nicht NULL)

--Fremdschl�ssel (FK -> Foreign Key)
----Prim�rschl�ssel aus anderer Tabelle -> Referenz
----Kann nur Werte enthalten die auch in der anderen Tabelle vorkommen

SELECT * FROM Orders; --EmployeeID
SELECT * FROM Employees; --Datens�tze kombinieren �ber EmployeeID

SELECT * FROM Orders
INNER JOIN Employees --Hier andere Tabelle angeben
ON Orders.EmployeeID = Employees.EmployeeID; --Hier angeben welche 2 Spalten verbunden werden

SELECT
Employees.EmployeeID, --Ambiguous column name EmployeeID (in Orders und Employees ist eine EmployeeID enthalten)
FirstName + ' ' + LastName AS FullName,
Freight,
ShipName,
ShipAddress
FROM Orders
INNER JOIN Employees
ON Orders.EmployeeID = Employees.EmployeeID; --Sinnvolle Spalten ausw�hlen

SELECT
e.EmployeeID, --Hier ist der Alias erzwingend, da die Spalte in beiden Tabellen vorhanden ist
e.FirstName + ' ' + e.LastName AS FullName,
o.Freight, --Hier ist der Alias optional, da jede Spalte nur in einer Tabelle vorkommt
o.ShipName,
o.ShipAddress
FROM Orders AS o --Tabellenalias: Tabelle einen kurzen Namen geben damit diese einfacher zu verwenden ist
INNER JOIN Employees e --AS nicht notwendig
ON o.EmployeeID = e.EmployeeID;

SELECT * FROM [Order Details] od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID; --Mehr als zwei Tabellen kombinieren

SELECT 
o.OrderID,
od.ProductID,
p.ProductName,
p.QuantityPerUnit,
od.UnitPrice,
od.Quantity,
o.Freight
FROM [Order Details] od
INNER JOIN Orders o ON od.OrderID = o.OrderID
INNER JOIN Products p ON od.ProductID = p.ProductID; --Sinnvolle Spalten ausw�hlen

SELECT * FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID; --830 Datens�tze

SELECT * FROM Orders o
RIGHT JOIN Customers c --Beachtet auch Datens�tze die auf der anderen Seite kein Match haben
ON o.CustomerID = c.CustomerID; --832 Datens�tze

SELECT * FROM Customers c
LEFT JOIN Orders o --RIGHT -> LEFT
ON c.CustomerID = o.CustomerID; --Customer und Order vertauschen damit Customer links sind

SELECT c.* FROM Customers c --c.* um nur Spalten aus Customers zu holen
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL; --Hier schauen welche Kunden noch keine Bestellungen get�tigt haben

SELECT * FROM Customers c
FULL JOIN Orders o --Durch FULL werden beide Seiten erg�nzt (Alle Kunden die keine Bestellungen get�tigt haben und alle Bestellungen die keinen Kunden haben)
ON c.CustomerID = o.CustomerID;

SELECT * FROM Customers CROSS JOIN Orders; --Alle Bestellungen mit allen Kunden kombinieren