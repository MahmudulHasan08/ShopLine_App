import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/models/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopline_app/providers/user_provider.dart';

class AccountServices {
  Future<List<OrderModel>> fetchMyOrders(
      {required BuildContext context}) async {
    List<OrderModel> orderList = [];
    var user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.get(
          Uri.parse(
            '$uri/api/user-orders',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          print(res.body);
          var jsonData = jsonDecode(res.body);
            print('jsonData: ${jsonData}');
          for(int i=0; i<jsonData.length; i++) {
            orderList.add(OrderModel.fromMap(jsonData[i]));
            print('orderList: ${orderList}');
          }
        },
        onCreateSuccess: () {},
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return orderList;
  }
}
