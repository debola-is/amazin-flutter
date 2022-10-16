import 'package:amazin/features/admin/screens/orders_screen.dart';
import 'package:amazin/features/admin/screens/products_screen.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  final double _bottomNavBarWidth = 42;
  final double _bottomBarBorderWidth = 3;

  final List<Widget> _pages = [
    const ProductsScreen(),
    const Center(
      child: Text('Analytics Page'),
    ),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    if (mounted) {
      setState(() {
        _page = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            label: "Products",
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
                Icons.shopping_bag_outlined,
              ),
            ),
          ),

          // User Profile
          BottomNavigationBarItem(
            label: "Analytics",
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
                Icons.analytics_outlined,
              ),
            ),
          ),

          // Cart
          BottomNavigationBarItem(
            label: "Orders",
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
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
