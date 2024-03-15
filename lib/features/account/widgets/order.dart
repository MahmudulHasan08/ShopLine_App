import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/common/widgets/loader.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/account/services/account_services.dart';
import 'package:shopline_app/features/account/widgets/single_product.dart';
import 'package:shopline_app/features/address/screens/address_page.dart';
import 'package:shopline_app/features/order/screens/order_details.dart';
import 'package:shopline_app/features/product-details-screen/screeens/product_details_page.dart';
import 'package:shopline_app/models/order_model.dart';

class OrderList extends StatefulWidget {
  const OrderList({super.key});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  AccountServices accountServices = AccountServices();
  List<OrderModel>? myOrder;
  @override
  void initState() {
    super.initState();
    getMyOrder();
  }

  getMyOrder() async {
    myOrder = await accountServices.fetchMyOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Orders',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'See All',
                style: TextStyle(color: GlobalVariables.selectedNavBarColor),
              ),
            ],
          ),
          myOrder == null
              ? const Loader()
              : Container(
                  height: 170.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: myOrder!.length,
                      itemBuilder: (_, index) {
                        // print(myOrder!.length);
                        var order = myOrder![index];
                        return Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, OrderDetailsScreen.routeName,
                                    arguments: order,);
                              },
                              child: singleProduct(
                                  imageUrl: order.products[0].images[0])),
                        );
                      }),
                )
        ],
      ),
    );
  }
}
