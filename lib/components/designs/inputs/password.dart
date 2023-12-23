import 'package:flutter/material.dart';
import 'package:sheeta/shared/constants.dart';
import 'package:sheeta/static/colors.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController passwordController;
  final bool check;
  const PasswordInput(
      {super.key, required this.passwordController, this.check = false});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isVisable = true;
  bool isPassword8Char = false;
  bool isPasswordHas1Number = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;

  onPasswordChanged(String password) {
    isPassword8Char = false;
    isPasswordHas1Number = false;
    hasUppercase = false;
    hasLowercase = false;
    hasSpecialCharacters = false;
    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPassword8Char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        isPasswordHas1Number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        hasUppercase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        hasLowercase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        hasSpecialCharacters = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        onChanged: (password) {
          onPasswordChanged(password);
        },
        // we return "null" when something is valid
        validator: widget.check
            ? (value) {
                return value!.length < 8 ? "Enter at least 8 characters" : null;
              }
            : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.passwordController,
        keyboardType: TextInputType.text,
        obscureText: isVisable ? true : false,
        decoration: decorationTextfield.copyWith(
            hintText: "Enter Your Password : ",
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisable = !isVisable;
                  });
                },
                icon: isVisable
                    ? const Icon(Icons.visibility, color: primaryColor)
                    : const Icon(Icons.visibility_off, color: primaryColor))));
  }
}
