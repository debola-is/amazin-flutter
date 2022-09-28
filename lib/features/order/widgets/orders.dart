import 'package:amazin/common/scroll_behaviour.dart';
import 'package:amazin/common/widgets/network_image.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/features/account/services/account_services.dart';
import 'package:amazin/features/account/widgets/single_product.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/models/order.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final AccountServices accountServices = AccountServices();
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : orders!.isEmpty
            ? const Center(child: Text('Create your first order'))
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 15),
                        child: const Text(
                          "Your Orders",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: Text(
                          "See all",
                          style: TextStyle(
                            color: GlobalVariables.selectedNavBarColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // orders display section
                  SizedBox(
                    height: screenHeight(context) / 2,
                    child: ScrollConfiguration(
                      behavior: MyCustomScrollBehaviour(),
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        itemCount: orders!.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: double.infinity,
                            height: 150,
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  margin: const EdgeInsets.all(10),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: CustomNetworkImage(
                                      imageSource:
                                          orders![index].products[0].images[0],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 15,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${orders![index].products[0].name} ${orders![index].products.length > 1 ? ' and ${orders![index].products.length - 1} items more..' : ''} ',
                                          maxLines: 3,
                                        ),
                                        const Text(
                                            'Created on: 26th August 2020'),
                                        const Text(
                                            'Status: Pending confirmation'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
  }

  void getOrders() async {
    orders = await accountServices.getOrders(context: context);
    if (mounted) {
      setState(() {});
    }
  }
}
