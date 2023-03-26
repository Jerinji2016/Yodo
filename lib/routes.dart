import 'package:flutter/material.dart';

import 'ui/login.dart';
import 'ui/task_editor/task_editor.dart';
import 'ui/tasks_list/tasks_list.dart';

class Routes {
  static const String login = "/";
  static const String tasksList = "tasks-list";
  static const String manageTask = "manage-task";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint("Routes.onGenerateRoute: ${settings.name}");

    switch (settings.name) {
      case tasksList:
        return MaterialPageRoute(
          builder: (context) => const TasksList(),
        );
      case manageTask:
        return MaterialPageRoute(
          builder: (context) => const TaskEditor(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }

  Routes._();
}
