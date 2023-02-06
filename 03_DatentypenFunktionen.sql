USE Northwind;

--Numerische Typen
--int: Ganze Zahl
--decimal, numeric, float, real: Kommazahlen
--bit: 1 oder 0, wahr oder falsch
--money: Geldwerte

--Texttypen
--varchar(X): Text mit maximal X Zeichen
--char(X): Text mit genau X Zeichen
--text: Text mit beliebiger Länge (veraltet) -> varchar(MAX)
--n vor Typen: Unicode

--Datumstypen
--datetime: Datum + Zeit
--date: Nur Datum
--time: Nur Zeit



--Datumsfunktionen
SELECT GETDATE(); --Das jetztige Datum + Zeit, millisekundengenau
SELECT SYSDATETIME(); --Das jetztige Datum + Zeit, nanosekundengenau

/*
	Intervalle:
    year, yyyy, yy = Year
    month, MM, M = month
    week, ww, wk = Week
    day, dd, d = Day
    hour, hh = hour
    minute, mi, m = Minute
    second, ss, s = Second
    millisecond, ms = Millisecond
	nanosecond, ns

    weekday, dw, w = Weekday (1-7)
    dayofyear, dy, y = Day of the year (1-366)
    quarter, qq, q = Quarter (1-4)
*/

--YEAR/MONTH/DAY
SELECT YEAR(GETDATE()); --Vom heutigen Datum nur das Jahr zurückgeben
SELECT MONTH(GETDATE()); --Vom heutigen Datum nur das Monat zurückgeben
SELECT DAY(GETDATE()); --Vom heutigen Datum nur den Tag zurückgeben

SELECT YEAR(HireDate) FROM Employees; --Funktionen auf Spalten anwenden

--DATEPART: Teil eines Datums, anhand eines Intervalls
SELECT DATEPART(HOUR, GETDATE()); --Die Stunde vom heutigen Datum
SELECT DATEPART(SECOND, GETDATE()); --Die Sekunde vom heutigen Datum

SELECT DATEPART(WEEKDAY, GETDATE()); --Wochentag vom heutigen Datum (1)
SELECT DATEPART(DAYOFYEAR, GETDATE()); --Jahrestag vom heutigen Datum vom 01.01. (37)
SELECT DATEPART(QUARTER, GETDATE()); --Quartal vom heutigen Datum (1)

SELECT DATEPART(YEAR, HireDate) FROM Employees; --DATEPART auf Spalte anwenden

--DATEDIFF: Unterschied zwischen zwei Datumswerten
SELECT HireDate, DATEDIFF(YEAR, HireDate, GETDATE()) FROM Employees; --Wie lange sind unsere Mitarbeiter schon in der Firma? (ungenau)

SELECT DATEDIFF(YEAR, '2020-01-01', GETDATE()); --ISO-8601 Datum immer möglich
SELECT DATEDIFF(YEAR, '01.01.2020', GETDATE()); --Deutsches Datum möglich weil deutscher Server
SELECT DATEDIFF(YEAR, '01/30/2020', GETDATE()); --Amerikanisches Datum nicht möglich, da deutscher Server (aber auf amerikanischem Server wäre das möglich)



--Stringfunktionen
SELECT Address + City + PostalCode + Country FROM Customers; --Strings verbinden mit +

SELECT CONCAT(Address, City, PostalCode, Country) FROM Customers; --CONCAT: beliebig viele Spalten zusammenbauen

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) FROM Customers; --CONCAT_WS: beliebig viele Spalten zusammenbauen mit einem Separator

SELECT CONCAT_WS(' ', Address, City, PostalCode, Country) AS [Volle Adresse] FROM Customers;

--LEN/DATALENGTH: Gibt die Länge des Texts aus
SELECT LEN('Test'); --4
SELECT LEN(FirstName) FROM Employees; --Länge der Vornamen aller Mitarbeiter

SELECT LEN(' Test '); --5, weil automatisch Abstände am Ende weggeschnitten werden
SELECT DATALENGTH(' Test '); --6, weil RTRIM weggelassen wird



--Konvertierungsfunktionen

--CAST: Wandelt einen Wert in einen anderen Typen um
SELECT CAST(GETDATE() AS DATE); --Datetime zu Date umwandeln -> Zeit wird abgeschnitten

SELECT CAST(GETDATE() AS TIME); --DateTime zu Time umwandeln -> Datum wird abgeschnitten

SELECT HireDate, CAST(HireDate AS DATE) FROM Employees; --Cast auf Tabellenspalten anwenden

SELECT '123' + 3; --Automatische Konvertierung von varchar zu int möglich

SELECT '123.4' + 3; --Hier nicht möglich

SELECT CAST('123.4' AS float) + 3; --Explizite Konvertierung notwendig

--FORMAT: Formatiert den gegebenen Wert in die angegebene Formatierung

/*
	Intervalle:
    year, yyyy, yy = Year
    month, MM, M = month
    week, ww, wk = Week
    day, dd, d = Day
    hour, hh = hour
    minute, mi, n = Minute
    second, ss, s = Second
    millisecond, ms = Millisecond
	nanosecond, ns

    weekday, dw, w = Weekday (1-7)
    dayofyear, dy, y = Day of the year (1-366)
    quarter, qq, q = Quarter (1-4)
*/

SELECT GETDATE(); --ISO-Datum (nicht sonderlich anschaulich)

SELECT FORMAT(GETDATE(), 'dd.MM.yyyy'); --Formatierung hier angeben

SELECT FORMAT(GETDATE(), 'dd.MM.'); --Beliebige Formate möglich

SELECT FORMAT(GETDATE(), 'dd ddd dddd MM MMM MMMM yy yyyy');

SELECT FORMAT(GETDATE(), 'dddd, dd. MMMM yyyy hh:mm:ss'); --Schönstes Deutsches Datum

--Schnellformatierungen
SELECT FORMAT(GETDATE(), 'd');
SELECT FORMAT(GETDATE(), 'D');

SELECT FORMAT(HireDate, 'D') FROM Employees;