"use strict";

const mysql = require("promise-mysql");
const config = require("../config/db/eshop.json");

require("console.table");

let db;

// MAIN
(async function () {
    db = await mysql.createConnection(config);

    process.on("exit", () => {
        db.end();
    });
})();


async function showCategories() {
    let sql = `CALL show_categories();`;
    let res;

    res = await db.query(sql);

    return res[0];
}

async function addCategory(newCategory) {
    let sql = `CALL add_category(?);`;

    await db.query(sql, [newCategory]);
}

async function addCategoryToProduct(body) {
    let sql = `CALL add_category_to_product(?, ?);`;

    await db.query(sql, [body.produktkod, body.category]);
}

async function getCategoriesFromProduct(produktkod) {
    let sql = `CALL get_categories_from_product(?);`;
    let res;

    res = await db.query(sql, [produktkod]);

    return res[0];
}


async function getProductsFromCategory(category) {
    let sql = `CALL get_products_from_category(?);`;
    let res;

    res = await db.query(sql, [category]);

    return res[0];
}


async function showProductsAvailable() {
    let sql = `CALL show_products_available();`;
    let res;

    res = await db.query(sql);

    for (const row of res[0]) {
        if (row.antal == null) {
            row.antal = 0;
        }
    }

    return res[0];
}


async function createProduct(data) {
    let sql = `CALL create_product(?, ?, ?, ?, ?);`;

    await db.query(sql,
        [data.produktkod, data.namn, data.beskrivning, data.pris, data.kategori]);
}


async function getProduct(id) {
    let sql = `CALL get_product(?);`;
    let res;

    res = await db.query(sql, [id]);
    return res[0];
}

async function updateProduct(data) {
    let sql = `CALL update_product(?, ?, ?, ?, ?);`;
    let res;

    res = await db.query(sql,
        [data.produktkod, data.namn, data.beskrivning, data.pris, data.kategori]);
    return res[0];
}

async function deleteProduct(data) {
    let sql = `CALL delete_product(?);`;

    await db.query(sql, [data.produktkod]);
}


// CLI

async function showLogRows(rows) {
    let sql = `CALL show_log_rows(?);`;
    let res;

    res = await db.query(sql, [rows]);
    console.table(res[0]);
}

async function showShelves() {
    let sql = `CALL show_shelves();`;
    let res;

    res = await db.query(sql);
    console.table(res[0]);
}

async function showInventory() {
    let sql = `CALL inventory();`;
    let res;

    res = await db.query(sql);
    console.table(res[0]);
}

async function showInventoryBySearch(search) {
    let sql = `CALL inventory_like(?);`;
    let res;
    let like = `%${search}%`;

    res = await db.query(sql, [like]);
    console.table(res[0]);
}

async function addProductAmountToShelf(productid, shelf, amount) {
    let sql = `CALL update_amount_product_shelf(?, ?, ?);`;
    let res;

    res = await db.query(sql, [shelf, productid, amount]);

    if (res.affectedRows > 0) {
        console.log('UPDATE ADD');
        console.log(`You added ${amount} products with productid ${productid} to shelf ${shelf}. `);
    }
}

async function deleteAmountProductShelf(productid, shelf, amount) {
    let sql = `CALL delete_amount_product_shelf(?, ?, ?);`;
    let res;

    res = await db.query(sql, [shelf, productid, amount]);

    if (res.affectedRows > 0) {
        console.log('UPDATE REDUCE');
        console.log(
            `You removed ${amount} products with productid ${productid} of shelf ${shelf}. `);
    }
}

async function orderSearch(search) {
    let sql = `CALL search_order(?);`;
    let res;
    let like = `%${search}%`;

    res = await db.query(sql, [like]);
    console.table(res[0]);
}

async function logOrders() {
    let sql = `CALL get_orders();`;
    let res;

    res = await db.query(sql);

    console.table(res[0]);
}



async function getPicklist(orderId) {
    let sql = `CALL picklist_get_order(?);`;
    let res;

    res = await db.query(sql, [orderId]);

    console.table(res[0]);

    for (const row of res[0]) {
        if (row.antal_bestallda > row.lagerstatus) {
            let missing =  row.antal_bestallda - row.lagerstatus;

            console.log(`Kunden har beställt ${row.antal_bestallda} ${row.produktkod}`
            + ` men det saknas ${missing} stycken.\n`);

            row.errorMessage = `Kunden har beställt ${row.antal_bestallda} ${row.produktkod}`
            + ` men det saknas ${missing} stycken.`;
        }
    }

    return res;
}


