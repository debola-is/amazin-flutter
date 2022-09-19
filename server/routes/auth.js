const express = require('express');
const User = require('../models/user_model');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth_middleware');


const authRouter = express.Router();

// authRouter.get('/user', (req, res)=>{
//     res.json({user: "Debola"})
// });

/* Signs up a new user and if all goes well, stores the new user in db */
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
        
    const existingUser = await User.findOne({email}); //search for existing user in database
    if(existingUser) {
        return res.status(400).json({msg: "This email address is linked to an existing account."});
    }

    let user = new User({name,email, password: encryptPassword(password),});    // create new user 
    user = await user.save();

    res.json(user);
    } 
    catch(e) {
        return res.status(500).json({error: e.message});
    }
});

/* Sign in existing user and returns jwt signed token in response body */
authRouter.post('/api/signin', async (req, res)=>{
    /**
     * Get login details from request body
     * Check database if user with the entered email exists
     * Sign in user if user exists, deny user access if user doesn't exist
     * Use appropriate status codes and result formatting
     */
    const {email, password} = req.body;

    /* validation to verify post request contains all neccessary inputs */
    if(!email || !password ) {
        return res.status(400).json({
            error: "Incomplete parameters sent!"
        });
    } // 

    try{
        var existingUser = await User.findOne({email});
    if(!existingUser) {
        return res.status(400).json({error: "This email address is not registered. Sign up?"});
    }

    /* Compare hashed password and user plain text password input */
     const validPass = await bcrypt.compare(password,existingUser.password);

     if(!validPass) {
        return res.status(400).json({error: "The password you entered is incorrect!"});
     }
        
    const token = jwt.sign({id: existingUser._id}, "passwordKey");
    return res.json({token, ...existingUser._doc}); //...existingUser.doc is object destructuring shorthand.
    
    }catch(e) {
        return res.status(500).json({error: e.message}); 
    }
    

},);

/* Verify user token supplied in request header and returns true or false based on result of verification */
authRouter.post('/token/validation', async(req, res) =>{
   try {
    const token = req.header('user-auth-token');
    if (!token) return res.json(false);
    const isVerified = jwt.verify(token, "passwordKey");
    if (!isVerified) return res.json(false);

    const user = await User.findById(isVerified.id);
    if(!user) return res.json(false);

    return res.json(true);
   }
   catch(e) {
    res.status(400).json({error: e.message});
   }
})


/* gets user data */
authRouter.get('/', auth, async (req, res)=> {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});	

})


function encryptPassword(password) {
    var salt = bcrypt.genSaltSync(10);
    var hash = bcrypt.hashSync(password, salt);
    return hash;
}




//To user authRouter in other files
module.exports = authRouter;