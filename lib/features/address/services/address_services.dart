import 'dart:convert';
import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/models/user.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazin/constants/utils.dart';
import 'package:provider/provider.dart';

class AddressServices {
  void saveUserAddress({
    required BuildContext context,
    required String userAddress,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/user/shipping/add-shipping-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {"address": userAddress},
        ),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          User newUser = userProvider.user
              .copyWith(address: jsonDecode(response.body)['address']);
          userProvider.setUserFromModel(newUser);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), "error");
    }
  }

  void placeOrder({
    required BuildContext context,
    required String userAddress,
    required String totalSum,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/user/order/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
        body: jsonEncode(
          {
            'cart': userProvider.user.cart,
            'address': userAddress,
            'totalPrice': totalSum,
          },
        ),
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Order placed successfully!', 'success');
          User newUser = userProvider.user
              .copyWith(cart: jsonDecode(response.body)['cart']);
          userProvider.setUserFromModel(newUser);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), "error");
    }
  }
}
