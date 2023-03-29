import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color primaryBackgroundColor = Color(0xFF46539E);
const Color primaryDarkBackgroundColor = Color(0xFF212121);
const Color accentColor = Color(0xFF2EB9EE);
const Color accentShadowColor = Color(0xFF186483);

const Color lightDisabledColor = Color(0xFF3B3B3B), darkDisabledColor = Color(0xFFADADAD);

ThemeData lightTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: primaryBackgroundColor,
  disabledColor: lightDisabledColor,
  cardColor: Colors.grey[200]!,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: accentColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryBackgroundColor,
    elevation: 5.0,
    shadowColor: accentShadowColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryBackgroundColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      fontFamily: "Poppins",
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: accentColor,
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
      color: lightDisabledColor,
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: darkDisabledColor,
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
      color: accentColor,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: accentColor,
        width: 2.0,
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: primaryBackgroundColor,
  ),
);

ThemeData darkTheme = ThemeData(
  fontFamily: "Poppins",
  scaffoldBackgroundColor: primaryDarkBackgroundColor,
  disabledColor: darkDisabledColor,
  cardColor: Colors.blueGrey[900]!,
  shadowColor: primaryDarkBackgroundColor,
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: accentColor,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: primaryDarkBackgroundColor,
    elevation: 5.0,
    shadowColor: accentShadowColor,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: primaryDarkBackgroundColor,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
    titleTextStyle: TextStyle(
      fontFamily: "Poppins",
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: accentColor,
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
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      color: darkDisabledColor,
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
      color: accentColor,
    ),
    enabledBorder: UnderlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    border: UnderlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: Colors.grey[500]!,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8.0),
      ),
      borderSide: BorderSide(
        color: accentColor,
        width: 2.0,
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: primaryDarkBackgroundColor,
  ),
);
