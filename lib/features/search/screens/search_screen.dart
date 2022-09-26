import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/admin/widgets/loader.dart';
import 'package:amazin/features/home/widgets/address_box.dart';
import 'package:amazin/features/product_details/screens/product_details_screen.dart';
import 'package:amazin/features/search/services/search_services.dart';
import 'package:amazin/features/search/widgets/searchProduct.dart';
import 'package:amazin/models/product.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search_screen';
  final String searchQuery;

  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
    getSearchedProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: products == null
          ? const Loader()
          : products!.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: GlobalVariables.selectedNavBarColor,
                          size: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Sorry! There are no products matching your search criteria.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: GlobalVariables.selectedNavBarColor,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    const AddressBox(),
                    Expanded(
                      child: ListView.builder(
                          itemCount: products!.length,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                navigateToProductDetails(products![index]);
                              },
                              child: SingleSearchProduct(
                                product: products![index],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
    );
  }

  void getSearchedProducts() async {
    products = await searchServices.getSearchProduct(
      context: context,
      searchQuery: widget.searchQuery,
    );

    if (mounted) {
      //Check to see if current widget is still mounted in the widget tree before calling set state so as to avoid memory leaks.
      setState(() {});
    }
  }

  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToProductDetails(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }
}
