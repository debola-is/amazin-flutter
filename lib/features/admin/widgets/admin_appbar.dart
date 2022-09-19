import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

PreferredSizeWidget getAdminAppbar() {
  return PreferredSize(
    preferredSize: const Size.fromHeight(
      50,
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
          Container(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'lib/assets/images/amazon_in.png',
              width: 120,
              height: 45,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Admin',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
