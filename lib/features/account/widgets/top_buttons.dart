import 'package:flutter/material.dart';
import 'package:shopline_app/features/account/widgets/account_single_button.dart';

Widget topButtons () {
  return  Column(
    children:  [
      Row(
        children: [
          accountSingleButton(buttonName: "Your Orders", onTap: (){},),
          accountSingleButton(buttonName: "Turn Seller", onTap: (){},)
        ],
      ),
        Row(
        children: [
          accountSingleButton(buttonName: "Log Out", onTap: (){},),
          accountSingleButton(buttonName: "Your Wishlist", onTap: (){},)
        ],
      ),
      // Row(children: [

      // ],)
    ],
  );
}