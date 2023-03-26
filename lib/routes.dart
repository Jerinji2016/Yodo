import 'package:flutter/material.dart';

import 'ui/login.dart';
import 'ui/tasks_list/tasks_list.dart';

class Routes {
  static const String login = "/";
  static const String tasksList = "tasks-list";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint("Routes.onGenerateRoute: ${settings.name}");

    if (settings.name == tasksList) {
      return MaterialPageRoute(
        builder: (context) => const TasksList(),
      );
    }

    return MaterialPageRoute(
      builder: (context) => const LoginPage(),
    );
  }

  Routes._();
}
