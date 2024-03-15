import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget accountSingleButton ({required String buttonName,required VoidCallback onTap}) {
  return Expanded(
    child: Container(
      margin:const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 0,
        ),
        borderRadius: BorderRadius.circular(50),
    
      ),
      child: OutlinedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.black12.withOpacity(0.03),
          
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(50)
          // )
        ),
        onPressed: onTap, child: Text(buttonName,style:  TextStyle(
          fontSize: 14.sp,
        color: Colors.black,fontWeight: FontWeight.w400
      ),)),
    ),
  );
}