console.log("Hello World!")

const express = require('express');
const PORT   = 3000;
const IP = "0.0.0.0";
const app = express();

app.listen(PORT, IP, () => {
    console.log("connected at port: ", PORT);
});

app.get("/hello-world", (req, res)=>{
    res.send("Hello World")
    })
