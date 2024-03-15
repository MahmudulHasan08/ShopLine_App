import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/models/user_model.dart';
import 'package:shopline_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class AddressServices {
  Future<void> saveUserAddress(BuildContext context, String address) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res =
          await http.post(Uri.parse('$uri/api/sava-address-to-user'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token
              },
              body: jsonEncode({'address': address}));
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Address save successfully");
          UserModel user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );
          userProvider.setUserFromModel(user);
        },
        onCreateSuccess: () {},
      );
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }

  void placeOrder(
      {required BuildContext context,
      required String address,
      required double totalAmount}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/order-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode(
          {
            'cart': userProvider.user.cart,
            'address': address,
            'totalAmount': totalAmount
          },
        ),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Order has been placed successfully");

          UserModel user = userProvider.user.copyWith(
            cart: [],
          );

          userProvider.setUserFromModel(user);
        },
        onCreateSuccess: () {},
      );
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }
 

  void placeOrder1({
    required BuildContext context,
    required String address,
    required double totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'cart': userProvider.user.cart,
            'address': address,
            'totalPrice': totalSum,
          }));
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Your order has been placed!');
          UserModel user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
        onCreateSuccess: (){}
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
 
}
