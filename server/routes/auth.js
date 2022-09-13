const express = require('express');
const User = require('../models/user');
const bcrypt = require('bcryptjs');


const authRouter = express.Router();

// authRouter.get('/user', (req, res)=>{
//     res.json({user: "Debola"})
// });

authRouter.post('/api/signup', async (req,res)=>{
    /**
     * Get data from the client
     * Post the dat in db
     * return the posted data for the user (so we can save the data on the client side)
     */
    const {name, email, password} = req.body;

    if(!name || !email || !password ) {
        return res.status(400).json({
            error: "Incomplete parameters sent!"
        });
    } // perform basic validation to verify post request contains all neccessary inputs


    try{
        
    const existingUser = await User.findOne({email: email}); //search for existing user in database
    if(existingUser) {
        return res.status(400).json({msg: "Email address already registered by another user."});
    }

    let user = new User({name,email, password: encryptPassword(password),});    // create new user 
    user = await user.save();

    res.json(user);
    } 
    catch(e) {
        res.status(500).json({error: e.message});
    }
});


function encryptPassword(password) {
    var salt = bcrypt.genSaltSync(10);
    var hash = bcrypt.hashSync(password, salt);
    return hash;
}


//To user authRouter in other files
module.exports = authRouter;