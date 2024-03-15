import 'dart:convert';

import 'package:shopline_app/models/product_model.dart';

class OrderModel {
  final String id;
  final List<ProductModel> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final double totalPrice;
  final int orderAt;
  final int status;
  OrderModel({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.totalPrice,
    required this.orderAt,
    required this.status,
  });

 

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'products': products.map((x) => x.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'totalPrice': totalPrice,
      'orderAt': orderAt,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['_id'] ?? '',
      products: List<ProductModel>.from(map['products']?.map((x) => ProductModel.fromMap(x['product']))),
      quantity: List<int>.from(map['products']?.map((e) => e['quantity'])),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      totalPrice: map['totalPrice']?.toDouble() ?? 0.0,
      orderAt: map['orderAt']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) => OrderModel.fromMap(json.decode(source));
}
