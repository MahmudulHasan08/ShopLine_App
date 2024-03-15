import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/admin/screens/analyticale_page.dart';
import 'package:shopline_app/features/admin/screens/order_page.dart';
import 'package:shopline_app/features/admin/screens/post_page.dart';
import 'package:shopline_app/features/admin/widgets/app_bar.dart';

class AdminScreen extends StatefulWidget {
  static const pageRoute = '/admin';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  List<Widget> pages = [
    const PostPage(),
    const AnalyticleScreen(),
    const OrderPageAdmin(),
  ];
  int page = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: (){},child: Icon(Icons.add,size: 20.w,),),
      appBar: adminAppBar(),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: page,          
          backgroundColor: GlobalVariables.backgroundColor,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          iconSize: 30.w,
          onTap: (value) {
            setState(() {
              page = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: 5,
                    ),
                  ),
                ),
                child: const Icon(Icons.home_outlined),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: 5,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.analytics_outlined,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: 5,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.all_inbox_outlined,
                ),
              ),
              label: '',
            ),
          ]),
      body: pages[page],
    );
  }
}
