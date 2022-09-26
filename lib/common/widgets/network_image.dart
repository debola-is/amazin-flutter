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
    this.height,
    this.imageFit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageSource,
      width: width,
      height: height,
      fit: imageFit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return child;
      },
    );
  }
}
