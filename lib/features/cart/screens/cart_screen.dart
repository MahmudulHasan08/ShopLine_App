import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/common/widgets/custom_button.dart';
import 'package:shopline_app/common/widgets/rate_product.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/address/screens/address_page.dart';
import 'package:shopline_app/features/cart/services/cart_services.dart';
import 'package:shopline_app/features/home/widgets/address_box.dart';
import 'package:shopline_app/features/search/screens/search_page.dart';
import 'package:shopline_app/features/search/widgets/search_product.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class CartScreen extends StatefulWidget {
  static const String routeName = '/cart';
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartServices cartServices = CartServices();
  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(int totalAmount) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: totalAmount.toString());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    int subTotal = 0;

    user.cart
        .map((e) => subTotal += e['product']['price'] * e['quantity'] as int)
        .toList();
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
        child: user.cart.isEmpty
            ? Expanded(
                child: Column(
               
                children: [
                  height(200.h),
                  Center(
                  
                    child: Text(
                      'No Cart Item in your carts',
                      style:
                    
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
                    ),
                  ),
                ],
              ))
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                addressBox(text: user.name),
                height(10.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "SubTotal ",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          )),
                      TextSpan(
                          text: '\$$subTotal',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ))
                    ],
                  ),
                ),
                height(10.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomButton(
                    text: "Proceed to buy (${user.cart.length} items)",
                    onTap: () {
                      navigateToAddress(subTotal);
                      print('press success');
                    },
                    color: Colors.yellow[700],
                    textColor: Colors.black,
                  ),
                ),
                height(10.h),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: user.cart.length,
                    itemBuilder: (_, index) {
                      final userCart =
                          context.watch<UserProvider>().user.cart[index];
                      final product = ProductModel.fromMap(userCart['product']);
                      final quantity = userCart['quantity'];
                      // var product = products![index];
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
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
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
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
                                      child: const Text(
                                          'Eligible for FREE Shipping'),
                                    ),
                                    Container(
                                      width: 235,
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5),
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
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black12,
                                  ),
                                  child: Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cartServices.removeItemToCart(
                                              context: context,
                                              id: product.id!);
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 1.5),
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: Text(
                                            quantity.toString(),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          cartServices.addToCart(
                                              context: context,
                                              product: product);
                                        },
                                        child: Container(
                                          width: 35,
                                          height: 32,
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    })
              ]),
      ),
    );
  }
}
