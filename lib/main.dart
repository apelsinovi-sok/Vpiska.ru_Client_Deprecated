import 'package:flutter/material.dart';
import 'package:vpiska_ru_client/helper/login_and_registration_or_home_screen.dart';
import 'package:vpiska_ru_client/screens/login_screen.dart';
import 'package:vpiska_ru_client/screens/register_screen.dart';

void main() {
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:
       const LoginAndRegistrationOrHome(),
    );
  }
}