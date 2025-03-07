const express = require("express");  
const app = express();  

app.get("/", (req, res) => {  
    res.send("Selenium Server is Running");  
});  

app.listen(4444, () => {  
    console.log("Server running on port 4444");  
});
