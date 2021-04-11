DROP TABLE IF EXISTS kund;
CREATE TABLE kund
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    adress CHAR(50) NOT NULL,
	email CHAR(100) NOT NULL,
	fornamn CHAR(50) NOT NULL,
	efternamn CHAR(75) NOT NULL,
    postnummer CHAR(50) NOT NULL,
    ort CHAR(50) NOT NULL,
    land CHAR(50) NOT NULL,
	telefonnummer CHAR(50)
);

DROP TABLE IF EXISTS produkt;
CREATE TABLE produkt
(
	produktkod CHAR(100) PRIMARY KEY NOT NULL,
	namn CHAR(100) NOT NULL,
	beskrivning VARCHAR(400),
	pris INT NOT NULL,
    KEY `index_namn` (`namn`)
);

DROP TABLE IF EXISTS kategori;
CREATE TABLE kategori
(
	id CHAR(100) PRIMARY KEY NOT NULL
);

DROP TABLE IF EXISTS produkt2kategori;
CREATE TABLE produkt2kategori
(
	produktkod CHAR(100) NOT NULL,
	kategori_id CHAR(100) NOT NULL,
    FOREIGN KEY (produktkod) REFERENCES produkt(produktkod) ON UPDATE CASCADE,
    FOREIGN KEY (kategori_id) REFERENCES kategori(id) ON UPDATE CASCADE,
    PRIMARY KEY (produktkod, kategori_id)
);


DROP TABLE IF EXISTS bestallning;
CREATE TABLE bestallning
(
	`id` INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	`kund_id` INT NOT NULL,
    `skapad` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `uppdaterad` TIMESTAMP DEFAULT NULL
                ON UPDATE CURRENT_TIMESTAMP,
    `bestalld` TIMESTAMP DEFAULT NULL,
    `skickad` TIMESTAMP DEFAULT NULL,
    `raderad` TIMESTAMP DEFAULT NULL,
	FOREIGN KEY (kund_id) REFERENCES kund(id)
);


DROP TABLE IF EXISTS bestallning_produkt;
CREATE TABLE bestallning_produkt
(
	produktkod CHAR(100) NOT NULL,
	FOREIGN KEY (produktkod) REFERENCES produkt(produktkod),
	bestallning_id INT NOT NULL,
	FOREIGN KEY (bestallning_id) REFERENCES bestallning(id),
	antal INT NOT NULL
);


DROP TABLE IF EXISTS faktura;
CREATE TABLE faktura
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	totalt_pris INT NOT NULL,
	bestallning_id INT NOT NULL,
    betald DATE DEFAULT NULL,
	FOREIGN KEY (bestallning_id) REFERENCES bestallning(id),
    CONSTRAINT uc_name_address UNIQUE (totalt_pris, bestallning_id)
);

DROP TABLE IF EXISTS lager;
CREATE TABLE lager
(
	hylla CHAR(100) PRIMARY KEY NOT NULL,
	plats CHAR(100) NOT NULL
);

DROP TABLE IF EXISTS hylla;
CREATE TABLE hylla
(
    lager_hylla CHAR(100) NOT NULL,
	produktkod CHAR(100),
	antal INT,
	FOREIGN KEY (produktkod) REFERENCES produkt(produktkod),
	FOREIGN KEY (lager_hylla) REFERENCES lager(hylla),
    PRIMARY KEY (lager_hylla, produktkod)
);

DROP TABLE IF EXISTS logg;
CREATE TABLE logg
(
    `id` INTEGER PRIMARY KEY AUTO_INCREMENT,
    `tidsstämpel` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `händelse` VARCHAR(100)
);

-- Trigger för INSERT i logg

DROP TRIGGER IF EXISTS logg_produkt_insert;

CREATE TRIGGER logg_produkt_insert
AFTER INSERT
ON produkt FOR EACH ROW
    INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Ny produkt lades till med produktkod ', NEW.produktkod, '.'));

-- Trigger för UPDATE i logg

DROP TRIGGER IF EXISTS logg_produkt_update;

