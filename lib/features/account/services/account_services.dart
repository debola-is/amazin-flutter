import 'dart:convert';

import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/features/auth/screens/auth_screen.dart';
import 'package:amazin/models/order.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> getOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> ordersList = [];

    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/user/orders/get'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'user-auth-token': userProvider.user.token,
      });

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            ordersList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), "error");
    }
    return ordersList;
  }

  Future<void> logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('user-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString(), 'error');
    }
  }
}
