
const express = require("express");
const jwt = require("jsonwebtoken");
const bycript = require('bcryptjs');

const authRouter = express.Router();
const authMiddleware = require("./../middleware/auth_middleware.js");
const AppError = require("./../utils/appError");
const User = require("../models/usermodel");

//get all users
authRouter.get('/api/signup', async (req,res) => {

  try{
    const users = await User.find();

    res.status(200).json({
      status: 'success',
      data : {
        users,
      }
    })
  }catch (err){
    res.status(500).json({
      status: 'error',
      message: err.message
    });
  }
 

});

// get single user from database 

authRouter.get('/api/signup/:userId', async (req,res) => {

  try{
    const id = req.params.userId;

    const singleUser = await User.findById(id);
 
    res.status(200).json({
      status: 'success',
      user : singleUser,
    })
  }catch(err){
    res.status(500).json({
      status: 'error',
      message: err.message
    });
  }

});

//get all users 
authRouter.get('/api/users', async (req,res) => {
  const users = await User.find();

  res.status(200).json({
    status: 'success',
    results: users.length,
    data:{
      users
    }
  })

});

//create a new user
authRouter.post('/api/signup',async (req,res)=>{
  console.log(req.body);
  try{
    const email = req.body.email;
    const existingUser = await User.findOne({email});
    if(existingUser){
      return res.status(400).json({msg: "User already exists"});
    }

    const newUser = await User.create({
      name: req.body.name,
      email: req.body.email,
      password: req.body.password
    });
     
    const token = jwt.sign({id : newUser._id}, process.env.jwt_secret,{
      // expiresIn: process.env.JWT_EXPIRES_IN,
      expiresIn: process.env.JWT_EXPIRES_IN
    });
    res.status(201).json({
      status: 'success',
      token,
      createAt: req.reqstTime,
      data: {
        user: newUser
      }
    });
  }catch(err){
    res.status(401).json({
      status: 'danger',
      message: err.message
    })
  }
  // res.send("done");
});

authRouter.post('/api/signin', async (req, res,next) => {
 
  try{
// const email = req.body.email;
  // const password = req.body.password;
  const {email,password} = req.body;

  // 1) check email and password exist or not
  if (!email || !password) return next(new AppError("Please enter your  email and  password",404));
  
 
  // 2) check user exist and password correct or not 
  const user =await User.findOne({email}).select("+password");
  const correct =await user.correctPassword(password, user.password);
  console.log(user.name);
  if(!user || !correct) return next(new AppError('please enter correct email and password'));
 
  // 3) if everything is ok, send the token to client 
  const token =await jwt.sign({id: user._id}, process.env.JWT_SECRET,{
   expiresIn: process.env.JWT_EXPIRES_IN
  });
  res.status(200).json({
   status: 'success',
   token,
   ...user._doc
  });
  }catch(err){
    res.status(401).json({
      status: 'fail',
      message: err.message
     });
  }

});

authRouter.post('/tokenIsValid', async (req,res,next) => {
  // getting a token and check it's there
  const token = req.header('x-auth-token');
  if(!token){
    return res.json(false);
    // next(new AppError('You are not login . please login to get access.',401),);
  }
  // verification token
 const isVarified = jwt.verify(token, process.env.JWT_SECRET);
 if (!isVarified) {
  return res.json(false);
  // next(new AppError('token is not varified ',401));
 }
 // check if user still exists 
 const user = await User.findById(isVarified.id);
 if(!user){
  return res.json(false);
  // next(new  AppError('the user belonging to this user does not exits',401));
 }
 res.json(true);
//  res.status(200).json({
//   ...user._doc,
//   token
//  });

} );

// get the use data from valid token 

authRouter.get('/',authMiddleware.auth,async(req,res) =>{
 const user =await User.findById(req.userId);
 res.status(200).json({
  status: 'success',
  token: req.token,
  ...user._doc,
 
 });
});





// authRouter.post("/api/signup", async (req, res) => {
//    try {
//      const { name, email, password } = req.body;
 
//      const existingUser = await User.findOne({ email });
//      if (existingUser) {
//        return res
//          .status(400)
//          .json({ msg: "User with same email already exists!" });
//      }
 
//    //   const hashedPassword = await bcryptjs.hash(password, 8);
 
//    //   let user = new User({
//    //     name,
//    //     email,
//    //     password,
//    //   });
//    //   user = await user.save();
//    console.log(req.body);
//    const newUser =await User.create(req.body); 
//      res.json(newUser);
//    } catch (e) {
//      res.status(500).json({ error: e.message });
//    }
//  });

module.exports = authRouter;


//-------->


// const express = require("express");
// const User = require("../models/usermodel");
// const bcryptjs = require("bcryptjs");
// const authRouter = express.Router();
// const jwt = require("jsonwebtoken");
// const auth = require("../middlewares/auth");

// // SIGN UP
// authRouter.post("/api/signup", async (req, res) => {
//   try {
//     const { name, email, password } = req.body;

//     const existingUser = await User.findOne({ email });
//     if (existingUser) {
//       return res
//         .status(400)
//         .json({ msg: "User with same email already exists!" });
//     }

//     const hashedPassword = await bcryptjs.hash(password, 8);

//     let user = new User({
//       email,
//       password: hashedPassword,
//       name,
//     });
//     user = await user.save();
//     res.json(user);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

// // Sign In Route
// // Exercise
// authRouter.post("/api/signin", async (req, res) => {
//   try {
//     const { email, password } = req.body;

//     const user = await User.findOne({ email });
//     if (!user) {
//       return res
//         .status(400)
//         .json({ msg: "User with this email does not exist!" });
//     }

//     const isMatch = await bcryptjs.compare(password, user.password);
//     if (!isMatch) {
//       return res.status(400).json({ msg: "Incorrect password." });
//     }

//     const token = jwt.sign({ id: user._id }, "passwordKey");
//     res.json({ token, ...user._doc });
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

// authRouter.post("/tokenIsValid", async (req, res) => {
//   try {
//     const token = req.header("x-auth-token");
//     if (!token) return res.json(false);
//     const verified = jwt.verify(token, "passwordKey");
//     if (!verified) return res.json(false);

//     const user = await User.findById(verified.id);
//     if (!user) return res.json(false);
//     res.json(true);
//   } catch (e) {
//     res.status(500).json({ error: e.message });
//   }
// });

// // get user data
// authRouter.get("/", auth, async (req, res) => {
//   const user = await User.findById(req.user);
//   res.json({ ...user._doc, token: req.token });
// });

// module.exports = authRouter;