CREATE TRIGGER logg_produkt_update
AFTER UPDATE
ON produkt FOR EACH ROW
    INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Detaljer om produktkod ', NEW.produktkod, ' uppdaterades.'));


-- Trigger för DELETE i logg

DROP TRIGGER IF EXISTS logg_produkt_delete;

CREATE TRIGGER logg_produkt_delete
AFTER DELETE
ON produkt FOR EACH ROW
    INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Produkten med produktkod ', OLD.produktkod,  ' raderades.'));



-- 
-- TRIGGERS FÖR ATT LÄGGA TILL ORDER I LOGGEN
--


DROP TRIGGER IF EXISTS logg_bestallning_insert;

CREATE TRIGGER logg_bestallning_insert
AFTER INSERT
ON bestallning FOR EACH ROW
    INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Order ', NEW.id, ' lades till. Kund id är ', NEW.kund_id, '.'));

-- Trigger för UPDATE i logg

DROP TRIGGER IF EXISTS logg_bestallning_update;

CREATE TRIGGER logg_bestallning_update
AFTER UPDATE
ON bestallning FOR EACH ROW
    INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Ny orderstatus för beställning ', NEW.id,  ' är ',
         order_status(NEW.raderad, NEW.skickad, NEW.bestalld, NEW.uppdaterad, NEW.skapad),
          '.'));


-- Trigger för DELETE i logg

DROP TRIGGER IF EXISTS logg_bestallning_delete;

CREATE TRIGGER logg_bestallning_delete
AFTER DELETE
ON bestallning FOR EACH ROW
    INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Order ', OLD.id, ' raderades.'));





-- ESHOP PROCEDURES

--
-- Create procedure for select * from account
--
DROP PROCEDURE IF EXISTS show_categories;
DELIMITER ;;
CREATE PROCEDURE show_categories()
BEGIN
    SELECT id FROM kategori;
END
;;
DELIMITER ;




DROP PROCEDURE IF EXISTS show_products_available;
DELIMITER ;;
CREATE PROCEDURE show_products_available()
BEGIN
    SELECT DISTINCT p.produktkod, namn, pris,
    (SELECT SUM(antal) FROM produkt AS z JOIN hylla ON z.produktkod = hylla.produktkod WHERE z.produktkod = p.produktkod) AS antal,
    GROUP_CONCAT(c.id SEPARATOR ' - ') AS 'kategori'
    FROM produkt AS p 
    LEFT JOIN hylla ON p.produktkod = hylla.produktkod
        JOIN produkt2kategori AS p2c
            ON p.produktkod = p2c.produktkod
        JOIN kategori AS c 
            ON c.id = p2c.kategori_id
    GROUP BY p.produktkod, hylla.antal;
END
;;
DELIMITER ;




DROP PROCEDURE IF EXISTS create_product;
DELIMITER ;;
CREATE PROCEDURE create_product(IN a_produktkod CHAR(100), a_namn CHAR(100), a_beskrivning VARCHAR(400), a_pris INT, a_kategori CHAR(50))
BEGIN
    INSERT INTO produkt (produktkod, namn, beskrivning, pris)
    VALUES (a_produktkod, a_namn, a_beskrivning, a_pris);

    INSERT IGNORE INTO  kategori VALUES (a_kategori);

    INSERT INTO produkt2kategori VALUES (a_produktkod, a_kategori);

    INSERT INTO hylla (lager_hylla, produktkod, antal)
    VALUES ('A:101', a_produktkod, 10);
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_product;
DELIMITER ;;
CREATE PROCEDURE get_product(IN a_produktkod CHAR(100))
BEGIN
    SELECT produkt.produktkod, namn, beskrivning, pris, kategori_id AS kategori 
    FROM produkt
    JOIN produkt2kategori AS k ON k.produktkod = produkt.produktkod 
    WHERE produkt.produktkod = a_produktkod
    ;

END
;;
DELIMITER ;



-- FÖr att uppdatera kategori. Har nu istället satt readonly och kan inte redigera en kategori.
-- Man kan bara lägga till en.
-- Låg inuti update_product nedan

