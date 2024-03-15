import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/features/cart/screens/cart_screen.dart';
import 'package:shopline_app/features/home/screens/home_page.dart';
import 'package:badges/badges.dart' as badges;
import 'package:shopline_app/providers/user_provider.dart';

import '../../constants/global_variables.dart';
import '../../features/account/screens/account_page.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/bottom-nav';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
 
  List<Widget> pages = [
   const HomePage(),
   const AccontScreen(),
   const CartScreen(),
  ];
  int page = 0;
  @override
  Widget build(BuildContext context) {
     var user = context.watch<UserProvider>().user;
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: page,
          backgroundColor: GlobalVariables.backgroundColor,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          iconSize: 30,
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
                 child:const Icon(Icons.home_outlined),
              ),
              label: '',
            ),
             BottomNavigationBarItem(
              icon: Container(
                width: 42,
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
                child:const Icon(Icons.person_outline_outlined),
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
                 child: badges.Badge(
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.white,
                  ),
                  badgeContent: Text(user.cart.length.toString()),
                  
                  child:  const Icon(Icons.shopping_cart_rounded)),
              ),
              label: '',
            ),
          ]),
    );
  }
}
