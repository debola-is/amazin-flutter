const mongoose = require('mongoose');

// Schema is basically the structure of our user
const userSchema = mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    email: {
        type: String,
        required: true,
        validation: (val)=>{
            const reg = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            return val.tolowercase().match(reg);
        }
    },
    password: {
        type: String,
        required: true,
        validation: "",
    }
});

const userModel =mongoose.Model(user, userSchema);

module.exports = userModel;