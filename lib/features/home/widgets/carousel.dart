import 'package:amazin/common/widgets/network_image.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/constants/utils.dart';
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
            builder: (BuildContext context) => CustomNetworkImage(
              imageSource: i,
              width: screenWidth(context),
              imageFit: BoxFit.fitWidth,
            ),
          );
        },
      ).toList(),
      options: CarouselOptions(
        autoPlay: true,
        height: 150,
        viewportFraction: 1,
        autoPlayCurve: Curves.easeInOutCubicEmphasized,
        autoPlayAnimationDuration: const Duration(seconds: 2),
      ),
    );
  }
}
