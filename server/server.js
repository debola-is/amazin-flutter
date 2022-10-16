const express = require('express');
const mongoose = require('mongoose');
const adminRouter = require('./routes/admin');
const authRouter= require('./routes/auth');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');
const db = require('./config');

// TODO: Create your own mogodb cluster uri from mongodb.com
// TIP: When connecting to mongodb through clients native driver, use node.js 2.2.12 or older, SVR is probably not working due to Mongoose. 



// For testing on an emulator, the IP adress parmaeter should be used in the 
// app.listen call back.
const PORT   = 3000;
const app = express(); 


/*
 Middlewares & Routers
data moves from Client -> Server -> Client
in order to manipulate the data before sending back to the client, we need to 
use a middleware

Configure server to accept requests through all used routers
*/
app.use(express.json());
app.use(authRouter); 
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


//Database Connnection
mongoose.connect(db).then(()=>{
    console.log("Connection successfull");
}).catch((e)=>{
    console.log("Could not connect to mongodb: \n", e);
});


// app.listen(PORT, IP, () => {
//     console.log("connected at port: ", PORT);
// });

app.listen(PORT, () => {
    console.log("connected at port: ", PORT);
});

