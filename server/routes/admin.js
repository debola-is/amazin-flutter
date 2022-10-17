const express = require('express');
const {Product} = require('../models/product_model');
const Order = require('../models/order');
const adminRouter = express.Router();
const admin = require('../middlewares/admin_middleware');
const mongoose = require('mongoose');

// All requests make use of the admin middleware for admin authentication

/* Add product */

adminRouter.post('/admin/add-product', admin, async (req, res)=>{
    try{
        const {name, description, images, quantity, price, category} = req.body;

        let product = new Product({
            name, description, images, quantity, price, category,
        });

        product = await product.save();
        res.json(product);
    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
}); 

/* Get all products */

adminRouter.get('/admin/get-all-products', admin, async(req, res)=>{
    try{
        const allProducts = await Product.find({});
        res.json(allProducts);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }

});


/* Delete a product, supply productId in query parameters */

adminRouter.delete('/admin/delete-product/:productId', async(req, res)=> {
    const productId = req.params.productId;
    if(!productId) {
        return res.status(400).json({error: "Bad request parameters!"});
    }
    try{
        
        let product = await Product.findByIdAndDelete(productId);

        return res.json({msg: "Product deleted successfully!"});
        
    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});



adminRouter.get('/admin/get-orders', admin, async (req, res)=>{
    try{
        const allOrders = await Order.find({});
        res.json(allOrders);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }
});


adminRouter.post('/admin/order/update-status', admin, async(req, res)=>{
    

    try{
        const {id, status} = req.body;
    let order = await Order.findById(id);
    order.status = status;
    order = await order.save();
    res.json(order);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }
});


adminRouter.get('/admin/analytics', admin, async(req, res)=>{
    try{
        const orders = await Order.find({});

        let totalEarnings = 0;
        for (let i=0; i< orders.length; i++) {
            totalEarnings += orders[i].totalPrice;
        }

        // Get earnings for all categories
        let mobileEarnings = await getCategoryEarnings('Mobiles');
        let essentialsEarnings = await getCategoryEarnings('Essentials');
        let appliancesEarnings = await getCategoryEarnings('Appliances');
        let booksEarnings = await getCategoryEarnings('Books');
        let fashionEarnings = await getCategoryEarnings('Fashion');

        // create all earnings object to be sent to client
        let earnings = {
            totalEarnings,
            mobileEarnings,
            essentialsEarnings,
            appliancesEarnings,
            booksEarnings,
            fashionEarnings,
        }
        res.json(earnings);
    }
    catch(e) {
        return res.status(500).json({error: e.message});  
    }

});

async function getCategoryEarnings(category) {
    let categoryEarnings = 0;
    let categoryOrders = await Order.find({'products.product.category': category});
    

    if(categoryOrders.length > 0) {
        
        for (let i=0; i< categoryOrders.length; i++) {
            for(let j = 0; j< categoryOrders[i].products.length; j++) {
            if(categoryOrders[i].products[j].product.category === category) {
                categoryEarnings+= categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].product.price;
            }  
            }
        } 
    }

    return categoryEarnings;
}

module.exports = adminRouter;