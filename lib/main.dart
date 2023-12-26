import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sheeta/components/designs/cards/snackbar.dart';
import 'package:sheeta/firebase_options.dart';
import 'package:sheeta/providers/user_provider.dart';
import 'package:sheeta/screens/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:sheeta/screens/grand_screen.dart';
import 'package:sheeta/shared/check_version.dart';
import 'package:sheeta/themes/main_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return UserProvider();
      },
      child: MaterialApp(
        title: 'Sheeta',
        debugShowCheckedModeBanner: false,
        theme: mainTheme,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(color: Colors.white)));
            } else if (snapshot.hasError) {
              checkForNewVersion(context);
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              checkForNewVersion(context);
              return const GrandScreen();
            } else {
              checkForNewVersion(context);
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
