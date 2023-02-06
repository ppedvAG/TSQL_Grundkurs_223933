USE Northwind; --Datenbank ausw�hlen

/*
Mehrzeilige
Kommentare
*/

--SELECT: Spalten ausw�hlen die geholt werden sollen

SELECT 100; --Einzelnen Wert ausgeben

SELECT 10.5; --Kommazahl mit Punkt statt Komma

SELECT 'Test'; --Text mit ''

--Strg + E: Markiertes Statement ausf�hren
--Strg + R: Ergebnisansicht schlie�en

SELECT 100 * 3; --Berechnungen mit +/-/*/:/%

SELECT '100 * 3'; --Wird als Text interpretiert (und nicht berechnet)

SELECT 100 AS Zahl; --Mit AS einer Spalte einen Namen geben

SELECT 100 AS Zahl1, 200 AS Zahl2, 'Text' AS Text; --Mehrere Spalten ausw�hlen mit Komma getrennt

--FROM: Tabelle ausw�hlen aus der die Daten geholt werden

SELECT * FROM Customers; --*: Alle Spalten und Datens�tze

SELECT CompanyName FROM Customers; --Bestimmte Spalten ausw�hlen

SELECT CompanyName, ContactName FROM Customers; --Mehrere Spalten ausw�hlen

SELECT Freight * 5 FROM Orders; --Berechnungen auf Spalten durchf�hren

SELECT Freight % 5 FROM Orders; --Modulo (%): Gibt den Rest einer Division zur�ck

SELECT Address + City + PostalCode + Country FROM Customers; --Strings (Texte) verbinden (unsch�n)

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country FROM Customers; --Strings verbinden mit Abst�nden

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse] FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS "Volle Adresse" FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS 'Volle Adresse' FROM Customers;
--Namen mit Abst�nden m�ssen mit [] oder "" oder '' angegeben werden

--Umbr�che beliebig m�glich
SELECT --SELECT kann mehrere Zeilen beanspruchen
CompanyName,
ContactName,
Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse]
FROM Customers; --FROM sollte in einer Zeile sein