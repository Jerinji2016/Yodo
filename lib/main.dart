import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const YodoApp(),
  );
}

class YodoApp extends StatelessWidget {
  const YodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    String initialRoute = Routes.login;
    if (user != null) {
      initialRoute = Routes.tasksList;
    }

    return MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          elevation: 5.0,
          shadowColor: Colors.grey[100]!,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.orange,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          titleTextStyle: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
            ),
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.orange,
        ),
      ),
      initialRoute: initialRoute,
    );
  }
}
