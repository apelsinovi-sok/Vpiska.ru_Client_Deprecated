import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class MyPasswordField extends StatefulWidget {

   TextEditingController? passwordRepeatTextController;

  MyPasswordField(
      {super.key,
      required this.passwordTextController,
      required this.hintText,
      required this.obscureText,
      required this.icon,
      required this.suffixIcon,
      this.passwordRepeatTextController,
      });

  final TextEditingController passwordTextController;

  final String hintText;
  bool obscureText;
  final IconData icon;
  IconData suffixIcon;


  @override
  State<MyPasswordField> createState() => MyPasswordFieldState();
}

class MyPasswordFieldState extends State<MyPasswordField> {
  bool switchPassword = false;

  @override
  Widget build(BuildContext context) {
    return
    TextFormField(
        inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp("^[\u0000-\u007F]+\$"))
      ],
        validator: (value) {
          if(widget.passwordRepeatTextController != null) {
            if(widget.passwordTextController.text != widget.passwordRepeatTextController?.text) {
              return "Пароли не совпадают";
            }
          }

          if(value!.isEmpty) {
            // print(widget.passwordRepeatTextController?.text);
            return "Введите пароль";
          }
        },
        controller: widget.passwordTextController,
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: Icon(widget.icon),
          suffixIcon: GestureDetector(
            child: Icon(widget.suffixIcon),

            onTap: () {
              setState(() {
                if (switchPassword == false) {
                  widget.suffixIcon = Icons.visibility;
                  widget.obscureText = false;
                  switchPassword = true;
                } else {
                  widget.suffixIcon = Icons.visibility_off;
                  widget.obscureText = true;
                  switchPassword = false;
                }
              });
            },
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          // suffixIcon: const Icon(Icons.panorama_fish_eye)
        ),
    );
  }
}
