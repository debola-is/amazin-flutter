import 'dart:convert';
import 'dart:io';
import 'package:amazin/constants/error_handling.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';

const String _cloudname = 'dwiltileg';
const String _uploadPreset = 't0hl9qse';

class AdminServices {
  void addNewProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic(_cloudname, _uploadPreset);
      final String folderName = '$name-${DateTime.now()}';
      List<String> imageUrls = [];
      for (var image in images) {
        CloudinaryResponse response =
            await cloudinary.uploadFile(CloudinaryFile.fromFile(
          image.path,
          folder: folderName,
        )); // parsing a folder helps to organise     our files in cloudinary file storage. The string interpolation is to split the product name and add a timestamp to the folder name.
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
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<List<Product>> getAllProducts(BuildContext context) async {
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
      );
    }

    return allProducts;
  }

  void deleteProduct(
      BuildContext context, String productId, VoidCallback onSuccess) async {
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
      );
    }
  }
}
