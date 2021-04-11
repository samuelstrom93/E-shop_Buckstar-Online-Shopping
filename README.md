# E-shop - Buckstar-Online-Shopping

En e-shop som bland annat säljer kaffemuggar, kaffepryler och även lite te-prylar.

Projektet har ett stort fokus på programmering mot databaser både mot en webbklient men också en terminalbaserad klient. 

## Tekniker

De tekniker som använts är applikationsservern Express.js i Node.js som använts mot databasen MySQL. För att rendera resultat i webbklienten har templatemotorn EJS använts.


### SQL

För att spara mockdata har jag använt CSV-filer och sedan infogat det direkt i från dessa för att både testa och göra det hela mer verklighetstroget.

I projektet har databashanteraren MySQL använts. För att kapsla in SQL-koden har API:et anropat procedurer i databasen.

I e-shopens databas finns det bland annat tabeller för en logg, beställningar och faktura. Där har jag med fördel kunnat jobba med *triggers* och *funktioner* för en smidigare hantering.

Jag har även jobbat lagt till index i tabellerna för att jobba med prestandan.



**Trigger** som uppdaterar en logg ifall en ny produkt läggs till i databasen.
```
CREATE TRIGGER logg_produkt_insert
AFTER INSERT
ON produkt FOR EACH ROW
    INSERT INTO logg (`händelse`)
        VALUES(CONCAT('Ny produkt lades till med produktkod ', NEW.produktkod, '.'));
```


**Funktion** som returnerar relevant status på fakturan beroende på om kunden har betalat eller inte.
```
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

```

**Procedur** för att visa upp tillgängliga produkter med bland annat *GROUP_CONCAT()* för att visa om produkten har flera kategorier.
```
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
```

### Webbklient

I webbklienten kan man bland annat lägga till produkter i databasen, hitta varor i respektive kategori, lägga en beställning samt hantera beställning. Det finns även en logg för viktiga händelser som sker i e-shopen samt en länk för att få en översikt över befintliga fakturor och bland annat deras betalstatus samt klicka sig vidare till fakturan och se viktig information såsom kund-id, beställningsnummer, beställda varor, betalstatus och totala beloppet att betala.

### Terminalbaserad klient med meny

Den terminalbaserad klienten har kunnat återanvända de metoder som webbklienten använts sig av för att skapa mer DRY-kod. 

I terminalen finns det meny som hjälper en att förstå hur den ska användas. I den terminalbaserade klienten kan man bland annat se hur lagret ser ut, skapa en plocklista för en beställning, skicka iväg en order, betala en faktura samt söka i loggen.


**Från terminalen**
```
Enter something: menu
 You can choose from the following commands.
  exit, quit, ctrl-d - to exit the program.
  help, menu - to show this menu.
  log <number>      - shows <number> of rows in log for products.
  shelf             - shows products that is available in stock.
  inventory         - show table over where in stock products are.
  inventory <str>   - as above but with str as an optional search function .
  invadd <produktkod> <shelf> <number> - adds <number> products of <produktkod> to <shelf>.
  invdel <produktkod> <shelf> <number> - removes <number> products of <produktkod> on <shelf>.
 - order <search>    - searches for order that matches <search> or if left empty will write out all orders .
 - picklist <orderid> - writes out a picklist for chosen orderid.
 - ship <orderid>    - ships chosen orderid.
 - author            - writes out author of the work.
 - logsearch <str>   - searches for <str> in log.
 - payed <invoiceid> <date>    - pays invoice <invoiceid> on <date> - date-format is YYYYMMDD.
```

**Funktion för att köra respektive kommando**
```
(async function() {
    const rl = readline.createInterface({
        input: process.stdin,
        output: process.stdout
    });

    rl.setPrompt("Enter something: ");
    rl.prompt();

    rl.on("close", exitProgram);
    rl.on("line", async (input) => {
        input = input.trim();

        let lineArray = input.split(" ");

        switch (lineArray[0]) {
            case "quit":
            case "exit":
                exitProgram();
                break;
            case "help":
            case "menu":
                showMenu();
                break;
            case "log":
                await eshop.showLogRows(lineArray[1]);
                break;
            case "shelf":
                await eshop.showShelves();
                break;
            case "inventory":
                lineArray[1] === undefined ? await eshop.showInventory()
                    : await eshop.showInventoryBySearch(lineArray[1]);
                break;
            case "invadd":
                await eshop.addProductAmountToShelf(lineArray[1], lineArray[2], lineArray[3]);
                break;
            case "invdel":
                await eshop.deleteAmountProductShelf(lineArray[1], lineArray[2], lineArray[3]);
                break;
            case "order":
                lineArray[1] === undefined ? console.table(await eshop.logOrders())
                    : await eshop.orderSearch(lineArray[1]);
                break;
            case "picklist":
                await eshop.getPicklist(lineArray[1]);
                break;
            case "ship":
                await eshop.shipOrder(lineArray[1]);
                break;
            case "logsearch":
                console.table(await eshop.searchOrders(lineArray[1]));
                break;
            case "payed":
                await eshop.payInvoiceOnDate(lineArray[1], lineArray[2]);
                break;
            case "about":
                authorOfWork();
                break;
            default:
                showMenu();
                break;
        }
        rl.prompt();
    });
})();



