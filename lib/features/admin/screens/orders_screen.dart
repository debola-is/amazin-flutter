import 'package:amazin/common/widgets/network_image.dart';
import 'package:amazin/features/account/widgets/single_product.dart';
import 'package:amazin/features/admin/services/admin_services.dart';
import 'package:amazin/features/admin/widgets/admin_appbar.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/features/order/screens/order_details_screen.dart';
import 'package:amazin/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final AdminServices adminServices = AdminServices();
  List<Order>? allOrders;

  @override
  void initState() {
    super.initState();
    getallOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAdminAppbar(titleText: 'Orders'),
      body: allOrders == null
          ? const Center(
              child: Loader(),
            )
          : GridView.builder(
              itemCount: allOrders!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final orderData = allOrders![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      OrderDetailsScreen.routeName,
                      arguments: orderData,
                    );
                  },
                  child: SizedBox(
                    height: 140,
                    child:
                        SingleProduct(image: orderData.products[0].images[0]),
                  ),
                );
              },
            ),
    );
  }

  void getallOrders() async {
    allOrders = await adminServices.getAllOrders(context: context);
    if (mounted) {
      setState(() {});
    }
  }
}
