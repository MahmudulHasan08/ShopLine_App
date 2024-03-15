import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/constants/global_variables.dart';

PreferredSize adminAppBar(){
  return PreferredSize(preferredSize: Size.fromHeight(50.h), child: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: 5.w).copyWith(top: 8.h),
            //   child: Image.asset('assets/images/amazon_in.png',height: 40.h,width:120.w, fit: BoxFit.cover,),
            // ),
             Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Text('ShopLine',style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            ),
           Text('Admin',style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600
           ),)

          ],
        ),
      ),);

}