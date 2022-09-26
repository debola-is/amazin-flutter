import 'dart:convert';

import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> getSearchProduct(
      {required BuildContext context, required String searchQuery}) async {
    List<Product> allProducts = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/search/$searchQuery'),
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
}
