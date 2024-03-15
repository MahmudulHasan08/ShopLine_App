import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/features/account/widgets/app_bar.dart';
import 'package:shopline_app/features/account/widgets/bellow_app_bar.dart';
import 'package:shopline_app/features/account/widgets/order.dart';
import 'package:shopline_app/features/account/widgets/top_buttons.dart';
import 'package:shopline_app/providers/user_provider.dart';

class AccontScreen extends StatelessWidget {
  const AccontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    // print(height1);
    double width1 = MediaQuery.of(context).size.width;
    // print(width1);
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: appBar(),
      body:Column(
            children: [
              belowAppBar(userName: user.user.name),
              height(10),
              topButtons(),
              height(10),
             const OrderList(),
             height(10),
         ],
        ),
      
    );
  }
}
