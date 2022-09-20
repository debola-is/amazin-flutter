import 'package:amazin/common/scroll_behaviour.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
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

  void deleteProduct(Product product) {
    adminServices.deleteProduct(context, product.id!, () {
      showSnackBar(context, '${product.name} has been deleted successfully!');
      getProducts();
    });
  }

  Future<void> confirmDelete(Product product) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height / 5),
            icon: Icon(
              Icons.warning_outlined,
              color: GlobalVariables.selectedNavBarColor,
            ),
            title: Text(
              'Confirm Deletion of Product',
              style: TextStyle(
                  fontSize: 15, color: GlobalVariables.selectedNavBarColor),
            ),
            content: Column(
              children: [
                Text(
                  '"${product.name}"',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.network(
                    product.images[0],
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'This action is NOT reversible',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  deleteProduct(product);
                  getProducts();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            backgroundColor: Colors.grey.shade100,
          );
        });
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
                child: ScrollConfiguration(
                  behavior: MyCustomScrollBehaviour(),
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
                                          color: GlobalVariables
                                              .selectedNavBarColor,
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
                                  onPressed: () {
                                    confirmDelete(productData);
                                  },
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
