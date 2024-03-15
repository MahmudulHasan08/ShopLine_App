import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/global_variables.dart';

Widget selectProductImage ({required VoidCallback onTap}) {
  return   InkWell(
    onTap: onTap,
    child: Container(
             padding: EdgeInsets.symmetric(vertical: 20.h),
            child: DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12.r),
              padding: EdgeInsets.all(6.r),
              dashPattern:const [10,4], 
              strokeWidth: 1.5,
              child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.r)),
          child: Container(      
            height: 150.h,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.folder_open,size: 40.w,),
                height(10.h),
                Text('Select Product Image',style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.black38
                ),)
              ],
            ),
          ),
              ),
            ),
          ),
  );
       
}