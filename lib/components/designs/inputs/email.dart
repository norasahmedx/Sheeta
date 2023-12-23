import 'package:flutter/material.dart';
import 'package:sheeta/shared/constants.dart';
import 'package:sheeta/static/colors.dart';

class EmailInput extends StatelessWidget {
  final TextEditingController emailController;
  final bool check;
  const EmailInput(
      {super.key, required this.emailController, this.check = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // we return "null" when something is valid
        validator: check
            ? (email) {
                return email!.contains(RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                    ? null
                    : "Enter a valid email";
              }
            : null,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        obscureText: false,
        decoration: decorationTextfield.copyWith(
            hintText: "Enter Your Email : ",
            suffixIcon: const Icon(Icons.email, color: primaryColor)));
  }
}
