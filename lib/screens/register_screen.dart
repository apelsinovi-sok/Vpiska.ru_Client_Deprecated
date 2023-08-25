import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vpiska_ru_client/helper/http_request.dart';
import 'package:vpiska_ru_client/models/registration_request.dart';
import 'package:vpiska_ru_client/screens/login_screen.dart';
import 'package:vpiska_ru_client/screens/ui_components/button.dart';
import 'package:vpiska_ru_client/screens/ui_components/password_field.dart';
import 'package:vpiska_ru_client/screens/ui_components/text_field.dart';

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final numberTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final passwordRepeatTextController = TextEditingController();

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
                  passwordRepeatTextController: passwordRepeatTextController,
                  hintText: 'Пароль',
                  obscureText: true,
                  icon: Icons.lock,
                  suffixIcon: Icons.visibility_off,
                ),

                const SizedBox(
                  height: 10,
                ),

                MyPasswordField(
                  passwordTextController: passwordRepeatTextController,
                  passwordRepeatTextController: passwordRepeatTextController,
                  hintText: 'Повторите пароль',
                  obscureText: true,
                  icon: Icons.lock,
                  suffixIcon: Icons.visibility_off,
                ),

                const SizedBox(
                  height: 10,
                ),

                MyButton(
                  text: 'Зарегистрироваться',
                  onTap: () async {
                    bool check = formKey.currentState!.validate();
                    if(check) {
                      RegisterRequest registerRequestObject = RegisterRequest(
                          numberTextController.text, passwordTextController.text);

                      Map<String, dynamic> registerRequestMap =
                      registerRequestObject.toMap();

                      String registerRequestJson = jsonEncode(registerRequestMap);

                      Map<String, dynamic> data =
                      await httpRequest(registerRequestJson, "registration");

                      RegisterRequest kek = RegisterRequest.fromJson(data);
                      // print(data["response"]);
                      // print(kek.phoneNumber);
                      // print(kek.password);
                      if(data["response"] == "Такой аккаунт уже существует") {
                        _showSnackBar(context, 'Такой аккаунт уже существует');
                      } else {
                        _showSnackBar(context, 'Успешная регистрация');
                        // ignore: use_build_context_synchronously
                        FocusScope.of(context).unfocus();
                        numberTextController.text = "";
                        passwordTextController.text = "";
                        passwordRepeatTextController.text = "";
                      }
                    } else {
                      // _showSnackBar(context, 'Delete');
                    }
                  },
                ),
                const SizedBox(height: 20),

                GestureDetector(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Войти',
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
      return const LoginScreen();
    }));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
