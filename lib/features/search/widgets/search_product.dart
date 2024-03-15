import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/common/widgets/rate_product.dart';
import 'package:shopline_app/features/product-details-screen/screeens/product_details_page.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class SearchedProduct extends StatelessWidget {
  final ProductModel product;
  const SearchedProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
       double myRating =0;
    double totalRaing=0;
    double avgRating = 0;
    for(int i=0; i<product.rating!.length; i++){
      totalRaing += product.rating![i].rating;
      if(product.rating![i].userId == Provider.of<UserProvider>(context).user.id){
        myRating = product.rating![i].rating;
      }
      
    }
    if(totalRaing != 0){
      avgRating = totalRaing/product.rating!.length;
    }
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(
                product.images[0],
                fit: BoxFit.contain,
                height: 135,
                width: 135,
              ),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child:  RattingProduct(rating: avgRating,),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${product.price}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text('Eligible for FREE Shipping'),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In Stock',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ),
                
                ],
              ),
            ],
          ),
        ),
          Divider(
                    height: 1,
                    color: Colors.cyan,
                  )
      ],
    );
  }
}