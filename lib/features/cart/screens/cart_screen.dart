import 'package:amazin/common/scroll_behaviour.dart';
import 'package:amazin/common/widgets/custom_button.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/address/screens/address_screen.dart';
import 'package:amazin/features/cart/services/cart_services.dart';
import 'package:amazin/features/cart/widgets/cart_product.dart';
import 'package:amazin/features/cart/widgets/cart_subtotal.dart';
import 'package:amazin/features/home/widgets/address_box.dart';
import 'package:amazin/features/search/screens/search_screen.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final cartLength = user.cart.length;
    double sum = 0;
    user.cart
        .map((e) => sum += e['quantity'] * (e['product']['price']).toDouble())
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60,
        ),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    // <Material> is used just so we can create the elevation effect.
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      onFieldSubmitted: navigateToSearchScreen,
                      decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 22,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.all(5),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.black45,
                              width: 1,
                            ),
                          ),
                          hintText: "Search Amazon.in",
                          hintStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          )),
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const AddressBox(),
          CartSubtotal(
            total: sum,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButton(
              onTap: (() => navigateToAddressScreen(sum)),
              text:
                  'Proceed to buy $cartLength ${cartLength > 1 ? "items" : "item"}',
              color: Colors.yellow.shade600,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(
            thickness: 1,
          ),
          Expanded(
            child: RefreshIndicator(
              displacement: 0,
              backgroundColor: Colors.transparent,
              strokeWidth: 2,
              onRefresh: updateCart,
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehaviour(),
                child: ListView.builder(
                  itemCount: cartLength,
                  itemBuilder: (context, index) {
                    return CartProduct(
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(
      context,
      SearchScreen.routeName,
      arguments: query,
    );
  }

  void navigateToAddressScreen(double total) {
    Navigator.pushNamed(
      context,
      AddressScreen.routeName,
      arguments: total.toString(),
    );
  }

  Future<void> updateCart() {
    return cartServices.updateCart(context: context);
  }
}
