import 'package:amazin/common/widgets/network_image.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/features/cart/services/cart_services.dart';
import 'package:amazin/models/product.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    super.key,
    required this.index,
  });

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  final CartServices cartServices = CartServices();

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = Product.fromMap(productCart['product']);
    final quantity =
        context.watch<UserProvider>().user.cart[widget.index]['quantity'];

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 135,
                width: 135,
                padding: const EdgeInsets.all(5),
                child: CustomNetworkImage(
                  imageSource: product.images[0],
                ),
              ),
              Container(
                height: 135,
                width: screenWidth(context) - 160,
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                    ),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 2,
                    ),
                    const Text(
                      'Eligible for FREE shipping',
                      style: TextStyle(fontSize: 12),
                    ),
                    const Text(
                      'In stock',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.teal,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black12,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black12,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => removeFromCart(product),
                          child: Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 32,
                            child: const Icon(
                              Icons.remove,
                              size: 18,
                            ),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1.5),
                              color: Colors.white,
                              borderRadius: BorderRadius.zero),
                          child: Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 32,
                            child: Text(
                              quantity.toString(),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => increaseCartItemQuantity(product),
                          child: Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 32,
                            child: const Icon(
                              Icons.add,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  void increaseCartItemQuantity(Product product) {
    cartServices.addToCart(
      context: context,
      product: product,
    );
  }

  void removeFromCart(Product product) {
    cartServices.removeFromCart(
      context: context,
      product: product,
    );
  }
}
