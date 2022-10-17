import 'dart:convert';
import 'dart:io';
import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/admin/model/sales.dart';
import 'package:amazin/models/order.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';
import '../../../secrets.dart';

class AdminServices {
  void addNewProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic(cloudname, uploadPreset);
      final String folderName = '$name-${DateTime.now()}';
      List<String> imageUrls = [];
      for (var image in images) {
        CloudinaryResponse response =
            await cloudinary.uploadFile(CloudinaryFile.fromFile(
          image.path,
          folder: folderName,
        )); // parsing a folder helps to organise our files in cloudinary file storage. The string interpolation is to split the product name and add a timestamp to the folder name.
        imageUrls.add(response.secureUrl);
      }
      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
      );

      http.Response response =
          await http.post(Uri.parse('$uri/admin/add-product'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'user-auth-token': userProvider.user.token,
              },
              body: product.toJson());

      httpErrorHandler(
          response: response, context: context, onSuccess: onSuccess);
    } catch (e) {
      showSnackBar(context, e.toString(), "error");
    }
  }

  Future<List<Product>> getAllProducts({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> allProducts = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-all-products'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
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

  void deleteProduct({
    required BuildContext context,
    required String productId,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.delete(
        Uri.parse('$uri/admin/delete-product/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        "error",
      );
    }
  }

  Future<List<Order>> getAllOrders({required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> allOrders = [];

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            allOrders.add(
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
    return allOrders;
  }

  void updateOrderStatus({
    required BuildContext context,
    required int newStatus,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response response = await http.post(
        Uri.parse('$uri/admin/order/update-status'),
        body: jsonEncode({
          'id': order.id,
          'status': newStatus,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      showSnackBar(context, e.toString(), "error");
    }
  }

  Future<Map<String, dynamic>> getEarnings(
      {required BuildContext context}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    double totalEarning = 0;

    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/analytics'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'user-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandler(
        response: response,
        context: context,
        onSuccess: () {
          var res = jsonDecode(response.body);
          totalEarning = res['totalEarnings'].toDouble();
          sales = [
            Sales('Mobiles', res['mobileEarnings'].toDouble()),
            Sales('Essentials', res['essentialsEarnings'].toDouble()),
            Sales('Appliances', res['appliancesEarnings'].toDouble()),
            Sales('Books', res['booksEarnings'].toDouble()),
            Sales('Fashion', res['fashionEarnings'].toDouble()),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString(), "error");
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
