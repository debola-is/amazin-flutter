const mongoose = require('mongoose');
const { productSchema } = require('../models/product_model');

// Schema is basically the structure of our user
const userSchema = mongoose.Schema({
    name: {
        required: true,
        type: String,
        trim: true //remove leading and trailing whitespaces
    },
    email: {
        required: true,
        type: String,
        trim: true,
    },
    password: {
        type: String,
        required: true,
    },
    address: {
        type: String,
        default: "",
    },
    userType: {
        type: String,
        default: "user",
    },
    cart: [
        {
           product: productSchema, 
           quantity: {
            type: Number,
            required: true,
           }
        },
    ],
});

const User =mongoose.model("User", userSchema);

module.exports = User;