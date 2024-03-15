const jwt = require('jsonwebtoken');
const AppError = require('../utils/appError');

exports.auth = async (req,res,next)=>{
  const token = req.header('x-auth-token');
  if(!token){
    next(new AppError('no token. access denied',401));
  }
  const verify = jwt.verify(token,process.env.JWT_SECRET);
  if (!verify) {
    next(new AppError('token verification failed , access denied', 401));
  }
  req.userId = verify.id;
  req.token = token;
  next();
}