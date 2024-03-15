import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget singleProduct({required String imageUrl}) {
  return Container(
    child: DecoratedBox(
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.black12,
        width: 1.5,
      )),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h,horizontal: 5),
        width: 180.w,
        child: Image.network(
          imageUrl,
          fit: BoxFit.fitHeight,
          width: 180.w,
        ),
      ),
    ),
  );
}
