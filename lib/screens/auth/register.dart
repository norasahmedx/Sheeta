import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/containers/screen_container.dart';
import 'package:sheeta/components/designs/forms/register_form.dart';
import 'package:sheeta/static/colors.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: mobBg,
      body: ScreenContainer(
        paddingTop: 0,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: RegisterForm(),
            ),
          ),
        ),
      ),
    );
  }
}
