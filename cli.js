"use strict";

const readline = require("readline");

const eshop = require("./src/eshop.js");



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



function exitProgram(code) {
    code = code || 0;

    console.info("Exiting with status code " + code);
    process.exit(code);
}

function authorOfWork() {
    console.log("\nDenna sida är skapad av Samuel Ström för kursen"
    + " Databasteknologier för webben på Blekinge Tekniska högskola.\n"
    + "Detta är del 3 av eshopen och är del i de optionella kraven som finns i kursen.\n");
}

function showMenu() {
    console.info(
        ` You can choose from the following commands.\n`
        + `  exit, quit, ctrl-d - to exit the program.\n`
        + `  help, menu - to show this menu.\n`
        + `  log <number>      - shows <number> of rows in log for products.\n`
        + `  shelf             - shows products that is available in stock.\n`
        + `  inventory         - show table over where in stock products are.\n`
        + `  inventory <str>   - as above but with str as an optional search function .\n`
        + `  invadd <produktkod> <shelf> <number>`
        + ` - adds <number> products of <produktkod> to <shelf>.\n`
        + `  invdel <produktkod> <shelf> <number>`
        + ` - removes <number> products of <produktkod> on <shelf>.\n`

        + ` - order <search>    - searches for order that matches <search>`
        + ` or if left empty will write out all orders .\n`
        + ` - picklist <orderid> - writes out a picklist for chosen orderid.\n`
        + ` - ship <orderid>    - ships chosen orderid.\n`
        + ` - author            - writes out author of the work.\n`
        + ` - logsearch <str>   - searches for <str> in log.\n`
        + ` - payed <invoiceid> <date>   `
        + ` - pays invoice <invoiceid> on <date> - date-format is YYYYMMDD.\n`
    );
}

