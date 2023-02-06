USE Northwind;

--Tabellen haben Abhängigkeiten zueinander in Form von IDs

--Primärschlüssel (PK -> Primary Key)
----Existiert generell in jeder Tabelle (nicht erzwungen)
----Datensätze eindeutig identifizieren
----Jeder Datensatz muss einen eindeutigen Schlüssel haben (keine Duplikate)
----Jeder Datensatz muss einen Schlüssel haben (nicht NULL)

--Fremdschlüssel (FK -> Foreign Key)
----Primärschlüssel aus anderer Tabelle -> Referenz
----Kann nur Werte enthalten die auch in der anderen Tabelle vorkommen

SELECT * FROM Orders; --EmployeeID
SELECT * FROM Employees; --Datensätze kombinieren über EmployeeID

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
ON Orders.EmployeeID = Employees.EmployeeID; --Sinnvolle Spalten auswählen

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
INNER JOIN Products p ON od.ProductID = p.ProductID; --Sinnvolle Spalten auswählen

SELECT * FROM Orders o
INNER JOIN Customers c
ON o.CustomerID = c.CustomerID; --830 Datensätze

SELECT * FROM Orders o
RIGHT JOIN Customers c --Beachtet auch Datensätze die auf der anderen Seite kein Match haben
ON o.CustomerID = c.CustomerID; --832 Datensätze

SELECT * FROM Customers c
LEFT JOIN Orders o --RIGHT -> LEFT
ON c.CustomerID = o.CustomerID; --Customer und Order vertauschen damit Customer links sind

SELECT c.* FROM Customers c --c.* um nur Spalten aus Customers zu holen
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL; --Hier schauen welche Kunden noch keine Bestellungen getätigt haben

SELECT * FROM Customers c
FULL JOIN Orders o --Durch FULL werden beide Seiten ergänzt (Alle Kunden die keine Bestellungen getätigt haben und alle Bestellungen die keinen Kunden haben)
ON c.CustomerID = o.CustomerID;

SELECT * FROM Customers CROSS JOIN Orders; --Alle Bestellungen mit allen Kunden kombinieren