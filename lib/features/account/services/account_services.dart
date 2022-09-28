import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

class AccountServices {
  void getOrders({
    required BuildContext context,
  }) async {
    try {
      http.Response response =
          await http.get(Uri.parse('$uri//api/user/orders/get'));
    } catch (e) {
      showSnackBar(context, e.toString(), "error");
    }
  }
}
