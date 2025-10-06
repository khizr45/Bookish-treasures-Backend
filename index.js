const con = require("./connection");
const express = require("express");
const cors = require("cors");
const app = express();

app.use(express.json());
app.use(cors({
	origin: '*',
	methods: ['GET','POST','PUT','PATCH','DELETE','OPTIONS'],
	allowedHeaders: ['Content-Type','Authorization']
}));
app.options('*', cors());


var query = "";
var id = 0;

app.post('/auth/Admin', (req, res) => {
    try {
        const { UserName, Password } = req.body;
        query = "select * from admin where username = '" + req.body.UN + "'";
        con.query(query, (error, result) => {
            if (error) throw error
            if (result.lenght === "undefined") {
                return res.status(200).json({ UserName: "", Password: "" });
            } else {
                return res.status(200).json(result);
            }
        })
    } catch (error) {
        console.log("error: ", error)
        return res.status(500).json({ message: "Some error" });
    }
})

app.get('/getBooks', (req, res) => {
    try {
        con.query("select * from book", (error, result) => {
            if (error) throw error
            return res.status(200).json(result);
        })
    }
    catch (error) {
        return res.status(500).json({ message: "Some Error" });
    }
})

app.get('/getPubs', (req, res) => {
    try {
        con.query("select * from publisher", (error, result) => {
            if (error) throw error
            return res.status(200).json(result);
        })
    }
    catch (error) {
        return res.status(500).json({ message: "Some Error" });
    }
})

app.post('/RegisterAdmin', (req, res) => {
    try {
        query = "insert into admin (UserName , Password) values ('" + req.body.UN + "','" + req.body.Pass + "')";
        con.query(query, (error, data) => {
            if (error) throw error
            return res.status(200).json("Successfull");
        })
    }
    catch (err) {
        return res.status(500).json({ message: "some Error" });
    }
})

app.get('/book/genre', (req, res) => {
    try {
        con.query("select distinct(genre) from book", (error, result) => {
            if (error) throw error
            return res.status(200).json(result);
        })
    }
    catch (err) {
        return res.status(500).json({ message: "some error" });
    }
})

app.get('/book/publishers', (req, res) => {
    try {
        con.query("select name from publisher", (error, result) => {
            if (error) throw error
            return res.status(200).json(result);
        })
    }
    catch (err) {
        return res.status(500).json({ message: "some error" });
    }
})

app.post('/Admin/NewPublisher', (req, res) => {
    try {
        con.beginTransaction();
        con.query("select max(publisher_id) as 'Max_id' from publisher", (error, result) => {
            if (error) throw error
            id = result[0].Max_id;
            id++;
            console.log(id);

            con.query("insert into publisher (publisher_id,name,phone_number,email) values (?,?,?,?)", [id, req.body.NewPubName, req.body.NewPubContact, req.body.NewPubEmail], (error, result) => {
                if (error) throw error
                console.log(query);
                con.commit();
                return res.status(200).json("successfull");
            })
        })
    }
    catch (err) {
        con.rollback();
        return res.status(500).json({ message: "some error" });
    }
})

app.post('/Admin/AddBook',(req,res)=>{
    try{
        con.beginTransaction();
        con.query("select publisher_id from publisher where name = ?",[req.body.BookPublisher],(error,result)=>{
            if(error) throw error
            id = result[0].publisher_id;
            let qt = 0;
            if(req.body.BookQuantity){
                qt = req.body.BookQuantity
            }else{
                qt=0;
            }
            con.query("insert into book (book_isbn,title,author,genre,price,quantity,image_source,publisher_id,ebook_source,publication_date) value (?,?,?,?,?,?,?,?,?,?)",
            [req.body.isbn,req.body.title,req.body.author,req.body.BookGenre,req.body.BookPrice,qt,
            req.body.imgSource,id,req.body.ebookSource,req.body.PublishDate],(error,result)=>{
                if(error) throw error
                con.commit();
                return res.status(200).json("successfull");
            })
        })
    }
    catch(error){
        con.rollback();
        return req.status(500).json({message:"some error"})
    }
})

