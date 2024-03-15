import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct(
      BuildContext context, ProductModel product, double rating) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: <String, String>{
          'Content-Type': 'application/json, charset=UTF-8',
          'x-auth-token': user.user.token
        },
        body: jsonEncode(
          {'id': product.id, 'rating': rating},
        ),
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {},
          onCreateSuccess: () {});
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

    void rateProduct1({
    required BuildContext context,
    required ProductModel product,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id!,
          'rating': rating,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
        onCreateSuccess: (){},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
