import 'package:amazin/features/account/screens/account_screen.dart';
import 'package:amazin/features/account/services/account_services.dart';
import 'package:amazin/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class AccountButtonsLayout extends StatefulWidget {
  const AccountButtonsLayout({super.key});

  @override
  State<AccountButtonsLayout> createState() => _AccountButtonsLayoutState();
}

class _AccountButtonsLayoutState extends State<AccountButtonsLayout> {
  final AccountServices accountServices = AccountServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "Your Orders",
              onTap: () {},
            ),
            AccountButton(
              text: "Your Wishlist",
              onTap: () {},
            )
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            AccountButton(
              text: "Sign Out",
              onTap: () {
                accountServices.logOut(context);
              },
            ),
            AccountButton(
              text: "Turn Seller",
              onTap: () {},
            )
          ],
        ),
      ],
    );
  }
}
