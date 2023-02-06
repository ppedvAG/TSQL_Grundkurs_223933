USE Northwind;

-- WHERE: Ausgabe filtern nach Bedingungen
-- Operatoren:
-- <, >, <=, >= kleiner, größer, kleiner-gleich, größer-gleich
-- =, !=, <> gleich, ungleich, ungleich
-- BETWEEN, IN, LIKE: BETWEEN: Zwischen X und Y, IN: innerhalb einer Liste
-- AND, OR: Bedingungen verknüpfen, AND: Beide Bedingungen müssen Wahr sein, OR: Mindestens eine Bedingung muss Wahr sein
-- NOT: Bedingungen invertieren

SELECT * FROM Orders WHERE Freight > 50; --Bestellungen mit Freight mindestens 50

SELECT * FROM Orders WHERE Freight < 50; --Bestellungen mit Frachtkosten weniger als 50

SELECT * FROM Orders WHERE EmployeeID = 1; --Alle Bestellungen vom Employee 1 finden

SELECT * FROM Orders WHERE EmployeeID = 1 AND Freight > 50; --Alle Bestellungen vom Employee 1 die mindestens 50 Frachtkosten hatten

SELECT * FROM Orders WHERE EmployeeID = 1 OR Freight < 10; --Alle Bestellungen die von Employee 1 verarbeitet wurden oder unter 10 Frachtkosten haben

--BETWEEN

SELECT * FROM Orders WHERE Freight BETWEEN 10 AND 20; --Alle Bestellungen mit Frachtkosten zwischen 10 und 20

SELECT * FROM Orders WHERE EmployeeID BETWEEN 1 AND 3; --Grenzen sind bei BETWEEN inkludiert

SELECT * FROM Orders WHERE OrderDate BETWEEN '19970101' AND '19970303'; --Hier korrekte Ordnung der Datumsformatierung beachten

SELECT * FROM Orders WHERE OrderDate BETWEEN '1997-01-01' AND '1997-31-03'; --Amerikanisches Datum

--Funktionen

SELECT * FROM Orders WHERE YEAR(OrderDate) = 1997; --Funktionen im WHERE verwenden

SELECT * FROM Orders WHERE MONTH(OrderDate) = 10; --Bestellungen im Oktober finden

--IN

SELECT * FROM Customers WHERE Country = 'Spain' OR Country = 'UK' OR Country = 'USA'; --Lang und unübersichtlich

SELECT * FROM Customers WHERE Country IN('Spain', 'UK', 'USA'); --Selbiges wie oben nur mit IN

SELECT * FROM Orders WHERE EmployeeID IN(1, 2, 5, 8); --Numerische Werte sind bei IN auch möglich

SELECT * FROM Orders WHERE YEAR(OrderDate) IN(1997, 1998); --IN mit Funktion

SELECT * FROM Orders WHERE ShipCountry = 'UK' AND (YEAR(OrderDate) = 1997 OR YEAR(OrderDate) = 1998);

--NULL

SELECT * FROM Customers WHERE Fax = NULL; --NULL Vergleiche funktionieren nicht mit = und !=

SELECT * FROM Customers WHERE Fax IS NULL; --IS NULL/IS NOT NULL um zu schauen welche Datensätze leer sind

SELECT * FROM Customers WHERE Fax IS NOT NULL;

--NOT

SELECT * FROM Orders WHERE Freight NOT BETWEEN 10 AND 20; --Mit NOT BETWEEN invertieren

SELECT * FROM Orders WHERE EmployeeID NOT IN(1, 2, 5, 8);