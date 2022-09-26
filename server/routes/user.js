const express = require('express');
const { default: mongoose } = require('mongoose');
const userRouter = express.Router();
const auth = require('../middlewares/auth_middleware');
const { Product } = require('../models/product_model');
const User = require('../models/user_model');


userRouter.post("/api/user/cart/add-to-cart", auth, async (req, res) => {
    try{
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        if(user.cart.length == 0) {
            user.cart.push({product, quantity: 1});
        } else {
            let productExists = false;
            for (let i = 0; i < user.cart.length; i++) {
                if(user.cart[i].product._id.equals(product._id)) {
                    productExists = true;
                }
            }

            if(productExists) {
                let foundProduct = user.cart.find((item) => item.product._id.equals(product._id));

                foundProduct.quantity += 1;
            } else {
                user.cart.push({product, quantity: 1});
            }
        }
        user = await user.save();
        res.json(user);

    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});


userRouter.delete("/api/user/cart/remove-from-cart/:id", auth, async (req, res) => {
    try{
        const id = req.params.id;
        const product = await Product.findById(id);

        
        let user = await User.findById(req.user);

        if (!product) {
            for (let i = 0; i < user.cart.length; i++) {
                if(user.cart[i].product._id.equals(new mongoose.Types.ObjectId(id))) {
                    if(user.cart[i].quantity == 1) {
                        user.cart.splice(i, 1);
                    } else {
                        user.cart[i].quantity -= 1;
                    }
                }
            }
            user = await user.save();
            return res.json(user);
        }

        for (let i = 0; i < user.cart.length; i++) {
            if(user.cart[i].product._id.equals(product._id)) {
                if(user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1);
                } else {
                    user.cart[i].quantity -= 1;
                }
            }
        }

       
        user = await user.save();
        return res.json(user);

    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});




module.exports = userRouter;