-- UPDATE kategori
--    JOIN produkt2kategori AS k ON k.kategori_id = kategori.id
--    SET id = a_kategori
--    WHERE k.produktkod = a_produktkod;

DROP PROCEDURE IF EXISTS update_product;
DELIMITER ;;
CREATE PROCEDURE update_product(IN a_produktkod CHAR(100), a_namn CHAR(100), a_beskrivning VARCHAR(400), a_pris INT, a_kategori CHAR(50))
BEGIN
    UPDATE produkt
    SET namn = a_namn, beskrivning = a_beskrivning, pris = a_pris
    WHERE produktkod = a_produktkod;
END
;;
DELIMITER ;



-- Borde egentligen använda någon typ av ON DROP CASCADE för delete_product-proceduren.

DROP PROCEDURE IF EXISTS delete_product;
DELIMITER ;;
CREATE PROCEDURE delete_product(IN a_produktkod CHAR(100))
BEGIN
    DELETE FROM hylla
        WHERE produktkod = a_produktkod;

    DELETE FROM bestallning_produkt
        WHERE produktkod = a_produktkod;

    DELETE FROM produkt2kategori
        WHERE produktkod = a_produktkod;

    DELETE FROM produkt
        WHERE produktkod = a_produktkod;
END
;;
DELIMITER ;




-- CLI ESHOP PROCEDURES


DROP PROCEDURE IF EXISTS show_log_rows;
DELIMITER ;;
CREATE PROCEDURE show_log_rows(IN `rows` INT)
BEGIN
    SELECT * FROM logg ORDER BY tidsstämpel DESC LIMIT `rows`;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS show_shelves;
DELIMITER ;;
CREATE PROCEDURE show_shelves()
BEGIN
    SELECT * FROM hylla;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS inventory;
DELIMITER ;;
CREATE PROCEDURE inventory()
BEGIN
    SELECT hylla.produktkod, namn, lager_hylla, antal FROM hylla JOIN produkt ON produkt.produktkod = hylla.produktkod;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS inventory_like;
DELIMITER ;;
CREATE PROCEDURE inventory_like(IN search VARCHAR(40))
BEGIN
    SET search = CONCAT('%', search, '%');
    SELECT hylla.produktkod, namn, lager_hylla, antal FROM hylla JOIN produkt ON produkt.produktkod = hylla.produktkod
    WHERE hylla.produktkod LIKE search
    OR produkt.namn LIKE search
    OR lager_hylla LIKE search
    ORDER BY produktkod;
END
;;
DELIMITER ;



DROP PROCEDURE IF EXISTS update_amount_product_shelf;
DELIMITER ;;
CREATE PROCEDURE update_amount_product_shelf(IN a_hylla VARCHAR(40), a_produktkod CHAR(100), a_antal INT)
BEGIN
    UPDATE HYLLA
    SET antal = antal + a_antal
    WHERE produktkod = a_produktkod AND lager_hylla = a_hylla; 

    INSERT IGNORE INTO hylla (lager_hylla, produktkod, antal)
        VALUES (a_hylla, a_produktkod, a_antal);
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS delete_amount_product_shelf;
DELIMITER ;;
CREATE PROCEDURE delete_amount_product_shelf(IN a_hylla VARCHAR(40), a_produktkod CHAR(100), a_antal INT)
BEGIN
    UPDATE HYLLA
    SET antal = antal - a_antal
    WHERE produktkod = a_produktkod AND lager_hylla = a_hylla; 
END
;;
DELIMITER ;



DROP PROCEDURE IF EXISTS get_customers;
DELIMITER ;;
CREATE PROCEDURE get_customers()
BEGIN
    SELECT id, CONCAT(fornamn, " ", efternamn) AS namn, email, telefonnummer FROM kund;
END
;;
DELIMITER ;





