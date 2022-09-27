import 'dart:convert';
import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:amazin/models/user.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CartServices {
  void addToCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/user/cart/add-to-cart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'id': product.id!,
          },
        ),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          User cartUpdatedUser = userProvider.user
              .copyWith(cart: jsonDecode(response.body)['cart']);
          userProvider.setUserFromModel(cartUpdatedUser);
          showSnackBar(context, 'Cart updated successfully', 'success');
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        "error",
      );
    }
  }

  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/api/user/cart/remove-from-cart/${product.id}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          User cartUpdatedUser = userProvider.user
              .copyWith(cart: jsonDecode(response.body)['cart']);
          userProvider.setUserFromModel(cartUpdatedUser);
          showSnackBar(context, 'Cart updated successfully', 'success');
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        "error",
      );
    }
  }

  Future<void> updateCart({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/user/cart/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          User cartUpdatedUser =
              userProvider.user.copyWith(cart: jsonDecode(response.body));
          userProvider.setUserFromModel(cartUpdatedUser);
          showSnackBar(context, 'Cart updated successfully', 'success');
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        "error",
      );
    }
  }
}
