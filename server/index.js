// Import from package
const express = require("express");
const dotenv = require('dotenv');
const mongoose = require('mongoose');
// const app = require('./app');
// Import from other files 
const authRouter = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/product");
const userRouter = require("./routes/user");
const AppError = require("./utils/appError");

dotenv.config({ path: './config.env' });
//init 
const app = express();
console.log(process.env.DATABASE);
app.use(express.json());
const port = 3000;
const DB = "mongodb+srv://shetu:Shetu7723@cluster0.dgkk0fj.mongodb.net/shopline?retryWrites=true&w=majority"
// const db = "mongodb+srv://shetu:<password>@cluster0.dgkk0fj.mongodb.net/"
app.use((req,res,next) => {
req.reqstTime = new Date().toISOString();
console.log(req.headers);
next();
});

app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


app.all('*', (req, res,next) => {
    // res.status(404).json({
    //     status: 'fail',
    //     message: `can not find the ${req.originalUrl} on the server`
    // })
    // const err = new Error(`can not find the ${req.originalUrl} on the server`);
    // err.statusCode = 404;
    // err.status = 'fail';
    next(new AppError(`can not find the ${req.originalUrl} on the fuckng server`,404));
});

app.use((err, req, res,next) => {
    err.statusCode = err.statusCode || 500;
    err.status = err.status || 'fail';
    res.status(err.statusCode).json({
     status: err.status,
     message: err.message
    });
   
});


mongoose.connect(DB).then(()=>{
    console.log("connection established");
})

app.listen(port,"192.168.56.1",()=>{
   console.log(`server listening on port ${port}`);
})