DROP PROCEDURE IF EXISTS get_orders;
DELIMITER ;;
CREATE PROCEDURE get_orders()
BEGIN
    SELECT DISTINCT bestallning.id,
    DATE_FORMAT(skapad, "%Y-%m-%d %T") AS skapad,
    (SELECT COUNT(antal) FROM bestallning_produkt WHERE bestallning_id = o.bestallning_id) AS antal_orderrader,
    order_status(bestallning.raderad, bestallning.skickad, bestallning.bestalld, bestallning.uppdaterad, bestallning.skapad) AS status,
    kund_id,
    CONCAT(fornamn, " ", efternamn) AS namn,
    adress,
    ort,
    postnummer
    FROM bestallning
    LEFT JOIN bestallning_produkt AS o ON bestallning.id = o.bestallning_id
    JOIN kund ON kund.id = kund_id
    ORDER BY id DESC
    ;
END
;;
DELIMITER ;









DROP FUNCTION IF EXISTS order_status;
DELIMITER ;;

CREATE FUNCTION order_status(
    a_raderad TIMESTAMP, a_skickad TIMESTAMP, a_bestalld TIMESTAMP, a_uppdaterad TIMESTAMP, a_skapad TIMESTAMP
)
RETURNS CHAR(15)
DETERMINISTIC
BEGIN
    IF a_raderad IS NOT NULL THEN
        RETURN 'Raderad';
    ELSEIF a_skickad IS NOT NULL THEN
        RETURN 'Skickad';
    ELSEIF a_bestalld IS NOT NULL THEN
        RETURN 'Beställd';
    ELSEIF a_uppdaterad IS NOT NULL THEN
        RETURN 'Uppdaterad';
    ELSEIF a_skapad IS NOT NULL THEN
        RETURN 'Skapad';
    END IF;
    RETURN 'Okänd status';
END
;;
DELIMITER ;


DROP FUNCTION IF EXISTS bestalld_status;
DELIMITER ;;

CREATE FUNCTION bestalld_status(
    a_bestalld TIMESTAMP
)
RETURNS CHAR(15)
DETERMINISTIC
BEGIN
    IF a_bestalld IS NOT NULL THEN
        RETURN 'Betald';
    ELSE 
        RETURN 'Ej betald';
    END IF;
    RETURN 'Okänd status';
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_order;
DELIMITER ;;
CREATE PROCEDURE get_order(IN a_bestallning_id INT)
BEGIN
    SELECT DISTINCT a.produktkod, o.namn, pris, antal,
    (SELECT SUM(antal) FROM produkt AS z JOIN hylla ON z.produktkod = hylla.produktkod WHERE z.produktkod = a.produktkod) AS lagerstatus
    FROM bestallning
    JOIN bestallning_produkt AS a ON bestallning_id = a.bestallning_id 
    JOIN produkt AS o ON o.produktkod = a.produktkod 
    WHERE bestallning_id = a_bestallning_id;
END
;;
DELIMITER ;


SELECT DISTINCT a.produktkod, o.namn, pris, antal,
    (SELECT SUM(antal) FROM produkt AS z JOIN hylla ON z.produktkod = hylla.produktkod WHERE z.produktkod = a.produktkod) AS lagerstatus
    FROM bestallning
    JOIN bestallning_produkt AS a ON bestallning_id = a.bestallning_id 
    JOIN produkt AS o ON o.produktkod = a.produktkod 
    WHERE bestallning_id = 2;



DROP PROCEDURE IF EXISTS create_order;
DELIMITER ;;
CREATE PROCEDURE create_order(customer_id INT)
BEGIN
    INSERT INTO bestallning (kund_id)
        VALUES (customer_id);
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_products;
DELIMITER ;;
CREATE PROCEDURE get_products()
BEGIN
    SELECT namn, produktkod 
    FROM produkt;
END
;;
DELIMITER ;

DROP PROCEDURE IF EXISTS get_order_status;
DELIMITER ;;
CREATE PROCEDURE get_order_status(a_bestallning_id INT)
BEGIN
    SELECT order_status(bestallning.raderad, bestallning.skickad, bestallning.bestalld, bestallning.uppdaterad, bestallning.skapad) AS status
    FROM bestallning
    WHERE id = a_bestallning_id;
END
;;
DELIMITER ;



