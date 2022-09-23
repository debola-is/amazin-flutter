import 'dart:convert';

import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
  }) async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/products/rate'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': user.token,
        },
        body: jsonEncode(
          {
            'id': product.id!,
            'rating': rating,
          },
        ),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context,
              'You have given ${product.name} $rating stars. Thanks for your feedback! 🙂');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
