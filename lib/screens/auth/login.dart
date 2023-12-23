import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/buttons/main_button.dart';
import 'package:sheeta/components/designs/containers/screen_container.dart';
import 'package:sheeta/components/designs/forms/dont_have.dart';
import 'package:sheeta/components/designs/inputs/email.dart';
import 'package:sheeta/components/designs/inputs/password.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/screens/auth/register.dart';
import 'package:sheeta/screens/grand_screen.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  // register button handler
  btnHandler() async {
    setState(() {
      isLoading = true;
    });
    var credential = await Auth().login(
      ctx: context,
      emailAddress: emailController.text,
      password: passwordController.text,
    );

    setState(() {
      isLoading = false;
    });

    if (credential != null) {
      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GrandScreen()),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
        backgroundColor: mobBg,
        body: ScreenContainer(
          paddingTop: 0,
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(33.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmailInput(emailController: emailController),
                    const SizedBox(height: large),
                    PasswordInput(passwordController: passwordController),
                    const SizedBox(height: large * 1.5),
                    MainButton(
                      onTap: btnHandler,
                      text: 'Login',
                      isLoading: isLoading,
                    ),
                    const SizedBox(height: medium),
                    DontHave(
                      txt: 'Do not have an account?',
                      txtButton: 'sign up',
                      goTo: (context) => const Register(),
                    )
                  ]),
            ),
          )),
        ));
  }
}
