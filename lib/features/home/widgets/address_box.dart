import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget addressBox ({ required String text }) {
  return Container(
            height: 40.h,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 114, 226, 221),
                  Color.fromARGB(255, 162, 236, 233),
                ],
                stops: [0.5, 1.0],
              ),
            ),
            child: Padding(
              padding:  EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  Icon(Icons.location_on_outlined,size: 20.w,),
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.only(left: 8.h),
                      child: Text(text),
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 2.h,right: 5.w),
                    child:  Icon(Icons.arrow_drop_down_outlined,size: 18.w,),
                  ),
                ],
              ),
            ),
          );
          
          
}