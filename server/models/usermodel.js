const mongoose = require("mongoose");
const bycript = require('bcryptjs');
// const { productSchema } = require("./product");
const  { productSchema } = require('./productmodel');

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
    trim: true,
  },
  email: {
    required: true,
    type: String,
    trim: true,
    validate: {
      validator: (value) => {
        const re =
          /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
        return value.match(re);
      },
      message: "Please enter a valid email address",
    },
  },
  password: {
    required: true,
    type: String,
    select: false
  },
  address: {
    type: String,
    default: "",
  },
  type: {
    type: String,
    default: "user",
  },
  cart: [
    {
      product: productSchema,
      quantity:{
        type: Number,
        required: true
      },
    },
  ]


});

userSchema.pre('save', async function (next){
  // when the password is modified
  if(!this.isModified('password')) return next();
  // Hash the password with cost of 12
  this.password =await bycript.hash(this.password, 12);
  next();

});

userSchema.methods.correctPassword =async function (plainPassword, hashedPassword){
  return await bycript.compare(plainPassword, hashedPassword);
}

const User = mongoose.model("User", userSchema);
module.exports = User;


//---------->

// const mongoose = require("mongoose");
// // const { productSchema } = require("./product");

// const userSchema = mongoose.Schema({
//   name: {
//     required: true,
//     type: String,
//     trim: true,
//   },
//   email: {
//     required: true,
//     type: String,
//     trim: true,
//     validate: {
//       validator: (value) => {
//         const re =
//           /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
//         return value.match(re);
//       },
//       message: "Please enter a valid email address",
//     },
//   },
//   password: {
//     required: true,
//     type: String,
//   },
//   address: {
//     type: String,
//     default: "",
//   },
//   type: {
//     type: String,
//     default: "user",
//   },
//   // cart: [
//   //   {
//   //     product: productSchema,
//   //     quantity: {
//   //       type: Number,
//   //       required: true,
//   //     },
//   //   },
//   // ],
// });

// const User = mongoose.model("User", userSchema);
// module.exports = User;