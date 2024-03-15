import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/models/user_model.dart';
import 'package:shopline_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  void addToCart({required context, required ProductModel product}) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
        body: jsonEncode({
          'id': product.id!,
        }),
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserModel user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
        onCreateSuccess: () {},
      );
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }

  removeItemToCart({required BuildContext context, required String id}) async {
    var userProvider = Provider.of<UserProvider>(context,listen: false);
    try {
      http.Response res = await http.delete(
          Uri.parse('$uri/api/remove-to-cart/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          });

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          UserModel user = userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
        },
        onCreateSuccess: () {},
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }
}
