USE Northwind;

--Alle Bestellungen finden die überdurchschnittlich hohe Frachtkosten
SELECT * FROM Orders WHERE Freight > AVG(Freight);

--Mit Unterabfrage
SELECT * FROM Orders WHERE Freight > (SELECT AVG(Freight) FROM Orders) ORDER BY Freight; --Aggregatsfunktionen geben immer genau einen Wert zurück

SELECT * FROM Orders WHERE Freight > (SELECT TOP 1 Freight FROM Orders); --Mit TOP 1 genau einen Wert holen

SELECT * FROM Orders WHERE Freight >= (SELECT Freight FROM Orders WHERE Freight > 1000); --Zufälligerweise kommt hier nur ein Wert heraus (DB schaut wie viele Werte hier heraus kommen)

--Mit Variable
DECLARE @avg float = 0; --Mit DECLARE eine Variable anlegen
SET @avg = (SELECT AVG(Freight) FROM Orders); --Mit SET einer Variable einen Wert zuweisen
SELECT * FROM Orders WHERE Freight > @avg;

--Subselect im IN
SELECT * FROM Customers --Finde alle Kunden die in einem Land wohnen in dem auch ein Employee wohnt)
WHERE Country IN(SELECT DISTINCT Country FROM Employees); --Alle Ergebnisse von der Unterabfrage werden in das IN gegeben

--Subselect im SELECT
SELECT Freight, (SELECT AVG(Freight) FROM Orders) AS Average
FROM Orders ORDER BY Freight;

--Subselect im FROM
SELECT *
FROM
(
	SELECT 
	o.EmployeeID,
	o.Freight,
	e.FirstName + ' ' + e.LastName AS FullName --Jede Spalte muss einen Namen haben
	FROM Orders o
	INNER JOIN Employees e ON o.EmployeeID = e.EmployeeID
) AS Ergebnis --Unterabfrage muss einen Namen haben
WHERE Ergebnis.Freight > 50 --Korrelierte Abfrage
ORDER BY Ergebnis.EmployeeID; --Mit Ergebnis.<Spalte> in die Unterabfrage hereingreifen

--EXISTS: Gibt wahr/falsch zurück wenn die Unterabfrage ein/kein Ergebnis hat
SELECT * FROM Customers
WHERE EXISTS (SELECT * FROM Customers WHERE Country LIKE 'X%'); --Unterabfrage hat kein Ergebnis

SELECT * FROM Customers
WHERE NOT EXISTS (SELECT * FROM Customers WHERE Country LIKE 'X%'); --Ergebnis wird invertiert (falsch -> wahr)