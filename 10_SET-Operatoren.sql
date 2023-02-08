USE Northwind;

SELECT 'Test1', 'Test2'; --Zwei Spalten

SELECT 'Test1'
UNION --Ergebnisse von beiden SELECTs kombinieren
SELECT 'Test2';

--UNION
--Beide SELECTs müssen die selben Spalten ausgeben + die selben Typen haben
--Filtert Duplikate (Performance)

--Wir wollen alle Adressen aus der Datenbank haben
SELECT * FROM Customers;
SELECT * FROM Suppliers;

SELECT Address FROM Customers
UNION
SELECT Address FROM Suppliers; --Alle Adressen in einem Ergebnis

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Customers
UNION
SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Suppliers; --Alle langen Adressen

SELECT CompanyName FROM Customers
UNION
SELECT CompanyName FROM Suppliers; --Alle Firmennamen

SELECT CompanyName, ContactName FROM Customers
UNION
SELECT CompanyName FROM Suppliers; --Unterschiedlich viele Spalten sind nicht möglich

SELECT CompanyName, ContactName FROM Customers
UNION
SELECT CompanyName, NULL FROM Suppliers; --Spalten ergänzen durch einen leeren Wert (NULL, '', 0, ...)

SELECT CustomerID FROM Customers
UNION
SELECT SupplierID FROM Suppliers; --Unterschiedliche Datentypen sind auch nicht kompatibel

SELECT CustomerID FROM Customers
UNION
SELECT CAST(SupplierID AS NVARCHAR) FROM Suppliers; --Einzelnen Typen zu einem anderen Typen konvertieren

SELECT Address, City, PostalCode, Country FROM Customers
UNION
SELECT Address, City, PostalCode, Country FROM Customers; --Sinnvolle Spalten auswählen

SELECT Phone FROM Customers
UNION
SELECT Phone FROM Suppliers
UNION
SELECT HomePhone FROM Employees; --Alle Telefonnummern in der Datenbank

SELECT Phone AS P1 FROM Customers --AS bei UNION: Das AS beim ersten SELECT wird akzeptiert, der Rest wird verworfen
UNION
SELECT Phone AS P2 FROM Suppliers --P2 wird verworfen
UNION
SELECT HomePhone AS P3 FROM Employees; --P3 wird verworfen

--INTERSECT: Gibt alle Datensätze aus die in beiden Tabellen enthalten sind

SELECT Country FROM Customers
INTERSECT --Finde alle Länder in denen wir Kunden und Lieferanten haben
SELECT Country FROM Suppliers;

--EXCEPT: Gibt alle Datensätze aus die in der ersten Tabelle enthalten sind aber nicht in der zweiten Tabelle

SELECT Country FROM Customers
EXCEPT --Finde alle Länder in denen wir Kunden aber keine Lieferanten haben
SELECT Country FROM Suppliers;

SELECT Country FROM Customers
INTERSECT --Finde alle Länder in denen wir Kunden und Lieferanten haben
SELECT Country FROM Suppliers
EXCEPT --Außer Länder in denen Mitarbeiter arbeiten
SELECT Country FROM Employees; --Alle Länder mit Kunden und Lieferanten aber ohne Mitarbeiter

--Umsatztabellen erstellen

CREATE TABLE Umsatz2021
(
	datum date,
	umsatz float
);

--Umsatztabellen befüllen

DECLARE @i int = 0
WHILE @i < 20000
BEGIN
	INSERT INTO Umsatz2021 VALUES
	(DATEADD(DAY, RAND()*365, '20210101'), RAND()*1000);
	SET @i += 1;
END

SET STATISTICS time, io OFF; --Performancemessung einschalten

SELECT * FROM Umsatz2019
UNION
SELECT * FROM Umsatz2020
UNION
SELECT * FROM Umsatz2021
--CPU: 94ms, Gesamtzeit: 406ms

--UNION ALL: Selbiges wie UNION, nur ohne Duplikate filtern

SELECT * FROM Umsatz2019
UNION ALL
SELECT * FROM Umsatz2020
UNION ALL
SELECT * FROM Umsatz2021
--CPU: 0ms, Gesamtzeit: 256ms (keine Duplikate filtern -> kein CPU Aufwand)

GO

CREATE VIEW v_UmsatzGesamt
AS
	SELECT * FROM Umsatz2019
	UNION ALL
	SELECT * FROM Umsatz2020
	UNION ALL
	SELECT * FROM Umsatz2021
GO

--Auf Gesamtumsatz zugreifen und damit alle Tabellen abdecken
SELECT * FROM v_UmsatzGesamt ORDER BY Umsatz DESC;
SELECT * FROM v_UmsatzGesamt WHERE Umsatz > 900;

SELECT
YEAR(datum) AS Jahr,
SUM(umsatz) AS [Summe Jahresumsatz]
FROM v_UmsatzGesamt
GROUP BY YEAR(datum)
ORDER BY Jahr;