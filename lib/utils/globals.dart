import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final DateFormat globalDateFormat = DateFormat("dd MMMM yyyy");

const Color primaryColor = Color(0xFF480AC5);

late final SharedPreferences preferences;
