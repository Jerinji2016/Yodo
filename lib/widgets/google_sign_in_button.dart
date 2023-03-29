import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInButton extends StatefulWidget {
  final Function(User user) onSignInComplete;
  final Function(String message) onSignInFailed;

  const GoogleSignInButton({
    Key? key,
    required this.onSignInComplete,
    required this.onSignInFailed,
  }) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  void _signInWithGoogle() async {
    setState(() => _isSigningIn = true);

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      try {
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(authCredential);
        if (userCredential.user != null) {
          widget.onSignInComplete(userCredential.user!);
        } else {
          widget.onSignInFailed("No user was found");
        }
      } catch (e) {
        await googleSignIn.signOut();
        debugPrint("_GoogleSignInButtonState._signInWithGoogle: ERROR: $e");
        widget.onSignInFailed("Authentication Failed! Try with other account.");
      }
    } else {
      //  ignore: authentication cancelled by user
    }

    setState(() => _isSigningIn = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      child: _isSigningIn
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Authenticating",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            )
          : Material(
              color: Colors.white,
              elevation: 8.0,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: InkWell(
                onTap: _signInWithGoogle,
                borderRadius: const BorderRadius.all(
                  Radius.circular(30.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Image(
                        image: AssetImage("assets/images/google_logo.png"),
                        height: 24.0,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          'Sign in with Google',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
