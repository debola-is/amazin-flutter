import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/features/home/services/home_services.dart';
import 'package:amazin/features/product_details/screens/product_details_screen.dart';
import 'package:amazin/models/product.dart';
import 'package:flutter/material.dart';

class CategoryProducts extends StatefulWidget {
  static const String routeName = '/category_products';
  final String category;
  const CategoryProducts({
    super.key,
    required this.category,
  });

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  List<Product>? productsList;
  final HomeServices homeServices = HomeServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryProducts();
  }

  Future<void> getCategoryProducts() async {
    productsList = await homeServices.getProductForCategory(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          50,
        ),
        child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: GlobalVariables.appBarGradient,
              ),
            ),
            title: Text(
              widget.category,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: productsList == null
            ? const Loader()
            : productsList!.isEmpty
                ? const Center(
                    child: Text(
                      'No Product in this category for now',
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Keep shopping for ${widget.category}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: GridView.builder(
                          itemCount: productsList!.length,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(left: 15),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            childAspectRatio: 1.4,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            final product = productsList![index];
                            return GestureDetector(
                              onTap: () {
                                navigateToProductDetails(product);
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 130,
                                    width: 130,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black12,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          product.images[0],
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: CircularProgressIndicator(
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null,
                                              ),
                                            );
                                          },
                                          frameBuilder: (context, child, frame,
                                              wasSynchronouslyLoaded) {
                                            return child;
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          color: GlobalVariables
                                              .selectedNavBarColor,
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      Text(
                                        product.description,
                                        style: const TextStyle(
                                          color: Colors.black45,
                                          fontSize: 10,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        'Demo Headline 2',
                        style: TextStyle(fontSize: 18),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Text(
                        'Demo Headline 2',
                        style: TextStyle(fontSize: 18),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                      Card(
                        child: ListTile(
                            title: Text('Motivation $int'),
                            subtitle: Text(
                                'this is a description of the motivation')),
                      ),
                    ],
                  ),
      ),
    );
  }

  void navigateToProductDetails(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }
}
