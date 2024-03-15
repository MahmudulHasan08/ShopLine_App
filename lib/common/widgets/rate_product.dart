import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class RattingProduct extends StatelessWidget {
  final double size;
  final double? rating;
 
 
   RattingProduct({
    Key? key,
    this.size=30,
     this.rating,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
 
    return RatingBar.builder(
      itemSize: size,
   initialRating: rating!,
   
   minRating: 1,
   direction: Axis.horizontal,
   allowHalfRating: true,
   itemCount: 5,
  //  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
   itemBuilder: (context, _) => const Icon(
     Icons.star,
     color: Colors.amber,
   ),
   onRatingUpdate: (rating) {
     print(rating);
   },
);
  }
}
