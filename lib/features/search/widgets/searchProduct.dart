import 'package:amazin/common/widgets/rating_stars.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:flutter/material.dart';

class SingleSearchProduct extends StatelessWidget {
  final Product product;
  const SingleSearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            height: 135,
            width: 135,
            padding: const EdgeInsets.all(5),
            child: Image.network(
              product.images[0],
              fit: BoxFit.contain,
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
                const RatingStars(rating: 4.0),
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
    );
  }
}
