import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/home/screens/category_deal_screen.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});
  void navigateToCategory(BuildContext context,String category){
   Navigator.pushNamed(context, CategoryDealScreen.routeName,arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
            height: 80.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: GlobalVariables.categoryImages.length,
                itemExtent: 80.w,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: (){
             navigateToCategory(context, GlobalVariables.categoryImages[index]['title']!);
                    },
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.w),
                          child: Image.asset(
                            GlobalVariables.categoryImages[index]['image']!,
                            fit: BoxFit.cover,
                            height: 40.w,
                            width: 40.w,
                          ),
                        ),
                        height(4.h),
                        Padding(
                          padding:  EdgeInsets.only(left: 5.w),
                          child: Text(
                            '${GlobalVariables.categoryImages[index]['title']}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          );
  }
}

