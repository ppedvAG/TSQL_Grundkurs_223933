USE Northwind;

--CREATE TABLE <Name> (<Spalte1> <Typ1>, <Spalte2> <Typ2>, ...)

CREATE TABLE Test
(
	--primary key: Prim�rschl�ssel, eindeutige Spalte, kann nicht null sein, h�ufig IDs, mehrere Prim�rschl�ssel (kombinierter Schl�ssel)
	--identity: Erh�ht und bef�llt die Spalte automatisch um 1 (gut f�r IDs)
	--identity(<Startwert>, <Inkrement>)
	ID int identity primary key,
	Vorname varchar(20) NULL,
	Nachname varchar(20) NOT NULL --Feld kann nicht NULL sein
);

-----------------------------------------------------------------------

--INSERT INTO <Tabelle> VALUES (<Wert1>, <Wert2>, ...), (<Wert1>, <Wert2>, ...), ...;
INSERT INTO Test VALUES
('Max', 'Muster');

--Mehrere Datens�tze gleichzeitig einf�gen
INSERT INTO Test VALUES
('Max', 'Muster'),
('Test', 'Test');

--Nur bestimmte Spalten in die Tabelle schreiben statt jeden Wert
INSERT INTO Customers (CustomerID, CompanyName, Country) VALUES
('PPEDV', 'ppedv AG', 'DE');

--Ergebnis einer Prozedur direkt in eine Tabelle schreiben
CREATE PROC p_Test
AS
	SELECT FirstName, LastName FROM Employees;
GO

INSERT INTO Test
EXEC p_Test;

--SELECT INTO: Ergebnis einer Abfrage in eine NEUE Tabelle schreiben
SELECT FirstName, LastName
INTO Test
FROM Employees;

--INSERT INTO SELECT: Selbiges wie SELECT INTO nur funktioniert auf bestehende Tabellen statt nur auf neue Tabellen
INSERT INTO Test
SELECT FirstName, LastName FROM Employees;

-----------------------------------------------------------------------

--UPDATE <Name> SET <Spalte> = <Neuer Wert> WHERE <Bedingung>
UPDATE Test SET Nachname = 'Test';

--Bei UPDATE unbedingt WHERE verwenden um nicht alle Daten zu �berschreiben
UPDATE Test
SET Nachname = Nachname + '123' --Auf den bestehenden Wert zugreifen (vor Update)
WHERE ID BETWEEN 15 AND 18;

UPDATE Test
SET Nachname = Nachname + '123', Vorname = 'Test' --Mehrere Spalten gleichzeitig anpassen
WHERE ID BETWEEN 15 AND 18;

-----------------------------------------------------------------------

--CREATE SEQUENCE <Name> AS <Datentyp>
CREATE SEQUENCE Rechnungsnummern AS int;

--N�chsten Wert aus der Sequenz entnehmen
SELECT NEXT VALUE FOR Rechnungsnummern;

--Startwert und Inkrement festlegen
CREATE SEQUENCE Rechnungsnummern AS int
START WITH 230000
INCREMENT BY 1;

--N�chsten Value auch bei INSERT m�glich
INSERT INTO Test VALUES
(NEXT VALUE FOR Rechnungsnummern, 'test');

-----------------------------------------------------------------------

--DELETE FROM <Name>
DELETE FROM Test; --L�scht alle Daten ohne WHERE

DELETE FROM Test WHERE ID > 10;

--L�scht alle Daten (kann kein WHERE enthalten)
--Programmierer wollte explizit alle Daten l�schen
TRUNCATE TABLE Test;

-----------------------------------------------------------------------

--Transaktionen: Erm�glichen uns UPDATE/DELETE sicher zu machen und r�ckg�ngig zu machen falls etwas schief l�uft

BEGIN TRANSACTION; --Transaktion gestartet

--Jedes SQL-Statement ab hier wird "gespeichert" aber noch nicht auf die Datenbank geschrieben

DELETE FROM Test; --Ab hier wird die Tabelle gesperrt f�r andere Sessions

COMMIT; --Transaktion beendet
ROLLBACK; --Transaktion beendet

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; --Dieser Befehl ist essentiell um nicht geschriebene �nderungen auf der Datenbank zu sehen

-----------------------------------------------------------------------

SELECT * FROM INFORMATION_SCHEMA.TABLES; --Alle Tabellen und Views anzeigen
SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'; --Alle Tabellen anzeigen

SELECT * FROM INFORMATION_SCHEMA.COLUMNS; --Alle Spalten anzeigen
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'Employees';

-----------------------------------------------------------------------

--ALTER: Datenbankobjekte bearbeiten

ALTER TABLE Test ADD NeueSpalte int;

ALTER TABLE Test DROP COLUMN NeueSpalte;

ALTER TABLE Test ALTER COLUMN NeueSpalte varchar(20);