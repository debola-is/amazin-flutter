import 'package:amazin/common/scroll_behaviour.dart';
import 'package:amazin/common/widgets/custom_button.dart';
import 'package:amazin/common/widgets/network_image.dart';
import 'package:amazin/common/widgets/rating_stars.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/features/cart/services/cart_services.dart';
import 'package:amazin/features/product_details/services/product_services.dart';
import 'package:amazin/features/search/screens/search_screen.dart';
import 'package:amazin/models/product.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/productDetails';
  final Product product;
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductServices productServices = ProductServices();
  final CartServices cartServices = CartServices();
  double averageRating = 0;
  double myRating = 0;
  String shouldRate = "Rate this product";

  @override
  void initState() {
    super.initState();
    double totalRating = 0;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
        shouldRate = "You've rated this product";
      }
    }

    if (totalRating != 0) {
      averageRating = totalRating / widget.product.rating!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(
              60,
            ),
            child: AppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 42,
                      margin: const EdgeInsets.only(left: 15),
                      child: Material(
                        // <Material> is used just so we can create the elevation effect.
                        borderRadius: BorderRadius.circular(7),
                        elevation: 1,
                        child: TextFormField(
                          onFieldSubmitted: navigateToSearchScreen,
                          decoration: InputDecoration(
                              prefixIcon: InkWell(
                                onTap: () {},
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(5),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(7),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black45,
                                  width: 1,
                                ),
                              ),
                              hintText: "Search Amazon.in",
                              hintStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    height: 40,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Icon(
                      Icons.mic,
                      color: Colors.black,
                      size: 25,
                    ),
                  )
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.product.id!),
                      RatingStars(rating: averageRating),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 15,
                      color: GlobalVariables.selectedNavBarColor,
                    ),
                  ),
                ),
                CarouselSlider(
                  items: widget.product.images.map(
                    (i) {
                      return Builder(
                        builder: (BuildContext context) => CustomNetworkImage(
                          imageSource: i,
                          height: 300,
                        ),
                      );
                    },
                  ).toList(),
                  options: CarouselOptions(
                    viewportFraction: 1,
                    height: 200,
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
                        children: widget.product.images
                            .map(
                              (e) => Container(
                                width: 75,
                                height: 75,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black12)),
                                child: CustomNetworkImage(
                                  imageSource: e,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 5,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: RichText(
                    text: TextSpan(
                      text: 'Deal Price ',
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: '\$${widget.product.price}',
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 5,
                  color: Colors.black12,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                    onTap: (() {}),
                    text: "Buy Now",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CustomButton(
                    onTap: addProductToCart,
                    text: "Add to cart",
                    color: const Color.fromRGBO(254, 216, 19, 1),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          persistentFooterAlignment: AlignmentDirectional.topStart,
          persistentFooterButtons: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    shouldRate,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                RatingBar.builder(
                    initialRating: myRating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    allowHalfRating: true,
                    itemBuilder: (context, _) {
                      return const Icon(
                        Icons.star,
                        color: GlobalVariables.secondaryColor,
                      );
                    },
                    onRatingUpdate: (value) {
                      productServices.rateProduct(
                          context: context,
                          product: widget.product,
                          rating: value);
                    })
              ],
            )
          ]),
    );
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addProductToCart() {
    cartServices.addToCart(
      context: context,
      product: widget.product,
    );
  }
}
