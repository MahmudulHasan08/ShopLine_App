import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/common/widgets/custom_button.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/admin/services/product_service.dart';
import 'package:shopline_app/features/search/screens/search_page.dart';

import 'package:shopline_app/models/order_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class OrderDetailsScreen extends StatefulWidget {
  static const String routeName = '/routeName';
  final OrderModel order;
  const OrderDetailsScreen({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  ProductService productService = ProductService();
  navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  int currentStep = 0;
  @override
  void initState() {
    currentStep = widget.order.status;
    super.initState();
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
                              BorderSide(color: Colors.black12, width: 1.h),
                        ),
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
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'View Order Details',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              height(5.h),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5.w,
                  ),
                ),
                child: Column(
                  children: [
                    orderProperty(
                        title: "Order Date:",
                        space: 25,
                        value: widget.order.orderAt.toString()),
                    orderProperty(
                        title: "Order ID:",
                        space: 48,
                        value: widget.order.userId),
                    orderProperty(
                        title: "Order Total:",
                        space: 25,
                        value: widget.order.totalPrice.toString()),
                  ],
                ),
              ),
              height(10.h),
              Text(
                'Purchase Details',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              height(5.h),
              Container(
                padding: EdgeInsets.all(8.w),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5.w,
                  ),
                ),
                child: Row(
                  children: [
                    Image.network(
                      widget.order.products[0].images[0],
                      height: 150.h,
                      width: 85.w,
                      fit: BoxFit.contain,
                    ),
                    width(20.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.order.products[0].name,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                          ),
                        ),
                        height(5.h),
                        Text(
                          "Qty: ${widget.order.quantity.toString()}",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              height(10.h),
              Text(
                'Tracking',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
              ),
              height(5.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                    width: 1.5.w,
                  ),
                ),
                child: Stepper(
                    controlsBuilder: (builder, details) {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .type ==
                          'admin') {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: SizedBox(
                            height: 35,
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                            
                                productService.changeOrderStatus(
                                  context: context,
                                  order: widget.order,
                                  status: details.currentStep + 1,
                                  onSuccess: () {
                                    setState(() {
                                      currentStep++;
                                    });
                                    
                                  },
                                );
                                print("currentStep is ${currentStep}");
                              },
                              style: ElevatedButton.styleFrom(
                                // primary: color,
                                // side: BorderSide(),
                                minimumSize: const Size(double.infinity, 50),
                                backgroundColor: GlobalVariables.secondaryColor,
                              ),
                              child: const Text(
                                "Process Done",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                   
                    currentStep: currentStep,
                    steps: [
                    Step(
                      title: const Text('Pending'),
                      content: const Text(
                        'Your order is yet to be delivered',
                      ),
                      isActive: currentStep > 0,
                      state: currentStep > 0
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Completed'),
                      content: const Text(
                        'Your order has been delivered, you are yet to sign.',
                      ),
                      isActive: currentStep > 1,
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Received'),
                      content: const Text(
                        'Your order has been delivered and signed by you.',
                      ),
                      isActive: currentStep > 2,
                      state: currentStep > 2
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                    Step(
                      title: const Text('Delivered'),
                      content: const Text(
                        'Your order has been delivered and signed by you!',
                      ),
                      isActive: currentStep >= 3,
                      state: currentStep >= 3
                          ? StepState.complete
                          : StepState.indexed,
                    ),
                  ],
                    // steps: [
                    //   Step(
                    //     isActive: currentStep > 0,
                    //     state: currentStep > 0
                    //         ? StepState.complete
                    //         : StepState.indexed,
                    //     title: const Text('Pending'),
                    //     content:
                    //         const Text('Your order is yet to be delivered'),
                    //   ),
                    //   Step(
                    //     isActive: currentStep > 1,
                    //     state: currentStep > 1
                    //         ? StepState.complete
                    //         : StepState.indexed,
                    //     title: const Text('Completed'),
                    //     content: const Text(
                    //         'Your order has been delivered, you are yet to sign.'),
                    //   ),
                    //   Step(
                    //     isActive: currentStep > 2,
                    //     state: currentStep > 2
                    //         ? StepState.complete
                    //         : StepState.indexed,
                    //     title: const Text('Received'),
                    //     content: const Text(
                    //         'Your order has been delivered and signed by you.'),
                    //   ),
                    //   Step(
                    //     isActive: currentStep >= 3,
                    //     state: currentStep >= 3
                    //         ? StepState.complete
                    //         : StepState.indexed,
                    //     title: const Text('Delivered'),
                    //     content: const Text(
                    //         'Your order has been delivered and signed by you!'),
                    //   ),
                    // ]

                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget orderProperty(
      {required String title, required String value, required double space}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
        width(space),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}
