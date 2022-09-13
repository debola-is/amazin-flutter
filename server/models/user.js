const mongoose = require('mongoose');

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
                return val.toLowerCase().match(reg);
            },
            message: "Please enter a valid email address"
        }
    },
    password: {
        type: String,
        required: true,
        validate: {
            validator: (val)=>{
                return val.length > 7 //pretty basic password validation, lol.
            },
            message: "Password should contain at least 8 characters"
        }
    },
    address: {
        type: String,
        default: "",
    },
    userType: {
        type: String,
        default: "user",
    },
    //cart
});

const User =mongoose.model("User", userSchema);

module.exports = User;