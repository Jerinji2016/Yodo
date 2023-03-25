import 'package:flutter/material.dart';

import 'ui/login.dart';

class Routes {
  static const String login = "/";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const LoginPage(),
    );
  }

  Routes._();
}
