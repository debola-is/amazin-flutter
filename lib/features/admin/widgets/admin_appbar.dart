import 'package:flutter/material.dart';

import '../../../constants/global_variables.dart';

PreferredSizeWidget getAdminAppbar({required String titleText}) {
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              titleText,
              style: const TextStyle(
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
