USE Northwind;

--CASE: Erzeugt eine neue Spalte im SELECT abh�ngig von Bedingungen

--Jedes Order mit Frachtkosten > 100 soll eine teure Bestellung sein, sonst eine g�nstige Bestellung
SELECT *,
	CASE
		WHEN Freight > 100 THEN 'Teure Bestellung'
		WHEN Freight <= 100 THEN 'G�nstige Bestellung'
	END AS Status
FROM Orders;

--Finde alle Customer die Deutsch sprechen k�nnen
SELECT *,
	CASE
		WHEN Country IN('Austria', 'Germany', 'Switzerland') THEN 'Spricht deutsch' --Alle Bedingungen die auch in einem WHERE m�glich w�ren k�nnen hier verwendet werden
		ELSE 'Spricht kein deutsch' --ELSE f�r alle anderen F�lle
	END
FROM Customers;

--Lieferstatus: Welche Order sind vorzeitig/rechtzeitig/zu sp�t/noch nicht angekommen?
SELECT *,
	CASE
		WHEN ShippedDate < RequiredDate THEN 'Vorzeitig angekommen'
		WHEN ShippedDate = RequiredDate THEN 'Genau rechtzeitig angekommen'
		WHEN ShippedDate > RequiredDate THEN 'Zu sp�t angekommen'
		ELSE 'Noch nicht angekommen'
	END AS Lieferstatus
FROM Orders
ORDER BY Lieferstatus;

--CASE im WHERE
--Rechnungsposten: Quantity, UnitPrice -> Quantity * UnitPrice = Gesamtbetrag
SELECT * FROM [Order Details]
WHERE Quantity * UnitPrice >
CASE
	WHEN Discount >= 0.2 THEN 5000 --Wenn dieses CASE ausgef�hrt wird, werden die restlichen CASES ausgelassen
	WHEN Discount >= 0.1 THEN 2000
	WHEN Discount >= 0.05 THEN 500
END