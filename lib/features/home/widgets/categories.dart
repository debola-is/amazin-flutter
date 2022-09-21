import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/home/screens/category_products.dart';
import 'package:flutter/material.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  void navigateToCategoryScreen(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryProducts.routeName,
        arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: GlobalVariables.categoryImages.length,
          itemExtent: 85,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => navigateToCategoryScreen(
                  context, GlobalVariables.categoryImages[index]["title"]!),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      foregroundImage: AssetImage(
                          GlobalVariables.categoryImages[index]["image"]!),
                      radius: 20,
                    ),
                  ),
                  Text(
                    GlobalVariables.categoryImages[index]["title"]!,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
