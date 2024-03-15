import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../constants/global_variables.dart';

PreferredSizeWidget appBar(){
  return PreferredSize(
        preferredSize:  Size.fromHeight(50.h),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
              padding:  EdgeInsets.symmetric(horizontal: 5.w),
              child: Text('ShopLine',style: TextStyle(
                fontSize: 21.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),),
            ),
                 Row(
                    children: [
                    const  Icon(Icons.notifications_outlined),
                      width(10.h),
                    const  Icon(Icons.search_outlined),                  
                    ],
                  ),               
              ],
            ),
          ),
        ),
      );
}