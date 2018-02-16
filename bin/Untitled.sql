--ALTER TABLE CUSTOMER
--ADD sex char(1)
--DEFAULT 'M'
--NOT NULL
--CHECK (sex='M' OR sex='F');
--SELECT sex FROM CUSTOMER;
--
--UPDATE CUSTOMER
--SET sex='F'
--WHERE FIRSTNAME IN ('Helena', 'Kara', 'Fernanda', 'Jenifer', 'Kathy', 'Heather', 'Julia', 'Martha', 'Ellie', 'Madalena', 'Hannah', 'Camille', 'Isabelle', 'Emma', 'Puja');
--SELECT SEX FROM CUSTOMER;
--
--UPDATE CUSTOMER
--SET 
--INSERT INTO
--CUSTOMER (CUSTOMERID, FIRSTNAME, LASTNAME, ADDRESS, CITY, COUNTRY, POSTALCODE, PHONE, EMAIL, SEX)
--VALUES (100,'DAVID,','LESKO','URBANKOVA 2','KOSICE','SLOVAKIA','04001','0910123456','DAVID@TS.SK','M' )
--SELECT SEX FROM CUSTOMER;

--SELECT DISTINCT FIRSTNAME, LASTNAME
--FROM CUSTOMER; 
--ORDER BY FIRSTNAME


--Jednoduché dopyty
--1. Vypíšte názvy všetkých skladieb, ktoré majú ako skladateľa uvedenú skupinu U2. Pre overenie správnosti vedzte, že takýchto skladieb je 57.
SELECT name, COMPOSER
FROM TRACK
WHERE COMPOSER LIKE '%U2%';

--2. Zistite, koľko sekúnd trvá skladba “One” od skupiny U2. Pre overenie správnosti vedzte, že skladba trvá 276,192 sekúnd.
SELECT MILLISECONDS
FROM TRACK
WHERE NAME='One' AND COMPOSER='U2';

--3. Vypíšte meno a priezvisko všetkých tých zákazníkov, ktorí pochádzajú z Českej republiky (Czech Republic).
SELECT FIRSTNAME, LASTNAME
FROM CUSTOMER
WHERE COUNTRY ='Czech Republic';


--4. Vypíšte zoznam všetkých skladieb, pričom vypíšete jej názov, skladateľa, jednotkovú cenu v dolároch (hodnota v stĺpci UnitPrice), cenu v eurách (1$=0.76€) a v českých korunách (1$=19.20CK). Pri vypisovaní jednotlivých prepočítaných cien nezabudnite správne nazvať aj stĺpec (napr. USD, EUR, CZK) a za hodnotu pripíšte aj samotnú jednotku ($, €, CK). Každú cenu zaokrúhlite na 2 desatinné miesta. 
SELECT NAME, COMPOSER, UNITPRICE || ' $' AS USD,
SUBSTR( UNITPRICE / 0.76, 0, 4 )|| ' €' AS EUR,
SUBSTR( UNITPRICE*19.2, 0, 5 )|| ' cz' AS CZ
FROM track;



--5. Zistite zoznam všetkých zamestnancov spoločnosti, ktorí nepochádzajú z USA.
SELECT COUNTRY
FROM EMPLOYEE
WHERE COUNTRY !='USA';



--6. Ktorých zákazníkov máme zo strednej európy?
SELECT COUNTRY
FROM CUSTOMER
WHERE COUNTRY IN ('Slovakia', 'Czech Republic', 'Austria', 'Poland', 'Hungary');

--7. Zistite, ktorí zamestnanci majú narodeniny vo februári.
SELECT FIRSTNAME, LASTNAME, BIRTHDATE
FROM EMPLOYEE
WHERE EXTRACT (MONTH FROM birthdate)='02';


