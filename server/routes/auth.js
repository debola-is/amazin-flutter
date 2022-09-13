const express = require('express');


const authRouter = express.Router();

authRouter.get('/user', (req, res)=>{
    res.json({user: "Debola"})
});

//To user authRouter in other files
module.exports = authRouter;