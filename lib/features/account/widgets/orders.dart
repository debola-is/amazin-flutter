import 'package:amazin/common/scroll_behaviour.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List tempList = [
    'https://m.media-amazon.com/images/W/WEBP_402378-T1/images/I/61YK7fv9NcL._AC_SX679_.jpg',
    'https://m.media-amazon.com/images/W/WEBP_402378-T1/images/I/41VEc7626VL._AC_.jpg',
    'https://m.media-amazon.com/images/W/WEBP_402378-T1/images/I/81EKup9NVaL._AC_SX679_.jpg',
    'https://m.media-amazon.com/images/W/WEBP_402378-T1/images/I/51nwj3aTX5L._AC_SS450_.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehaviour(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: tempList.length,
              itemBuilder: (context, index) {
                return SingleProduct(
                  image: tempList[index],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
