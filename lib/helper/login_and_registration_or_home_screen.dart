import 'package:flutter/material.dart';
import 'package:vpiska_ru_client/screens/home_screen.dart';
import 'package:vpiska_ru_client/screens/login_screen.dart';

class LoginAndRegistrationOrHome extends StatelessWidget {
  const LoginAndRegistrationOrHome({super.key});

  static bool login = false;
  @override
  Widget build(BuildContext context) {
    if (login) {
      return const HomePage();
    } else {
      return const LoginScreen();
    }
  }
}
