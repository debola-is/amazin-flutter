import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageSource;
  final double? width;
  final double? height;
  final BoxFit imageFit;

  const CustomNetworkImage({
    super.key,
    required this.imageSource,
    this.width,
    this.height = 150,
    this.imageFit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholderScale: 0.5,
      placeholderFit: BoxFit.fitHeight,
      placeholder: 'assets/images/amazon_logo.png',
      image: imageSource,
      width: width,
      height: height,
      fit: imageFit,
      imageErrorBuilder: (context, error, stackTrace) => Image.asset(
        'assets/images/amazon_logo.png',
        width: width,
        height: height,
        fit: imageFit,
      ),
    );
  }
}