async function shipOrder(orderId) {
    let sql = `CALL ship_order(?)`;

    await db.query(sql, [orderId]);

    console.log(`Order ${orderId} är nu skickat från lagret.`);
}

// SLUT CLI.js

async function getCustomers() {
    let sql = `call get_customers();`;
    let res;

    res = await db.query(sql);
    return res[0];
}


async function getOrders() {
    let sql = `CALL get_orders();`;
    let res;

    res = await db.query(sql);

    return res[0];
}


async function getOrder(id) {
    let sql = `CALL get_order(?);`;
    let res;

    res = await db.query(sql, [id]);

    return res[0];
}


async function createOrder(id) {
    let sql = `CALL create_order(?);`;
    let res;

    res = await db.query(sql, [id]);

    return res[0];
}


async function getProducts() {
    let sql = `CALL get_products()`;
    let res;

    res = await db.query(sql);

    return res[0];
}


async function addProductToOrder(data) {
    let sql = `CALL add_product_order(?, ?, ?)`;
    let res;

    res = await db.query(sql, [data.produktkod, data.orderId, data.antal]);

    return res[0];
}

async function sendOrder(orderId) {
    let sql = `CALL send_order(?)`;
    let res;

    res = await db.query(sql, [orderId]);

    return res[0];
}


async function getOrderStatus(orderId) {
    let sql = `CALL get_order_status(?)`;
    let res;

    res = await db.query(sql, [orderId]);

    return res[0];
}


async function getLatestOrders() {
    let sql = `CALL latest_orders()`;
    let res;

    res = await db.query(sql);

    return res[0];
}


async function searchOrders(search) {
    let sql = `CALL search_orders(?);`;
    let res;
    let like = `%${search}%`;

    res = await db.query(sql, [like]);

    return res[0];
}

async function getInvoices() {
    let sql = `CALL get_invoices();`;
    let res;

    res = await db.query(sql);

    return res[0];
}


async function getInvoiceOverview(orderNumber) {
    let sql = `CALL get_invoice_overview(?);`;
    let res;

    res = await db.query(sql, [orderNumber]);

    return res[0];
}

async function getInvoiceProductInfo(orderNumber) {
    let sql = `CALL get_invoice_product_info(?);`;
    let res;

    res = await db.query(sql, [orderNumber]);

    return res[0];
}

async function payInvoiceOnDate(invoiceId, date) {
    let sql = `CALL pay_invoice(?, ?);`;

    await db.query(sql, [invoiceId, date]);
}



module.exports = {
    showCategories: showCategories,
    showProductsAvailable: showProductsAvailable,
    createProduct: createProduct,
    getProduct: getProduct,
    updateProduct: updateProduct,
    deleteProduct: deleteProduct,
    showLogRows: showLogRows,
    showShelves: showShelves,
    showInventory: showInventory,
    showInventoryBySearch: showInventoryBySearch,
    addProductAmountToShelf: addProductAmountToShelf,
    deleteAmountProductShelf: deleteAmountProductShelf,
    getCustomers: getCustomers,
    getOrders: getOrders,
    getOrder: getOrder,
    createOrder: createOrder,
    getProducts: getProducts,
    addProductToOrder: addProductToOrder,
    sendOrder: sendOrder,
    orderSearch: orderSearch,
    logOrders: logOrders,
    getPicklist: getPicklist,
    shipOrder: shipOrder,
    getOrderStatus: getOrderStatus,
    getLatestOrders: getLatestOrders,
    searchOrders: searchOrders,
    getProductsFromCategory: getProductsFromCategory,
    addCategory: addCategory,
    addCategoryToProduct: addCategoryToProduct,
    getCategoriesFromProduct: getCategoriesFromProduct,
    getInvoices: getInvoices,
    getInvoiceOverview: getInvoiceOverview,
    getInvoiceProductInfo: getInvoiceProductInfo,
    payInvoiceOnDate: payInvoiceOnDate

};