DROP PROCEDURE IF EXISTS add_product_order;
DELIMITER ;;
CREATE PROCEDURE add_product_order(a_produktkod CHAR(100), a_bestallning_id INT, a_antal INT)
BEGIN
    INSERT INTO bestallning_produkt 
    (produktkod, bestallning_id, antal)
    VALUES (a_produktkod, a_bestallning_id, a_antal);
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS send_order;
DELIMITER ;;
CREATE PROCEDURE send_order(a_bestallning_id INT)
BEGIN
    UPDATE bestallning
        SET bestalld = CURRENT_TIMESTAMP()
        WHERE id = a_bestallning_id;
END
;;
DELIMITER ;




DROP PROCEDURE IF EXISTS search_order;
DELIMITER ;;
CREATE PROCEDURE search_order(IN search VARCHAR(40))
BEGIN
    SET search = CONCAT('%', search, '%');

    SELECT DISTINCT bestallning.id,
    DATE_FORMAT(skapad, "%Y-%m-%d %T") AS skapad,
    kund_id,
    (SELECT COUNT(antal) FROM bestallning_produkt WHERE bestallning_id = o.bestallning_id) AS antal_orderrader,
    order_status(bestallning.raderad, bestallning.skickad, bestallning.bestalld, bestallning.uppdaterad, bestallning.skapad) AS status
    FROM bestallning
    LEFT JOIN bestallning_produkt AS o ON bestallning.id = o.bestallning_id
    WHERE bestallning.id LIKE search 
    OR kund_id LIKE search;
END
;;
DELIMITER ;



DROP PROCEDURE IF EXISTS picklist_get_order;
DELIMITER ;;
CREATE PROCEDURE picklist_get_order(IN a_bestallning_id INT)
BEGIN
    SELECT DISTINCT a.produktkod, a.antal AS antal_bestallda,
    (SELECT GROUP_CONCAT(lager_hylla SEPARATOR ' - ') FROM hylla AS h WHERE h.produktkod = a.produktkod LIMIT 1) AS hylla,
    (SELECT SUM(antal) FROM produkt AS z JOIN hylla ON z.produktkod = hylla.produktkod WHERE z.produktkod = a.produktkod) AS lagerstatus
    FROM bestallning
    JOIN bestallning_produkt AS a ON bestallning_id = a.bestallning_id 
    JOIN produkt AS o ON o.produktkod = a.produktkod
    JOIN hylla ON o.produktkod = hylla.produktkod  
    WHERE bestallning_id = a_bestallning_id;
END
;;
DELIMITER ;






DROP PROCEDURE IF EXISTS ship_order;
DELIMITER ;;
CREATE PROCEDURE ship_order(a_bestallning_id INT)
BEGIN
    UPDATE bestallning
        SET skickad = CURRENT_TIMESTAMP()
        WHERE id = a_bestallning_id;

        UPDATE hylla
        JOIN bestallning_produkt AS bp ON bp.bestallning_id = a_bestallning_id
        SET hylla.antal = hylla.antal - bp.antal 
        WHERE hylla.produktkod = bp.produktkod AND bestallning_id = a_bestallning_id;

        INSERT INTO faktura (totalt_pris, bestallning_id) 
        SELECT SUM(pris*antal), bestallning_id FROM produkt 
        JOIN bestallning_produkt ON produkt.produktkod = bestallning_produkt.produktkod 
        WHERE bestallning_id = a_bestallning_id
        GROUP BY bestallning_produkt.bestallning_id;

END
;;
DELIMITER ;





DROP PROCEDURE IF EXISTS latest_orders;
DELIMITER ;;
CREATE PROCEDURE latest_orders()
BEGIN
    SELECT 
        DATE_FORMAT(tidsstämpel, "%Y-%m-%d %T") AS tidsstämpel,
        händelse
        FROM logg
        ORDER BY tidsstämpel DESC
        LIMIT 20;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS search_orders;
