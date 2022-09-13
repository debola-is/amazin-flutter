const express = require('express');


const authRouter = express.Router();

// authRouter.get('/user', (req, res)=>{
//     res.json({user: "Debola"})
// });

authRouter.post('/api/signup', (req,res)=>{
    const {name, email, password} = req.body;

    if(!name || !email || !password ) {
        return res.status(400).json({
            Error: "Incomplete parameters sent!"
        })
    }
    /**
     * Get data from the client
     * Post the dat in db
     * return the posted data for the user (so we can save the data on the client side)
     */
});


//To user authRouter in other files
module.exports = authRouter;