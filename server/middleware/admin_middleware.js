const jwt = require ('jsonwebtoken');
const AppError = require('../utils/appError');
const User = require('../models/usermodel');

const admin = async (req,res,next)=> {
 try{
    const token = req.header('x-auth-token');
    if(!token){
       return next(new AppError('No token,Access denied'),401);
    }
    
    const verify = jwt.verify(token,process.env.JWT_SECRET);
    if(!verify){
       return next(new AppError('Invalid token,Aceess denied'),401);
    }
    const user =await User.findById(verify.id);
    if(user.type == 'user' && user.type == 'seller'){
       return next(new AppError('You are not Admin '),401);
    }
    req.token = token;
    req.id = verify.id;
    next();
 }catch(e){
   res.status(401).json({
    status: 'failed',
    message: e.message,
   })
 }
}

module.exports = admin;

// const jwt = require("jsonwebtoken");
// const User = require("../models/usermodel");

// const admin = async (req, res, next) => {
//   try {
//     const token = req.header("x-auth-token");
//    //  const token = req.headers.token;
//     if (!token)
//       return res.status(401).json({ msg: "No auth token, access denied" });

//     const verified = jwt.verify(token, process.env.JWT_SECRET);
//     if (!verified)
//       return res
//         .status(401)
//         .json({ msg: "Token verification failed, authorization denied." });
//     const user = await User.findById(verified.id);
//     if (user.type == "user" || user.type == "seller") {
//       return res.status(401).json({ msg: "You are not an admin!" });
//     }
//     req.user = verified.id;
//     req.token = token;
//     next();
//   } catch (err) {
//     res.status(500).json({ error: 'fuck' });
//   }
// };

// module.exports = admin;