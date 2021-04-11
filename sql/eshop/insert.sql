DELETE FROM kund;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';
-- Insert into kurs 
--
LOAD DATA LOCAL INFILE 'kund.csv'
INTO TABLE kund
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
(adress, email, fornamn, efternamn, postnummer, ort, land, telefonnummer)
;

SELECT * FROM kund;


--
-- PRODUKTER 
--

DELETE FROM produkt;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'produkt.csv'
INTO TABLE produkt
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM produkt;


-- 
-- LAGER
--

DELETE FROM lager;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'lager.csv'
INTO TABLE lager
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM lager;


-- 
-- HYLLA
--

DELETE FROM hylla;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'hylla.csv'
INTO TABLE hylla
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM hylla;







-- Lägger in data utan kategorier

-- DELETE FROM produkt;

-- --
-- -- Enable LOAD DATA LOCAL INFILE on the server.
-- --
-- SET GLOBAL local_infile = 1;
-- SHOW VARIABLES LIKE 'local_infile';

-- LOAD DATA LOCAL INFILE 'produkt2.csv'
-- INTO TABLE produkt
-- CHARSET utf8
-- FIELDS
--     TERMINATED BY ','
--     ENCLOSED BY '"'
-- LINES
--     TERMINATED BY '\n'
-- IGNORE 1 LINES
-- ;

-- SELECT * FROM produkt;




--
-- INSERT I kategorier
--

DELETE FROM kategori;

--
-- Enable LOAD DATA LOCAL INFILE on the server.
--
SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA LOCAL INFILE 'kategorier.csv'
INTO TABLE kategori
CHARSET utf8
FIELDS
    TERMINATED BY ','
    ENCLOSED BY '"'
LINES
    TERMINATED BY '\n'
IGNORE 1 LINES
;

SELECT * FROM kategori;


--
-- INSERT FÖR många-till-många tabellen
--

INSERT INTO produkt2kategori
    VALUES ("kaffe1", "kaffeblandning");

    INSERT INTO produkt2kategori
    VALUES ("kaffe2", "kaffeblandning");
    
    INSERT INTO produkt2kategori
    VALUES ("kaffemix1", "kaffeblandning");

    INSERT INTO produkt2kategori
    VALUES ("skiva1", "skivor");

    INSERT INTO produkt2kategori
    VALUES ("te1", "muggar");




