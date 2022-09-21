const express = require('express');
const productRouter = express.Router();
const Product = require('../models/product_model');

/* Gets all product for category parsed in through request parameter 
Note: The value of "category" is case sensitive
*/
productRouter.get("/api/products/:category", async (req, res)=>{
    const category = req.params.category;
    if(!category){
        return res.status(400).json({error: "Bad request parameters!"});
    }
    try{
        const categoryPproducts = await Product.find({category});
        return res.json(categoryPproducts);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }

});

module.exports = productRouter;