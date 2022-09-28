import 'dart:convert';

import 'package:amazin/models/product.dart';

class Order {
  final String id;
  final List<Product> products;
  final List<int> quantity;
  final String address;
  final String userId;
  final int timeOfOrder;
  final int status;

  Order({
    required this.id,
    required this.products,
    required this.quantity,
    required this.address,
    required this.userId,
    required this.timeOfOrder,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'products': products.map((e) => e.toMap()).toList(),
      'quantity': quantity,
      'address': address,
      'userId': userId,
      'timeOfOrder': timeOfOrder,
      'status': status,
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['_id'] ?? '',
      products: List<Product>.from(
        map['products']?.map(
          (x) => Product.fromMap(
            x['product'],
          ),
        ),
      ),
      quantity: List<int>.from(
        map['products']?.map(
          (x) => x['quantity'],
        ),
      ),
      address: map['address'] ?? '',
      userId: map['userId'] ?? '',
      timeOfOrder: map['timeOfOrder']?.toInt() ?? 0,
      status: map['status']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) => Order.fromMap(json.decode(source));
}
