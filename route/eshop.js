// ESHOP

"use strict";

const express = require("express");
const { showCategories } = require("../src/eshop.js");
const router = express.Router();
const eshop = require("../src/eshop.js");

router.get("/index", (req, res) => {
    let data = {
        title: "Welcome | Buckstar Online Shopping",
    };

    res.render("eshop/index", data);
});

// KATEGORIER
router.get("/category", async (req, res) => {
    let data = {
        title: "Category | Buckstar Online Shopping",
    };

    data.res = await eshop.showCategories();

    res.render("eshop/category", data);
});


// LÄGG TILL KATEGORI
router.post("/category", async (req, res) => {
    let data = {
        title: "Category | Buckstar Online Shopping",
    };

    await eshop.addCategory(req.body.newCategory);

    data.res = await eshop.showCategories();

    res.render("eshop/category", data);
});



// BESTÄLLNINGAR
router.get("/order", async (req, res) => {
    let data = {
        title: "Order | Buckstar Online Shopping",
        res: await eshop.getOrders()
    };

    res.render("eshop/order", data);
});

router.get("/order/:id", async (req, res) => {
    let data = {
        title: "Order | Buckstar Online Shopping",
        res: await eshop.getOrder(req.params.id),
        orderNumber: req.params.id,
        productList: await eshop.getProducts(),
        orderStatus: await eshop.getOrderStatus(req.params.id)
    };

    res.render("eshop/chosen-order", data);
});

router.get("/order/picklist/:id", async (req, res) => {
    let data = {
        title: "Picklist | Buckstar Online Shopping",
        res: await eshop.getPicklist(req.params.id),
    };

    res.render("eshop/picklist", data);
});


router.post("/order/add", async (req, res) => {
    await eshop.addProductToOrder(req.body);

    res.redirect(`/eshop/order/${req.body.orderId}`);
});

router.get("/order/send-order/:id", async (req, res) => {
    await eshop.sendOrder(req.params.id);

    res.redirect("/eshop/order");
});


// KUNDER
router.get("/customers", async (req, res) => {
    let data = {
        title: "Customers | Buckstar Online Shopping",
    };

    data.res = await eshop.getCustomers();

    res.render("eshop/customers", data);
});

router.get("/order/create/:id", async (req, res) => {
    await eshop.createOrder(req.params.id);

    res.redirect("/eshop/order");
});


router.get("/product", async (req, res) => {
    let data = {
        title: "Product | Buckstar Online Shopping",
    };

    data.res = await eshop.showProductsAvailable();

    res.render("eshop/product", data);
});


router.get("/product/category/:category", async (req, res) => {
    let data = {
        title: "Category | Buckstar Online Shopping",
        category: req.params.category
    };

    data.res = await eshop.getProductsFromCategory(req.params.category);

    res.render("eshop/chosen-category", data);
});



// CREATE

router.get("/product/create", async (req, res) => {
    let data = {
        title: "Create product | Buckstar Online Shopping",
    };

    res.render("eshop/create", data);
});

router.post("/product/create", async (req, res) => {
    await eshop.createProduct(req.body);


    res.redirect("/eshop/product");
});

// UPDATE

router.get("/product/update/:id", async (req, res) => {
    let data = {
        title: "Update product | Buckstar Online Shopping",
        result: await eshop.getProduct(req.params.id),
        allCategories: await showCategories(),
        currentProductCategories: await eshop.getCategoriesFromProduct(req.params.id)
    };

    res.render("eshop/update.ejs", data);
});


router.post("/product/update", async (req, res) => {
    await eshop.updateProduct(req.body);

    res.redirect("/eshop/product");
});


router.post("/product/category/update", async (req, res) => {
    await eshop.addCategoryToProduct(req.body);

    res.redirect(`/eshop/product/update/${req.body.produktkod}`);
});



// DELETE

router.get("/product/delete/:id", async (req, res) => {
    let data = {
        title: "Delete product | Buckstar Online Shopping",
        result: await eshop.getProduct(req.params.id)
    };

    res.render("eshop/delete", data);
});

router.post("/product/delete", async (req, res) => {
    await eshop.deleteProduct(req.body);

    res.redirect("/eshop/product");
});

// LOGG
router.get("/log", async (req, res) => {
    let data = {
        title: "Logg | Buckstar Online Shopping",
    };

    req.query.search === undefined ? data.logg = await eshop.getLatestOrders() :
        data.logg = await eshop.searchOrders(req.query.search);

    res.render("eshop/log", data);
});

// FAKTURA
router.get("/invoice", async (req, res) => {
    let data = {
        title: "Invoice | Buckstar Online Shopping",
        invoices: await eshop.getInvoices()
    };

    res.render("eshop/invoice", data);
});

// FAKTURA
router.get("/invoice/:id", async (req, res) => {
    let data = {
        title: "Invoice | Buckstar Online Shopping",
        invoiceOverviewInfo: await eshop.getInvoiceOverview(req.params.id),
        invoiceProductinfo: await eshop.getInvoiceProductInfo(req.params.id)
    };

    res.render("eshop/chosen-invoice", data);
});

// ABOUT
router.get("/about", async (req, res) => {
    let data = {
        title: "About | Buckstar Online Shopping",
    };

    res.render("eshop/about", data);
});


module.exports = router;