--8. Vypíšte zoznam všetkých zamestnancov, ktorí sa narodili v 70tych rokoch minulého tisícročia. Vypíšte ich v poradí od najstaršieho po najmladšieho.
SELECT FIRSTNAME, LASTNAME, BIRTHDATE
FROM EMPLOYEE
WHERE BIRTHDATE BETWEEN '01.01.1970' AND '31.12.1979'
ORDER BY BIRTHDATE;



--9. Vypíšte zoznam všetkých zákazníkov, ktorí majú svoj e-mailový účet na gmail.com alebo na yahoo.com.
SELECT FIRSTNAME, LASTNAME, EMAIL
FROM CUSTOMER
WHERE EMAIL LIKE '%gmail.com' 
OR EMAIL LIKE '%yahoo.com';


--10. Vypíšte zoznam zamestnancov v tvare meno a priezvisko, dátum narodenia a počet rokov daného zamestnanca.
SELECT FIRSTNAME, LASTNAME, BIRTHDATE,
CEIL ( MONTHS_BETWEEN (CURRENT_DATE, birthdate) / 12) AS age 
FROM EMPLOYEE;


--11. Obchod má aj elektronickú podobu, kde si zákazníci môžu skladby vyhľadávať na základe fulltextového vyhľadávača, ktorý vyhľadá skladby nehľadiac na veľkosť písmen. Vytvorte dopyt, ktorý vyhľadá všetky skladby na základe ich názvu, v ktorých sa nachádza slovo 'love'.
SELECT NAME
FROM TRACK
WHERE NAME LIKE '%Love%'
OR NAME LIKE '%love%'
OR NAME LIKE '%LOVE%';



--Spajanie tabuliek
--1
SELECT *
FROM ALBUM a
RIGHT OUTER JOIN ARTIST ar ON a.ARTISTID=ar.ARTISTID
WHERE NAME='U2';

SELECT *
FROM ARTIST ar 
INNER JOIN ALBUM al 
ON ar.ARTISTID=al.ARTISTID
WHERE ar.ARTISTID = 150;

SELECT *
FROM ARTIST ar 
INNER JOIN ALBUM al 
ON ar.ARTISTID = al.ARTISTID
AND ar.NAME='U2';

--2
SELECT *
FROM MEDIATYPE mt
INNER JOIN TRACK tr 
ON mt.MEDIATYPEID=tr.MEDIATYPEID
WHERE mt.MEDIATYPEID='3';

SELECT *
FROM TRACK tr
INNER JOIN MEDIATYPE med
ON tr.MEDIATYPEID=med.MEDIATYPEID
WHERE med.NAME LIKE '%video%';

--3
SELECT t.name, COMPOSER, MILLISECONDS/1000 FROM track t
INNER JOIN PLAYLISTTRACK pt
ON pt.TRACKID=t.TRACKID AND COMPOSER IS NOT NULL
INNER JOIN PLAYLIST pl
ON pl.PLAYLISTID=pt.PLAYLISTID AND pl.NAME='90’s Music';

--4
SELECT DISTINCT a.TITLE 
FROM GENRE g
INNER JOIN TRACK t
ON g.GENREID=t.GENREID and g.name='Soundtrack'
INNER JOIN ALBUM a
ON a.ALBUMID=t.ALBUMID;

--6
--Vypíšte sumárne, koľko skladieb sa nachádza v jednotlivých playlistoch. Pre overenie správnosti vedzte, že v playliste TV Shows sa nachádza 213 skladieb a v playliste Audiobooks sa nenachádza žiadna skladba (počet je 0). Výsledný zoznam usporiadajte vzostupne podľa názvu playlistu.
SELECT
	pl.name,
	COUNT( pt.trackid )
FROM
	PLAYLIST pl
LEFT OUTER JOIN PLAYLISTTRACK pt ON
	pl.PLAYLISTID = pt.PLAYLISTID
GROUP BY
	pl.PLAYLISTID,
	pl.NAME;


