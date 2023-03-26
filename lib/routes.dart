import 'package:flutter/material.dart';
import 'package:yodo/ui/manage_task/manage_task.dart';

import 'ui/login.dart';
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
          builder: (context) => const ManageTask(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }

  Routes._();
}
