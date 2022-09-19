import 'package:amazin/common/widgets/bottom_bar.dart';
import 'package:amazin/constants/global_variables.dart';
import 'package:amazin/features/admin/screens/admin_screen.dart';
import 'package:amazin/features/auth/screens/auth_screen.dart';
import 'package:amazin/features/auth/services/auth_service.dart';
import 'package:amazin/providers/user_provider.dart';
import 'package:amazin/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context: context);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    // )); // Makes the status bar apprear transparent and sort of fade into the app UI
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
        /* 
        If User token exists and user type is normal user, we want to navigate to home_screen
        If user token exists and user type is admin, we want to navifate to admin_screen
        Anything else means token doesn't exist, navigate to auth_screen where admin/user can sign in.
         */
        home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == "admin"
                ? const AdminScreen()
                : const BottomBar()
            : const AuthScreen());
  }
}
