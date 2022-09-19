import 'package:amazin/common/scroll_behaviour.dart';
import 'package:flutter/material.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({super.key});

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Image.network(
            'https://m.media-amazon.com/images/I/71RbT53F8pL._AC_SX679_.jpg',
            height: 235,
            fit: BoxFit.fitHeight,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 15),
          alignment: Alignment.centerLeft,
          child: const Text(
            "\$500",
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 15, top: 5),
          child: const Text(
            'Alienware M15',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    'https://m.media-amazon.com/images/I/81oxUnvX9QL._AC_SX679_.jpg',
                    fit: BoxFit.fitWidth,
                    width: 75,
                    height: 75,
                  ),
                  Image.network(
                    'https://m.media-amazon.com/images/I/71X5yd0vLaL._AC_SX679_.jpg',
                    fit: BoxFit.fitWidth,
                    width: 75,
                    height: 75,
                  ),
                  Image.network(
                    'https://m.media-amazon.com/images/I/61GUq2yHqIL._AC_SX679_.jpg',
                    fit: BoxFit.fitWidth,
                    width: 75,
                    height: 75,
                  ),
                  Image.network(
                    'https://m.media-amazon.com/images/I/61rQXcsudbL._AC_SX679_.jpg',
                    fit: BoxFit.fitWidth,
                    width: 75,
                    height: 75,
                  ),
                  Image.network(
                    'https://m.media-amazon.com/images/I/5137HkQgj0L._AC_SX679_.jpg',
                    fit: BoxFit.fitWidth,
                    width: 75,
                    height: 75,
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15).copyWith(left: 15),
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