DELIMITER ;;
CREATE PROCEDURE search_orders(IN search VARCHAR(100))
BEGIN
    SELECT 
        id,
        DATE_FORMAT(tidsstämpel, "%Y-%m-%d %T") AS tidsstämpel,
        händelse
        FROM logg
        WHERE id LIKE search
        OR tidsstämpel LIKE search
        OR händelse LIKE search
        ;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_products_from_category;
DELIMITER ;;
CREATE PROCEDURE get_products_from_category(IN search VARCHAR(50))
BEGIN
    SELECT produkt.produktkod, namn, beskrivning, pris, kategori_id AS kategori 
    FROM produkt JOIN produkt2kategori AS k ON k.produktkod = produkt.produktkod 
    WHERE k.kategori_id = search
    ;
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS add_category;
DELIMITER ;;
CREATE PROCEDURE add_category(IN category CHAR(100))
BEGIN
    INSERT IGNORE INTO kategori VALUES (category)
    ;
END
;;
DELIMITER ;



DROP PROCEDURE IF EXISTS add_category_to_product;
DELIMITER ;;
CREATE PROCEDURE add_category_to_product(IN a_produktkod CHAR(100), a_kategori CHAR(100))
BEGIN
    INSERT INTO produkt2kategori (produktkod, kategori_id) VALUES (a_produktkod, a_kategori);
END
;;
DELIMITER ;


DROP PROCEDURE IF EXISTS get_categories_from_product;
DELIMITER ;;
CREATE PROCEDURE get_categories_from_product(IN a_produktkod CHAR(100))
BEGIN
    SELECT kategori_id AS kategori FROM produkt2kategori WHERE produktkod = a_produktkod;
END
;;
DELIMITER ;





DROP PROCEDURE IF EXISTS get_invoices;
DELIMITER ;;
CREATE PROCEDURE get_invoices()
BEGIN
    SELECT faktura.id, totalt_pris, bestallning_id, CONCAT(fornamn, " ", efternamn) AS namn,
    bestalld_status(faktura.betald) AS betal_status
    FROM faktura 
    JOIN bestallning AS b ON b.id = bestallning_id 
    JOIN kund AS k ON k.id = kund_id ORDER BY id DESC;
END
;;
DELIMITER ;




DROP PROCEDURE IF EXISTS get_invoice_overview;
DELIMITER ;;
CREATE PROCEDURE get_invoice_overview(IN order_number INT)
BEGIN
    SELECT faktura.id, bestallning_id, 
    DATE_FORMAT(b.skapad, "%Y-%m-%d %T") AS skapad,
    order_status(b.raderad, b.skickad, b.bestalld, b.uppdaterad, b.skapad) AS status,
    k.id AS kund_id, CONCAT(fornamn, " ", efternamn) AS namn, k.adress, k.ort, k.postnummer,
    totalt_pris, bestalld_status(faktura.betald) AS betal_status
    FROM faktura 
    JOIN bestallning AS b ON b.id = bestallning_id 
    JOIN kund AS k ON k.id = kund_id WHERE bestallning_id = order_number;
END
;;
DELIMITER ;




DROP PROCEDURE IF EXISTS get_invoice_product_info;
DELIMITER ;;
CREATE PROCEDURE get_invoice_product_info(IN order_number INT)
BEGIN
    SELECT p.produktkod, p.pris, bp.antal,
        SUM(p.pris * bp.antal) AS totalt
        FROM faktura 
            JOIN bestallning AS b ON b.id = faktura.bestallning_id
            JOIN bestallning_produkt AS bp ON bp.bestallning_id = b.id
            JOIN produkt AS p ON p.produktkod = bp.produktkod
            JOIN kund AS k ON k.id = kund_id WHERE faktura.bestallning_id = order_number
        GROUP BY bp.antal, p.produktkod, faktura.id;
END
;;
DELIMITER ;



DROP PROCEDURE IF EXISTS pay_invoice;
DELIMITER ;;
CREATE PROCEDURE pay_invoice(IN invoice_number INT, betal_datum DATE)
BEGIN
    UPDATE faktura 
        SET betald = betal_datum
    WHERE faktura.id = invoice_number
    ;
    
END
;;
DELIMITER ;

