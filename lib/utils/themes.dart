import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color lightDisabledColor = Color(0xFF3B3B3B), darkDisabledColor = Color(0xFFADADAD);

ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.white,
  disabledColor: lightDisabledColor,
  cardColor: Colors.grey[200]!,
  shadowColor: Colors.grey[100]!,
  iconTheme: IconThemeData(
    color: Colors.grey[700],
  ),
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
      fontFamily: "Poppins",
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
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.black,
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
    ),
    headlineSmall: TextStyle(
      color: Colors.black,
      fontSize: 16.0,
    ),
    headlineMedium: TextStyle(
      color: lightDisabledColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: Colors.black,
      fontStyle: FontStyle.italic,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    alignLabelWithHint: true,
    labelStyle: const TextStyle(
      color: darkDisabledColor,
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.orange,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.orange,
        width: 2.0,
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: Colors.grey[900]!,
  disabledColor: darkDisabledColor,
  cardColor: Colors.blueGrey[900]!,
  shadowColor: Colors.grey[900],
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
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
      fontFamily: "Poppins",
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
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.0,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    ),
    headlineMedium: TextStyle(
      color: darkDisabledColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      color: Colors.white,
      fontStyle: FontStyle.italic,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    alignLabelWithHint: true,
    labelStyle: const TextStyle(
      color: darkDisabledColor,
    ),
    floatingLabelStyle: const TextStyle(
      color: Colors.orange,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.orange,
        width: 2.0,
      ),
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.grey[900]!,
  ),
);
