var mysql = require("mysql2");
var con = mysql.createConnection({
    host:"bl45uisedcenkiwkqlta-mysql.services.clever-cloud.com",
    user:"uhelc1ly83ajbrnk",
    password:"QLn3ZxB16PhJhz4rsRc8",
    database:"bl45uisedcenkiwkqlta"
})

con.connect((error)=>{
    if(error) throw error;
})

module.exports=con;