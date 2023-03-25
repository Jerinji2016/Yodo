import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
    return const MaterialApp(
      onGenerateRoute: Routes.onGenerateRoute,
    );
  }
}
