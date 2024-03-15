import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/global_variables.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopline_app/providers/user_provider.dart';

class HomeServices {
  Future<List<ProductModel>> fetchProducts(
      BuildContext context, String category) async {
    List<ProductModel> product = [];
    var user = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
          Uri.parse('$uri/api/products?category=$category'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.user.token
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            var data = jsonDecode(res.body)['data']['products'];
            print(data);
            for (var element in data) {
              product.add(ProductModel.fromJson(jsonEncode(element)));
              print('product is $product');
            }
          },
          onCreateSuccess: () {});
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
    return product;
  }

  // Future<ProductModel> getDealOfTheDay (BuildContext context) async {
  //   var user =  Provider.of(context,listen: false).user;
  //   http.Response res =  await http.get(Uri.parse('$uri/api/deal-of-the-day'),
  //   headers: <String,String> {
  //     'Content-Type': 'application/json, charset=UTF-8',
  //     'x-auth-token': user.user.
  //   }

  //   );
  // }
  Future<ProductModel> getDealOfTheDay(BuildContext context) async {
    var user = Provider.of<UserProvider>(context,listen: false).user;
    ProductModel product = ProductModel(
        name: "",
        description: "",
        quantity: 0,
        images: [],
        category: "",
        price: 0);
   try{
 http.Response res = await http.get(Uri.parse('$uri/api/deal-of-the-day'),
        headers: <String, String>{
          'Content-Type': 'application/json, charset=UTF-8',
          'x-auth-token': user.token
        });

    // ignore: use_build_context_synchronously
    httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var jsonData = jsonDecode(res.body)['product'];
          product = ProductModel.fromMap(jsonData);
        },
        onCreateSuccess: () {});
   }catch(err){
    // ignore: use_build_context_synchronously
    showSnackBar(context, err.toString());
   }
   return product;
  }

    
}
