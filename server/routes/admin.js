const express = require("express");
const adminRouter = express.Router();
// const adminAuthMiddleware = require("../middleware/admin_middleware.js");
const admin = require("../middleware/admin_middleware.js");
const { Product } = require("../models/productmodel");
const Order = require("../models/order");

// adminRouter.post('/admin/add-products', admin, async (req, res) => {
//   try {
// const product = await Product.create({
//   name: req.body.name,
//   description: req.body.description,
//   price: req.body.price,
//   quantity:req.body.quantity,
//   images:req.body.images,
//   category:req.body.category,
// });

// res.status(201).json({
//     status: 'success',
//     data : {
//         product
//     }
// })

//   } catch (err) {
//     res.status(404).json({ message: err.message });
//   }
// });

adminRouter.post("/admin/add-product", admin, async (req, res) => {
  try {
    //   const { name, description, images, quantity, price, category } = req.body;
    //   let product = new Product({
    //     name,
    //     description,
    //     images,
    //     quantity,
    //     price,
    //     category,
    //   });
    //   product = await product.save();
    //   res.json(product);
    const product = await Product.create({
      name: req.body.name,
      description: req.body.description,
      price: req.body.price,
      quantity: req.body.quantity,
      images: req.body.images,
      category: req.body.category,
    });

    res.status(201).json({
      status: "success",
      data: {
        product,
      },
    });
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
});
// get all products
adminRouter.get("/admin/all-product/", admin, async (req, res) => {
  try {
    const products = await Product.find();
    res.status(200).json({
      status: "success",
      results: products.length,
      data: {
        products,
      },
    });
  } catch (err) {
    res.status(500).json({
      status: "failed",
      message: err.message,
    });
  }
});

// delete product
adminRouter.delete("/admin/all-product/:Id", admin, async (req, res) => {
  try {
    console.log(req.params);
    await Product.findByIdAndDelete(req.params.Id);
    const product = await Product.find();
    res.status(200).json({
      status: "success",
      result: product.length,
    });
  } catch (err) {
    res.status(500).json({
      status: "failed",
      message: err.message,
    });
  }

  res.status(404);
});

adminRouter.get("/api/admin-get-all-orders", admin, async (req, res) => {
  try {
    const order = await Order.find({});
    res.json(order);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

adminRouter.post("/admin/change-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    if (status < 4) {
      let order = await Order.findById(id);
      order.status = status;
      order = await order.save();
      res.json(order);
    } else {
      res.status(404).json({ message: "you limit your status Number" });
    }
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

adminRouter.get("/admin/analytics", admin, async (req, res) => {
  try {
    let totalEarnings = 0;
    const order = await Order.find({});
    for (let i = 0; i < order.length; i++) {
      for (let j = 0; j < order[i].products.length; j++) {
        totalEarnings =
          totalEarnings +
          order[i].products[j].product.price * order[i].products[j].quantity;
      }
    }

    const mobileEarnings =await fetchCategoryWiseProduct("Mobiles");
    const fashionEarnings =await fetchCategoryWiseProduct("Fashion");
    const appliancesEarnings =await fetchCategoryWiseProduct("Appliances");
    const booksEarnings =await fetchCategoryWiseProduct("Books");
    const essentialseEarnings =await fetchCategoryWiseProduct("Essentials");

    let earnings = {
      totalEarnings,
      mobileEarnings,
      fashionEarnings,
      appliancesEarnings,
      booksEarnings,
      essentialseEarnings,
    };

    res.json(earnings);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earnings = 0;
  const categoryOrder = await Order.find({
    "products.product.category": category,
  });
  for (let i = 0; i < categoryOrder.length; i++) {
    for (let j = 0; j < categoryOrder[i].products.length; j++) {
      earnings =
        earnings +
        categoryOrder[i].products[j].product.price * categoryOrder[i].products[j].quantity;
    }
  }
  return earnings;
}

module.exports = adminRouter;
