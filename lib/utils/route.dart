import 'package:boong3/main.dart';
import 'package:boong3/screens/home.dart';
import 'package:boong3/screens/signin.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) => const StartApp());
      case "/signin":
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case "/home":
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        throw const FormatException('Error!');
    }
  }
}
