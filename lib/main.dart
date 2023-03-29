import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yodo/providers/theme_provider.dart';
import 'package:yodo/utils/themes.dart';

import 'routes.dart';
import 'utils/globals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  preferences = await SharedPreferences.getInstance();

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

    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themProvider, child) {
          return MaterialApp(
            onGenerateRoute: Routes.onGenerateRoute,
            debugShowCheckedModeBanner: false,
            themeMode: themProvider.mode,
            theme: lightTheme,
            darkTheme: darkTheme,
            initialRoute: initialRoute,
          );
        },
      ),
    );
  }
}
