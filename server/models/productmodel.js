const mongoose = require('mongoose');
const ratingSchema = require('./ratting');

const productSchema =  mongoose.Schema({
   name: {
    required: [true, 'Product must have a name'],
    type: String,
    trim: true,
   },
   description: {
    required: [true,'Product must have a descripiton'],
    type: String,
    trim: true,
   },
   price:{
    type: Number,
    required: [true,'Product must have a price'],
   },
   quantity:{
    type: Number,
    required: [true,'Product must have a quantity'],
   },
   images:[
    {
        type: String,
        required: [true,'product must have a image']
    }
   ],
   category:{
    type: String,
    required: [true,'Product must have a category']
   },
   ratings: [ratingSchema]

});

const Product = mongoose.model('Product',productSchema);

module.exports = {Product, productSchema};
