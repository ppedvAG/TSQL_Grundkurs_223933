USE Northwind;

SELECT COUNT(*) FROM Customers; --Anzahl der Datens�tze

SELECT COUNT(*) FROM Customers WHERE Country = 'UK'; --Anzahl Customer aus UK (7)

SELECT COUNT(DISTINCT Country) FROM Customers; --Anzahl einzigartiger (verschiedener) L�nder (22)

SELECT 
AVG(Freight) AS Durchschnittskosten,
SUM(Freight) AS Gesamtkosten,
MIN(Freight) AS BilligsteBestellung,
MAX(Freight) AS TeuersteBestellung
--Freight --nicht m�glich, da mehr als ein Ergebnis herauskommt
FROM Orders;

--------------------------------------------------------------------------------

SELECT * FROM Orders GROUP BY EmployeeID; --1er Gruppe (10258, 10270, 10275, ...), 2er Gruppe (11073, 11070, 11060, ...)

SELECT EmployeeID, --Spalten im GROUP BY k�nnen im SELECT verwenden werden
COUNT(*) AS AnzBestellungen, --Aggregatsfunktionen beziehen sich auf die einzelnen Gruppen
AVG(Freight) AS Durchschnittskosten,
SUM(Freight) AS Gesamtkosten,
MIN(Freight) AS BilligsteBestellung,
MAX(Freight) AS TeuersteBestellung
FROM Orders
GROUP BY EmployeeID;

--Wie viele Kunden haben wir pro Land?
SELECT Country,
COUNT(*) AS AnzKunden
FROM Customers
GROUP BY Country --L�ndergruppen (UK, USA, Spain, ...)
ORDER BY AnzKunden DESC; --Sortierung m�glich nach Alias
--ORDER BY COUNT(*) DESC; --Sortierung m�glich nach Aggregatsfunktion

SELECT Country, City,
COUNT(*) AS AnzKunden
FROM Customers
GROUP BY Country, City --L�nder + St�dtegruppen
ORDER BY AnzKunden DESC;

SELECT CustomerID, CompanyName,
COUNT(*) AS AnzKunden
FROM Customers
GROUP BY CustomerID, CompanyName;
--Wenn nach einem Schl�ssel gruppiert wird (Spalte mit nur eindeutigen Werten) k�nnen weitere Spalten kostenlos hinzugef�gt werden

--------------------------------------------------------------------------------

--WHERE vs. GROUP BY + HAVING
--WHERE filtert die Daten bevor sie gruppiert werden
--HAVING filtert die Gruppen (die Daten nach WHERE werden hier verwendet)

SELECT CustomerID,
COUNT(*) AS AnzKunden
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10; --Finde alle Kunden mit mindestens 10 Bestellungen

SELECT CustomerID,
COUNT(*) AS AnzKunden
FROM Orders
WHERE Freight >= 100 --Schr�nkt die Menge an Daten ein die bei GROUP BY verwendet wird
GROUP BY CustomerID
HAVING COUNT(*) > 10;

SELECT CustomerID,
COUNT(*) AS AnzKunden
FROM Orders
GROUP BY CustomerID
HAVING AVG(Freight) > 100; --Alle Aggregatsfunktionen hier unten m�glich, auch wenn sie nicht oben verwendet werden

SELECT 
o.CustomerID,
c.CompanyName,
COUNT(*) AS Anz
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
GROUP BY o.CustomerID, c.CompanyName
ORDER BY Anz DESC;
--Wenn nach einem Schl�ssel gruppiert wird (Spalte mit nur eindeutigen Werten) k�nnen weitere Spalten kostenlos hinzugef�gt werden

SELECT OrderID,
SUM(UnitPrice * Quantity) --Berechnungen hier m�glich
FROM [Order Details]
GROUP BY OrderID; --Gesamtpreise pro Rechnung