import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../routes.dart';
import 'primary_button.dart';

class ProfileModal extends StatelessWidget {
  static const double _height = 250.0;

  static void show(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      constraints: BoxConstraints.tight(
        Size(
          MediaQuery.of(context).size.width,
          _height,
        ),
      ),
      enableDrag: true,
      useRootNavigator: true,
      builder: (context) => const ProfileModal._(),
    );
  }

  const ProfileModal._({Key? key}) : super(key: key);

  Widget getAvatar(User user) {
    return CircleAvatar(
      backgroundColor: Colors.grey[300]!,
      radius: 50,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(50.0),
        ),
        child: (user.photoURL?.isNotEmpty ?? false)
            ? Image(
                image: NetworkImage(
                  user.photoURL!,
                ),
              )
            : Text(
                user.displayName != null ? user.displayName![0] : user.email![0],
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User user;
    try {
      user = FirebaseAuth.instance.currentUser!;
    } catch (e) {
      //  not likely to happen since user is checked in `main.dart`
      SchedulerBinding.instance.addPostFrameCallback(
        (timeStamp) => Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false),
      );
      return const SizedBox.shrink();
    }

    debugPrint("ProfileModal.build: ${user.photoURL}");
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.loose,
      children: [
        Positioned(
          top: 50.0,
          child: Material(
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: SizedBox(
              height: _height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 62.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      user.displayName ?? "No Name",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      user.email!,
                      style: TextStyle(
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    LogOutButton(
                      onLogOutSuccess: () => Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.login,
                        (route) => false,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0.0,
          child: getAvatar(user),
        ),
      ],
    );
  }
}

class LogOutButton extends StatefulWidget {
  final VoidCallback onLogOutSuccess;

  const LogOutButton({
    Key? key,
    required this.onLogOutSuccess,
  }) : super(key: key);

  @override
  State<LogOutButton> createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  bool _isLoggingOut = false;

  void _logout() async {
    debugPrint("_LogOutButtonState._logout: ");
    setState(() => _isLoggingOut = true);
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      widget.onLogOutSuccess.call();
    } catch (e) {
      debugPrint("_LogOutButtonState._logout: ERROR: logout failed: $e");
    }
    setState(() => _isLoggingOut = false);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: _isLoggingOut
          ? const CircularProgressIndicator()
          : PrimaryButton(
              text: "Logout",
              borderRadius: 30.0,
              onTap: _logout,
            ),
    );
  }
}
