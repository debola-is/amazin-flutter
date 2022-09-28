const express = require('express');
const { default: mongoose } = require('mongoose');
const userRouter = express.Router();
const auth = require('../middlewares/auth_middleware');
const Order = require('../models/order');
const { Product } = require('../models/product_model');
const User = require('../models/user_model');

/*
These are user-specific actions that can only be performeb by an authenticated user
Mostly cart and shopping related actions to be more specific.
Hence, requires auth middleware for all calls.
*/


// Function to add item to cart
// Post request, the Id of the product mut be parsed in the post request body sent by the client.
userRouter.post("/api/user/cart/add-to-cart", auth, async (req, res) => {
    try{
        const {id} = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);
        
        // We are checking if user has any item in their cart, if no item in user cart, we add one number of theproduct to their cart.
        if(user.cart.length == 0) {
            user.cart.push({product, quantity: 1});
        } else {

            // Next, we need to check if the product exists in the user's cart, if yes we increase the quantity in  the cart by one, if no, we add 1 No of the product to the user cart.
            let productExists = false;
            for (let i = 0; i < user.cart.length; i++) {
                if(user.cart[i].product._id.equals(product._id)) {
                    productExists = true;
                }
            }

            if(productExists) {
                let foundProduct = user.cart.find((item) => item.product._id.equals(product._id));
                // We now need to check if the quantity of the product in our store is more than the quantity that the user wants to put in their cart. Obviously, a user shouldn't be able to order 10 apples when we only have 5 in stock for example.
                if (product.quantity > foundProduct.quantity) {
                    foundProduct.quantity += 1;
                } else {
                    return res.status(400).json({error: `Could not add any more of ${product.name}. No more in stock.`});
                }

                
            } else {
                user.cart.push({product, quantity: 1});
            }
        }
        // Not really neccessary but we then save the updated state of the user model.
        user = await user.save();
        // Send the updated user model to the client in the response with a status code of 200.
        res.json(user);

    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});




// Delete request to remove a product from the user's cart
// The id of the product must be parsed as a request parameter "id" in the request url.
// A typical request call url will look like 
// "http://domain-name/api/user/cart/remove-from-cart/prkcmcj1234dmef"
// Where "prkcmcj1234dmef" is the id of the product.
// The request removes a single product from the user cart. i.e. in a situation where user has more than 1No of "product a" in their cart, the quantity of "product a" is reduced by one.
// See below request to remove all of a particular product from cart.
// Also, see below for request to completely clear user cart i.e remove all products.
userRouter.delete("/api/user/cart/remove-from-cart/:id", auth, async (req, res) => {
    try{
        // Get the product Id from the request parameters, find the product in our DB and find the user from our DB by the userID supplied by the auth middleware.
        const id = req.params.id;
        const product = await Product.findById(id);
        let user = await User.findById(req.user);

        // The purpose of finding the product in the DB is to check if the user is trying to make cart modifications to a product that no longer exists in our product database. This situation can occur when a product is deleted in the DB by superuser but a user still has the product in their cart.
        
        // If product no longer exists in our products DB, remove the product from the user cart.
        if (!product) {
            for (let i = 0; i < user.cart.length; i++) {
                if(user.cart[i].product._id.equals(new mongoose.Types.ObjectId(id))) {
                    user.cart.splice(i, 1);
                }
            }
            user = await user.save();
            return res.json(user);
        }
        
        // If product exists in our products DB, reduce quantity or remove products.
        for (let i = 0; i < user.cart.length; i++) {
            if(user.cart[i].product._id.equals(product._id)) {
                if(user.cart[i].quantity == 1) {
                    user.cart.splice(i, 1); // Splice method removes 1 item counting from the index i
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


// In retrospect, I think this request is kinda redundant and completely unneccesary. However,
// Get request that just returns the user details to the client, no request parametes required, the client calling this request just has to pass authentication by auth middleware.
userRouter.get('/api/user/cart/', auth, async (req, res)=>{
    try{
        const user = await User.findById(req.user);
        return res.json(user.cart);
    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});




// Post request that saves the shipping address of the user into the user DB.
// User address must be parsed in the request body.
// Future modification will allow user to have multiple addresses and the UI will allow the user to select a shipping address from the list of presaved addresses in the DB.

userRouter.post('/api/user/shipping/add-shipping-address', auth, async (req, res)=>{
    try{
        const {address} = req.body;
        let user = await User.findById(req.user);
        user.address = address;
        user = await user.save();
        return res.json(user);
    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});



userRouter.post('/api/user/order/create', auth, async (req, res)=>{
    try{
        const {cart, totalPrice, address} = req.body;
        let products = [];

        for(let i=0; i<cart.length; i++) {
            let product = await Product.findById(cart[i].product._id);
            if(product.quantity>= cart[i].quantity) {
                product.quantity -= cart[i].quantity;
                products.push({product, quantity: cart[i].quantity});
                await product.save();
            } else {
                return res.status(400).json({error: `Order could not be created, only ${product.quantity} units of ${product.name} remaining in stock`})
            }
        }

        let user = await User.findById(req.user);
        user.cart = [];
        user = await user.save();
        if (products.length > 0) {
            let order = new Order({
                products,
                totalPrice,
                deliveryAddress: address,
                userId: req.user,
                timeOfOrder: new Date().getTime(),
            });

            order = await order.save();
            res.json(order);
        }
        else {
            return res.status(400).json({error: "Can not create empty order. Add items to cart and try again."});
        }

    }
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});


userRouter.get('/api/user/orders/get', auth,async (req, res)=>{
    try{
        let userOrders = [];
        userOrders = await Order.find({userId: req.user});
        return res.json(userOrders);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
})





module.exports = userRouter;