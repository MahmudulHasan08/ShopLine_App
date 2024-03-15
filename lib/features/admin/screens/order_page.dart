import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/common/widgets/loader.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/account/widgets/app_bar.dart';
import 'package:shopline_app/features/account/widgets/single_product.dart';
import 'package:shopline_app/features/admin/services/product_service.dart';
import 'package:shopline_app/features/order/screens/order_details.dart';
import 'package:shopline_app/models/order_model.dart';

class OrderPageAdmin extends StatefulWidget {
  const OrderPageAdmin({super.key});

  @override
  State<OrderPageAdmin> createState() => _OrderPageAdminState();
}

class _OrderPageAdminState extends State<OrderPageAdmin> {
  ProductService productService = ProductService();
  List<OrderModel>? order;
  @override
  void initState() {
    getAllOrders();
    super.initState();
  }

  void getAllOrders() async {
    order = await productService.fetchAllOrders(context: context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: order == null
          ? const Loader()
          : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                        'All Orders',
                        style:
                      
                            TextStyle(fontWeight: FontWeight.w500, fontSize: 20.sp),
                      ),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: order!.length,
                    itemBuilder: (_, index) {
                      var orderProduct = order![index];
                      print(order!.length);
                      return InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, OrderDetailsScreen.routeName, arguments: orderProduct);
                        },
                        child: Padding(
                          padding:  EdgeInsets.all(8.w),
                          child: singleProduct(
                              imageUrl: orderProduct.products[0].images[0]),
                        ),
                      );
                    },
                  ),
              ),
            ],
          ),
    );
  }
}
