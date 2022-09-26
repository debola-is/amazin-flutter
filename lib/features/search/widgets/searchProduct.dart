import 'package:amazin/common/widgets/network_image.dart';
import 'package:amazin/common/widgets/rating_stars.dart';
import 'package:amazin/constants/utils.dart';
import 'package:amazin/models/product.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleSearchProduct extends StatelessWidget {
  final Product product;
  const SingleSearchProduct({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double totalRating = 0;
    double averageRating = 0;
    for (int i = 0; i < product.rating!.length; i++) {
      totalRating += product.rating![i].rating;
    }

    if (totalRating != 0) {
      averageRating = totalRating / product.rating!.length;
    }
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
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
                averageRating == 0
                    ? const Text(
                        'No ratings yet..',
                        style: TextStyle(
                          color: Colors.teal,
                          fontStyle: FontStyle.italic,
                          fontSize: 12,
                        ),
                      )
                    : RatingStars(rating: averageRating),
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
