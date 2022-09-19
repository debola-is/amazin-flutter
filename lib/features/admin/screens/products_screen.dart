import 'package:amazin/features/admin/widgets/admin_appbar.dart';
import 'package:flutter/material.dart';

import 'add_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  void goToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAdminAppbar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToAddProduct();
        },
        tooltip: "Add a product",
        child: const Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
