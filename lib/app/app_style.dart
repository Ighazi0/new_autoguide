import 'package:flutter/material.dart';

class AppStyle {
  static const primaryColor = Color(0xff0256ff);
  static const secondryColor = Colors.black;
  static final lightGrey = Colors.grey.shade300;

  static ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
    fontFamily: "Almarai",
    useMaterial3: false,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all<Color>(primaryColor),
      ),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.white,
    ),
  );

  static final radius = 10;
  static final padinationPixel = 0.75;
  static BorderRadius get borderRadius => BorderRadius.circular(10);
  static final shadow = const [
    BoxShadow(color: Colors.black26, spreadRadius: 0.1, blurRadius: 5),
  ];
}
