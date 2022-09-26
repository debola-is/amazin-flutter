import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/account/screens/account_screen.dart';
import 'package:amazin/features/cart/screens/cart_screen.dart';
import 'package:amazin/features/home/screens/home_screen.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/nav-bar';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  final double _bottomNavBarWidth = 42;
  final double _bottomBarBorderWidth = 3;

  final List<Widget> _pages = [
    const HomeScreen(),
    const AccountScreen(),
    const CartScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: _pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          // Home Page
          BottomNavigationBarItem(
            label: "Home",
            icon: Container(
              width: _bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 0
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: _bottomBarBorderWidth),
                ),
              ),
              child: const Icon(
                Icons.home_outlined,
              ),
            ),
          ),

          // User Profile
          BottomNavigationBarItem(
            label: "Account",
            icon: Container(
              width: _bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 1
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: _bottomBarBorderWidth),
                ),
              ),
              child: const Icon(
                Icons.person_outlined,
              ),
            ),
          ),

          // Cart
          BottomNavigationBarItem(
            label: "Cart",
            icon: Container(
              width: _bottomNavBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                      color: _page == 2
                          ? GlobalVariables.selectedNavBarColor
                          : GlobalVariables.backgroundColor,
                      width: _bottomBarBorderWidth),
                ),
              ),
              child: Badge(
                elevation: 0,
                padding: const EdgeInsets.only(right: 10, top: 15),
                badgeContent: Text(
                  userCartLength.toString(),
                  style: TextStyle(
                    color: GlobalVariables.selectedNavBarColor,
                    fontSize: 12,
                  ),
                ),
                badgeColor: Colors.white,
                child: const Icon(
                  Icons.shopping_cart_outlined,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
