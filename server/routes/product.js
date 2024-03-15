const express = require("express");
const productRouter = express.Router();
const auth = require("../middleware/auth_middleware");
const { Product } = require("../models/productmodel");

productRouter.get("/api/products", auth.auth, async (req, res) => {
    try {
        console.log(req.query.category);
        const products = await Product.find({ category: req.query.category });
        res.status(200).json({
            'status': 'success',
            'results': products.length,
            'data': {
                products
            }
        });
    } catch (err) {
        res.status(500).json({ 'message': err.message });
    }
});

productRouter.get('/api/products/search/:name', auth.auth, async (req,res) => {
   try{
    const products = await Product.find({
        name: {
            $regex: req.params.name, $options: 'i'
        }
    })
    // const product = await Product.find({
    //     name: {$regex: req.params.name, $options: 'i'}
    // });
    res.status(200).json({
        'status' : 'success',
        "data": {
            products
        }
    })
   }catch(err){
    res.status(500).json({'message': err.message});
   }
}),
productRouter.post('/api/rate-product', auth.auth, async (req, res) => {
   const {id, rating} = req.body;
   let product = await Product.findById(id);
   for(let i =0; i < product.ratings.length; i++ ) {
    if(product.ratings[i].userId == req.userId){
        product.ratings.splice(i, 1);
        break;
    }
   }
   const ratingSchema = {
    userId: req.userId,
    rating
   }
   product.ratings.push(ratingSchema);
   product = product.save();
   res.status(200).json({
    status: 'success',
    data : {
        product: product
    }
   })
  


});

productRouter.get('/api/deal-of-the-day', auth.auth, async (req,res) => {
  try{
    let product = await Product.find({});
    product.sort((productOne,productTwo) => {
      let sumProductOne = 0;
      let sumProductTwo = 0;
     for(let i = 0; i<productOne.ratings.length; i++){
      sumProductOne += productOne.ratings[i].rating;
     }
     for(let i=0; i<productTwo.ratings.length; i++){
      sumProductTwo += productTwo.ratings[i].rating;
     }
    return sumProductOne < sumProductTwo ? 1 : -1;
  
    })

    // product.sort()
//   res.json(product[0]);
    res.status(200).json({
      'status': 'success',
      'product': product[0]
    })
  }catch(err){
   res.status(500).json({'message': err.message});
  }
});

module.exports = productRouter;
