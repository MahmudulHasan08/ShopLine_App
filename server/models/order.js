const mongoose = require("mongoose");
const { productSchema } = require("./productmodel");

const orderSchema = new mongoose.Schema({
  products: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
      },
    },
  ],
  address: {
   type: String,
   required: true,
  },
  totalPrice: {
    type: Number,
    required: true,
  },
  userId: {
    type: String,
    required: true,
  },
  orderAt: {
    type: Number,
    required: true,
  },
  status: {
    type: Number,
    default: 0,
  },

});

const Order = mongoose.model('Order', orderSchema);

module.exports = Order;



