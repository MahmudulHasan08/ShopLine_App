import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/constants/global_variables.dart';

PreferredSizeWidget? searchAppBar() {
  return PreferredSize(preferredSize:  Size.fromHeight(60.h), child: AppBar(
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
      );
}