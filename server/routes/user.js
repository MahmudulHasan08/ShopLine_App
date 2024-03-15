const express = require("express");
const userRouter = express.Router();
const authMiddleware = require("../middleware/auth_middleware");
const { Product } = require("../models/productmodel");
const User = require("../models/usermodel");
const Order = require("../models/order");

// userRouter.post("/api/add-to-cart", authMiddleware.auth, async (req, res) => {
//   try{
//    const { id } = req.body;
//   const product = await Product.findById(id);
//   let user = await User.findById(req.userId);

//   if(user.cart.length == 0 ){
//   user.cart.push({ product, quantity:1 });
//   }else {
//      let isProductFound = false;
//     for(let i=0; i<user.cart.length; i++) {
//      if(user.cart[i].product._id.equals(product._id)){
//         isProductFound= true;
//      }
//      if(isProductFound){
//      let productCopy = await user.cart.find((product)=>product.product._id.equals(product.id));
//      productCopy.quantity+=1;
//      }else{
//         user.cart.push({product,quantity:1});
//      }
//     }
//   }
//   user = await user.save();
//   res.json(user);
//   }catch(err){
//    res.status(404).json({'message': err.message});
//   }
// //   user.cart.save();
// });

userRouter.post("/api/add-to-cart", authMiddleware.auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.userId);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
        let producttt = user.cart.find((productt) =>
          productt.product._id.equals(product._id)
        );
        producttt.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

userRouter.delete(
  "/api/remove-to-cart/:id",
  authMiddleware.auth,
  async (req, res) => {
    try {
      const { id } = req.params;
      let user = await User.findById(req.userId);
      const product = await Product.findById(id);
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          if (user.cart[i].quantity == 1) {
            user.cart.splice(i, 1);
          }
          user.cart[i].quantity--;
        }
      }
      user = await user.save();
      res.json(user);
    } catch (err) {
      res.status(404).json({ error: err.message });
    }
  }
);

// save address to user

userRouter.post(
  "/api/sava-address-to-user",
  authMiddleware.auth,
  async (req, res) => {
    try {
      const { address } = req.body;
      let user = await User.findById(req.userId);
      user.address = address;
      user = user.save();
      res.json(user);
    } catch (err) {
      json.status(400).json({ message: err.message });
    }
  }
);

// userRouter.post('/api/order-products', authMiddleware.auth, async (req, res) => {
//   try {
//     const { cart, totalPrice, address} = req.body;
//     let products = [];
//     for(let i = 0; i < cart.length; i++) {
//       let product = await Product.findById(cart[i].product._id);
//       if(product.quantity >= cart[i].quantity){
//         product.quantity -= cart[i].quantity;
//         product.save();
//         products.push({
//           product, quantity: cart[i].quantity
//         })
//      }else {
//       res.status(400).json({message: `${product.name} is out of stock`});
//      }
//      let user = await User.findById(req.userId);
//      user.cart = [];
//      user = await user.save();

//      let order = new Order({
//       products,
//       totalPrice,
//       address,
//       userId: req.userId,
//       orderAt: Date.now(),

//      })
//      order = await order.save();
//      res.json(order);

//     }
//   }catch(err){
//     res.status(500).json({ 'message': err.message});
// }

// });

userRouter.post("/api/order-products", authMiddleware.auth, async (req, res) => {
  /*
products= product, product_quantity,
address,
userId,
create time,
product's total_amount
*/


   
});

userRouter.post("/api/order", authMiddleware.auth, async (req, res) => {
  try {
    const { cart, totalPrice, address } = req.body;
    console.log(cart);
    console.log(cart.length);
    console.log(totalPrice);
    console.log(address);
    let products = [];

    for (let i = 0; i < cart.length; i++) {

      let product = await Product.findById(cart[i].product._id);

      if (product.quantity >= cart[i].quantity) {

        product.quantity -= cart[i].quantity;
        products.push({ product, quantity: cart[i].quantity });
        await product.save();

      } else {
        return res
          .status(400)
          .json({ msg: `${product.name} is out of stock!` });
      }
    }
    console.log(products);
    console.log(products.length);

    let user = await User.findById(req.userId);
    user.cart = [];
    user = await user.save();
    console.log(req.userId);
    

    let order = new Order({
      products,
      totalPrice,
      address,
      userId: req.userId,
      orderAt: new Date().getTime(),
    });
    order = await order.save();
    res.json(order);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});



userRouter.get('/api/user-orders', authMiddleware.auth, async (req, res) => {
   try{
    const userOrder = await Order.find({userId: req.userId});
    res.json(userOrder);
   }catch(err){
      res.status(404).json({message: err.message});
   }
});


module.exports = userRouter;
