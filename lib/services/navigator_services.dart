import 'package:autoguide/app/init_app.dart';
import 'package:flutter/material.dart';

class NavigatorServices {
  static pushAndRemoveUntil(Widget child) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => child),
      (route) => route.isFirst,
    );
  }

  // static resetMainScreen() async {
  //   await navigatorKey.currentState?.pushAndRemoveUntil(
  //       MaterialPageRoute(builder: (context) => MainScreen()),
  //       (route) => false);
  // }

  static push(Widget child) {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (context) => child),
    );
  }

  static pushReplacement(Widget child) {
    navigatorKey.currentState?.pushReplacement(
      MaterialPageRoute(builder: (context) => child),
    );
  }

  static pop() {
    navigatorKey.currentState?.pop();
  }
}
