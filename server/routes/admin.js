const express = require('express');
const Product = require('../models/product_model');
const adminRouter = express.Router();
const admin = require('../middlewares/admin_middleware');


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

adminRouter.get('/admin/get-all-products', admin, async(req, res)=>{
    try{
        const allProducts = await Product.find({});
        res.json(allProducts);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }

});

module.exports = adminRouter;