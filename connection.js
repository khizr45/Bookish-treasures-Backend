var mysql = require("mysql");
var con = mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"bookish-treasures"
})

con.connect((error)=>{
    if(error) throw error;
})

module.exports=con;