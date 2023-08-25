// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vpiska_ru_client/models/login_request.dart';
import 'package:vpiska_ru_client/screens/home_screen.dart';
import 'package:vpiska_ru_client/screens/register_screen.dart';
import 'package:vpiska_ru_client/screens/ui_components/button.dart';
import 'package:vpiska_ru_client/screens/ui_components/password_field.dart';
import 'package:vpiska_ru_client/screens/ui_components/text_field.dart';

import '../helper/http_request.dart';
import '../helper/login_and_registration_or_home_screen.dart';

var formKey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final numberTextController = TextEditingController();
  final passwordTextController = TextEditingController();


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // const Icon(Icons.lock,size: 100,),
                MyTextField(
                  controller: numberTextController,
                  hintText: 'Номер телефона',
                  obscureText: false,
                  icon: Icons.phone,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyPasswordField(

                  passwordTextController: passwordTextController,
                  hintText: 'Пароль',
                  obscureText: true,
                  icon: Icons.lock,
                  suffixIcon: Icons.visibility_off,
                  // formKey: formKey,
                ),
                const SizedBox(
                  height: 10,
                ),

                MyButton(
                  text: 'Войти',
                  onTap: () async {
                    bool check = formKey.currentState!.validate();
                    if(check) {
                      LoginRequest loginRequestObject = LoginRequest(numberTextController.text, passwordTextController.text);
                      Map<String, dynamic> loginRequestMap =
                      loginRequestObject.toMap();
                      String loginRequestJson = jsonEncode(loginRequestMap);

                      Map<String, dynamic> data =
                      await httpRequest(loginRequestJson, "login");

                     // LoginRequest kek = LoginRequest.fromJson(data);
                      if(data["response"] == "account_does_not_exist") {
                        _showSnackBar(context, "Неверный логин или пароль");
                      }
                      if(data["response"] == "login_true") {
                        print("Авторизирован");
                        LoginAndRegistrationOrHome.login = true;
                        navigateToDetail2(context);
                      }
                    }
                  },
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Зарегистрироваться',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              fontSize: 17)),
                    ],
                  ),
                  onTap: () {
                    navigateToDetail(context);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToDetail(BuildContext context) async {
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const RegisterScreen();
    }));
  }

  void navigateToDetail2(BuildContext context) async {
        await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginAndRegistrationOrHome();
    }));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

