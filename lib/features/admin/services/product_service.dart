import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopline_app/constants/error_handle.dart';
import 'package:shopline_app/constants/utils.dart';
import 'package:shopline_app/features/admin/models/sales_model.dart';
import 'package:shopline_app/models/order_model.dart';
import 'package:shopline_app/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'package:shopline_app/providers/user_provider.dart';

import '../../../constants/global_variables.dart';

class ProductService {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    try {
      const String url = "http://192.168.56.1:3000/admin/add-products";
      final cloudinary = CloudinaryPublic("dahiph7rh", "edsnwxy8");
      // final cloudinary = CloudinaryPublic("denfgaxvg", "uszbstnu");
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: 'Product-Img'),
        );
        imageUrl.add(res.secureUrl);
      }

      ProductModel product = ProductModel(
          name: name,
          description: description,
          quantity: quantity,
          images: imageUrl,
          category: category,
          price: price);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': user.user.token
        },
        body: product.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {},
          onCreateSuccess: () {
            showSnackBar(context, "Product Added successfully");
            Navigator.pop(context);
          });
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void sellProduct1({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      final cloudinary = CloudinaryPublic('denfgaxvg', 'uszbstnu');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      ProductModel product = ProductModel(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onCreateSuccess: () {
          showSnackBar(context, 'Product Added Successfully!');
          fetchAllProducts(context);
          Navigator.pop(context);
        },
        onSuccess: () {
          // showSnackBar(context, 'Product Added Successfully!');
          // Navigator.pop(context);
        },
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

// fetch all product
  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    final user = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> products = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/admin/all-product/'), headers: <String, String>{
        'Content-Type': 'application/json, charset=UTF-8',
        'x-auth-token': user.user.token
      });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            // print(res.body);
            var data = jsonDecode(res.body)['data']['products'];
            products.clear();
            for (int i = 0; i < data.length; i++) {
              products.add(ProductModel.fromJson(jsonEncode(data[i])));
            }
          },
          onCreateSuccess: () {});
      // var data = jsonDecode(res.body);
      // for (int i = 0; i < data.length; i++) {
      //   products.add(ProductModel.fromJson(data[i]));
      // }

      // print(products);
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
    return products;
  }

// delete product from proucts
  Future<void> deleteProduct(BuildContext context, String id) async {
    var user = Provider.of<UserProvider>(context, listen: false);
    try {
      String url = "$uri/admin/all-product/$id";
      http.Response res = await http.delete(
          Uri.parse('http://192.168.56.1:3000/admin/all-product/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json, charset=UTF-8',
            'x-auth-token': user.user.token,
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Product deleted successfully");
        },
        onCreateSuccess: () {},
      );
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }

  Future<List<OrderModel>> fetchAllOrders(
      {required BuildContext context}) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    List<OrderModel> orderList = [];
    try {
      http.Response res = await http.get(
          Uri.parse("$uri/api/admin-get-all-orders"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          });
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var jsonData = jsonDecode(res.body);
          print("jsonData : ${jsonData}");
          for (int i = 0; i < jsonData.length; i++) {
            orderList.add(OrderModel.fromMap(jsonData[i]));
            print('orderList is ${orderList}');
          }
        },
        onCreateSuccess: () {},
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    return orderList;
  }

  Future<void> changeOrderStatus(
      {required BuildContext context,
      required OrderModel order,
      required int status,
      required VoidCallback onSuccess}) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/admin/change-order-status'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': user.token
          },
          body: jsonEncode({'id': order.id, 'status': status}));
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
        onCreateSuccess: () {},
      );
    } catch (err) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, err.toString());
    }
  }

  Future<Map<String, dynamic>> getAllEarnings(
      {required BuildContext context}) async {
    var user = Provider.of<UserProvider>(context, listen: false).user;
    int totalEarnings=0;
    List<Sales> earnSales = [];
    try {
      http.Response res = await http.get(
          Uri.parse(
            "$uri/admin/analytics",
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
          var jsonData = jsonDecode(res.body);
          print(jsonData);
           totalEarnings = jsonData['totalEarnings'];
           print("totalEarning is ${totalEarnings}");
           print('shetu');
          earnSales = [
            Sales(label: 'Mobiles', earnings: jsonData['mobileEarnings']),
            Sales(label: 'Fashion', earnings: jsonData['fashionEarnings']),
            Sales(label: 'Appliances', earnings: jsonData['appliancesEarnings']),
            Sales(label: 'Books', earnings: jsonData['booksEarnings']),
            Sales(label: 'Essentials', earnings: jsonData['essentialseEarnings']),
          ];
        },
        onCreateSuccess: () {},
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
    return {
      'totalEarnings': totalEarnings,
      'earnSales': earnSales
    };
  }
}
