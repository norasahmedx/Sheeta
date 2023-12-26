import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/buttons/main_button.dart';
import 'package:sheeta/components/designs/cards/snackbar.dart';
import 'package:sheeta/components/designs/forms/dont_have.dart';
import 'package:sheeta/components/designs/images/form_image_picker.dart';
import 'package:sheeta/components/designs/inputs/email.dart';
import 'package:sheeta/components/designs/inputs/password.dart';
import 'package:sheeta/firebase/auth.dart';
import 'package:sheeta/screens/grand_screen.dart';
import 'package:sheeta/screens/auth/login.dart';
import 'package:sheeta/shared/constants.dart';
import 'package:sheeta/static/colors.dart';
import 'package:sheeta/static/sizes.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  Uint8List? imgPath;
  String? imgName;

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final bioController = TextEditingController();
  FocusNode usernameFocus = FocusNode();

  void updateImg(Uint8List? path, String? name) {
    setState(() {
      imgPath = path;
      imgName = name;
    });
  }

  // register button handler
  btnHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      bool valid = await Auth().register(
        ctx: context,
        username: usernameController.text,
        email: emailController.text,
        bio: bioController.text,
        password: passwordController.text,
        imgName: imgName,
        imgPath: imgPath,
      );
      setState(() {
        isLoading = false;
      });

      if (valid) {
        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const GrandScreen()),
        );
      } else {
        usernameFocus.requestFocus();
      }
    } else {
      showSnackBar(context, "Something went wrong, please try again later");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          //* image picker
          FormImagePicker(
            updateImg: updateImg,
            imgName: imgName,
            imgPath: imgPath,
          ),
          const SizedBox(height: large * 1.5),
          //* Form inputs
          TextFormField(
              validator: (txt) {
                return txt!.isEmpty ? 'Username CAN\'T be empty' : null;
              },
              controller: usernameController,
              focusNode: usernameFocus,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: decorationTextfield.copyWith(
                  hintText: "Enter Your username : ",
                  suffixIcon: const Icon(Icons.person, color: primaryColor))),
          const SizedBox(height: large),
          TextFormField(
              validator: (txt) {
                return txt!.isEmpty ? 'Your bio CAN\'T be empty' : null;
              },
              controller: bioController,
              keyboardType: TextInputType.text,
              obscureText: false,
              decoration: decorationTextfield.copyWith(
                  hintText: "Enter Your bio : ",
                  suffixIcon:
                      const Icon(Icons.person_outline, color: primaryColor))),
          const SizedBox(height: large),
          EmailInput(emailController: emailController, check: true),
          const SizedBox(height: large),
          PasswordInput(passwordController: passwordController, check: true),
          const SizedBox(height: large * 1.5),
          //* Register Button
          MainButton(
            onTap: btnHandler,
            text: 'Register',
            isLoading: isLoading,
          ),
          const SizedBox(height: medium),
          //* don't have an account
          DontHave(
            txt: 'Already have an account?',
            txtButton: 'sign in',
            goTo: (context) => const Login(),
          ),
        ],
      ),
    );
  }
}