app.post('/GetBook/Isbn',(req,res)=>{
    try{
        const i = req.body.isbn //parseInt(req.body.isbn);
        con.query('select * from book where book_isbn = ?',[i],(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return req.status(500).json({message:"some error"});
    }
})

app.post('/Book/UpdatePrice',(req,res)=>{
    try{
        const p = parseInt(req.body.UpdatePrice);
        const i = parseInt(req.body.isbn);
        con.query('update book set price = ? where book_isbn = ?',[p,i],(error,result)=>{
            if(error) throw error
            return res.status(200).json("successfull");
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.get('/getOrders',(req,res)=>{
    try{
        con.query("SELECT b.payment_id,b.order_id,u.username,u.address,bk.title from booking b join user u on b.username = u.username join book bk on b.book_isbn = bk.book_isbn where b.status = 'P' ",(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.post('/Order/UpdateStatus',(req,res)=>{
    try{
        const O_id = parseInt(req.body.id)
        con.query("update booking set status = 'F' where order_id = ?",[O_id],(error,result)=>{
            if(error) throw error
            return res.status(200).json("successfull");
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.get('/Book/ReOrder',(req,res)=>{
    try{
        con.query('select * from book where quantity<=2',(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"})
    }
})

app.post('/Book/UpdateQty',(req,res)=>{
    try{
        const i = parseInt(req.body.is);
        con.query('select quantity from book where book_isbn = ?',[i],(error,result)=>{
            if(error) throw error
            let q = result[0].quantity;
            q += parseInt(req.body.q);
            con.query('update book set quantity = ? where book_isbn = ?',[q,i],(error,result)=>{
                if(error) throw error
                return res.status(200).json("successfull");
            })
            
        })
    }
    catch(err){
        return res.status(500).json({message:"some error"});
    }
})

app.post('/auth/User',(req,res)=>{
    try{                                                           
        con.query('select username,password from user where username = ?',[req.body.UN],(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.post('/user/register',(req,res)=>{
    try{
        con.beginTransaction();
        con.query('insert into user (name,email,password,address,phone_num,username) values (?,?,?,?,?,?)',
        [req.body.Fname,req.body.Email,req.body.Pass,req.body.Address,req.body.Pno,req.body.UN],(error,result)=>{
            if(error) throw error
            con.commit();
            return res.status(200).json("successfull");
        })
    }
    catch(error){
        con.rollback();
        return res.status(500).json({message:"some error"});
    }
})

app.get('/book/authors',(req,res)=>{
    try{
        con.query("select distinct(author) from book",(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.post('/book/filterGenre',(req,res)=>{
    try{
        if(req.body.selectAuthor === "" || req.body.selectAuthor === "Authors"){
            con.query("select * from book where genre=?",[req.body.value],(error,result)=>{
                if(error) throw error
                return res.status(200).json(result);
            })
        }else{
            con.query("select * from book where genre=? and author=?",[req.body.value,req.body.selectAuthor],(error,result)=>{
                if(error) throw error
                return res.status(200).json(result);
            })
        }
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.post('/book/filterAuthor',(req,res)=>{
    try{
        if(req.body.selectGenre === "" || req.body.selectGenre === "Genres"){
            con.query("select * from book where author=?",[req.body.value],(error,result)=>{
                if(error) throw error
                return res.status(200).json(result);
            })
        }else{
            con.query("select * from book where genre=? and author=?",[req.body.selectGenre,req.body.value],(error,result)=>{
                if(error) throw error
                return res.status(200).json(result);
            })
        }
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.post('/book/search',(req,res)=>{
    try{
        query = "select * from book where title like '%"+req.body.content+"%'";
        con.query(query,(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.post('/Get/Book/Isbn',(req,res)=>{
    try{
        const i = parseInt(req.body.ISBN);
        query = "SELECT book.*,avg_reviews.average_rating FROM book JOIN (SELECT book_isbn,AVG(rating) AS average_rating FROM review GROUP BY book_isbn) AS avg_reviews ON book.book_isbn =avg_reviews.book_isbn where book.book_isbn = ?"
        con.query(query,[i],(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"})
    }
})

app.post('/Get/user/username',(req,res)=>{
    try{
        con.query("select * from user where username = ?",[req.body.UserName],(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"})
    }
})

app.post('/Get/user/orders',(req,res)=>{
    try{
        con.query('select * from booking where username = ?',[req.body.UserName],(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status.json({message:"some error"});
    }
})

app.post('/Cancel/Order',(req,res)=>{
    try{
        con.beginTransaction();
        const o = parseInt(req.body.oi);
        con.query("select quantity,book_isbn from booking where order_id = ?",[req.body.oi],(error,result)=>{
            if(error) throw error
            const qty = result[0].quantity;
            const i = parseInt(result[0].book_isbn);
            con.query("delete from booking where order_id = ?",[req.body.oi],(error,result)=>{
                if(error) throw error
                con.query("update book set quantity = quantity + ? where book_isbn = ?",[qty,i],(error,result)=>{
                    if(error) throw error;
                    con.commit();
                    return res.status(200).json("successfull");
                })
            })
        })
    }
    catch(error){
        con.rollback();
        return res.status(500).json({message:"some error"});
    }
})

app.post("/Get/Book/Review",(req,res)=>{
    try{
        const i = parseInt(req.body.ISBN);
        con.query("select * from review where book_isbn = ?",[i],(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})

app.post("/user/PlaceOrder",(req,res)=>{
    try{
        con.beginTransaction();
        for(let i=0;i<req.body.Book.length;i++){
            const ii = parseInt(req.body.Book[i].Isbn);
            const currDate = new Date();
            const pay_type = req.body.age;
            let pay = 0
            if(pay_type === "VISA"){
                pay = 2;
            }else{
                pay=1;
            }
            let OrderStatus = "";
            let type_id = 0
            let qt = 0;
            if(req.body.Book[i].Book_Type === "P"){
                OrderStatus = "P";
                type_id = 1;
                qt = req.body.Book[i].Quantity;
            }else{
                OrderStatus = "F";
                type_id = 2;
                qt = 0;
            }
            query = "insert into booking (order_date,status,quantity,username,payment_id,book_isbn,type_id) values (?,?,?,?,?,?,?)";
            con.query(query,[currDate,OrderStatus,qt,req.body.user,pay,req.body.Book[i].Isbn,type_id],(error,result)=>{
                if(error) throw error
                con.query("update book set quantity = quantity - ? where book_isbn = ?",[qt,req.body.Book[i].Isbn],(error,result)=>{
                    if(error) throw error
                })
            })
        }
        con.commit();
        return res.status(200).json("successfull");
    }
    catch(error){
        con.rollback();
        return res.status(500).json({message:"some error"});
    }
})

app.post("/user/review",(req,res)=>{
    try{
        con.query("insert into review (rating,description,username,book_isbn) values(?,?,?,?)",[req.body.ratingValue,req.body.reviewContent,req.body.user,req.body.isbn],(error,result)=>{
            if(error) throw error
            return res.status(200).json("successfull");
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"});
    }
})
app.post("/get/user/checkout",(req,res)=>{
    try{
        con.query("select * from user where username = ?",[req.body.user],(error,result)=>{
            if(error) throw error
            return res.status(200).json(result);
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"})
    }
})

app.post('/update/read_flag',(req,res)=>{
    try{
        con.query('update messages set read_flag = 1 where sender = ? and receiver = ?',[req.body.send,req.body.recv],(error,result)=>{
            if(error) throw error
            return res.status(200).json('successfull')
        })
    }
    catch(error){
        return res.status(500).json({message:'some error'})
    }
})

app.get('/all/senders',(req,res)=>{
    try{
        console.log('getting')
        con.query('select distinct sender from messages',(error,result)=>{
            if(error) throw error
            console.log(result)
            return res.status(200).json(result)
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"})
    }
})

app.post('/get/message/history',(req,res)=>{
    try{
        let name = req.body.user
        console.log(name)
        con.query('select * from messages where sender = ? or receiver = ?',[req.body.user,req.body.user],(err,result)=>{
            if(err) throw err
            return res.status(200).json(result)
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"})
    }
})

app.get('/get/unread/messages',(req,res)=>{
    try{
        con.query('SELECT sender, COUNT(*) AS unread_messages FROM messages WHERE read_flag = 0 GROUP BY sender',(err,result)=>{
            if(err) throw err
            return res.status(200).json(result)
        })
    }
    catch(error){
        return res.status(500).json({message:"some error"})
    }
})
const server = app.listen(8000, () => {
    console.log("Listening to 8000");
})


const http = require("http");
const { Server } = require("socket.io");
const { Socket } = require("dgram");
const io = new Server(server, {
    cors: {
      origin: "*",
    },
  });


online_user = {}
io.on('connection' , (socket)=>{

    socket.on('userOnline',(user)=>{
        online_user[user] = socket.id
        console.log(online_user)
    })

    socket.on('userSendMessage',(message,user,receiver)=>{
        const receiver_id = online_user[receiver]
        if(receiver_id){
            io.to(receiver_id).emit('newMess',message,user,receiver)
            io.to(receiver_id).emit('ResetUsers',message,user,receiver)
            console.log(message,user,receiver)
            if(user === 'admin'){
                con.query('insert into messages(message,sender,receiver,timestamp,read_flag) values (?,?,?,CURRENT_TIMESTAMP,?)',[message,user,receiver,1],(error,result)=>{
                    if(error) throw error
                })
            }else{
                con.query('insert into messages(message,sender,receiver,timestamp,read_flag) values (?,?,?,CURRENT_TIMESTAMP,?)',[message,user,receiver,0],(error,result)=>{
                    if(error) throw error
                })
            }
        }else{
            con.query('insert into messages(message,sender,receiver,timestamp,read_flag) values (?,?,?,CURRENT_TIMESTAMP,?)',[message,user,receiver,0],(error,result)=>{
                if(error) throw error
            })
        }
    })

    socket.on('userOffline',(user)=>{
        delete online_user[user]
        console.log(online_user)
    })
})

module.exports = app;