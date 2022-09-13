const express = require('express');

const authRouter = require('./routes/auth')

// For testing on an emulator, the IP adress parmaeter should be used in the 
// app.listen call back.
const PORT   = 3000;
const IP = "0.0.0.0";
const app = express();

// MIddleware


app.listen(PORT, IP, () => {
    console.log("connected at port: ", PORT);
});

app.get("/hello-world", (req, res)=>{
    res.send("Hello World")
    })
