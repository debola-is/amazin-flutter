import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/account/widgets/account_buttons_layout.dart';
import 'package:amazin/features/account/widgets/greeting_bar.dart';
import 'package:amazin/features/order/widgets/orders.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(
          70,
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
              Container(
                padding: const EdgeInsets.only(
                  left: 25,
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: const [
          GreetingBar(),
          SizedBox(height: 20),
          AccountButtonsLayout(),
          SizedBox(height: 20),
          Orders()
        ],
      ),
    );
  }
}
