import 'dart:convert';

import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> getProductForCategory(
      {required BuildContext context, required String category}) async {
    List<Product> allProducts = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/$category'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            allProducts.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        "error",
      );
    }

    return allProducts;
  }

  Future<Product> getDailyDeal({
    required BuildContext context,
  }) async {
    Product product = Product(
      name: '',
      description: '',
      price: 0,
      quantity: 0,
      category: '',
      images: [],
    );
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/get/deal-of-the-day'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          product = Product.fromJson(response.body);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        "error",
      );
    }
    return product;
  }
}
