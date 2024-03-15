import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/common/widgets/loader.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/home/services/home_services.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

class DealOfTheDay extends StatefulWidget {
  const DealOfTheDay({super.key});

  @override
  State<DealOfTheDay> createState() => _DealOfTheDayState();
}

class _DealOfTheDayState extends State<DealOfTheDay> {

  HomeServices homeServices = HomeServices();
  ProductModel? productDealOfDay;
  @override
  void initState() {
    getDealOfTheDay();
    super.initState();
  }

  void getDealOfTheDay() async {
    productDealOfDay = await homeServices.getDealOfTheDay(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      var user = Provider.of<UserProvider>(context).user;
    return productDealOfDay == null
        ? const Loader()
        : productDealOfDay!.name.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Text(
                        'DEAL OF THE DAY',
                        style: TextStyle(fontSize: 20.sp),
                      ),
                    ),
                  ),
                  Image.network(
                    productDealOfDay!.images[0],
                    height: 235.h,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.w, top: 5.h),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '\$${productDealOfDay!.price}',
                      style: TextStyle(fontSize: 18.sp, color: Colors.black87),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(left: 15.w, right: 40.w),
                    child:  Text(
                      user.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: productDealOfDay!.images.map((e) {
                        return Image.network(
                          e,
                          height: 100.h,
                          width: 100.w,
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                    ).copyWith(left: 15.w),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              );
  }
}