--7
SELECT
    e.FIRSTNAME || ', '|| e.LASTNAME AS employee,
    s.FIRSTNAME || ', '|| s.LASTNAME AS supervisor
FROM EMPLOYEE e
INNER JOIN EMPLOYEE s ON
    e.REPORTSTO=s.EMPLOYEEID
    WHERE s.REPORTSTO IS null;









--Agregačné funkcie
--1. Aká bola tržba z objednávok v máji 2013? Pre overenie správnosti bola táto tržba 37.62.
SELECT sum (TOTAL)
FROM INVOICE
WHERE EXTRACT (YEAR FROM INVOICEDATE)='2013'
AND EXTRACT (MONTH FROM invoicedate)='05';

--2
SELECT COUNT(BILLINGCOUNTRY)
FROM INVOICE
WHERE 

--4
SELECT COUNT (*) AS pocet
FROM album a 
INNER JOIN TRACK t ON a.ALBUMID=t.ALBUMID
AND a.TITLE='War';

--5
SELECT
TRUNC( sum( t.milliseconds )/ 1000 ) AS secs,
TRUNC( sum( t.milliseconds )/ 1000 / 60 ) AS mins
FROM album a 
INNER JOIN TRACK t ON a.ALBUMID=t.ALBUMID
AND a.TITLE='War';



--Vnorene dopyty
--1
--Zistite meno, priezvisko a dátum narodenia najstaršieho zamestnanca, ktorého má obchod. Výsledný dopyt porovnajte s riešením pomocou spojenia tabuliek.
SELECT *
FROM EMPLOYEE e 
WHERE
e.BIRTHDATE=(
SELECT min(BIRTHDATE)
FROM EMPLOYEE);

SELECT *
FROM EMPLOYEE e 
WHERE
e.BIRTHDATE >= ALL (
SELECT BIRTHDATE
FROM EMPLOYEE);

SELECT COUNT (pl.NAME)
FROM PLAYLIST pl 
INNER JOIN PLAYLISTTRACK plt 
ON pl.PLAYLISTID=plt.PLAYLISTID
WHERE pl.NAME='Heavy Metal Classic';

SELECT tra.UNITPRICE, invl.QUANTITY
FROM TRACK tra 
INNER JOIN INVOICELINE invl
ON tra.UNITPRICE=invl.UNITPRICE
INNER JOIN INVOICE inv 
ON inv.INVOICEID=invl.INVOICEID
WHERE tra.UNITPRICE > 0
AND invl.QUANTITY > 0;

SELECT COUNT(MEDIATYPEID)
FROM MEDIATYPE;

SELECT COUNT (*)
FROM MEDIATYPE
WHERE NAME NOT IN ('MPEG audio file', 'Protected AAC audio file', 'Protected MPEG-4 video file', 'Purchased AAC audio file', 'AAC audio file');

SELECT COUNT (*)
FROM INVOICE
WHERE TOTAL < 0;

SELECT COUNT (*)
FROM TRACK
WHERE UNITPRICE < 0;

SELECT COUNT (COUNTRY)
FROM CUSTOMER
WHERE COUNTRY NOT IN ('Argentina', 'Australia', 'Austria', 'Belgium', 'Brazil', 'Canada', 'Chile', 'Czech Republic', 'Denmark', 'Finlad', 'France', 'Germany', 'Hungary', 'India', 'Ireland', 'Italy', 'Netherelands', 'Norway', 'Poland', 'Portugal', 'Spain', 'Sweden', 'USA', 'United Kindgdom');


SELECT FIRSTNAME || ', ' || LASTNAME AS name
FROM CUSTOMER
WHERE NOT REGEXP_LIKE(FIRSTNAME, '%[^a-zA-Z]%');

SELECT LENGTH(NAME), NAME
FROM TRACK
--ORDER BY LENGTH(NAME) DESC
WHERE LENGTH (NAME) >= 150;

