const express = require('express');
const productRouter = express.Router();
const Product = require('../models/product_model');
const auth = require('../middlewares/auth_middleware');

/* Gets all product for category parsed in through request parameter 
Note: The value of "category" is case sensitive
*/
productRouter.get("/api/products/:category", async (req, res)=>{
    const category = req.params.category;
    if(!category){
        return res.status(400).json({error: "Bad request parameters!"});
    }
    try{
        const categoryProducts = await Product.find({category});
        return res.json(categoryProducts);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }

});


productRouter.get("/api/products/search/:searchQuery", async (req, res)=>{
    
    const query= req.params.searchQuery;
    
    try{
        const products = await Product.find({
            name: {$regex: query, 
            $options: "i"},
        });
        return res.json(products);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }

});

productRouter.post("/api/products/rate", auth, async (req, res) => {
    const {id, rating} = req.body;
    if(!rating || !id) {
        res.status(400).json({error: "Bad request"});
    }
    try{
        let product = await Product.findById(id);

        for (let i  = 0; i < product.ratings.length; i++) {
            if(product.ratings[i].userId== req.user) {
                product.ratings.splice(i, 1);
                break;
            }
        }
        const ratingSchema = {
            userId: req.user,
            rating,
        };

        product.ratings.push(ratingSchema);
        product = await product.save();
        res.json(product);
    }
    catch(e){
        return res.status(500).json({error: e.message});
    }

    
})

module.exports = productRouter;