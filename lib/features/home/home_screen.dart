import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/home/widgets/address_box.dart';
import 'package:amazin/features/home/widgets/carousel.dart';
import 'package:amazin/features/home/widgets/categories.dart';
import 'package:amazin/features/home/widgets/deal_of_the_day.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // scaffold can't be const because obviously the provider value isn't constant!
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          60,
        ),
        child: AppBar(
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
          children: const [
            AddressBox(),
            SizedBox(
              height: 10,
            ),
            HomeCategories(),
            CarouselImages(),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}
