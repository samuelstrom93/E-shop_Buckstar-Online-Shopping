-- Skapa databas
CREATE DATABASE IF NOT EXISTS eshop;

-- Välj vilken databas du vill använda
USE eshop;


-- Skapa en användare user med lösenordet pass och ge tillgång oavsett
-- hostnamn.
CREATE USER IF NOT EXISTS 'user'@'%'
IDENTIFIED
BY 'pass'
;


-- Ge användaren alla rättigheter på alla databaser.
GRANT ALL PRIVILEGES
    ON *.*
    TO 'user'@'%'
;

-- -- Skapa användaren "user" med
-- -- lösenordet "pass" och ge
-- -- fulla rättigheter till databasen "skolan"
-- -- när användaren loggar in från maskinen "localhost"
-- GRANT ALL ON buckstar_online_shopping.* TO user@localhost IDENTIFIED BY 'pass';



-- mysql -uuser -ppass eshop;