SET TRANSACTION NAME 'test';
INSERT INTO TRACK (TRACKID, NAME, MEDIATYPEID, MILLISECONDS, UNITPRICE)
VALUES ('98791', 'aaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadaaaaaaddddddddddaaaaaaaaaaddaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadddddddddd', '1', '233', '0.98');
ROLLBACK;

SET TRANSACTION NAME 'test'; 
DELETE FROM TRACK
WHERE TRACKID = 987654;
INSERT INTO TRACK (TRACKID, NAME, MEDIATYPEID, MILLISECONDS, UNITPRICE) VALUES ('987654','aaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadaaaaaaddddddddddaaaaaaaaaaddaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadddddddddd', '1', '233', '0.98'); 
--SELECT LENGTH(NAME) FROM TRACK WHERE LENGTH (NAME) >= 150; 
SELECT COUNT(NAME)
FROM TRACK
GROUP BY NAME
HAVING LENGTH(NAME) > 150;
ROLLBACK;

SELECT name
FROM TRACK
GROUP BY NAME
HAVING LENGTH(NAME) > 150;

SELECT COUNT(name)
FROM TRACK;

INSERT INTO TRACK (TRACKID, NAME, MEDIATYPEID, MILLISECONDS, UNITPRICE) VALUES ('98791', 'aaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadaaaaaaddddddddddaaaaaaaaaaddaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaadddddddddd', '1', '233', '0.98');
DELETE FROM TRACK
WHERE TRACKID = 98791;

INSERT INTO TRACK (TRACKID, NAME, MEDIATYPEID, MILLISECONDS, UNITPRICE)
VALUES ('32242', 'sdfasad', '4', '234234', DEFAULT);

SELECT MAX (TRACKID)+1
FROM TRACK;

SELECT MAX(ALBUMID)
FROM ALBUM;

SELECT FIRSTNAME,LASTNAME, BIRTHDATE 
FROM EMPLOYEE
WHERE BIRTHDATE = (SELECT MIN(BIRTHDATE) FROM EMPLOYEE);


CREATE SEQUENCE track_seq
START WITH 5
INCREMENT BY 9;
SELECT track_seqq.currval
FROM DUAL;

SELECT * FROM movie;

SET TRANSACTION name 'testik';
INSERT INTO movie (id, title, year)
VALUES ('123456', 'aaaaaaaaaadddddrrrrrrrrrrrrrrrrrrrrrdddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaeeeeeeeeeeeaaaaaaaaddddddddddaaaaaaaaaadaaaaaaddddddddddaaaaaaaaaaddaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddaaaaaaaaaaddddddddddsssssssssssssssssssssssssssfffffffffffffffffffffffffffff', '2019');
SELECT COUNT(title)
FROM movie
GROUP BY title
HAVING LENGTH(title) > 200;
ROLLBACK;

SELECT FIRSTNAME, LASTNAME, BIRTHDATE
FROM EMPLOYEE
WHERE BIRTHDATE = (SELECT MIN(BIRTHDATE) FROM EMPLOYEE);


SELECT *
FROM OBEC
WHERE ID_OKRES=(SELECT ID FROM OKRES WHERE NAZOV LIKE 'Humenne');

SELECT *
FROM OBEC
WHERE ID_OBEC =()

SELECT FIRSTNAME, LASTNAME, EXTRACT(YEAR FROM birthdate) AS birthdate, EXTRACT(YEAR FROM CURRENT_DATE) AS currdate, (CURRENT_DATE - birthdate)/356 AS age
FROM EMPLOYEE;

SELECT FIRSTNAME, LASTNAME, trunc((CURRENT_DATE - birthdate)/365, 2) AS age
FROM EMPLOYEE;

SELECT EXTRACT(YEAR FROM CURRENT_DATE)
FROM dual;

SELECT BIRTHDATE
FROM EMPLOYEE;

SELECT (2018-1962)*356 
FROM dual;