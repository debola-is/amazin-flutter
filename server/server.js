const express = require('express');
const mongoose = require('mongoose');
const authRouter= require('./routes/auth');

// TODO: Create your own mogodb cluster uri from mongodb.com
// TIP: When connecting to mongodb through clients native driver, use node.js 2.2.12 or older, SVR is probably not working due to Mongoose. 
const db = "mongodb://debola:pingmenot@ac-evsdkma-shard-00-00.zbnsvhm.mongodb.net:27017,ac-evsdkma-shard-00-01.zbnsvhm.mongodb.net:27017,ac-evsdkma-shard-00-02.zbnsvhm.mongodb.net:27017/?ssl=true&replicaSet=atlas-l25laf-shard-0&authSource=admin&retryWrites=true&w=majority"


// For testing on an emulator, the IP adress parmaeter should be used in the 
// app.listen call back.
const PORT   = 3000;
// const IP = "0.0.0.0";
const app = express();


/**
 MIddleware
data moves from CLient -> Server -> Client
in order to manipulate the data before sending back to the client, we need to 
use a middleware
*/
app.use(authRouter); 


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

