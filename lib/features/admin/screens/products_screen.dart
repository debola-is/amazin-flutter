import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/account/widgets/single_product.dart';
import 'package:amazin/features/admin/services/admin_services.dart';
import 'package:amazin/features/admin/widgets/admin_appbar.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/models/product.dart';
import 'package:flutter/material.dart';

import 'add_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  AdminServices adminServices = AdminServices();
  List<Product>? products;
  void goToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  Future<void> getProducts() async {
    products = await adminServices.getAllProducts(context);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            appBar: getAdminAppbar(),
            body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: RefreshIndicator(
                displacement: 10,
                onRefresh: getProducts,
                child: GridView.builder(
                    itemCount: products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemBuilder: (context, index) {
                      final productData = products![index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 140,
                            child: SingleProduct(
                              image: productData.images[0],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      productData.name,
                                      style: TextStyle(
                                        color:
                                            GlobalVariables.selectedNavBarColor,
                                        fontSize: 12,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Text(
                                      productData.description,
                                      style: const TextStyle(
                                        color: Colors.black45,
                                        fontSize: 10,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                goToAddProduct();
              },
              tooltip: "Add a product",
              child: const Icon(
                Icons.add,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
