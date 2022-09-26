import 'package:amazin/common/scroll_behaviour.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/features/home/services/home_services.dart';
import 'package:amazin/features/product_details/screens/product_details_screen.dart';
import 'package:amazin/models/product.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  final HomeServices homeServices = HomeServices();
  Product? product;

  void getDailyDeal() async {
    product = await homeServices.getDailyDeal(
      context: context,
    );
    setState(() {});
  }

  void navigateToProductDetail() {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  void initState() {
    super.initState();
    getDailyDeal();
  }

  @override
  Widget build(BuildContext context) {
    return product == null
        ? const SizedBox(height: 240, child: Loader())
        : product!.name.isEmpty
            ? const SizedBox()
            : Column(
                children: [
                  GestureDetector(
                    onTap: navigateToProductDetail,
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: const Text(
                            'Deal of the day',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Image.network(
                            product!.images[0],
                            height: 235,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '\$${product!.price}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15, top: 5),
                          child: Text(
                            product!.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ScrollConfiguration(
                            behavior: MyCustomScrollBehaviour(),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: product!.images
                                    .map(
                                      (e) => Image.network(
                                        e,
                                        fit: BoxFit.fitWidth,
                                        width: 75,
                                        height: 75,
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15)
                        .copyWith(left: 15),
                    alignment: Alignment.topLeft,
                    child: Text(
                      'See all deals',
                      style: TextStyle(
                        color: Colors.cyan[800],
                      ),
                    ),
                  ),
                ],
              );
  }
}
