import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/constants/global_variables.dart';

Widget carouselSlider () {
  return    CarouselSlider(
            options: CarouselOptions(
              height: 200.h,
              autoPlay: true,
              viewportFraction: 1
              ),
            items: GlobalVariables.carouselImages.map((image) {
              return Builder(builder: (_){
                return Image.network(image,fit: BoxFit.cover,height: 200.h,);
              });
            } ).toList(),
           
          );
        
}