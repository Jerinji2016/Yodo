import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yodo/providers/theme_provider.dart';

import '../routes.dart';
import '../widgets/google_sign_in_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  void _onSignInComplete(BuildContext context, User user) async =>
      Navigator.pushReplacementNamed(context, Routes.tasksList);

  void _onSignInFailed(BuildContext context, String message) async => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          closeIconColor: Colors.white,
          showCloseIcon: true,
        ),
      );

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Login to continue",
          style: TextStyle(
            color: themeProvider.isDarkTheme ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Image(
                image: AssetImage(
                  "assets/images/login_illustration.png",
                ),
                color: Colors.transparent,
                colorBlendMode: BlendMode.difference,
              ),
            ),
            Center(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 100),
                alignment: Alignment.center,
                child: GoogleSignInButton(
                  onSignInComplete: (user) => _onSignInComplete(context, user),
                  onSignInFailed: (message) => _onSignInFailed(context, message),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
