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
        validate: {
            validator: (val)=>{
                const reg = 
                /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                return val.toLowerCase().match(reg); // match method matches a string against a regex and returns an array with the matches or returns null if no match is found.
            },
            message: "Please enter a valid email address"
        }
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