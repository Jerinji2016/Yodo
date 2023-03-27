import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../utils/globals.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _key = "theme-key";

  late ThemeMode _mode;

  ThemeMode get mode => _mode;

  ThemeProvider() {
    int? modeInt = preferences.getInt(_key);
    if (modeInt != null) {
      _mode = ThemeMode.values.elementAt(modeInt);
    } else {
      _mode = ThemeMode.system;
    }
  }

  void toggleTheme() {
    int currentThemeIndex = ThemeMode.values.indexWhere(
      (element) => element == _mode,
    );

    int nextIndex = (currentThemeIndex + 1) % ThemeMode.values.length;
    _mode = ThemeMode.values.elementAt(nextIndex);
    notifyListeners();
  }

  IconData get icon {
    switch (_mode) {
      case ThemeMode.system:
        return Icons.cloud_outlined;
      case ThemeMode.light:
        return Icons.wb_sunny_outlined;
      case ThemeMode.dark:
        return Icons.nights_stay_outlined;
    }
  }

  bool get isDarkTheme => _mode == ThemeMode.system
      ? SchedulerBinding.instance.window.platformBrightness == Brightness.dark
      : _mode == ThemeMode.dark;
}
