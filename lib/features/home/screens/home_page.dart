import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/home/services/home_services.dart';
import 'package:shopline_app/features/home/widgets/address_box.dart';
import 'package:shopline_app/features/home/widgets/appbar.dart';
import 'package:shopline_app/features/home/widgets/carousel_slider.dart';
import 'package:shopline_app/features/home/widgets/top_categories.dart';
import 'package:shopline_app/features/search/screens/search_page.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';

import '../widgets/address_box.dart';
import '../widgets/deal_of_the_day.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
      navigateToSearchScreen (String query){
  Navigator.pushNamed(context, SearchScreen.routeName,arguments: query);
}

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: PreferredSize(preferredSize:  Size.fromHeight(60.h), child: AppBar(
        flexibleSpace: Container(
          decoration:const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
         title: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 15.w,),
                height: 42.h,
                child: Material(
                  borderRadius: BorderRadius.circular(7.r),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: navigateToSearchScreen,
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                        onTap: (){},
                        child: Padding(
                          padding:  EdgeInsets.only(left: 6.w),
                          child: Icon(Icons.search,color: Colors.black,size: 23.w,),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(top: 10.h),
                      border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(7.r),
                         borderSide: BorderSide.none
                      ),
                      enabledBorder:  OutlineInputBorder(
                         borderRadius: BorderRadius.circular(7.r),
                         borderSide: BorderSide(
                          color: Colors.black12,
                          width: 1.h
                         )
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
                margin:  EdgeInsets.symmetric(horizontal: 10.w),
                child:  Icon(Icons.mic, color: Colors.black, size: 25.w),
              ),
          ],
         ), 
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            addressBox(
              text: 'Delivery to ${user.name} - Admin - ${user.address}',
            ),
            height(10.h),
           const TopCategories(),
            carouselSlider(),
            height(15.h),
           const DealOfTheDay(),
          ],
        ),
      ),
    );
  }
}
