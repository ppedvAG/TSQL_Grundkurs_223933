USE Northwind; --Datenbank auswählen

/*
Mehrzeilige
Kommentare
*/

--SELECT: Spalten auswählen die geholt werden sollen

SELECT 100; --Einzelnen Wert ausgeben

SELECT 10.5; --Kommazahl mit Punkt statt Komma

SELECT 'Test'; --Text mit ''

--Strg + E: Markiertes Statement ausführen
--Strg + R: Ergebnisansicht schließen

SELECT 100 * 3; --Berechnungen mit +/-/*/:/%

SELECT '100 * 3'; --Wird als Text interpretiert (und nicht berechnet)

SELECT 100 AS Zahl; --Mit AS einer Spalte einen Namen geben

SELECT 100 AS Zahl1, 200 AS Zahl2, 'Text' AS Text; --Mehrere Spalten auswählen mit Komma getrennt

--FROM: Tabelle auswählen aus der die Daten geholt werden

SELECT * FROM Customers; --*: Alle Spalten und Datensätze

SELECT CompanyName FROM Customers; --Bestimmte Spalten auswählen

SELECT CompanyName, ContactName FROM Customers; --Mehrere Spalten auswählen

SELECT Freight * 5 FROM Orders; --Berechnungen auf Spalten durchführen

SELECT Freight % 5 FROM Orders; --Modulo (%): Gibt den Rest einer Division zurück

SELECT Address + City + PostalCode + Country FROM Customers; --Strings (Texte) verbinden (unschön)

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country FROM Customers; --Strings verbinden mit Abständen

SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse] FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS "Volle Adresse" FROM Customers;
SELECT Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS 'Volle Adresse' FROM Customers;
--Namen mit Abständen müssen mit [] oder "" oder '' angegeben werden

--Umbrüche beliebig möglich
SELECT --SELECT kann mehrere Zeilen beanspruchen
CompanyName,
ContactName,
Address + ' ' + City + ' ' + PostalCode + ', ' + Country AS [Volle Adresse]
FROM Customers; --FROM sollte in einer Zeile sein