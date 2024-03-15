import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:shopline_app/providers/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<ProductModel>> fetchSerachData(
      BuildContext context, String nameQuery) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> searchProducts = [];
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/products/search/$nameQuery'),
          headers: <String, String>{
            'Content-Type': 'application/json, charset=UTF-8',
            'x-auth-token': user.user.token
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var jsonData = jsonDecode(res.body)['data']['products'];
            for (int i = 0; i < jsonData.length; i++) {
              searchProducts.add(
                ProductModel.fromJson(
                  jsonEncode(jsonData[i]),
                ),
              );
            }
          },
          onCreateSuccess: () {});
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    return searchProducts;
  }
}
