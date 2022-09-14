import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/auth/screens/auth_screen.dart';
import 'package:amazin/router.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Amazin',
        theme: ThemeData(
          // This is the theme of your application.
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: const AuthScreen());
  }
}
