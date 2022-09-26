import 'package:amazin/constants/global_variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselImages extends StatelessWidget {
  const CarouselImages({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map(
        (i) {
          return Builder(
            builder: (BuildContext context) => Image.network(
              i,
              fit: BoxFit.fitWidth,
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        autoPlay: true,
        height: 150,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInOutCubicEmphasized,
        autoPlayAnimationDuration: const Duration(seconds: 2),
      ),
    );
  }
}
