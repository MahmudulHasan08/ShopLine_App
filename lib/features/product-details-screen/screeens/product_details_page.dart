import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/common/widgets/custom_button.dart';
import 'package:shopline_app/common/widgets/rate_product.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/cart/services/cart_services.dart';
import 'package:shopline_app/features/product-details-screen/services/product_details_services.dart';
import 'package:shopline_app/features/search/screens/search_page.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class ProudctDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final ProductModel product;
  const ProudctDetailsScreen({super.key, required this.product});

  @override
  State<ProudctDetailsScreen> createState() => _ProudctDetailsScreenState();
}

class _ProudctDetailsScreenState extends State<ProudctDetailsScreen> {
  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  CartServices cartServices = CartServices();
  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }
  double myRating = 0;
  double avgRating = 0;
  @override
  void initState() { 
    
    super.initState();
    double totalRating = 0;
    for(int i=0; i<widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if(widget.product.rating![i].userId == Provider.of<UserProvider>(context,listen: false).user.id){
        myRating = widget.product.rating![i].rating;
      }
    }
    if(totalRating != 0){
      avgRating = totalRating / widget.product.rating!.length;
    }
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15.w,
                  ),
                  height: 42.h,
                  child: Material(
                    borderRadius: BorderRadius.circular(7.r),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: EdgeInsets.only(left: 6.w),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23.w,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.only(top: 10.h),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.r),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7.r),
                            borderSide:
                                BorderSide(color: Colors.black12, width: 1.h)),
                        hintText: 'ShopLine.in',
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                child: Icon(Icons.mic, color: Colors.black, size: 25.w),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(widget.product.id!),
                  ),
                  RattingProduct( rating: avgRating,
                    size: 15.w,
                  ),
                ],
              ),
            ),
            height(15.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text(
                widget.product.name,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            height(5.h),
            CarouselSlider(
              options: CarouselOptions(
                height: 300.h,
                viewportFraction: 1,
                autoPlay: true,
              ),
              items: widget.product.images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Image.network(
                        image,
                        height: 200.h,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            height(5.h),
            Divider(
              thickness: 4.w,
              color: Colors.black12,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Text.rich(TextSpan(children: [
                TextSpan(
                  text: 'Deal Price: ',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                ),
                TextSpan(
                    text: '\$${widget.product.price}',
                    style: TextStyle(color: Colors.red, fontSize: 18.sp))
              ])),
            ),
            Container(
              padding: EdgeInsets.all(10.w),
              child: Text(
                widget.product.description,
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            ),
            height(5.h),
            Divider(
              thickness: 4.w,
              color: Colors.black12,
            ),
            height(5.h),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: CustomButton(
                  text: "Buy Now", color: Colors.green.shade400, onTap: () {}),
            ),
            height(10.h),
            Padding(
              padding: EdgeInsets.all(10.w),
              child: CustomButton(text: "Add to Cart", onTap: ()  {
                // cartServices.addToCart1(context,widget.product);
                // cartServices.addToCart(context: context, product: widget.product);
                cartServices.addToCart(context: context, product: widget.product);
                print('add to cart');
                
              }),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Rate The Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: RatingBar.builder(
                  // glowColor: Colors.red,

                  maxRating: 5,
                  allowHalfRating: true,
                  initialRating: myRating,
                  itemSize: 32.w,
                  minRating: 1,
                  itemPadding: EdgeInsets.only(right: 10.w),
                  itemBuilder: (context, _) {
                    return const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    );
                  },
                  onRatingUpdate: (rating) {
                    productDetailsServices.rateProduct1(
                        context: context,
                        product: widget.product,
                        rating: rating);
                    setState(() {});
                    // print(ratting);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
