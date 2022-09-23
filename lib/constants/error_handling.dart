import 'dart:convert';
import 'package:amazin/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandler({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, '400: ${jsonDecode(response.body)['msg']}');
      break;
    case 500:
      showSnackBar(context, '500: ${jsonDecode(response.body)['error']}');
      break;
    default:
      showSnackBar(context, 'Error occured: ${response.body}');
      break;
  }
}
