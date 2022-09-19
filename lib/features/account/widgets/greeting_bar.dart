import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GreetingBar extends StatelessWidget {
  const GreetingBar({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context).user;
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        bottom: 5,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(gradient: GlobalVariables.appBarGradient),
      child: RichText(
        text: TextSpan(
          text: 'Hello, ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.black,
          ),
          children: [
            TextSpan(
              text: user.name,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
