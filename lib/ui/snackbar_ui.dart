import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/app/init_app.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';

class SnackbarUI {
  static showSimpleSnackBar(String? message, {bool error = true}) {
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message.toString().tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: error ? Colors.red : AppStyle.primaryColor,
        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
        shape: RoundedRectangleBorder(borderRadius: AppStyle.borderRadius),
      ),
    );
  }
}
