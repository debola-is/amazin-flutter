// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:amazin/common/widgets/bottom_bar.dart';
import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../providers/user_provider.dart';

class AuthService {
  // TODO: Improve password validation using regex
  //Validate password by checking length of characters
  bool validPassword({
    required String password,
  }) {
    if (password.length > 7 && password.length < 16) {
      return true;
    }
    return false;
  }

  void signUpUser({
    ///posts user supplied info into database, handles error also by displaying
    ///appropriate feedback in snackbars in the current build context.
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    User user = User(
      id: '',
      name: name,
      password: password,
      type: '',
      token: '',
      address: '',
      email: email,
    );
    if (validPassword(
      password: password,
    )) {
      try {
        http.Response res = await http.post(
          Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        );

        httpErrorHandler(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(
              context,
              'Account created! Login with the same credentials',
            );
          },
        );
      } catch (e) {
        showSnackBar(
          context,
          e.toString(),
        );
      }
    } else {
      showSnackBar(context, "Passowrd should be 7-15 characters");
    }
  }

  void signInUser({
    ///posts user supplied info into database, handles error also by displaying
    ///appropriate feedback in snackbars in the current build context.
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString(
              'user-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
              context, BottomBar.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  void getUserData({
    ///posts user supplied info into database, handles error also by displaying appropriate feedback in snackbars in the current build context.
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('user-auth-token');

      if (token == null) {
        await prefs.setString('user-auth-token', '');
      }
      var tokenVerificationResult = await http.post(
        Uri.parse('$uri/token/validation'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenVerificationResult.body);

      if (response == true) {
        http.Response userResponse = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'user-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
